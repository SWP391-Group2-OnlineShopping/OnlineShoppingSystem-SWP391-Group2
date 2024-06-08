/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Staffs;
import model.Posts;
import model.Images;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import model.OrderDetail;
import model.PostCategories;
import model.PostCategoryList;
import model.Orders;
import java.util.Date;
import model.Customers;

/**
 *
 * @author DELL
 */
public class OrderDAO extends DBContext {

    public List<Orders> getAllOrders(int customerID, int orderStatus, int index) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        StringBuilder os = new StringBuilder("WHERE o.CustomerID = ?");
        if (orderStatus != 0) {
            os.append(" AND o.OrderStatusID = ?");
        }
        OrderDAO dao = new OrderDAO();
        String sql = "SELECT o.OrderID, c.Username as Customer, s.Username as Staff, o.OrderDate, o.TotalCost, os.OrderStatus, "
                + "o.NumberOfItems, o.OrderNotes, o.PaymentMethod "
                + "FROM Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + os.toString()
                + " ORDER BY o.OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            stmt.setInt(paramIndex++, customerID);
            if (orderStatus != 0) {
                stmt.setInt(paramIndex++, orderStatus);
            }
            stmt.setInt(paramIndex, (index - 1) * 5);

            System.out.println("Executing query: " + stmt.toString());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Date orderDate = rs.getDate(4);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = dateFormat.format(orderDate);
                listorderdetail = dao.getOrderDetailByOrderID(rs.getInt(1));
                System.out.println("Order ID: " + rs.getInt(1) + " has " + listorderdetail.size() + " order details");

