/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.BrandTotal;
import model.OrderDetail;
import model.Orders;

/**
 *
 * @author DELL
 */
public class MarketingDAO extends DBContext {

    public int getCustomer() {
        String sql = " select count(*) from Customers ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int getNewCustomer(String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM Customers WHERE CreatedDate BETWEEN ? AND ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int getAllFeedbacks() {
        String sql = "SELECT COUNT(*) FROM Feedbacks";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalFeedbacks(String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM Feedbacks WHERE Date BETWEEN ? AND ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return 0;
    }

    public int getAllPost() {
        String sql = "select count(*) from Posts";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int getTotalPost(String startDate, String endDate) {
        String sql = "select count(*) from Posts where UpdatedDate  BETWEEN ? AND ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int countRevenue7Day(String startDate, String endDate) {
        String sql = "  SELECT SUM(TotalCost) AS GrandTotalAmount FROM Orders\n"
                + "where OrderDate between ? and ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int countRevenue() {
        String sql = "  SELECT\n"
                + "   SUM(TotalCost) AS GrandTotalAmount\n"
                + " FROM\n"
                + "   [SWP_Query].[dbo].Orders;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public int countTotalOrder() {
        String sql = "  SELECT\n"
                + "               COUNT(*) AS TotalOrders\n"
                + "                FROM\n"
                + "              [SWP_Query].[dbo].Orders;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    public List<BrandTotal> getTotalByBrand() {
        List<BrandTotal> list = new ArrayList<>();
        String sql = "SELECT b.Name AS brandname, SUM(o.TotalCost) AS total \n"
                + "                FROM Order_Detail od \n"
                + "                JOIN Cart_Detail cd ON od.Cart_DetailID = cd.Cart_DetailID \n"
                + "                JOIN Product_CS pcs ON cd.ProductCSID = pcs.ProductCSID\n"
                + "				JOIN Products p ON pcs.ProductID = p.ProductID\n"
                + "                JOIN Product_Categories pc ON p.ProductID = pc.ProductID \n"
                + "                JOIN Product_Category_List b ON pc.ProductCL = b.ProductCL \n"
                + "                JOIN Orders o ON od.OrderID = o.OrderID \n"
                + "                GROUP BY b.Name;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new BrandTotal(rs.getString("brandname"), rs.getFloat("total")));
            }
        } catch (Exception e) {
            e.printStackTrace();  // In ra lỗi nếu có
        }
        return list;
    }

    public List<Orders> getRevenue(String year) {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT\n"
                + "    m.MonthNumber AS OrderMonth,\n"
                + "    COALESCE(SUM(o.TotalCost), 0) AS MonthlyRevenue\n"
                + "FROM\n"
                + "    (\n"
                + "        SELECT 1 AS MonthNumber UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL\n"
                + "        SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL\n"
                + "        SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12\n"
                + "    ) AS m\n"
                + "LEFT JOIN\n"
                + "    Orders o ON MONTH(o.OrderDate) = m.MonthNumber AND YEAR(o.OrderDate) = ? AND o.OrderStatusID = 5\n"
                + "GROUP BY\n"
                + "    m.MonthNumber\n"
                + "ORDER BY\n"
                + "    m.MonthNumber;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Orders(rs.getString("OrderMonth"), rs.getInt("MonthlyRevenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getEarningDay(String day) {
        String sql = "SELECT SUM(TotalCost) AS DailyRevenue\n"
                + "FROM Orders\n"
                + "WHERE CONVERT(date, OrderDate) = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, day);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("DailyRevenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Orders getHighestMonth() {
        String sql = "SELECT TOP 1\n"
                + "  MONTH(OrderDate) AS OrderMonth,\n"
                + "  SUM(TotalCost) AS MonthlyRevenue\n"
                + "FROM Orders\n"
                + "GROUP BY YEAR(OrderDate), MONTH(OrderDate)\n"
                + "ORDER BY MonthlyRevenue DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Orders(rs.getString("OrderMonth"), rs.getInt("MonthlyRevenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Orders getLowestMonth() {
        String sql = "SELECT TOP 1\n"
                + "  MONTH(OrderDate) AS OrderMonth,\n"
                + "  SUM(TotalCost) AS MonthlyRevenue\n"
                + "FROM Orders\n"
                + "GROUP BY YEAR(OrderDate), MONTH(OrderDate)\n"
                + "ORDER BY MonthlyRevenue ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Orders(rs.getString("OrderMonth"), rs.getInt("MonthlyRevenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getProductBestSeller() {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT TOP (4)\n"
                + "    p.ProductID,\n"
                + "    p.Title,\n"
                + "    p.SalePrice,\n"
                + "    i.Link AS img2,\n"
                + "    SUM(cd.Quantities) AS quantitySold,\n"
                + "    SUM(p.SalePrice * cd.Quantities) AS priceSold\n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    Order_Detail od ON o.OrderID = od.OrderID\n"
                + "JOIN \n"
                + "    Cart_Detail cd ON od.Cart_DetailID = cd.Cart_DetailID\n"
                + "JOIN \n"
                + "	Product_CS pcs ON pcs.ProductCSID = cd.ProductCSID\n"
                + "JOIN \n"
                + "    Products p ON pcs.ProductID = p.ProductID\n"
                + "LEFT JOIN \n"
                + "    Images i ON p.Thumbnail = i.ImageID\n"
                + "GROUP BY \n"
                + "    p.ProductID, p.Title, p.SalePrice, i.Link\n"
                + "ORDER BY \n"
                + "    quantitySold DESC;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt("ProductID"), rs.getString("Title"), rs.getFloat("SalePrice"), rs.getString("img2"), rs.getInt("quantitySold"), rs.getFloat("priceSold")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
// check debug using main
    //    public static void main(String[] args) {
    //        MarketingDAO dao = new MarketingDAO();
    //        String[] categoryIds = {"1", "3"}; // Example category IDs that the post must match all
    //        List<Posts> posts = dao.showAllPosts(0,0);
    //        System.out.println("Posts that match all specified categories:");
    //        
    //            for(Posts p:posts){
    //                System.out.println(p);
    //            
    //            }
    //    }

    public static void main(String[] args) {
        MarketingDAO dao = new MarketingDAO();
        List<Orders> list = new ArrayList<>();
        list = dao.getRevenue("2024");
        for (Orders b : list) {
            System.out.println(b);
        }
    }

}
