/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.OrderStatus;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import model.OrderDetail;
import model.Orders;
import java.util.Date;
import model.BrandTotal;
import model.Customers;
import model.OrderSummary;
import model.Products;

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
        String sql = "SELECT od.Order_DetailID,od.Cart_DetailID,od.Order_DetailID,p.ProductID,pcs.Size,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price, od.FeedbackID \n"
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
                OrderDetail od = new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11));
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
        List<OrderDetail> orderDetails = new ArrayList<>();
        OrderDAO orderDAO = new OrderDAO();
        String sql = "SELECT o.OrderID, c.CustomerID, c.Username as Customer, s.Username as Staff, o.OrderDate, o.TotalCost, os.OrderStatus, o.NumberOfItems, o.OrderNotes, o.PaymentMethod "
                + "FROM Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "WHERE o.OrderID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Date orderDate = rs.getDate("OrderDate");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String formattedDate = dateFormat.format(orderDate);
                    
                    orderDetails = orderDAO.getOrderDetailByOrderID(rs.getInt("OrderID"));
                    
                    if (!orderDetails.isEmpty()) {
                        Orders order = new Orders(
                                rs.getInt("OrderID"),
                                rs.getInt("CustomerID"),
                                rs.getString("Customer"),
                                rs.getFloat("TotalCost"),
                                rs.getInt("NumberOfItems"),
                                formattedDate,
                                rs.getString("OrderStatus"),
                                rs.getString("Staff"),
                                orderDetails,
                                orderDetails.get(0).getTitle(),
                                rs.getString("OrderNotes"),
                                rs.getString("PaymentMethod")
                        );
                        return order;
                    }
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
    
    public void UpdateOrderStatusByOrderID(int customerID, int orderStatus, int orderID, String paymentMethod) {
        String sql = "Update Orders set OrderStatusID = ? , PaymentMethod =? where CustomerID = ? and OrderID = ? ;";
        try {
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderStatus);
            st.setString(2, paymentMethod);
            st.setInt(3, customerID);
            st.setInt(4, orderID);
            st.executeUpdate();
            
        } catch (Exception e) {
        }
    }
    
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
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderStatus);
            stmt.setInt(2, orderID);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Update successful");
                return true;
            }
            
        } catch (Exception e) {
            System.err.println(e);
        }
        return false;
    }
    
    public boolean retunOrderToProducCS(int orderID, int productCSID) {
        String sql = "UPDATE Product_CS\n"
                + "SET Quantities = Quantities + (\n"
                + "    SELECT SUM(od.Quantities)\n"
                + "    FROM Order_Detail od\n"
                + "	JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID\n"
                + "	JOIN Orders o ON od.OrderID=o.OrderID\n"
                + "    WHERE cd.ProductCSID =? AND od.OrderID=?\n"
                + ")\n"
                + "WHERE Product_CS.ProductCSID=?";
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, productCSID);
            stmt.setInt(2, orderID);
            stmt.setInt(3, productCSID);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Update successful");
                return true;
            }
            
        } catch (Exception e) {
            System.err.println(e);
        }
        return false;
    }
    
    public List<OrderStatus> getAllOrderStatus() {
        List<OrderStatus> orderStatus = new ArrayList<>();
        String query = "select * from Order_Status";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    OrderStatus status = new OrderStatus();
                    status.setOrderStatusID(rs.getInt("OrderStatusID"));
                    status.setOrderStatus(rs.getString("OrderStatus"));
                    orderStatus.add(status);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderStatus;
    }
    
    public int countOrderByStatus(int orderStatus) {
        int count = 0;
        String os = "";
        if (orderStatus != 0) {
            os = " WHERE OrderStatusID=" + orderStatus;
        }
        String sql = "SELECT COUNT(*) FROM Orders" + os;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public List<Orders> getAllOrdersFromSaleMana(int orderStatus, int index) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        StringBuilder os = new StringBuilder();
        if (orderStatus != 0) {
            os.append("WHERE o.OrderStatusID = ?");
        }
        
        OrderDAO dao = new OrderDAO();
        String sql = "SELECT o.OrderID,  ri.ReceiverFullName,  s.FullName, o.OrderDate, o.TotalCost, os.OrderStatus, "
                + "o.NumberOfItems, o.OrderNotes, o.PaymentMethod "
                + "FROM Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "join Receiver_Information ri on ri.ReceiverInformationId = o.ReceiverID "
                + os.toString()
                + " ORDER BY o.OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
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
    
    public List<Orders> getAllOrdersFromSaleManaFilter(int orderStatus, int index, int staffID, String fromDate, String toDate, String search) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        StringBuilder os = new StringBuilder();
        
        if (orderStatus != 0) {
            os.append("WHERE o.OrderStatusID = ? ");
        }
        
        if (staffID != 0) {
            if (os.length() > 0) {
                os.append("AND s.StaffID = ? ");
            } else {
                os.append("WHERE s.StaffID = ? ");
            }
        }
        
        if (fromDate != null && toDate != null) {
            if (os.length() > 0) {
                os.append("AND o.OrderDate BETWEEN ? AND ? ");
            } else {
                os.append("WHERE o.OrderDate BETWEEN ? AND ? ");
            }
        }
        
        if (search != null && !search.isEmpty()) {
            if (os.length() > 0) {
                os.append("AND (o.OrderID = ? OR ri.ReceiverFullName LIKE ?) ");
            } else {
                os.append("WHERE (o.OrderID = ? OR ri.ReceiverFullName LIKE ?) ");
            }
        }
        
        OrderDAO dao = new OrderDAO();
        String sql = "SELECT o.OrderID, ri.ReceiverFullName, s.FullName, o.OrderDate, o.TotalCost, os.OrderStatus, "
                + "o.NumberOfItems, o.OrderNotes, o.PaymentMethod "
                + "FROM Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "JOIN Receiver_Information ri ON ri.ReceiverInformationId = o.ReceiverID "
                + os.toString()
                + "ORDER BY o.OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (orderStatus != 0) {
                stmt.setInt(paramIndex++, orderStatus);
            }
            if (staffID != 0) {
                stmt.setInt(paramIndex++, staffID);
            }
            if (fromDate != null && toDate != null) {
                stmt.setString(paramIndex++, fromDate);
                stmt.setString(paramIndex++, toDate);
            }
            if (search != null && !search.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(search);
                    stmt.setInt(paramIndex++, orderId);
                } catch (NumberFormatException e) {
                    stmt.setInt(paramIndex++, -1); // Invalid OrderID to ensure no match
                }
                stmt.setString(paramIndex++, "%" + search + "%");
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
    
    public List<Orders> getAllOrdersFromSale(int staffID, int orderStatus, int index, String fromDate, String toDate, String search) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        StringBuilder os = new StringBuilder();
        
        os.append("WHERE s.StaffID = ? ");
        
        if (orderStatus != 0) {
            os.append("AND o.OrderStatusID = ? ");
        }
        
        if (fromDate != null && toDate != null) {
            os.append("AND o.OrderDate BETWEEN ? AND ? ");
        }
        
        if (search != null && !search.isEmpty()) {
            os.append("AND (o.OrderID = ? OR ri.ReceiverFullName LIKE ?) ");
        }
        
        OrderDAO dao = new OrderDAO();
        String sql = "SELECT o.OrderID, ri.ReceiverFullName, s.FullName, o.OrderDate, o.TotalCost, os.OrderStatus, "
                + "o.NumberOfItems, o.OrderNotes, o.PaymentMethod, o.OrderStatusID "
                + "FROM Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "JOIN Receiver_Information ri ON ri.ReceiverInformationId = o.ReceiverID "
                + os.toString()
                + "ORDER BY o.OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            stmt.setInt(paramIndex++, staffID);
            
            if (orderStatus != 0) {
                stmt.setInt(paramIndex++, orderStatus);
            }
            
            if (fromDate != null && toDate != null) {
                stmt.setString(paramIndex++, fromDate);
                stmt.setString(paramIndex++, toDate);
            }
            
            if (search != null && !search.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(search);
                    stmt.setInt(paramIndex++, orderId);
                } catch (NumberFormatException e) {
                    stmt.setInt(paramIndex++, -1); // Invalid OrderID to ensure no match
                }
                stmt.setString(paramIndex++, "%" + search + "%");
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
                            rs.getString(9),
                            rs.getInt(10)
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void changeStatusOrder(String order_id, int status) {
        String sql = "update Orders set OrderStatusID=? where OrderID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, status);
            st.setString(2, order_id);
            ResultSet rs = st.executeQuery();
        } catch (Exception e) {
        }
    }
    
    public void ReturnProduct(String order_id) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select pcs.ProductCSID, od.Quantities from Order_Detail od\n"
                + "			join Cart_Detail cd on cd.Cart_DetailID = od.Cart_DetailID\n"
                + "			join Product_CS pcs on pcs.ProductCSID = cd.ProductCSID\n"
                + "			join Products p on p.ProductID = pcs.ProductID\n"
                + "			where od.OrderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, order_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt(1), rs.getInt(2)));
            }
            for (OrderDetail od : list) {
                String sql2 = "update Product_CS set Quantities+=? where ProductCSID = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, od.getQuantitySold());
                st2.setInt(2, od.getProductCSID());
                st2.executeUpdate();
            }
        } catch (Exception e) {
        }
    }
    
    public OrderDetail getOrderDetailByOrderDetailID(int orderDetailID) {
        String sql = "SELECT od.Order_DetailID, od.Cart_DetailID, od.OrderID, p.ProductID,pcs.Size,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price \n"
                + "from Order_Detail od \n"
                + "JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID \n"
                + "JOIN Product_CS pcs ON pcs.ProductCSID=cd.ProductCSID\n"
                + "JOIN Products p ON pcs.ProductID=p.ProductID\n"
                + "JOIN Images i ON i.ImageID = p.Thumbnail \n"
                + "Where od.Order_DetailID = ?";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderDetailID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
                return od;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void UpdateFeedbackIDForOrderDetail(int orderDetailID, int feedbackID) {
        String sql = "UPDATE Order_Detail SET FeedbackID = ? WHERE Order_DetailID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, feedbackID);
            stmt.setInt(2, orderDetailID);
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("FeedbackID updated successfully");
            } else {
                System.out.println("No rows were updated");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int countTodayOrderByStatus(int orderStatus) {
        int count = 0;
        String os = "";
        if (orderStatus != 0) {
            os = " AND OrderStatusID=" + orderStatus;
        }
        String sql = "SELECT COUNT(*) AS TotalOrders\n"
                + "FROM Orders\n"
                + "WHERE OrderDate = CAST(GETDATE() AS DATE)" + os;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int RevenueByMonth(int month) {
        int totalRevenue = 0;
        String sql = "SELECT SUM(TotalCost) AS TotalRevenue\n"
                + "FROM Orders\n"
                + "WHERE YEAR(OrderDate) = 2024\n"
                + "  AND MONTH(OrderDate) = ?\n"
                + "  AND OrderStatusID = 5;";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, month);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getInt("TotalRevenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }
    
    public void removeOrderExpired(int orderID) {
        String sql3 = "DELETE od\n"
                + "FROM Order_Detail od\n"
                + "JOIN Orders o ON o.OrderID = od.OrderID\n"
                + "WHERE o.OrderID = ?\n"
                + "AND o.OrderStatusID = 1\n"
                + "AND DATEDIFF(HOUR, o.OrderDate, GETDATE()) > 24;";
        
        String sql = "DELETE FROM Orders WHERE OrderID = ? and OrderStatusID = 1 AND DATEDIFF(HOUR, OrderDate, GETDATE()) > 24";
        try {
            PreparedStatement st3 = connection.prepareStatement(sql3);
            st3.setInt(1, orderID);
            st3.executeQuery();
            
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.executeQuery();
            
        } catch (Exception e) {
        }
    }
    
    public void AutoDeleteExpiredOrder(int customerID) {
        String selectSql = "SELECT o.OrderID\n"
                + "FROM Orders o\n"
                + "WHERE o.PaymentMethod IN ('Banking Online Transfer', 'VNPay')\n"
                + "  AND o.OrderStatusID IN (1, 8)\n"
                + "  AND DATEDIFF(HOUR, o.OrderDate, GETDATE()) > 24\n"
                + "  AND o.CustomerID = ?";
        
        String deleteOrderDetailsSql = "DELETE od\n"
                + "FROM Order_Detail od\n"
                + "JOIN Orders o ON o.OrderID = od.OrderID\n"
                + "WHERE o.OrderID = ?";
        
        String deleteOrdersSql = "DELETE FROM Orders\n"
                + "WHERE OrderID = ?";
        
        try {
            // Select the expired orders
            PreparedStatement selectStmt = connection.prepareStatement(selectSql);
            selectStmt.setInt(1, customerID);
            ResultSet rs = selectStmt.executeQuery();
            
            while (rs.next()) {
                int orderID = rs.getInt("OrderID");

                // Delete from Order_Detail
                PreparedStatement deleteOrderDetailsStmt = connection.prepareStatement(deleteOrderDetailsSql);
                deleteOrderDetailsStmt.setInt(1, orderID);
                deleteOrderDetailsStmt.executeUpdate();

                // Delete from Orders
                PreparedStatement deleteOrdersStmt = connection.prepareStatement(deleteOrdersSql);
                deleteOrdersStmt.setInt(1, orderID);
                deleteOrdersStmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the exception for debugging purposes
        }
    }
    
    public List<OrderSummary> getOrdersByDateAndSaler(String startDate, String endDate, int staffID) {
        List<OrderSummary> orderSummaries = new ArrayList<>();
        String os = "";
        if (staffID != 0) {
            os = " AND o.StaffID = ? ";
        }
        String sql = "SELECT o.OrderDate, o.StaffID, s.FullName, SUM(o.TotalCost) AS TotalRevenue, COUNT(o.OrderID) AS TotalOrders\n"
                + "FROM Orders o\n"
                + "JOIN Staffs s ON s.StaffID = o.StaffID\n"
                + "WHERE o.OrderDate BETWEEN ? AND ? "
                + os
                + "GROUP BY \n"
                + "    o.OrderDate,\n"
                + "    o.StaffID, \n"
                + "    s.FullName\n"
                + "ORDER BY o.OrderDate;";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            if (staffID != 0) {
                stmt.setInt(3, staffID);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderSummary summary = new OrderSummary();
                summary.setOrderDate(rs.getString("OrderDate"));
                summary.setStaffID(rs.getInt("StaffID"));
                summary.setFullName(rs.getString("FullName"));
                summary.setTotalRevenue(rs.getInt("TotalRevenue"));
                summary.setTotalOrders(rs.getInt("TotalOrders"));
                orderSummaries.add(summary);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderSummaries;
    }
    
    public List<BrandTotal> getTotalRevenueByBrand() {
        List<BrandTotal> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    pcl.Name AS Brand,\n"
                + "    COALESCE(SUM(p.SalePrice * cd.Quantities), 0) AS TotalRevenue\n"
                + "FROM \n"
                + "    Product_Category_List pcl\n"
                + "    LEFT JOIN Product_Categories pc ON pc.ProductCL = pcl.ProductCL\n"
                + "    LEFT JOIN Products p ON pc.ProductID = p.ProductID\n"
                + "    LEFT JOIN Product_CS pcs ON p.ProductID = pcs.ProductID\n"
                + "    LEFT JOIN Cart_Detail cd ON pcs.ProductCSID = cd.ProductCSID\n"
                + "    LEFT JOIN Order_Detail od ON cd.Cart_DetailID = od.Cart_DetailID\n"
                + "GROUP BY \n"
                + "    pcl.Name\n"
                + "ORDER BY \n"
                + "    TotalRevenue DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new BrandTotal(rs.getString("Brand"), rs.getFloat("TotalRevenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return list;
    }
    
    public List<Products> getTop5BestSeller() {
        List<Products> products = new ArrayList<>();
        String query = "WITH RankedProducts AS (\n"
                + "    SELECT p.ProductID, p.Title AS ProductName, p.Description, p.SalePrice, p.Thumbnail,\n"
                + "        SUM(cd.Quantities) AS TotalSold,\n"
                + "        ROW_NUMBER() OVER (ORDER BY SUM(cd.Quantities) DESC) AS RowNum\n"
                + "    FROM Orders o\n"
                + "        JOIN Order_Detail od ON o.OrderID = od.OrderID\n"
                + "        JOIN Cart_Detail cd ON od.Cart_DetailID = cd.Cart_DetailID\n"
                + "        JOIN Product_CS pcs ON cd.ProductCSID = pcs.ProductCSID\n"
                + "        JOIN Products p ON pcs.ProductID = p.ProductID\n"
                + "    WHERE o.OrderStatusID = 5 -- Assuming '5' is the status for successful orders\n"
                + "    GROUP BY p.ProductID, p.Title, p.Description, p.SalePrice, p.Thumbnail\n"
                + ")\n"
                + "SELECT rp.ProductID, rp.ProductName, rp.Description, rp.SalePrice, i.Link AS ImageLink, rp.TotalSold\n"
                + "FROM RankedProducts rp LEFT JOIN Images i ON rp.Thumbnail = i.ImageID\n"
                + "WHERE rp.RowNum <= 5;";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("ProductName"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setThumbnailLink(rs.getString("ImageLink"));
                    product.setQuantity(rs.getInt("TotalSold"));
                    
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
////get the llast product in the order

    public static void main(String[] args) {
        OrderDAO oDAO = new OrderDAO();
        List<BrandTotal> orderList = new ArrayList<>();
        orderList = oDAO.getTotalRevenueByBrand();
        for (BrandTotal o : orderList) {
            System.out.println(o);
        }
////        System.out.println(oDAO.countOrderByStatusAndSale(1,3));
////
    }
}
