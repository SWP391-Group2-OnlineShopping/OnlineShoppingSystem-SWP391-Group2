package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Feedbacks;

public class FeedbackDAO extends DBContext {

    private static final String SELECT_ALL_FEEDBACKS
            = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, "
            + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname "
            + "FROM Feedbacks f "
            + "JOIN Products p ON f.ProductID = p.ProductID "
            + "JOIN Customers c ON f.CustomerID = c.CustomerID";

    private static final String SELECT_FEEDBACKS_WITH_ID
            = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, "
            + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname "
            + "FROM Feedbacks f "
            + "JOIN Products p ON f.ProductID = p.ProductID "
            + "JOIN Customers c ON f.CustomerID = c.CustomerID "
            + "WHERE f.FeedbackID = ? ";

    private static final String INSERT_FEEDBACK
            = "INSERT INTO Feedbacks (ProductID, CustomerID, Content, Status, RatedStar) VALUES (?, ?, ?, ?, ?)";

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
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return feedbacks;
    }

    public ArrayList<String> getImageLinkForFeedback(int feedbackID) {
        ArrayList<String> imageLinks = new ArrayList<>();
        String query = "SELECT i.Link FROM Images i "
                + "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID "
                + "WHERE im.EntityName = 1 AND im.EntityID = ?";

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

    public Feedbacks getFeedbackWithFeedbackID(int feedbackID) {
        Feedbacks feedback = null;
        String query = SELECT_FEEDBACKS_WITH_ID;

        try (Connection conn = this.connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, feedbackID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    feedback = new Feedbacks();
                    feedback.setFeedbackID(rs.getInt("FeedbackID"));
                    feedback.setProductID(rs.getInt("ProductID"));
                    feedback.setCustomerID(rs.getInt("CustomerID"));
                    feedback.setContent(rs.getString("Content"));
                    feedback.setStatus(rs.getBoolean("Status"));
                    feedback.setRatedStar(rs.getFloat("RatedStar"));
                    feedback.setProductTitle(rs.getString("ProductTitle"));
                    feedback.setCustomerFullname(rs.getString("CustomerFullname"));

                    // Fetching image links for the feedback
                    ArrayList<String> imageLinks = getImageLinkForFeedback(feedback.getFeedbackID());
                    feedback.setImageLinks(imageLinks);

                    System.out.println("Feedback found: " + feedback);
                } else {
                    System.out.println("No feedback found with ID: " + feedbackID);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedback;
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

    public int insertFeedback(Feedbacks feedback) throws SQLException {
        String sql = "INSERT INTO Feedbacks (ProductID, CustomerID, Content, RatedStar, Status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, feedback.getProductID());
            stmt.setInt(2, feedback.getCustomerID());
            stmt.setString(3, feedback.getContent());
            stmt.setFloat(4, feedback.getRatedStar());
            stmt.setBoolean(5, feedback.isStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating feedback failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    feedback.setFeedbackID(generatedKeys.getInt(1));
                    return feedback.getFeedbackID();
                } else {
                    throw new SQLException("Creating feedback failed, no ID obtained.");
                }
            }
        }
    }
    
}
