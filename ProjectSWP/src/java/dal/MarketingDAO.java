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
import java.util.HashMap;
import java.util.Map;
import model.BrandTotal;
import model.OrderDetail;
import model.Orders;
import model.PostCategories;
import model.PostCategoryList;

/**
 *
 * @author DELL
 */
public class MarketingDAO extends DBContext {

    //THIS IS POST CATEGORY CRUD
    //Get all Post Category
    public ArrayList<PostCategoryList> getAllPostCategories() {
        ArrayList<PostCategoryList> categories = new ArrayList<>();
        String sql = "SELECT * FROM Post_Category_List";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                PostCategoryList category = new PostCategoryList();
                category.setPostCL(rs.getInt("PostCL"));
                category.setName(rs.getString("Name"));
                category.setDescription(rs.getString("Description"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    //get Category by PostCl 
    public PostCategoryList getCategoryById(int postCL) {
        PostCategoryList category = null;
        String query = "SELECT * FROM Post_Category_List WHERE PostCL=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, postCL);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    category = new PostCategoryList();
                    category.setPostCL(resultSet.getInt("PostCL"));
                    category.setName(resultSet.getString("Name"));
                    category.setDescription(resultSet.getString("Description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    // Method to add a new post category
    public boolean addPostCategory(PostCategoryList category) {
        String query = "INSERT INTO Post_Category_List (Name, Description) VALUES (?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to update an existing post category
    public boolean updatePostCategory(PostCategoryList category) {
        String query = "UPDATE Post_Category_List SET Name = ?, Description = ? WHERE PostCL = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.setInt(3, category.getPostCL());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to delete a post category
    public boolean deletePostCategory(int postCL) {
        String query = "DELETE FROM Post_Category_List WHERE PostCL = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, postCL);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Get Categories from a PostID 
    public ArrayList<PostCategoryList> getPostCategoriesByPostID(int PostID) {
        ArrayList<PostCategoryList> posts = new ArrayList<>();
        String sql = "SELECT pcl.PostCL AS CategoryID, pcl.Name AS CategoryName , pcl.Description AS CategoryDescription \n"
                + "FROM Post_Categories pc\n"
                + "JOIN Post_Category_List pcl ON pc.PostCL = pcl.PostCL\n"
                + "WHERE pc.PostID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, PostID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PostCategoryList pcl = new PostCategoryList(rs.getInt(1), rs.getString(2), rs.getString(3));
                    posts.add(pcl);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    //Posts managements
    //Show all the posts as well as order the post by some criterias
    public List<Posts> showAllPosts(int x, int y) {
        MarketingDAO dao = new MarketingDAO();
        List<Posts> posts = new ArrayList<>();
        List<PostCategoryList> categories = new ArrayList<>();
        String criteria;
        String order;

        switch (x) {
            case 1:
                criteria = "UpdatedDate";
                break;
            case 2:
                criteria = "Content";
                break;
            default:
                criteria = "UpdatedDate";
                break;
        }
        switch (y) {
            case 1:
                order = "ASC";
                break;
            case 2:
                order = "DESC";
                break;
            default:
                order = "DESC";
                break;
        }
        String sql = "SELECT p.PostID,p.Content,p.Title, p.UpdatedDate, s.Username, i.Link "
                + "FROM Posts p "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "ORDER BY " + criteria + " " + order;

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Posts post = new Posts();
                post.setPostID(rs.getInt("PostID"));
                post.setStaff(rs.getString("Username"));
                post.setContent(rs.getString("Content"));
                post.setTitle(rs.getString("Title"));
                post.setUpdatedDate(rs.getDate("UpdatedDate"));
                post.setThumbnailLink(rs.getString("Link"));
                categories = dao.getPostCategoriesByPostID(rs.getInt("PostID"));
                post.setCategories(categories);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    //Get a Specific Post by its ID
    public Posts getPostByPostID(int PostID) {
        String sql = "SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link, pcl.Name AS CategoryName "
                + "FROM Posts p "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "JOIN Post_Categories pc ON p.PostID = pc.PostID "
                + "JOIN Post_Category_List pcl ON pc.PostCL = pcl.PostCL "
                + "WHERE p.PostID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, PostID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    MarketingDAO dao = new MarketingDAO();
                    ArrayList<PostCategoryList> categories = dao.getPostCategoriesByPostID(PostID);
                    Posts post = new Posts(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getDate("UpdatedDate"),
                            rs.getString("Username"),
                            rs.getString("Link"),
                            categories
                    );

                    return post;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//filter all Post that have chosen categories
    public List<Posts> getPostsByCategories(String[] categoryIds, int x, int y) {
        MarketingDAO dao = new MarketingDAO();

        List<Posts> posts = new ArrayList<>();
        String criteria;
        String order;
        Map<Integer, Posts> postsMap = new HashMap<>();

        switch (x) {
            case 1:
                criteria = "UpdatedDate";
                break;
            case 2:
                criteria = "Content";
                break;
            default:
                criteria = "UpdatedDate";
                break;
        }
        switch (y) {
            case 1:
                order = "ASC";
                break;
            case 2:
                order = "DESC";
                break;
            default:
                order = "DESC";
                break;
        }
        StringBuilder query = new StringBuilder(
                "SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link AS ThumbnailLink "
                + "FROM Posts p "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Post_Categories pc ON p.PostID = pc.PostID "
                + "JOIN Post_Category_List pcl ON pc.PostCL = pcl.PostCL "
                + "WHERE pc.PostCL IN ("
        );

        for (int i = 0; i < categoryIds.length; i++) {
            query.append("?");
            if (i < categoryIds.length - 1) {
                query.append(",");
            }
        }

        query.append(") "
                + "GROUP BY p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link "
                + "HAVING COUNT(DISTINCT pc.PostCL) = ? "
                + "ORDER BY " + criteria + " " + order);

        try (PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < categoryIds.length; i++) {
                preparedStatement.setString(i + 1, categoryIds[i]);
            }
            preparedStatement.setInt(categoryIds.length + 1, categoryIds.length);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Posts post = new Posts();
                    post.setPostID(rs.getInt("PostID"));
                    post.setStaff(rs.getString("Username"));
                    post.setContent(rs.getString("Content"));
                    post.setTitle(rs.getString("Title"));
                    post.setUpdatedDate(rs.getDate("UpdatedDate"));
                    post.setThumbnailLink(rs.getString("ThumbnailLink"));
                    ArrayList<PostCategoryList> categories = dao.getPostCategoriesByPostID(rs.getInt("PostID"));
                    post.setCategories(categories);
                    posts.add(post);

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

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
        String sql = "SELECT b.Name AS brandname, SUM(o.TotalCost) AS total "
                + "FROM Order_Detail od "
                + "JOIN Cart_Detail cd ON od.Cart_DetailID = cd.Cart_DetailID "
                + "JOIN Products p ON cd.ProductID = p.ProductID "
                + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                + "JOIN Product_Category_List b ON pc.ProductCL = b.ProductCL "
                + "JOIN Orders o ON od.OrderID = o.OrderID "
                + "GROUP BY b.Name;";
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
                + "    MONTH(OrderDate) AS OrderMonth,\n"
                + "    SUM(TotalCost) AS MonthlyRevenue\n"
                + "FROM\n"
                + "    Orders\n"
                + "WHERE\n"
                + "    YEAR(OrderDate) = ?\n"
                + "GROUP BY\n"
                + "    MONTH(OrderDate)\n"
                + "ORDER BY\n"
                + "    OrderMonth;";
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
        String sql = "SELECT TOP (4) \n"
                + "    p.ProductID,\n"
                + "    p.Title,\n"
                + "    p.SalePrice,\n"
                + "    i.Link AS img2,\n"
                + "    SUM(cd.Quantities) AS quantitySold,\n"
                + "    SUM(p.SalePrice * cd.Quantities) AS priceSold\n"
                + "FROM \n"
                + "    Cart_Detail cd\n"
                + "JOIN \n"
                + "    Products p ON cd.ProductID = p.ProductID\n"
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
        System.out.println(dao.getProductBestSeller());
    }

}
