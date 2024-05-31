package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Feedbacks;

public class FeedbackDAO extends DBContext {

    private static final String SELECT_ALL_FEEDBACKS = 
        "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, " +
        "p.Title AS ProductTitle, c.Fullname AS CustomerFullname " +
        "FROM Feedbacks f " +
        "JOIN Products p ON f.ProductID = p.ProductID " +
        "JOIN Customers c ON f.CustomerID = c.CustomerID";

    public List<Feedbacks> getAllFeedbacks() {
        List<Feedbacks> feedbacks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = this.connection;
            ps = conn.prepareStatement(SELECT_ALL_FEEDBACKS);
            rs = ps.executeQuery();

            while (rs.next()) {
                Feedbacks feedback = new Feedbacks();
                feedback.setFeedbackID(rs.getInt("FeedbackID"));
                feedback.setProductID(rs.getInt("ProductID"));
                feedback.setCustomerID(rs.getInt("CustomerID"));
                feedback.setContent(rs.getString("Content"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedback.setRatedStar(rs.getFloat("RatedStar"));
                feedback.setProductTitle(rs.getString("ProductTitle"));
                feedback.setCustomerFullname(rs.getString("CustomerFullname"));

                // Fetching image links for the current feedback
                ArrayList<String> imageLinks = getImageLinkForFeedback(feedback.getFeedbackID());
                feedback.setImageLinks(imageLinks);

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return feedbacks;
    }

    public ArrayList<String> getImageLinkForFeedback(int feedbackID) {
        ArrayList<String> imageLinks = new ArrayList<>();
        String query = "SELECT i.Link FROM Images i " +
                       "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID " +
                       "WHERE im.EntityName = 1 AND im.EntityID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, feedbackID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    imageLinks.add(resultSet.getString("Link"));
                }
                if (imageLinks.isEmpty()) {
                    System.out.println("No matching records found for feedbackID: " + feedbackID);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL exception occurred while fetching image links for feedbackID: " + feedbackID);
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected exception occurred while fetching image links for feedbackID: " + feedbackID);
            e.printStackTrace();
        }
        return imageLinks;
    }
    
    public boolean updateFeedbackStatus(int feedbackID, boolean status) {
        try (PreparedStatement preparedStatement = connection.prepareStatement("UPDATE Feedbacks SET Status = ? WHERE FeedbackID = ?")) {
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, feedbackID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static void main(String[] args) {
        FeedbackDAO feedbackDAO = new FeedbackDAO();

            List<Feedbacks> feedbacks = feedbackDAO.getAllFeedbacks();
            
            // Debug: Print the fetched feedbacks
            for (Feedbacks feedback : feedbacks) {
                System.out.println("Feedback ID: " + feedback.getFeedbackID());
                System.out.println("Product ID: " + feedback.getProductID());
                System.out.println("Customer ID: " + feedback.getCustomerID());
                System.out.println("Content: " + feedback.getContent());
                System.out.println("Status: " + feedback.isStatus());
                System.out.println("Rated Star: " + feedback.getRatedStar());
                System.out.println("Product Title: " + feedback.getProductTitle());
                System.out.println("Customer Fullname: " + feedback.getCustomerFullname());
                System.out.println("Image Links: " + feedback.getImageLinks());
                System.out.println("-------------------------------------");
            }
    }
}