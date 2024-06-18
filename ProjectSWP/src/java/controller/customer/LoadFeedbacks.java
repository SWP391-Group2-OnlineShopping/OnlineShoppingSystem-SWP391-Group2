/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.FeedbackDAO;
import java.util.List;
import model.Feedbacks;
/**
 *
 * @author Admin
 */
@WebServlet(name="LoadFeedbacks", urlPatterns={"/LoadFeedbacks"})
public class LoadFeedbacks extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet LoadFeedbacks</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadFeedbacks at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;

    @Override
    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productID");
        int productId = (productIdParam != null) ? Integer.parseInt(productIdParam) : 0;

        // Get page parameter and set default if not provided
        String pageParam = request.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        // Get filter parameter and set default if not provided
        String filter = request.getParameter("filter");
        filter = (filter != null) ? filter : "";

        // Fetch feedbacks and calculate total pages
        List<Feedbacks> feedbacks = feedbackDAO.getFeedbacksByProduct(productId, page, filter);
        int totalPages = feedbackDAO.getTotalFeedbackPages(productId, filter);

        // Set attributes for JSP
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("filter", filter);
        request.setAttribute("productID", productIdParam);
        
        PrintWriter out = response.getWriter();
        out.println(filter);
        
        for (Feedbacks fb : feedbacks) {
            out.println(fb);
        }
        // Forward to JSP
        request.getRequestDispatcher("feedbacklist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
