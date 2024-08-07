/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import com.google.gson.JsonObject;
import controller.auth.Authorization;
import dal.CustomersDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.channels.IllegalChannelGroupException;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Products;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "UpdatePriceServlet", urlPatterns = {"/updatePrice"})
public class UpdatePriceServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdatePriceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePriceServlet at " + request.getContextPath() + "</h1>");
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

        if (session.getAttribute("acc") == null) {
            request.setAttribute("error", "Please login first");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (session.getAttribute("staff") != null) {
            Authorization.redirectToHome(session, response);
        } else {
            Customers customer = (Customers) session.getAttribute("acc");
            CustomersDAO cDAO = new CustomersDAO();
            ProductDAO pDAO = new ProductDAO();
            String productIdStr = request.getParameter("productId");
            String productCSIDStr = request.getParameter("productCSID");
            String numStr = request.getParameter("num");

            try {
                int productId = Integer.parseInt(productIdStr);
                int productCSID = Integer.parseInt(productCSIDStr);
                int num = Integer.parseInt(numStr);

                Products product = pDAO.getProductByIDAndProductCS(productId, productCSID);

                float price = product.getSalePrice();

                if ((num == -1) && (cDAO.checkQuantity(customer.getCustomer_id(), productCSID) == 1)) {
                    cDAO.removeItem(productCSID, price, customer.getCustomer_id());
                } else if (num == -1) {
                    cDAO.decreaseItem(productCSID, price, customer.getCustomer_id());
                } else if (num == 1) {
                    if (cDAO.checkQuantity(customer.getCustomer_id(), productCSID) < cDAO.checkQuantityProductCS(productCSID) - cDAO.checkHoldProductCS(productCSID)) {
                        cDAO.increaseItem(productCSID, price, customer.getCustomer_id());

                    } else {
                        request.setAttribute("error", "There are not enough quanlities!");
                    }

                }

            } catch (Exception e) {
            }

            List<CartItem> listItem = cDAO.getCart(customer.getCustomer_id());
            float total = cDAO.totalAmount(customer.getCustomer_id());

            request.setAttribute("listi", listItem);
            request.setAttribute("totalPrice", total);
            session.setAttribute("CartSize", listItem.size());
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }

//        response.sendRedirect("cart.jsp");
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
