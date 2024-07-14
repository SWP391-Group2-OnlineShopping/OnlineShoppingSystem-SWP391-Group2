/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Product;

import controller.auth.Authorization;
import dal.ProductCategoriesListDAO;
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
import model.ProductCS;
import model.ProductCategoryList;
import model.Products;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "ProductDetailsServlet", urlPatterns = {"/productdetails"})
public class ProductDetailsServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailsServlet at " + request.getContextPath() + "</h1>");
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
        String redirect = request.getParameter("redirect");
        request.setAttribute("redirect", redirect);

        
            //        Get parameter id
            int id = Integer.parseInt(request.getParameter("id"));

            ProductDAO pDAO = new ProductDAO();
            ProductCategoriesListDAO pclDAO = new ProductCategoriesListDAO();
            Products p = pDAO.getProductByID(id);
            ProductCategoryList pcl = pDAO.getProductCategory(id);
//        List<ProductCS> sizes = pDAO.getProductSize(id);
            List<ProductCS> quantitiesAndHold = pDAO.getProductSizeQuantities(id);

            List<Products> lastestProductList = pDAO.getLastestProducts();
            List<ProductCategoryList> listCategories = pclDAO.getAllCategories();
            List<String> subImages = pDAO.getImagesByProductId(id);
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
                request.setAttribute("error", errorMessage);
            }

            session.setAttribute("product", p);
            session.setAttribute("quantities", quantitiesAndHold);
            session.setAttribute("lastestPro", lastestProductList);
            session.setAttribute("productCategory", pcl);
            session.setAttribute("listCategories", listCategories);
            session.setAttribute("subImages", subImages);
            request.getRequestDispatcher("productdetails.jsp").forward(request, response);
        

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