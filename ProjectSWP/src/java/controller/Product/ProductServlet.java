/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Product;

import Format.CurrencyFormatter;
import dal.ProductCategoriesListDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.ProductCategoryList;

/**
 *
 * @author admin
 */
public class ProductServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        ProductCategoriesListDAO categoryDAO = new ProductCategoriesListDAO();

        List<ProductCategoryList> allCategories = categoryDAO.getAllCategories();

        String[] selectedCategories = request.getParameterValues("category");
        String selectedPrice = request.getParameter("price");
        String searchKeyword = request.getParameter("search");

        String pageParam = request.getParameter("page");
        int page = pageParam != null ? Integer.parseInt(pageParam) : 1;
        int productsPerPage = 9;

        List<Product> filteredProducts;

        float minPrice = 0;
        float maxPrice = Float.MAX_VALUE;

        if (selectedPrice != null) {
            switch (selectedPrice) {
                case "under-1000000":
                    minPrice = 0;
                    maxPrice = 1000000;
                    break;
                case "1000000-2000000":
                    minPrice = 1000000;
                    maxPrice = 2000000;
                    break;
                case "2000001-4999999":
                    minPrice = 2000001;
                    maxPrice = 4999999;
                    break;
                case "over-5000000":
                    minPrice = 5000000;
                    maxPrice = Float.MAX_VALUE;
                    break;
            }
        }

        if (selectedCategories != null && selectedCategories.length > 0) {
            filteredProducts = productDAO.getProductsByCategoriesAndPrice(selectedCategories, minPrice, maxPrice);
            for (ProductCategoryList category : allCategories) {
                for (String selectedCategory : selectedCategories) {
                    if (category.getProductCL() == Integer.parseInt(selectedCategory)) {
                        category.setChecked(true);
                        break;
                    }
                }
            }
        } else {
            filteredProducts = productDAO.getProductsByPriceRange(minPrice, maxPrice);
        }

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            filteredProducts = productDAO.getProductsBySearchKeyword(filteredProducts, searchKeyword);
        }

        int totalProducts = filteredProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        int start = (page - 1) * productsPerPage;
        int end = Math.min(start + productsPerPage, totalProducts);
        List<Product> productsForPage = filteredProducts.subList(start, end);

        for (Product product : productsForPage) {
            product.setFormattedPrice(CurrencyFormatter.formatCurrency(product.getSalePrice()));
        }
        request.setAttribute("product", productsForPage);
        request.setAttribute("productcategory", allCategories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("productsPerPage", productsPerPage);

        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            request.getRequestDispatcher("product-list.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("shop.jsp").forward(request, response);
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
