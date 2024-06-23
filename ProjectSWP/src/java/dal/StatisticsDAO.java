/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BrandTotal;
import model.CustomerCount;
import model.FeedbackByCategory;
import model.OrderStatusCount;
import model.OrderTrend;
import model.RevenueByCategory;

/**
 *
 * @author admin
 */
public class StatisticsDAO extends DBContext {

    public List<OrderStatusCount> getNewOrdersToday() throws SQLException {
        String sql = "SELECT os.OrderStatus, COUNT(*) as Count "
                + "FROM Orders o "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "WHERE o.OrderDate = CAST(GETDATE() AS DATE) "
                + "GROUP BY os.OrderStatus";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            List<OrderStatusCount> orderStatusCounts = new ArrayList<>();
            while (rs.next()) {
                OrderStatusCount osc = new OrderStatusCount();
                osc.setOrderStatus(rs.getString("OrderStatus"));
                osc.setCount(rs.getInt("Count"));
                orderStatusCounts.add(osc);
            }
            return orderStatusCounts;
        }
    }

    public List<RevenueByCategory> getRevenues() throws SQLException {
        String sql = "SELECT pcl.Name AS Category, SUM(p.SalePrice * cd.Quantities) AS TotalRevenue "
                + "FROM Orders o "
                + "JOIN Order_Detail od ON o.OrderID = od.OrderID "
                + "JOIN Cart_Detail cd ON od.Cart_DetailID = cd.Cart_DetailID "
                + "JOIN Product_CS pcs ON cd.ProductCSID = pcs.ProductCSID "
                + "JOIN Products p ON pcs.ProductID = p.ProductID "
                + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                + "JOIN Product_Category_List pcl ON pc.ProductCL = pcl.ProductCL "
                + "GROUP BY pcl.Name";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            List<RevenueByCategory> revenuesByCategory = new ArrayList<>();
            while (rs.next()) {
                RevenueByCategory rbc = new RevenueByCategory();
                rbc.setCategory(rs.getString("Category"));
                rbc.setTotalRevenue(rs.getFloat("TotalRevenue"));
                revenuesByCategory.add(rbc);
            }
            return revenuesByCategory;
        }
    }

    public List<CustomerCount> getCustomersToday() throws SQLException {
        String sql = "SELECT 'Newly Registered' as Type, COUNT(*) as Count "
                + "FROM Customers "
                + "WHERE CreatedDate = CAST(GETDATE() AS DATE) "
                + "UNION ALL "
                + "SELECT 'Newly Bought' as Type, COUNT(DISTINCT o.CustomerID) as Count "
                + "FROM Orders o "
                + "WHERE o.OrderDate = CAST(GETDATE() AS DATE)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            List<CustomerCount> customerCounts = new ArrayList<>();
            while (rs.next()) {
                CustomerCount cc = new CustomerCount();
                cc.setType(rs.getString("Type"));
                cc.setCount(rs.getInt("Count"));
                customerCounts.add(cc);
            }
            return customerCounts;
        }
    }

    public List<FeedbackByCategory> getFeedbacks() throws SQLException {
        String sql = "SELECT pcl.Name AS Category, AVG(f.RatedStar) AS AverageStar "
                + "FROM Feedbacks f "
                + "JOIN Products p ON f.ProductID = p.ProductID "
                + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                + "JOIN Product_Category_List pcl ON pc.ProductCL = pcl.ProductCL "
                + "GROUP BY pcl.Name";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            List<FeedbackByCategory> feedbacksByCategory = new ArrayList<>();
            while (rs.next()) {
                FeedbackByCategory fbc = new FeedbackByCategory();
                fbc.setCategory(rs.getString("Category"));
                fbc.setAverageStar(rs.getFloat("AverageStar"));
                feedbacksByCategory.add(fbc);
            }
            return feedbacksByCategory;
        }
    }

    public List<OrderTrend> getOrderTrends(String startDate, String endDate) throws SQLException {
        String sql = "SELECT OrderDate, COUNT(*) AS OrderCount, "
                + "SUM(CASE WHEN os.OrderStatus = 'Success' THEN 1 ELSE 0 END) AS SuccessCount "
                + "FROM Orders o "
                + "JOIN Order_Status os ON o.OrderStatusID = os.OrderStatusID "
                + "WHERE o.OrderDate BETWEEN ? AND ? "
                + "GROUP BY OrderDate";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();
            List<OrderTrend> trends = new ArrayList<>();
            while (rs.next()) {
                OrderTrend trend = new OrderTrend();
                trend.setOrderDate(rs.getDate("OrderDate"));
                trend.setOrderCount(rs.getInt("OrderCount"));
                trend.setSuccessCount(rs.getInt("SuccessCount"));
                trends.add(trend);
            }
            return trends;
        }
    }

    public List<BrandTotal> getTotalRevenueByBrand() {
        List<BrandTotal> list = new ArrayList<>();
        String sql = "SELECT pcl.Name AS Brand, COALESCE(SUM(p.SalePrice * cd.Quantities), 0) AS TotalRevenue "
                + "FROM Product_Category_List pcl "
                + "LEFT JOIN Product_Categories pc ON pc.ProductCL = pcl.ProductCL "
                + "LEFT JOIN Products p ON pc.ProductID = p.ProductID "
                + "LEFT JOIN Product_CS pcs ON p.ProductID = pcs.ProductID "
                + "LEFT JOIN Cart_Detail cd ON pcs.ProductCSID = cd.ProductCSID "
                + "LEFT JOIN Order_Detail od ON cd.Cart_DetailID = od.Cart_DetailID "
                + "GROUP BY pcl.Name "
                + "ORDER BY TotalRevenue DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new BrandTotal(rs.getString("Brand"), rs.getFloat("TotalRevenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
