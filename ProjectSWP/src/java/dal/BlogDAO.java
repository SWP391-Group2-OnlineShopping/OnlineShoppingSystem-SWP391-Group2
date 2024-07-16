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
import model.Posts;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import model.PostCategoryList;
import model.Products;

/**
 *
 * @author DELL
 */
public class BlogDAO extends DBContext {

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
    //Show all the posts as well as order the post by some criterias as well as thier pagination
    public List<Posts> showAllPosts(String txt, int x, int y, int index) {
        BlogDAO dao = new BlogDAO();
        List<Posts> posts = new ArrayList<>();
        List<PostCategoryList> categories = new ArrayList<>();
        String criteria;
        String order;
        String search = "WHERE p.Status = 1";
        if (!txt.isEmpty()) {
            search = search + "AND  p.title like '%" + txt + "%'";
        }

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
        String sql = "SELECT p.PostID,p.Content,p.Title, p.UpdatedDate, s.FullName, i.Link,p.Status "
                + "FROM Posts p "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + search
                + "ORDER BY " + criteria + " " + order + " "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (index - 1) * 5);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Posts post = new Posts();
                    post.setPostID(rs.getInt("PostID"));
                    post.setStaff(rs.getString("FullName"));
                    post.setContent(rs.getString("Content"));
                    post.setTitle(rs.getString("Title"));
                    post.setUpdatedDate(rs.getDate("UpdatedDate"));
                    post.setThumbnailLink(rs.getString("Link"));
                    categories = dao.getPostCategoriesByPostID(rs.getInt("PostID"));
                    post.setCategories(categories);
                    post.setStatus(rs.getBoolean("Status"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    //count the upper code posts
    public int getCountAllPost(String txt, int x, int y) {
        String search = "WHERE p.Status = 1";
        if (!txt.isEmpty()) {
            search = search + "AND  p.title like '%" + txt + "%'";
        }
        String sql = "SELECT COUNT(*) "
                + "FROM Posts p "
                + search;
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Products getProductByPostID(int postID) {
        Products product = null;
        String sql = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "JOIN Posts post ON post.ProductID = p.ProductID "
                + "WHERE post.PostID = ? AND p.Status = 1";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, postID);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    //Get a Specific Post by its ID
    public Posts getPostByPostID(int PostID) {
        String sql = "SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link, pcl.Name AS CategoryName,p.Status,p.Feature "
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
                    BlogDAO dao = new BlogDAO();
                    ArrayList<PostCategoryList> categories = dao.getPostCategoriesByPostID(PostID);
                    Posts post = new Posts();
                    post.setPostID(rs.getInt(1));
                    post.setTitle(rs.getString(2));
                    post.setContent(rs.getString(3));
                    post.setUpdatedDate(rs.getDate("UpdatedDate"));
                    post.setStaff(rs.getString("Username"));
                    post.setThumbnailLink(rs.getString("Link"));
                    post.setCategories(categories);
                    post.setStatus(rs.getBoolean("Status"));
                    post.setFeature(rs.getBoolean("Feature"));
                    Products p = dao.getProductByPostID(rs.getInt("PostID"));
                    post.setProduct(p);
                    return post;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//filter all Post that have chosen categories
    public List<Posts> getPostsByCategoriesAndFilter(String[] categoryIds, String txt, int x, int y, int index) {
        BlogDAO dao = new BlogDAO();
        StringBuilder search = new StringBuilder("AND p.Status = 1");
        if (!txt.isEmpty()) {
            search.append(" AND p.title LIKE ?");
        }
        List<Posts> posts = new ArrayList<>();
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

        StringBuilder query = new StringBuilder(
                "SELECT DISTINCT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link AS ThumbnailLink, p.Status "
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
                + search.toString()
                + " ORDER BY " + criteria + " " + order + " "
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY");

        System.out.println("Constructed Query: " + query.toString());

        try (PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            for (int i = 0; i < categoryIds.length; i++) {
                preparedStatement.setString(paramIndex++, categoryIds[i]);
            }
            if (!txt.isEmpty()) {
                preparedStatement.setString(paramIndex++, "%" + txt + "%");
            }
            preparedStatement.setInt(paramIndex, (index - 1) * 5);

            System.out.println("Prepared Statement: " + preparedStatement.toString());

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
                    post.setStatus(rs.getBoolean("Status"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int countPostsByCategoriesAndFilter(String[] categoryIds, String txt) {
        int count = 0;
        String search = "";
        if (!txt.isEmpty()) {
            search = "AND p.title LIKE '%" + txt + "%'";
        }

        StringBuilder query = new StringBuilder(
                "SELECT COUNT(DISTINCT p.PostID) "
                + "FROM Posts p "
                + "JOIN Post_Categories pc ON p.PostID = pc.PostID "
                + "WHERE pc.PostCL IN ("
        );

        for (int i = 0; i < categoryIds.length; i++) {
            query.append("?");
            if (i < categoryIds.length - 1) {
                query.append(",");
            }
        }

        query.append(") " + search);

        try (PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < categoryIds.length; i++) {
                preparedStatement.setString(i + 1, categoryIds[i]);
            }

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1); // Retrieve the count from the result set
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Posts> getAllPosts() {
        BlogDAO dao = new BlogDAO();
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link, p.Status,p.Feature "
                + "FROM Posts p "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Posts post = new Posts();
                post.setPostID(rs.getInt("PostID"));
                post.setStaff(rs.getString("Username"));
                post.setContent(rs.getString("Content"));
                post.setTitle(rs.getString("Title"));
                post.setUpdatedDate(rs.getDate("UpdatedDate"));
                post.setThumbnailLink(rs.getString("Link"));
                ArrayList<PostCategoryList> categories = getPostCategoriesByPostID(rs.getInt("PostID"));
                post.setCategories(categories);
                post.setStatus(rs.getBoolean("Status"));
                post.setFeature(rs.getBoolean("Feature"));
                Products p = dao.getProductByPostID(rs.getInt("PostID"));
                post.setProduct(p);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Posts> getFilteredAndSortedPosts(String field, String value, String status) {
        List<Posts> list = new ArrayList<>();
        BlogDAO dao = new BlogDAO();
        StringBuilder sql = new StringBuilder("SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link, p.Status,p.Feature "
                + "FROM Posts p "
                + "JOIN Staffs s ON p.StaffID = s.StaffID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID ");

        List<String> conditions = new ArrayList<>();

        if (status != null && !status.equals("all")) {
            conditions.add("p.Status = ?");
        }

        if (!conditions.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        if (field != null && value != null) {
            switch (field) {
                case "id":
                    sql.append(" ORDER BY p.PostID ").append(value.equals("asc") ? "ASC" : "DESC");
                    break;
                case "title":
                    sql.append(" ORDER BY p.Title ").append(value.equals("asc") ? "ASC" : "DESC");
                    break;
                case "author":
                    sql.append(" ORDER BY s.FullName ").append(value.equals("asc") ? "ASC" : "DESC");
                    break;
                default:
                    break;
            }
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (status != null && !status.equals("all")) {
                stmt.setBoolean(paramIndex++, status.equals("visible"));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Posts post = new Posts();
                    post.setPostID(rs.getInt("PostID"));
                    post.setStaff(rs.getString("Username"));
                    post.setContent(rs.getString("Content"));
                    post.setTitle(rs.getString("Title"));
                    post.setUpdatedDate(rs.getDate("UpdatedDate"));
                    post.setThumbnailLink(rs.getString("Link"));
                    ArrayList<PostCategoryList> categories = getPostCategoriesByPostID(rs.getInt("PostID"));
                    post.setCategories(categories);
                    post.setStatus(rs.getBoolean("Status"));
                    post.setFeature(rs.getBoolean("Feature"));
                    Products p = dao.getProductByPostID(rs.getInt("PostID"));
                    post.setProduct(p);
                    list.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updatePostStatus(int postID, boolean status) {
        try (PreparedStatement preparedStatement = connection.prepareStatement("Update  Posts\n"
                + "SET Status = ? WHERE POSTID = ?")) {
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, postID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePostFeature(int postID, boolean status) {
        try (PreparedStatement preparedStatement = connection.prepareStatement("Update  Posts\n"
                + "SET Feature = ? WHERE POSTID = ?")) {
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, postID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updatePost(int postID, int staffID, String content, int thumbnail, String title, boolean status, boolean feature) {
        String sql = "UPDATE Posts SET Content=?, Thumbnail=?, Title=?, UpdatedDate=GETDATE(), Status=?, Feature=? WHERE PostID=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, content);
            preparedStatement.setInt(2, thumbnail);
            preparedStatement.setString(3, title);
            preparedStatement.setBoolean(4, status);
            preparedStatement.setBoolean(5, feature);
            preparedStatement.setInt(6, postID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // Log the exception (using a logging framework or standard output for simplicity)
            e.printStackTrace();
            // Optionally rethrow the exception as a custom exception or handle it accordingly
            throw new RuntimeException("Error updating post with ID " + postID, e);
        }
    }

    public int addPostImage(String link) {
        int imageID = 0;
        String sql = "INSERT INTO Images (Link) VALUES (?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, link);
            stmt.executeUpdate();

            // Retrieve the generated keys
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    imageID = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imageID;
    }

    public List<Posts> getAllPostFromCategoryId(String categoryID) {
        BlogDAO dao = new BlogDAO();
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT p.PostID, p.Content, p.Title, p.UpdatedDate, s.Username, i.Link, p.Status\n"
                + "                FROM Posts p \n"
                + "                JOIN Staffs s ON p.StaffID = s.StaffID \n"
                + "               JOIN Images i ON p.Thumbnail = i.ImageID \n"
                + "			   JOIN Post_Categories pc ON p.PostID = pc.PostID\n"
                + "			   WHERE pc.PostCL = " + categoryID;

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Posts post = new Posts();
                post.setPostID(rs.getInt("PostID"));
                post.setStaff(rs.getString("Username"));
                post.setContent(rs.getString("Content"));
                post.setTitle(rs.getString("Title"));
                post.setUpdatedDate(rs.getDate("UpdatedDate"));
                post.setThumbnailLink(rs.getString("Link"));
                ArrayList<PostCategoryList> categories = getPostCategoriesByPostID(rs.getInt("PostID"));
                post.setCategories(categories);
                post.setStatus(rs.getBoolean("Status"));
                Products p = dao.getProductByPostID(rs.getInt("PostID"));
                post.setProduct(p);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public boolean addNewPost(Posts post) {
        String query = "INSERT INTO Posts (StaffID, Content, Thumbnail, Title, UpdatedDate,Status,Feature) VALUES(?,?,?,?,GETDATE(),?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, post.getStaffID());
            preparedStatement.setString(2, post.getContent());
            int imgLink = addPostImage(post.getThumbnailLink());
            preparedStatement.setInt(3, imgLink);
            preparedStatement.setString(4, post.getTitle());
            preparedStatement.setBoolean(5, post.isStatus());
            preparedStatement.setBoolean(6, post.isFeature());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getNewestPost() {
        String sql = "SELECT TOP 1 PostID FROM Posts ORDER BY PostID DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean addNewPostCL(int postCL) {
        String query = "INSERT INTO Post_Categories (PostCL, PostID) VALUES(?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, postCL);
            preparedStatement.setInt(2, getNewestPost());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // check debug using main
    public static void main(String[] args) {
        BlogDAO dao = new BlogDAO();
        String[] categoryIds = {"1", "2"}; // Example category IDs that the post must match all
        List<Posts> post = dao.getPostsByCategoriesAndFilter(categoryIds, "", 0, 0, 1);
        for (Posts p : post) {
            System.out.println(p);
        }

    }
}
