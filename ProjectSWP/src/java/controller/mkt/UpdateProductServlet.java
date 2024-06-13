/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import controller.auth.Authorization;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Products;
import model.Staffs;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/updateProduct"})
public class UpdateProductServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductServlet at " + request.getContextPath() + "</h1>");
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

        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            processRequest(request, response);
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
        int productID = Integer.parseInt(request.getParameter("productId"));
        String title = request.getParameter("title");
        float salePrice = Float.parseFloat(request.getParameter("salePrice"));
        float listPrice = Float.parseFloat(request.getParameter("listPrice"));
        String description = request.getParameter("description");
        String briefInformation = request.getParameter("briefInformation");
        String thumbnailLink = request.getParameter("thumbnailLink");
        boolean status = request.getParameter("status") != null;
        boolean feature = request.getParameter("feature") != null;
        String imageDetails = request.getParameter("imageDetails");
        String category = request.getParameter("category");

        // Debugging: Print the values to the console to ensure they are being received
        System.out.println("productID: " + productID);
        System.out.println("title: " + title);
        System.out.println("salePrice: " + salePrice);
        System.out.println("listPrice: " + listPrice);
        System.out.println("description: " + description);
        System.out.println("briefInformation: " + briefInformation);
        System.out.println("thumbnailLink: " + thumbnailLink);
        System.out.println("status: " + status);
        System.out.println("feature: " + feature);
        System.out.println("imageDetails: " + imageDetails);
        System.out.println("category: " + category);

        Products product = new Products();
        product.setProductID(productID);
        product.setTitle(title);
        product.setSalePrice(salePrice);
        product.setListPrice(listPrice);
        product.setDescription(description);
        product.setBriefInformation(briefInformation);
        product.setThumbnailLink(thumbnailLink);
        product.setStatus(status);
        product.setFeature(feature);
        product.setImageDetails(imageDetails);
        product.setCategory(category);

        ProductDAO dao = new ProductDAO();
        boolean result = dao.updateProduct(product);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (result) {
            out.print("{\"status\":\"success\"}");
        } else {
            out.print("{\"status\":\"error\",\"message\":\"An error occurred.\"}");
        }
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
