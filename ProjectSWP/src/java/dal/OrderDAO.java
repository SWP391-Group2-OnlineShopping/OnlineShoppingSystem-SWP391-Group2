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
import model.Customers;

/**
 *
 * @author DELL
 */
public class OrderDAO extends DBContext {

    public List<Orders> getAllOrders(int customerID, int orderStatus) {
        List<Orders> list = new ArrayList<>();
        List<OrderDetail> listorderdetail = new ArrayList<>();
        String os = "WHERE o.CustomerID =" + customerID + " ";
        if (orderStatus != 0) {
            os = os+  " AND o.OrderStatusID=" + orderStatus + " ";
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

    public Customers getCustomerInfoByOrderID(int orderID) {

        String sql = "select c.FullName,c.Address,c.Email,c.Mobile,c.Gender,c.Avatar "
                + "from Customers c JOIN Orders o ON c.CustomerID=o.CustomerID "
                + "WHERE o.OrderID=?";
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
        String sql = "SELECT od.Order_DetailID,od.Cart_DetailID,od.Order_DetailID,p.ProductID,pcs.Size,p.Title,  p.SalePrice,  i.Link,od.Quantities, p.SalePrice * od.Quantities AS price \n"
                + "from Order_Detail od \n"
                + "JOIN Cart_Detail cd ON od.Cart_DetailID=cd.Cart_DetailID \n"
                + "JOIN Product_CS pcs ON pcs.ProductCSID=cd.ProductCSID\n"
                + "JOIN Products p ON pcs.ProductID=p.ProductID\n"
                + "JOIN Images i ON i.ImageID = p.Thumbnail \n"
                + "JOIN Orders o ON o.OrderID = od.OrderID\n"
                + "Where p.Title like ? AND o.CustomerID =?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, "%"+txt+"%");
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

    //get the llast product in the order
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        List<OrderDetail> list = dao.getOrderDetailBySearch(2, "a");
        for (OrderDetail o : list) {
            System.out.println(o);
        }
        Customers c = dao.getCustomerInfoByOrderID(1);

    }
}
