/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.*;
import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "DeleteFeedback", urlPatterns = {"/deleteFeedback"})
public class DeleteFeedback extends HttpServlet {

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
            out.println("<title>Servlet DeleteFeedback</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteFeedback at " + request.getContextPath() + "</h1>");
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
        String feedbackIDRaw = request.getParameter("feedbackID");
        String customerIDRaw = request.getParameter("customerID");
        HttpSession session = request.getSession();

        if (feedbackIDRaw != null && customerIDRaw != null) {
            try {
                int feedbackID = Integer.parseInt(feedbackIDRaw);
                int customerID = Integer.parseInt(customerIDRaw);

                FeedbackDAO fDAO = new FeedbackDAO();

                fDAO.deleteFeedback(feedbackID, customerID);
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid feedback ID or customer ID format.");
            }
        } else {
            session.setAttribute("error", "Invalid feedback ID or customer ID.");
        }
        
        // Chuyển hướng về trang feedback list với page 1 và filter mặc định
        response.sendRedirect("myfeedback?customerID=" + customerIDRaw + "&page=1&filter=''");

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
        processRequest(request, response);
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
