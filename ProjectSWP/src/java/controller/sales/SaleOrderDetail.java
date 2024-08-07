/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.sales;

import controller.auth.Authorization;
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
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name="SaleOrderDetail", urlPatterns={"/saleorderdetail"})
public class SaleOrderDetail extends HttpServlet {
   
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
            out.println("<title>Servlet SaleOrderDetail</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleOrderDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
        } else if (!Authorization.isSaler((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            int orderID = 0;
            try {
                orderID = Integer.parseInt(request.getParameter("orderID"));
            } catch (Exception e) {
            }

            List<model.OrderDetail> listorderdetail = new ArrayList<>();
            try {
                orderID = Integer.parseInt(request.getParameter("orderID"));
            } catch (Exception e) {
            }
            ProductDAO pdao = new ProductDAO();

            OrderDAO dao = new OrderDAO();
            List<model.OrderDetail> odlist = new ArrayList<>();
            odlist = dao.getOrderDetailByOrderID(orderID);
            Orders order = new Orders();

            order = dao.getOrderByOrderID(orderID);
            listorderdetail = dao.getOrderDetailByOrderID(orderID);
            Customers c = dao.getCustomerInfoByOrderID(orderID);
            session.setAttribute("totalOrderPrice", order.getTotalCost());
            request.setAttribute("order", order);
            session.setAttribute("order", order);
            request.setAttribute("orderDetail", listorderdetail);
            request.setAttribute("cus", c);
            request.getRequestDispatcher("saleorderdetail.jsp").forward(request, response);
        }
       
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
