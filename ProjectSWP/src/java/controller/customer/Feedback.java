package controller.customer;
import dal.FeedbackDAO;
import dal.ImageDAO;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Feedbacks;
import model.Images;
import model.OrderDetail;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "Feedback", urlPatterns = {"/Feedback"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class Feedback extends HttpServlet {

    private Connection connection; // Assuming you have a connection pool

    public void init() throws ServletException {
        // Initialize your database connection here
        // connection = ...
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Handle text fields
            int orderDetailID = Integer.parseInt(request.getParameter("OrderDetailID"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String content = request.getParameter("content");

            // Get productid and customerid
            OrderDAO orderDAO = new OrderDAO();
            OrderDetail orderDetail = orderDAO.getOrderDetailByOrderDetailID(orderDetailID);
            int productID = orderDetail.getProductID();
            int customerID = orderDAO.getOrderByOrderID(orderDetail.getOrderID()).getCustomerID();

            // Debugging: Print parameter values
            out.println("OrderDetailID: " + orderDetailID);
            out.println("Rating: " + rating);
            out.println("Content: " + content);
            out.println("ProductID: " + productID);
            out.println("CustomerID: " + customerID);

            // Handle file upload
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String avatarPath = null;
            List<String> imageLinks = new ArrayList<>();
            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + "uploads";
                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(uploadFilePath + File.separator + fileName);
                avatarPath = "uploads/" + fileName; // Relative path to the avatar image
                imageLinks.add(avatarPath);
            }

            for (String link : imageLinks) {
                out.println(link);
            }

            // Create feedback object
            Feedbacks feedback = new Feedbacks();
            feedback.setProductID(productID);
            feedback.setCustomerID(customerID);
            feedback.setContent(content);
            feedback.setRatedStar((float) rating);
            feedback.setStatus(true); // Assuming you want to set it as active
            feedback.setDate(Date.valueOf(LocalDate.now()));

            // Insert feedback into the database
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            int isInserted;

            try {
                isInserted = feedbackDAO.insertFeedback(feedback);
                if (isInserted != 0) {
                    int feedbackID = feedbackDAO.getFeedbackWithFeedbackID(isInserted).getFeedbackID();
                    out.println("Inserted Feedback ID: " + feedbackID);
                    orderDAO.UpdateFeedbackIDForOrderDetail(orderDetailID, feedbackID);
                    if (!imageLinks.isEmpty()) {
                        ImageDAO imageDAO = new ImageDAO();

                        for (String imageLink : imageLinks) {
                            Images image = new Images();
                            image.setLink(imageLink);
                            try {
                                int imageID = imageDAO.insertImage(image);
                                out.println("Inserted Image ID: " + imageID);
                                imageDAO.insertImageMapping(1, feedbackID, imageID); // Assuming EntityName for Feedback is 1
                                out.println("Image mapping inserted: feedbackID=" + feedbackID + ", imageID=" + imageID);
                            } catch (SQLException ex) {
                                Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, "Error inserting image or image mapping", ex);
                            }
                        }
                    }

                }

                if (isInserted != 0) {
                    response.getWriter().write("Feedback submitted successfully!");
                } else {
                    response.getWriter().write("Error submitting feedback.");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, "Error inserting feedback", ex);
                response.getWriter().write("Error submitting feedback: " + ex.getMessage());
            }

        } catch (Exception ex) {
            Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, "General error", ex);
            response.getWriter().write("General error: " + ex.getMessage());
        } finally {
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
