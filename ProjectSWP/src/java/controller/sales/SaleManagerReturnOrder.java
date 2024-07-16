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
@WebServlet(name = "SaleManagerReturnOrder", urlPatterns = {"/salemanagerreturnorder"})
public class SaleManagerReturnOrder extends HttpServlet {

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
            out.println("<title>Servlet SaleManagerReturnOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleManagerReturnOrder at " + request.getContextPath() + "</h1>");
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
        } else if (!Authorization.isSaleManager((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {

            OrderDAO dao = new OrderDAO();
            int page = 1;
            int salesFilter = 0;
            List<Orders> orders = new ArrayList<>();

            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            String searchQuery = request.getParameter("searchQuery");
            try {
                String salesParam = request.getParameter("salesSort");

                
                if (salesParam != null) {
                    salesFilter = Integer.parseInt(salesParam);
                }

            } catch (NumberFormatException e) {
                // Log the exception for debugging purposes
                System.err.println("Invalid orderStatus parameter: " + e.getMessage());
                // Optionally, you could set a default value or handle this scenario differently
                salesFilter = 0;
            }


            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));

                }
            } catch (NumberFormatException e) {
                // Handle exception
            }


            StaffDAO saleDAO = new StaffDAO();
            List<Staffs> saleList = new ArrayList<>();
            saleList = saleDAO.getAllStaffSales();
            orders = dao.getAllReturnOrdersFromSaleMana( page, salesFilter, dateFrom, dateTo, searchQuery);

            session.setAttribute("index", page);
            request.setAttribute("currentPage", page);
            request.setAttribute("orders", orders);
            request.setAttribute("sales", saleList);

            request.getRequestDispatcher("salemanager-returnorder.jsp").forward(request, response);
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
        request.getRequestDispatcher("salemanager-returnorder.jsp").forward(request, response);
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
