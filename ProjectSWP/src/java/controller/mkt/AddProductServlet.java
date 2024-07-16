/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import controller.Product.ProductCategory;
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
import model.ProductCS;
import model.ProductCategories;
import model.ProductCategoryList;
import model.Products;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProduct"})
public class AddProductServlet extends HttpServlet {

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
            out.println("<title>Servlet AddProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    response.setContentType("application/json");
    PrintWriter out = response.getWriter();

    String jsonResponse;

    try {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String briefInformation = request.getParameter("briefInformation");
        String thumbnailLink = request.getParameter("thumbnail");
        String imageDetails = request.getParameter("imageDetails");
        boolean feature = request.getParameter("feature") != null;

        Products product = new Products();
        product.setTitle(title);
        product.setDescription(description);
        product.setBriefInformation(briefInformation);
        product.setThumbnailLink(thumbnailLink);
        product.setImageDetails(imageDetails != null ? imageDetails : "");
        product.setStatus(false); // Status mặc định là false (tắt)
        product.setFeature(feature);

        String categoryId = request.getParameter("category");
        int productCL = Integer.parseInt(categoryId);
        ProductCategoryList categoryList = new ProductCategoryList();
        categoryList.setProductCL(productCL);

        ProductCategories productCategory = new ProductCategories();
        productCategory.setProductCL(categoryList);
        List<ProductCategories> productCategoriesList = new ArrayList<>();
        productCategoriesList.add(productCategory);

        ProductDAO productDAO = new ProductDAO();
        int thumbnailId = productDAO.addImage(thumbnailLink);
        if (thumbnailId != -1) {
            product.setThumbnail(thumbnailId);
            boolean success = productDAO.addProduct(product, productCategoriesList);
            if (success) {
                // Thêm chi tiết hình ảnh vào ImageMappings
                if (!imageDetails.isEmpty()) {
                    String[] imageLinks = imageDetails.split(", ");
                    for (String link : imageLinks) {
                        int imageId = productDAO.addImage(link);
                        if (imageId != -1) {
                            productDAO.addImageMapping(2, product.getProductID(), imageId); // 2 là tên thực thể cho sản phẩm
                        }
                    }
                }
                jsonResponse = "{\"status\":\"success\"}";
            } else {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Failed to add product\"}";
            }
        } else {
            jsonResponse = "{\"status\":\"error\",\"message\":\"Failed to add thumbnail image\"}";
        }
    } catch (Exception e) {
        jsonResponse = "{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}";
    }

    out.print(jsonResponse);
    out.flush();
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
