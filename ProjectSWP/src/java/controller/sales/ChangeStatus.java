/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sales;

import dal.OrderDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ChangeStatus", urlPatterns = {"/changestatus"})
public class ChangeStatus extends HttpServlet {

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
            out.println("<title>Servlet ChangeStatus</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeStatus at " + request.getContextPath() + "</h1>");
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
        OrderDAO oDAO = new OrderDAO();
        ProductDAO pdao = new ProductDAO();
        int order_id = 0;
        int status = 0;
        int value = 0;
        String page = "";
        try {
            page = request.getParameter("page");
            order_id = Integer.parseInt(request.getParameter("order_id"));
            status = Integer.parseInt(request.getParameter("status"));
            value = Integer.parseInt(request.getParameter("value"));
        } catch (NumberFormatException e) {
            // Log the exception for debugging purposes
            System.err.println("Invalid parameter: " + e.getMessage());
        }

        if (status == 1 && value == 2) {
            //Confirm order
            oDAO.changeStatusOrder(order_id, value);
            request.getRequestDispatcher("saleorderlist").forward(request, response);
        } else if (value == 6) {
            //Cancel order
            oDAO.changeStatusOrder(order_id, value);
            List<model.OrderDetail> odlist = new ArrayList<>();
            odlist = oDAO.getOrderDetailByOrderID(order_id);
            for (model.OrderDetail od : odlist) {
                oDAO.decreaseHoldAfterCancel(order_id, pdao.getProductCSIDByProducIDAndSize(od.getProductID(), od.getSize()));
            }

            if ("UnpaidPage".equals(page)) {
                request.getRequestDispatcher("cancelorderunpaid").forward(request, response);
            } else if ("OrderListPage".equals(page)) {
                request.getRequestDispatcher("saleorderlist").forward(request, response);
            }

        } else if (status == 13 && value == 14) {
            //Waiting return
            oDAO.changeStatusOrder(order_id, value);
            request.getRequestDispatcher("salereturnorder").forward(request, response);

        } else if (status == 13 && value == 15) {
            //Denied return
            oDAO.changeStatusOrder(order_id, value);
            request.getRequestDispatcher("salereturnorder").forward(request, response);

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
