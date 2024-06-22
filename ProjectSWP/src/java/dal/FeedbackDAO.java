package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Customers;
import model.Feedbacks;
import model.Images;
import model.Products;

public class FeedbackDAO extends DBContext {

    private static final String SELECT_ALL_FEEDBACKS
            = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, f.Date, "
            + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname "
            + "FROM Feedbacks f "
            + "JOIN Products p ON f.ProductID = p.ProductID "
            + "JOIN Customers c ON f.CustomerID = c.CustomerID "
            + "WHERE f.Status = 1";

    private static final String SELECT_FEEDBACKS_WITH_ID
            = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, f.Date, "
            + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname "
            + "FROM Feedbacks f "
            + "JOIN Products p ON f.ProductID = p.ProductID "
            + "JOIN Customers c ON f.CustomerID = c.CustomerID "
            + "WHERE f.FeedbackID = ? AND f.Status = 1";

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

    public ArrayList<Images> getImageForFeedback(int feedbackID) {
        ArrayList<Images> images = new ArrayList<>();
        String query = "SELECT i.[ImageID], i.Link FROM Images i "
                + "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID "
                + "WHERE im.EntityName = 1 AND im.EntityID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, feedbackID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    images.add(new Images(resultSet.getInt(1), resultSet.getString(2)));
                }
                if (images.isEmpty()) {
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
        return images;
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
                    ArrayList<Images> images = getImageForFeedback(feedback.getFeedbackID());
                    feedback.setImageLinks(imageLinks);
                    feedback.setImages(images);
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

    // New methods
    public List<Feedbacks> getFeedbacksByProduct(int productId, int page, String filter) {
        List<Feedbacks> feedbacks = new ArrayList<>();
        String sql = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, f.Date, "
                + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname "
                + "FROM Feedbacks f "
                + "JOIN Products p ON f.ProductID = p.ProductID "
                + "JOIN Customers c ON f.CustomerID = c.CustomerID "
                + "WHERE f.ProductID = ? AND f.Status = 1 ";

        // Add filtering conditions based on the filter parameter
        switch (filter) {
            case "5":
                sql += "AND f.RatedStar = 5 ";
                break;
            case "4":
                sql += "AND f.RatedStar = 4 ";
                break;
            case "3":
                sql += "AND f.RatedStar = 3 ";
                break;
            case "2":
                sql += "AND f.RatedStar = 2 ";
                break;
            case "1":
                sql += "AND f.RatedStar = 1 ";
                break;
            case "comment":
                sql += "AND f.Content IS NOT NULL ";
                break;
            case "image":
                sql += "AND EXISTS (SELECT 1 FROM Images i "
                        + "JOIN ImageMappings im ON i.ImageID = im.ImageID "
                        + "WHERE im.EntityName = 1 AND im.EntityID = f.FeedbackID) ";
                break;
        }

        // Add pagination for SQL Server and order by FeedbackID descending
        int offset = (page - 1) * 10;
        sql += "ORDER BY f.FeedbackID DESC OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
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
                feedback.setDate(rs.getDate("Date")); // Set the date field

                // Fetching image links for the current feedback
                ArrayList<String> imageLinks = getImageLinkForFeedback(feedback.getFeedbackID());
                feedback.setImageLinks(imageLinks);

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedbacks;
    }

    public int getTotalFeedbackPages(int productId, String filter) {
        int totalFeedbacks = 0;
        String sql = "SELECT COUNT(*) AS total FROM Feedbacks f "
                + "WHERE f.ProductID = ? AND f.Status = 1 ";

        // Add filtering conditions based on the filter parameter
        switch (filter) {
            case "5":
                sql += "AND f.RatedStar = 5 ";
                break;
            case "4":
                sql += "AND f.RatedStar = 4 ";
                break;
            case "3":
                sql += "AND f.RatedStar = 3 ";
                break;
            case "2":
                sql += "AND f.RatedStar = 2 ";
                break;
            case "1":
                sql += "AND f.RatedStar = 1 ";
                break;
            case "comment":
                sql += "AND f.Content IS NOT NULL ";
                break;
            case "image":
                sql += "AND EXISTS (SELECT 1 FROM Images i "
                        + "JOIN ImageMappings im ON i.ImageID = im.ImageID "
                        + "WHERE im.EntityName = 1 AND im.EntityID = f.FeedbackID) ";
                break;
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalFeedbacks = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return (int) Math.ceil((double) totalFeedbacks / 10);
    }

    public Customers getCustomerByID(int id) {
        Customers c = null;
        try {
            String sql = "SELECT * FROM Customers WHERE CustomerID = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                c = new Customers();
                c.setCustomer_id(rs.getInt(1));
                c.setUser_name(rs.getString(2));
                c.setPass_word(rs.getString(3));
                c.setEmail(rs.getString(4));
                c.setGender(rs.getBoolean(5));
                c.setAddress(rs.getString(6));
                c.setFull_name(rs.getString(7));
                c.setStatus(rs.getString(8));
                c.setPhone_number(rs.getString(9));
                c.setDob(rs.getDate(10));
                c.setAvatar(rs.getString(11));
            }
        } catch (Exception e) {
        }
        return c;
    }

    public Products getProductByID(int productID) {
        Products product = null;
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID WHERE p.ProductID = ? AND p.Status = 1";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, productID);
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

    public float getAvgRating(int productID) {
        float avgRating = 0;
        String sql = "SELECT AVG(RatedStar) AS avgRating FROM Feedbacks WHERE ProductID = ? AND Status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                avgRating = rs.getFloat("avgRating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return avgRating;
    }

    public List<Feedbacks> getFeedbacksByCustomerID(int customerId, int page, String filter) {
        List<Feedbacks> feedbacks = new ArrayList<>();
        String sql = "SELECT f.FeedbackID, f.ProductID, f.CustomerID, f.Content, f.Status, f.RatedStar, f.Date, "
                + "p.Title AS ProductTitle, c.Fullname AS CustomerFullname, "
                + "DATEDIFF(day, f.Date, GETDATE()) AS DaysSinceFeedback "
                + "FROM Feedbacks f "
                + "JOIN Products p ON f.ProductID = p.ProductID "
                + "JOIN Customers c ON f.CustomerID = c.CustomerID "
                + "WHERE f.CustomerID = ? AND f.Status = 1 ";

        // Add filtering conditions based on the filter parameter
        switch (filter) {
            case "5":
                sql += "AND f.RatedStar = 5 ";
                break;
            case "4":
                sql += "AND f.RatedStar = 4 ";
                break;
            case "3":
                sql += "AND f.RatedStar = 3 ";
                break;
            case "2":
                sql += "AND f.RatedStar = 2 ";
                break;
            case "1":
                sql += "AND f.RatedStar = 1 ";
                break;
            case "comment":
                sql += "AND f.Content IS NOT NULL ";
                break;
            case "image":
                sql += "AND EXISTS (SELECT 1 FROM Images i "
                        + "JOIN ImageMappings im ON i.ImageID = im.ImageID "
                        + "WHERE im.EntityName = 1 AND im.EntityID = f.FeedbackID) ";
                break;
        }

        // Add pagination for SQL Server
        int offset = (page - 1) * 10;
        sql += " ORDER BY DaysSinceFeedback ASC, f.FeedbackID OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedbacks feedback = new Feedbacks();
                feedback.setFeedbackID(rs.getInt("FeedbackID"));
                feedback.setProductID(rs.getInt("ProductID"));
                feedback.setCustomerID(rs.getInt("CustomerID"));
                feedback.setContent(rs.getString("Content"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedback.setRatedStar(rs.getFloat("RatedStar"));
                feedback.setDate(rs.getDate("Date"));
                feedback.setProductTitle(rs.getString("ProductTitle"));
                feedback.setCustomerFullname(rs.getString("CustomerFullname"));

                //get day since feedback
                int daySinceFeedback = rs.getInt("DaysSinceFeedback");
                feedback.setDaySinceFeedback(daySinceFeedback);

                // Fetching image links for the current feedback
                ArrayList<String> imageLinks = getImageLinkForFeedback(feedback.getFeedbackID());
                feedback.setImageLinks(imageLinks);

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedbacks;
    }

    public int getTotalFeedbackPagesByCustomerID(int customerId, String filter) {
        int totalFeedbacks = 0;
        String sql = "SELECT COUNT(*) AS total FROM Feedbacks f "
                + "WHERE f.CustomerID = ? AND f.Status = 1 ";

        // Add filtering conditions based on the filter parameter
        switch (filter) {
            case "5":
                sql += "AND f.RatedStar = 5 ";
                break;
            case "4":
                sql += "AND f.RatedStar = 4 ";
                break;
            case "3":
                sql += "AND f.RatedStar = 3 ";
                break;
            case "2":
                sql += "AND f.RatedStar = 2 ";
                break;
            case "1":
                sql += "AND f.RatedStar = 1 ";
                break;
            case "comment":
                sql += "AND f.Content IS NOT NULL ";
                break;
            case "image":
                sql += "AND EXISTS (SELECT 1 FROM Images i "
                        + "JOIN ImageMappings im ON i.ImageID = im.ImageID "
                        + "WHERE im.EntityName = 1 AND im.EntityID = f.FeedbackID) ";
                break;
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalFeedbacks = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return (int) Math.ceil((double) totalFeedbacks / 10);
    }

    public int totalFeedbackOfCustomer(int id) {
        int total = 0;
        try {
            String sql = "SELECT Count (*) AS totalFeedback FROM Feedbacks WHERE CustomerID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("totalFeedback");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return total;
    }

    public void deleteFeedback(int feedbackID, int customerID) {
        String sql1 = "UPDATE Order_Detail SET FeedbackID = NULL WHERE FeedbackID = ?";
        String sql = "DELETE FROM Feedbacks WHERE FeedbackID = ? AND CustomerID = ?";

        PreparedStatement ps1 = null;
        PreparedStatement ps = null;

        try {
            ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1, feedbackID);
            ps1.executeUpdate();

            ps = connection.prepareStatement(sql);
            ps.setInt(1, feedbackID);
            ps.setInt(2, customerID);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public void updateFeedback(Feedbacks feedback) throws SQLException {
        String updateFeedbackSQL = "UPDATE Feedbacks SET ProductID = ?, CustomerID = ?, Content = ?, Status = ?, RatedStar = ? WHERE FeedbackID = ?";
        try {
            PreparedStatement updateFeedbackStmt = connection.prepareStatement(updateFeedbackSQL);
            // Update feedback details
            updateFeedbackStmt.setInt(1, feedback.getProductID());
            updateFeedbackStmt.setInt(2, feedback.getCustomerID());
            updateFeedbackStmt.setString(3, feedback.getContent());
            updateFeedbackStmt.setBoolean(4, feedback.isStatus());
            updateFeedbackStmt.setFloat(5, feedback.getRatedStar());
            updateFeedbackStmt.setInt(6, feedback.getFeedbackID());
            System.out.println(updateFeedbackStmt.executeUpdate());
        } catch (SQLException e) {
            System.out.println("updateFeedback: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        FeedbackDAO fb = new FeedbackDAO();
        List<Feedbacks> fbs = fb.getFeedbacksByCustomerID(1, 1, "");
        for (Feedbacks ff : fbs) {
            System.out.println(ff);
        }

        int total = fb.totalFeedbackOfCustomer(1);
        System.out.println(total);
    }

}
