/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.OrderDAO;
import dal.ProductDAO;
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
import model.Customers;
import model.Orders;
import model.Products;
import model.OrderDetail;

/**
 *
 * @author DELL
 */
@WebServlet(name = "MyOrder", urlPatterns = {"/myorder"})
public class MyOrder extends HttpServlet {

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
            out.println("<title>Servlet MyOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyOrder at " + request.getContextPath() + "</h1>");
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
        Customers cus = (Customers) session.getAttribute("acc");
        OrderDAO dao = new OrderDAO();
        int page = 1;
        int recordsPerPage = 5;
        ProductDAO pdao = new ProductDAO();
        List<Products> products = pdao.getLastestProducts();
        int orderStatus = 0;
        List<Orders> orders = new ArrayList<>();

        if (cus == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect("login?error=You must login to see your order&redirect=myorder");
            return;
        }

        try {
            String orderStatusParam = request.getParameter("orderStatus");
            if (orderStatusParam != null) {
                orderStatus = Integer.parseInt(orderStatusParam);
            }
        } catch (NumberFormatException e) {
            // Log the exception for debugging purposes
            System.err.println("Invalid orderStatus parameter: " + e.getMessage());
            // Optionally, you could set a default value or handle this scenario differently
            orderStatus = 0; // Default order status if parsing fails
        }
        int count = dao.countOrderByStatusAndCustomer(orderStatus, cus.getCustomer_id());
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));

            }
        } catch (NumberFormatException e) {
            // Handle exception
        }
        try {
            String txt = request.getParameter("txt");
            List<OrderDetail> searchList = new ArrayList<>();
            searchList = dao.getOrderDetailBySearch(cus.getCustomer_id(), txt);
            request.setAttribute("searchList", searchList);
            request.setAttribute("search", txt);
        } catch (Exception e) {
        }
        int endPage = (int) Math.ceil((double) count / recordsPerPage);
        // User is logged in, allow access to see the order
        orders = dao.getAllOrders(cus.getCustomer_id(), orderStatus, page);
        request.setAttribute("endPage", endPage);
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("myorder.jsp").forward(request, response);
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
