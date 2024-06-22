/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import model.*;
import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "EditFeedback", urlPatterns = {"/editFeedback"})
public class EditFeedback extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        FeedbackDAO fDAO = new FeedbackDAO();
        Feedbacks feedback = fDAO.getFeedbackWithFeedbackID(feedbackID);
        request.setAttribute("feedback", feedback);
        request.getRequestDispatcher("editfeedback.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        FeedbackDAO fDAO = new FeedbackDAO();
        Feedbacks feedback = new Feedbacks();
        feedback.setFeedbackID(feedbackID);
        feedback.setCustomerID(Integer.parseInt(request.getParameter("customerID")));
        feedback.setProductID(Integer.parseInt(request.getParameter("productID")));
        feedback.setContent(request.getParameter("content"));
        feedback.setRatedStar(Float.parseFloat(request.getParameter("rating")));
        feedback.setStatus(true);
        try {
            fDAO.updateFeedback(feedback);
            // Get the image URL
            String[] imageUrls = request.getParameterValues("imageURL");
            if (imageUrls != null && imageUrls.length > 0) {
                for (String imageUrl : imageUrls) {
                    Images images = new Images();
                    images.setLink(imageUrl);
                    int imageID = new ImageDAO().insertImage(images);
                    new ImageDAO().insertImageMapping(1, feedbackID, imageID);
                }
            }
        } catch (SQLException e) {
            System.out.println("EditFeedback: " + e.getMessage());
        }
        feedback = fDAO.getFeedbackWithFeedbackID(feedbackID);
        request.setAttribute("feedback", feedback);
        request.setAttribute("success", "Update feedback successful");
        request.getRequestDispatcher("editfeedback.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
