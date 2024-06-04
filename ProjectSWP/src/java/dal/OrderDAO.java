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

    //get the llast product in the order
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        Orders o = dao.getOrderByOrderID(1);
        System.out.println(o);

    }
}
