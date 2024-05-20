package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Posts;

public class PostDAO extends DBContext {

    public List<Posts> getAllPosts() {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Posts post = new Posts();
                post.setPostID(rs.getInt("PostID"));
                post.setStaffID(rs.getInt("StaffID"));
                post.setContent(rs.getString("Content"));
                post.setThumbnail(rs.getInt("Thumbnail"));
                post.setTitle(rs.getString("Title"));
                post.setUpdatedDate(rs.getDate("UpdatedDate"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public Posts getPostById(int postId) {
        Posts post = null;
        String sql = "SELECT * FROM Posts WHERE PostID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, postId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = new Posts();
                    post.setPostID(rs.getInt("PostID"));
                    post.setStaffID(rs.getInt("StaffID"));
                    post.setContent(rs.getString("Content"));
                    post.setThumbnail(rs.getInt("Thumbnail"));
                    post.setTitle(rs.getString("Title"));
                    post.setUpdatedDate(rs.getDate("UpdatedDate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }

    public boolean insertPost(Posts post) {
        String sql = "INSERT INTO Posts (StaffID, Content, Thumbnail, Title, UpdatedDate) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, post.getStaffID());
            pstmt.setString(2, post.getContent());
            pstmt.setInt(3, post.getThumbnail());
            pstmt.setString(4, post.getTitle());
            pstmt.setDate(5, new java.sql.Date(post.getUpdatedDate().getTime()));
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePost(Posts post) {
        String sql = "UPDATE Posts SET StaffID = ?, Content = ?, Thumbnail = ?, Title = ?, UpdatedDate = ? WHERE PostID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, post.getStaffID());
            pstmt.setString(2, post.getContent());
            pstmt.setInt(3, post.getThumbnail());
            pstmt.setString(4, post.getTitle());
            pstmt.setDate(5, new java.sql.Date(post.getUpdatedDate().getTime()));
            pstmt.setInt(6, post.getPostID());
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePost(int postId) {
        String sql = "DELETE FROM Posts WHERE PostID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, postId);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Posts> getMostRecentBlogs() {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts ORDER BY UpdatedDate DESC";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Posts post = new Posts();
                post.setPostID(rs.getInt("PostID"));
                post.setStaffID(rs.getInt("StaffID"));
                post.setContent(rs.getString("Content"));
                post.setThumbnail(rs.getInt("Thumbnail"));
                post.setTitle(rs.getString("Title"));
                post.setUpdatedDate(rs.getDate("UpdatedDate"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
}