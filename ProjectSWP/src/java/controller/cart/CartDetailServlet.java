/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.cart;

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
import model.Cart;
import model.CartItem;
import model.Products;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "CartDetailServlet", urlPatterns = {"/cartdetail"})
public class CartDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet CartDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartDetailServlet at " + request.getContextPath() + "</h1>");
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
//        HttpSession session = request.getSession();
//        Cart cart = null;
//        session.setAttribute("cart", cart);
//        Object ob = session.getAttribute("cart");
//        if(ob != null){
//            cart = (Cart) ob;
//        }
//        else{
//            cart = new Cart();
//        }
//        int productId = Integer.parseInt(request.getParameter("productID"));
//        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
//        int size = Integer.parseInt(request.getParameter("size"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//        try{
//            ProductDAO pDAO = new ProductDAO();
//            Products product = pDAO.getProductByID(productId);
//            CartItem item = new CartItem(product, quantity, productPrice, size);
//            cart.AddItem(item);
//        }catch(Exception e){
//            e.getStackTrace();
//        }
//        ArrayList<CartItem> listCart =  (ArrayList<CartItem>) cart.getItems();
//        
//        session.setAttribute("cart", listCart);
//        session.setAttribute("listSize", size);
//        response.sendRedirect("productdetails?id=" + productId);

// Lấy thông tin sản phẩm từ request

        int productId = Integer.parseInt(request.getParameter("productID"));
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int size = Integer.parseInt(request.getParameter("size"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO pDAO = new ProductDAO();
        Products product = pDAO.getProductByID(productId);
        CartItem item = new CartItem(product, quantity, productPrice, size);

        // Lấy hoặc tạo giỏ hàng từ session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Thêm mục vào giỏ hàng
        cart.AddItem(item);

        // Chuyển hướng đến trang hiển thị giỏ hàng
        response.sendRedirect("productdetails?id=" + productId);
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
