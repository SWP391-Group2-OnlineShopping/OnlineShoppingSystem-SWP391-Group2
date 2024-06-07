/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

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
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Products;
import model.ReceiverInformation;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "ProcessProduct", urlPatterns = {"/processProduct"})
public class processPoduct extends HttpServlet {

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
            out.println("<title>Servlet processPoduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet processPoduct at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        
        if (session.getAttribute("acc") == null) {
            request.setAttribute("error", "Please login first");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (session.getAttribute("staff") != null) {
            Authorization.redirectToHome(session, response);
        } else {
            int customerId = Integer.parseInt(request.getParameter("customerID"));
            ProductDAO pDAO = new ProductDAO();

            String selectedList = request.getParameter("selectedList");
            if (selectedList == null || selectedList.isEmpty()) {
                request.setAttribute("error", "No products selected");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            String[] selectedItems = selectedList.split(",");
            List<CartItem> selectedCartItems = new ArrayList<>();

            for (String item : selectedItems) {
                String[] values = item.split("_");
                int productId = Integer.parseInt(values[0]);
                int size = Integer.parseInt(values[1]);
                int quantity = Integer.parseInt(values[2]);
                double price = Double.parseDouble(values[3]);
                int productCSID = Integer.parseInt(values[4]);

                Products product = pDAO.getProductByIDAndProductCS(productId, productCSID);
                float priceFloat = (float) price;

                CartItem selectedItem = new CartItem(product, productCSID, quantity, priceFloat, size);

                if (selectedItem != null) {
                    selectedItem.setQuantity(quantity);
                    selectedCartItems.add(selectedItem);

                }
            }

            for (CartItem selectedCartItem : selectedCartItems) {
                selectedCartItem.getProduct().getProductID();
            }
            Cart selectedCart = new Cart(selectedCartItems);

            double totalPriceDouble = selectedCart.GetTotalPrice();
//        for (CartItem c : selectedCartItems) {
//            c.getProductCSID();
//        }
            // Chuyển đổi double thành int bằng cách ép kiểu
            int totalPriceInt = (int) totalPriceDouble;
            session.setAttribute("selectedCartItems", selectedCartItems);

            CustomersDAO cDAO = new CustomersDAO();
            Customers getCustomerByID = cDAO.GetCustomerByID(customerId);
            ArrayList<ReceiverInformation> getCustomerAddress = cDAO.GetReceiverInforByCustomerID(customerId);

            session.setAttribute("customerInfo", getCustomerByID);
            session.setAttribute("customerAddress", getCustomerAddress);

            session.setAttribute("totalPrice", totalPriceInt);

            request.getRequestDispatcher("checkout.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        int customerId = Integer.parseInt(request.getParameter("customerID"));
        String newFullName = request.getParameter("newFullName");
        String newPhoneNumber = request.getParameter("newPhoneNumber");
        String newAddress = request.getParameter("newAddress");
        boolean makeDefault = request.getParameter("makeDefault") != null;

        if (newFullName != null && newPhoneNumber != null && newAddress != null) {
            CustomersDAO cDAO = new CustomersDAO();
            cDAO.AddNewAddress(customerId, newFullName, newPhoneNumber, newAddress, makeDefault);
        }

        // Update the address list and other session attributes
        CustomersDAO cDAO = new CustomersDAO();
        Customers getCustomerByID = cDAO.GetCustomerByID(customerId);
        ArrayList<ReceiverInformation> getCustomerAddress = cDAO.GetReceiverInforByCustomerID(customerId);

        session.setAttribute("customerInfo", getCustomerByID);
        session.setAttribute("customerAddress", getCustomerAddress);

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
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
