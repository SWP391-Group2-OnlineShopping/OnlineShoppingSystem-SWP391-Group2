/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

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
import java.util.List;
import model.CartItem;
import model.Customers;
import model.Products;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/addtocart"})
public class AddToCart extends HttpServlet {

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
            out.println("<title>Servlet AddToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCart at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("acc");

        if (customer == null) {
            session.setAttribute("message", "You need Login before want to buy!");
            response.sendRedirect("login");
        } else {
            // lấy thông tin với HTTPRequest
            int productId = Integer.parseInt(request.getParameter("productID"));
            int productCSSizeID = Integer.parseInt(request.getParameter("size"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            float price = Float.parseFloat(request.getParameter("productPrice"));

            CustomersDAO cDAO = new CustomersDAO();
            ProductDAO pDAO = new ProductDAO();
            // lấy product với id của nó
            Products product = pDAO.getProductByIDAndProductCS(productId, productCSSizeID);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");

            } else {
                int size = Integer.parseInt(product.getSize());
                //lấy các item trong card
                List<CartItem> listCartItem = cDAO.getCart(customer.getCustomer_id());
                CartItem item = new CartItem(product, productCSSizeID, quantity, price, size);
                //thêm item vào cart
                cDAO.addToCart(customer.getCustomer_id(), item);
                //tính tổng tiền tất cả order trong card
                float totalPrice = cDAO.totalAmount(customer.getCustomer_id());

                //lấy số lượng cart sau khi thêm vào
                request.setAttribute("CartSize", listCartItem.size());
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("listi", listCartItem);
                // Redirect lại trang product details vừa chọn
                request.getRequestDispatcher("viewcartdetail").forward(request, response);
            }
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
