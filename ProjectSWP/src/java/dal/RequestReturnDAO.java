/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author LENOVO
 */
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Feedbacks;
import model.RequestReturn;

public class RequestReturnDAO extends DBContext {

    private static final String SELECT_REQUESTRETURN_WITH_ID
            = "select r.RequestID, r.OrderID, r.CustomerID, r.Reason, r.PhoneNumber, r.BankAccount, r.Date, ri.ReceiverFullName\n"
            + "from RequestReturn r\n"
            + "join Orders o on o.OrderID = r.OrderID\n"
            + "join Customers c on c.CustomerID = r.CustomerID\n"
            + "join Receiver_Information ri on ri.ReceiverInformationId = o.ReceiverID\n"
            + "Where r.RequestID = ?";

    public int insertRequestReturn(RequestReturn request) throws SQLException {
        String sql = "INSERT INTO RequestReturn (OrderID, CustomerID, Reason, PhoneNumber, BankAccount, Date) VALUES (?,? , ?, ?, ?,? )";
        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, request.getOrderID());
            stmt.setInt(2, request.getCustomerID());
            stmt.setString(3, request.getReason());
            stmt.setString(4, request.getPhoneNumber());
            stmt.setString(5, request.getBankAccount());
            stmt.setDate(6, (Date) request.getDate());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating feedback failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    request.setRequestID(generatedKeys.getInt(1));
                    return request.getRequestID();
                } else {
                    throw new SQLException("Creating feedback failed, no ID obtained.");
                }
            }
        }
    }

    public RequestReturn getRequestWithRequestID(int requestID) {
        // Feedbacks feedback = null;
        RequestReturn request = null;
        String query = SELECT_REQUESTRETURN_WITH_ID;

        try (Connection conn = this.connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, requestID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    request = new RequestReturn();
                    request.setRequestID(rs.getInt("RequestID"));
                    request.setOrderID(rs.getInt("OrderID"));
                    request.setCustomerID(rs.getInt("CustomerID"));
                    request.setReason(rs.getString("Reason"));

                    request.setPhoneNumber(rs.getString("PhoneNumber"));
                    request.setBankAccount(rs.getString("BankAccount"));
                    request.setDate(rs.getDate("Date"));
                    request.setReceiverFullName(rs.getString("ReceiverFullName"));

                    // Fetching image links for the feedback
                    ArrayList<String> imageLinks = getImageLinkForRequestReturn(request.getRequestID());
                    request.setImageLinks(imageLinks);

                    System.out.println("Feedback found: " + request);
                } else {
                    System.out.println("No feedback found with ID: " + requestID);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return request;
    }

    public ArrayList<String> getImageLinkForRequestReturn(int requestID) {
        ArrayList<String> imageLinks = new ArrayList<>();
        String query = "SELECT i.Link FROM Images i \n"
                + "                INNER JOIN ImageMappings im ON i.ImageID = im.ImageID \n"
                + "                WHERE im.EntityName = 5 AND im.EntityID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, requestID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    imageLinks.add(resultSet.getString("Link"));
                }
                if (imageLinks.isEmpty()) {
                    System.out.println("No matching records found for feedbackID: " + requestID);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL exception occurred while fetching image links for requestID: " + requestID);
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected exception occurred while fetching image links for requestID: " + requestID);
            e.printStackTrace();
        }
        return imageLinks;
    }

    public RequestReturn getRequestByOrderID(int orderId) {
        String sql = "SELECT r.RequestID, r.OrderID, r.CustomerID, r.Reason, r.PhoneNumber, r.BankAccount, r.Date, ri.ReceiverFullName "
                + "FROM RequestReturn r "
                + "JOIN Customers c ON c.CustomerID = r.CustomerID "
                + "JOIN Orders o ON o.OrderID = r.OrderID "
                + "JOIN Receiver_Information ri ON ri.ReceiverInformationId = o.ReceiverID "
                + "WHERE r.OrderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    RequestReturn request = new RequestReturn();
                    request.setRequestID(rs.getInt("RequestID"));
                    request.setOrderID(rs.getInt("OrderID"));
                    request.setCustomerID(rs.getInt("CustomerID"));
                    request.setReason(rs.getString("Reason"));
                    request.setPhoneNumber(rs.getString("PhoneNumber"));
                    request.setBankAccount(rs.getString("BankAccount"));
                    request.setDate(rs.getDate("Date"));
                    request.setReceiverFullName(rs.getString("ReceiverFullName"));

                    // Fetching image links for the current feedback
                    ArrayList<String> imageLinks = getImageLinkForRequestReturn(request.getRequestID());
                    request.setImageLinks(imageLinks);

                    return request;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void main(String[] args) {
        RequestReturnDAO rdao = new RequestReturnDAO();
        System.out.println(rdao.getRequestByOrderID(14));
    }
}
