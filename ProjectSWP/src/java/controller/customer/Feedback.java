package controller.customer;

import dal.FeedbackDAO;
import dal.OrderDAO;
import dal.ImageDAO;
import model.Feedbacks;
import model.OrderDetail;
import model.Images;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
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
        // Handle text fields
        int orderDetailID = Integer.parseInt(request.getParameter("OrderDetailID"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String content = request.getParameter("content");

        // Get productid and customerid
        OrderDAO orderDAO = new OrderDAO();
        OrderDetail orderDetail = orderDAO.getOrderDetailByOrderDetailID(orderDetailID);
        int productID = orderDetail.getProductID();
        int customerID = orderDAO.getOrderByOrderID(orderDetail.getOrderID()).getCustomerID();

        PrintWriter out = response.getWriter();
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

        // Insert feedback into the database
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        int isInserted;
        
        try {
            isInserted = feedbackDAO.insertFeedback(feedback);
            if (isInserted != 0) {
                orderDAO.UpdateFeedbackIDForOrderDetail(orderDetailID, feedbackDAO.getFeedbackWithFeedbackID(isInserted).getFeedbackID());

                if (avatarPath != null) {
                    ImageDAO imageDAO = new ImageDAO();
                    Images image = new Images();
                    image.setLink(avatarPath);
                    int imageID;
                    try {
                        imageID = imageDAO.insertImage(image);
                        imageDAO.insertImageMapping(1, feedbackDAO.getFeedbackWithFeedbackID(isInserted).getFeedbackID(), imageID); // Assuming EntityName for Feedback is 1

                    } catch (SQLException ex) {
                        Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            
            }

            if (isInserted != 0) {
                response.getWriter().write("Feedback submitted successfully!");
            } else {
                response.getWriter().write("Error submitting feedback.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
