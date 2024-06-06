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

/**
 *
 * @author DELL
 */
public class OrderDAO extends DBContext {

    public List<Orders> getAllOrders(int orderStatus) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        String os = "";
        if (orderStatus != 0) {
            os = "WHERE o.OrderStatusID=" + orderStatus + " ";
        }
        OrderDAO dao = new OrderDAO();
        String sql = "select o.OrderID, c.Username as Customer,s.Username as Staff,o.OrderDate,o.TotalCost,os.OrderStatus,o.NumberOfItems "
                + "from Orders o "
                + "JOIN Staffs s ON o.StaffID = s.StaffID  "
                + "JOIN Customers c ON c.CustomerID = o.CustomerID "
                + "JOIN Order_Status os ON o.OrderStatusID=os.OrderStatusID  "
                + os
                + "ORDER BY o.OrderDate DESC";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Date orderDate = rs.getDate(4);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = dateFormat.format(orderDate);
                listorderdetail = dao.getOrderDetailByOrderID(rs.getInt(1));
                if (listorderdetail.isEmpty()) {

                } else {
                    Orders order = new Orders(rs.getInt(1), rs.getString(2), rs.getFloat(5), rs.getInt(7), formattedDate, rs.getString(6), rs.getString(3), listorderdetail, listorderdetail.get(0).getTitle());
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
        String sql = "SELECT od.Order_DetailID,od.Cart_DetailID,od.Order_DetailID,p.ProductID,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price "
                + "from Order_Detail od "
                + "JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID "
                + "JOIN Products p ON p.ProductID=cd.ProductID "
                + "JOIN Images i ON i.ImageID = p.Thumbnail "
                + "Where OrderID=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getFloat(6), rs.getString(7), rs.getInt(8), rs.getInt(9));
                listorderdetail.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listorderdetail;
    }

    public Orders getOrderByOrderID(int orderID) {
        List<OrderDetail> listorderdetail = new ArrayList<>();
        OrderDAO dao = new OrderDAO();
        String sql = "select o.OrderID, c.Username as Customer,s.Username as Staff,o.OrderDate,o.TotalCost,os.OrderStatus,o.NumberOfItems "
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
                    Orders order = new Orders(rs.getInt(1), rs.getString(2), rs.getFloat(5), rs.getInt(7), formattedDate, rs.getString(6), rs.getString(3), listorderdetail, listorderdetail.get(0).getTitle());
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void CreateNewOrder(int customerID, float totalCost, int numberOfItems, int orderStatus, int staffID, int receiverID, String orderNotes) {
        if (orderNotes.isEmpty() && orderNotes.isBlank()) {
            orderNotes += "None";
        }
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();

        String sql = "INSERT INTO Orders (CustomerID, TotalCost, NumberOfItems, OrderDate, OrderStatusID, StaffID, ReceiverID, OrderNotes)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?,?);";

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

            st.executeUpdate();
            System.out.println("Insert thành công");

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        }
    }

    public void AddToOrderDetail(int customerID,int productCSID, int quantities) {

        String sql = "select CartID from Carts where CustomerID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);

                String sql1 = "select Cart_DetailID from Cart_Detail where ProductCSID = ? and CartID = ?";
                
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, productCSID);
                st1.setInt(2, cart_id);
                ResultSet rs1 = st1.executeQuery();
                
                String sql2 = "SELECT OrderID FROM Orders WHERE CustomerID = ?";
                 PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, customerID);
                ResultSet rs2 = st2.executeQuery();
                
                if (rs1.next()&& rs2.next()) {
                    int cartDetailID = rs1.getInt(1);
                    int orderID = rs2.getInt(1);
                    
                    String sql4 = "INSERT INTO Order_Detail (Cart_DetailID, OrderID, Quantities)VALUES (?, ?, ?)  ";
                    PreparedStatement st4 = connection.prepareStatement(sql4);
                    st4.setInt(1, cartDetailID);
                    st4.setInt(2, orderID);
                    st4.setInt(3, cart_id);
                    st4.executeUpdate();
                } 
            
            }
        } catch (Exception e) {
        }

    }

    //get the llast product in the order
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        dao.CreateNewOrder(2, 1500000, 2, 1, 9, 5, "DUME");
//        System.out.println(o);

    }
}