                if (!listorderdetail.isEmpty()) {
                    Orders order = new Orders(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getFloat(5),
                            rs.getInt(7),
                            formattedDate,
                            rs.getString(6),
                            rs.getString(3),
                            listorderdetail,
                            listorderdetail.get(0).getTitle(),
                            rs.getString(8),
                            rs.getString(9)
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDetail> getOrderDetailByOrderID(int orderID) {
        List<OrderDetail> listorderdetail = new ArrayList<>();
        String sql = "SELECT od.Order_DetailID,od.Cart_DetailID,od.Order_DetailID,p.ProductID,pcs.Size,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price \n"
                + "from Order_Detail od \n"
                + "JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID \n"
                + "JOIN Product_CS pcs ON pcs.ProductCSID=cd.ProductCSID\n"
                + "JOIN Products p ON pcs.ProductID=p.ProductID\n"
                + "JOIN Images i ON i.ImageID = p.Thumbnail \n"
                + "Where OrderID=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
                listorderdetail.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listorderdetail;
    }

    public int countOrderByStatusAndCustomer(int orderStatus, int customerID) {
        int count = 0;
        String os = "WHERE CustomerID =" + customerID + " ";
        if (orderStatus != 0) {
            os = os + " AND OrderStatusID=" + orderStatus + " ";
        }
        String sql = "SELECT COUNT(*) from Orders " + os + " ";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public Orders getOrderByOrderID(int orderID) {
        List<OrderDetail> listorderdetail = new ArrayList<>();
        OrderDAO dao = new OrderDAO();
        String sql = "select o.OrderID, c.Username as Customer,s.Username as Staff,o.OrderDate,o.TotalCost,os.OrderStatus,o.NumberOfItems, o.OrderNotes, o.PaymentMethod "
                + "from Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID  "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID=os.OrderStatusID  "
                + "WHERE o.OrderID=? ";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Date orderDate = rs.getDate(4);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = dateFormat.format(orderDate);
                listorderdetail = dao.getOrderDetailByOrderID(rs.getInt(1));
                if (listorderdetail.isEmpty()) {

                } else {
                    Orders order = new Orders(rs.getInt(1), rs.getString(2), rs.getFloat(5), rs.getInt(7), formattedDate, rs.getString(6), rs.getString(3), listorderdetail, listorderdetail.get(0).getTitle(), rs.getString(8), rs.getString(9));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customers getCustomerInfoByOrderID(int orderID) {

        String sql = "select r.ReceiverFullName,r.Address,c.Email,r.PhoneNumber,c.Gender,c.Avatar \n"
                + "                from Customers c JOIN Orders o ON c.CustomerID=o.CustomerID \n"
                + "				JOIN Receiver_Information r ON o.ReceiverID = r.ReceiverInformationId\n"
                + "                WHERE o.OrderID=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customers c = new Customers(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getBoolean(5));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getOrderDetailBySearch(int CustomerID, String txt) {
        List<OrderDetail> listorderdetail = new ArrayList<>();
        String sql = "SELECT TOP 3 od.Order_DetailID,od.Cart_DetailID,od.OrderID,p.ProductID,pcs.Size,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price \n"
                + "from Order_Detail od \n"
                + "JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID \n"
                + "JOIN Product_CS pcs ON pcs.ProductCSID=cd.ProductCSID\n"
                + "JOIN Products p ON pcs.ProductID=p.ProductID\n"
                + "JOIN Images i ON i.ImageID = p.Thumbnail \n"
                + "JOIN Orders o ON o.OrderID = od.OrderID\n"
                + "Where p.Title like ? AND o.CustomerID =? "
                + "ORDER BY o.orderdate DESC ";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, "%" + txt + "%");
            stmt.setInt(2, CustomerID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
                listorderdetail.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listorderdetail;

    }

    public void CreateNewOrder(int customerID, float totalCost, int numberOfItems, int orderStatus, int staffID, int receiverID, String orderNotes, String paymentMethod) {
        if (orderNotes.isEmpty() && orderNotes.isBlank()) {
            orderNotes += "None";
        }
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();

        String sql = "INSERT INTO Orders (CustomerID, TotalCost, NumberOfItems, OrderDate, OrderStatusID, StaffID, ReceiverID, OrderNotes, PaymentMethod)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?,?,?);";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            // Set parameters
            st.setInt(1, customerID);
            st.setFloat(2, totalCost);
            st.setInt(3, numberOfItems);
            st.setString(4, date);
            st.setInt(5, orderStatus);
            st.setInt(6, staffID);
            st.setInt(7, receiverID);
            st.setString(8, orderNotes);
            st.setString(9, paymentMethod);

            st.executeUpdate();
            System.out.println("Insert thành công");

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        }
    }

    public void AddToOrderDetail(int customerID, int productCSID, int quantities) {
        String sqlCart = "SELECT CartID FROM Carts WHERE CustomerID = ?";
        String sqlCartDetail = "SELECT Cart_DetailID FROM Cart_Detail WHERE ProductCSID = ? AND CartID = ?";
        String sqlOrder = "SELECT TOP 1 OrderID FROM Orders WHERE CustomerID = ? ORDER BY OrderID DESC";
        String sqlInsertOrderDetail = "INSERT INTO Order_Detail (Cart_DetailID, OrderID, Quantities) VALUES (?, ?, ?)";

        try {

            PreparedStatement stCart = connection.prepareStatement(sqlCart);
            stCart.setInt(1, customerID);
            ResultSet rsCart = stCart.executeQuery();

            if (rsCart.next()) {
                int cartID = rsCart.getInt(1);

                PreparedStatement stCartDetail = connection.prepareStatement(sqlCartDetail);
                stCartDetail.setInt(1, productCSID);
                stCartDetail.setInt(2, cartID);
                ResultSet rsCartDetail = stCartDetail.executeQuery();

                PreparedStatement stOrder = connection.prepareStatement(sqlOrder);
                stOrder.setInt(1, customerID);
                ResultSet rsOrder = stOrder.executeQuery();

                if (rsCartDetail.next() && rsOrder.next()) {
                    int cartDetailID = rsCartDetail.getInt(1);
                    int orderID = rsOrder.getInt(1);

                    PreparedStatement stInsertOrderDetail = connection.prepareStatement(sqlInsertOrderDetail);
                    stInsertOrderDetail.setInt(1, cartDetailID);
                    stInsertOrderDetail.setInt(2, orderID);
                    stInsertOrderDetail.setInt(3, quantities);
                    stInsertOrderDetail.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteOrderExpired(int orderID) {
        // SQL để xóa chi tiết đơn hàng
        String sqlDeleteOrderDetail = "DELETE od "
                + "FROM Order_Detail od "
                + "JOIN Orders o ON o.OrderID = od.OrderID "
                + "WHERE o.OrderID = ? "
                + "AND o.OrderStatusID = 1 "
                + "AND DATEDIFF(HOUR, o.OrderDate, GETDATE()) > 24;";

        // SQL để xóa đơn hàng
        String sqlDeleteOrder = "DELETE FROM Orders "
                + "WHERE OrderID = ? "
                + "AND OrderStatusID = 1 "
                + "AND DATEDIFF(HOUR, OrderDate, GETDATE()) > 24;";

        try {
            // Xóa chi tiết đơn hàng
            PreparedStatement stDeleteOrderDetail = connection.prepareStatement(sqlDeleteOrderDetail);
            stDeleteOrderDetail.setInt(1, orderID);
            int rowsDeletedOrderDetail = stDeleteOrderDetail.executeUpdate();
            System.out.println("Deleted " + rowsDeletedOrderDetail + " rows from Order_Detail.");

            // Xóa đơn hàng
            PreparedStatement stDeleteOrder = connection.prepareStatement(sqlDeleteOrder);
            stDeleteOrder.setInt(1, orderID);
            int rowsDeletedOrder = stDeleteOrder.executeUpdate();
            System.out.println("Deleted " + rowsDeletedOrder + " rows from Orders.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void UpdateOrderStatus(int customerID, int orderStatus) {
        String sql2 = "SELECT TOP 1 OrderID FROM Orders WHERE CustomerID = ? ORDER BY OrderID DESC";
        try {
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, customerID);
            ResultSet rs = st2.executeQuery();
            if (rs.next()) {
                int order_id = rs.getInt(1);
                String sql = "Update Orders set OrderStatusID = ? where CustomerID = ? and OrderID = ?;";
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, orderStatus);
                st.setInt(2, customerID);
                st.setInt(3, order_id);
                st.executeUpdate();
            }
        } catch (Exception e) {
        }
    }

    public void UpdateOrderStatusByOrderID(int customerID, int orderStatus, int orderID) {
        String sql = "Update Orders set OrderStatusID = ? where CustomerID = ? and OrderID = ?;";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderStatus);
            st.setInt(2, customerID);
            st.setInt(3, orderID);
            st.executeUpdate();

        } catch (Exception e) {
        }
    }
//
//    //get the llast product in the order
//    public static void main(String[] args) {
//        OrderDAO dao = new OrderDAO();
//        List<OrderDetail> list = dao.getOrderDetailBySearch(2, "a");
//        for (OrderDetail o : list) {
//            System.out.println(o);
//        }
//        Customers c = dao.getCustomerInfoByOrderID(1);
//
//    }

    public int checkOrderStatusByOrderID(int orderID) {
        String sql = "select o.OrderStatusID from Orders o\n"
                + "WHERE o.OrderID=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateOrder(int orderID, int orderStatus) {
        String sql = "UPDATE Orders SET OrderStatusID=? WHERE OrderID=?";
        int check = checkOrderStatusByOrderID(orderID);
        try {
            // Assuming status 5 or higher means it cannot be canceled
            if (check == 0 || check >= 5) {
                System.out.println("Cannot be cancelled");
                return false;
            } else {
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setInt(1, orderStatus);
                stmt.setInt(2, orderID);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Update successful");
                    return true;
                }
            }
        } catch (Exception e) {
            System.err.println(e);
        }
        return false;
    }

//get the llast product in the order
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        List<Orders> order = dao.getAllOrders(3, 0, 3);
        for (Orders o : order) {
            System.out.println(o);
        }

    }
}
