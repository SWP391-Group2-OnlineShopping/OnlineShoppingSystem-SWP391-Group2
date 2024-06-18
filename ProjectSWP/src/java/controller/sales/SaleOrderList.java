/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sales;

import controller.auth.Authorization;
import dal.OrderDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Orders;
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "SaleOrderList", urlPatterns = {"/saleorderlist"})
public class SaleOrderList extends HttpServlet {

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
            out.println("<title>Servlet SaleOrderList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleOrderList at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isSaler((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            Staffs sale = (Staffs) session.getAttribute("staff");
            OrderDAO dao = new OrderDAO();
            int page = 1;
            int recordsPerPage = 5;
            int orderStatus = 0;
            List<Orders> orders = new ArrayList<>();

            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            String searchQuery = request.getParameter("searchQuery");
            try {
                String orderStatusParam = request.getParameter("statusSort");

                if (orderStatusParam != null) {
                    orderStatus = Integer.parseInt(orderStatusParam);
                }
            } catch (NumberFormatException e) {
                // Log the exception for debugging purposes
                System.err.println("Invalid orderStatus parameter: " + e.getMessage());
                // Optionally, you could set a default value or handle this scenario differently
                orderStatus = 0; // Default order status if parsing fails
            }
            int count = dao.countOrderByStatus(orderStatus);
            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));

                }
            } catch (NumberFormatException e) {
                // Handle exception
            }

            int endPage = (int) Math.ceil((double) count / recordsPerPage);

            session.setAttribute("orderStatus", orderStatus);
            orders = dao.getAllOrdersFromSale(sale.getStaffID(), orderStatus, page, dateFrom, dateTo, searchQuery);

            request.setAttribute("endPage", endPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("orders", orders);

            request.getRequestDispatcher("saleorderlist.jsp").forward(request, response);
        }

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
        request.getRequestDispatcher("saleorderlist.jsp").forward(request, response);
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
