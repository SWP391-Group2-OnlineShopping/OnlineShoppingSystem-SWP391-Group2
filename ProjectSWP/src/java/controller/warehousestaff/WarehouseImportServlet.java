/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.warehousestaff;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import model.ProductCS;
import model.Products;

/**
 *
 * @author admin
 */
@WebServlet(name="WarehouseImportServlet", urlPatterns={"/warehouseimport"})
public class WarehouseImportServlet extends HttpServlet {
   
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
            out.println("<title>Servlet WarehouseImportServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WarehouseImportServlet at " + request.getContextPath () + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        
        List<Products> products = productDAO.getAllProducts(); // Tải toàn bộ sản phẩm

        int page = 1;
        int recordsPerPage = 10;
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));
        
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, products.size());
        
        List<Products> paginatedProducts = products.subList(start, end); // Lấy sản phẩm theo trang

        int noOfPages = (int) Math.ceil(products.size() * 1.0 / recordsPerPage);
        
        request.setAttribute("products", paginatedProducts);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        
        request.getRequestDispatcher("warehouseimport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();

        try (PrintWriter logWriter = new PrintWriter(System.out)) {
            String productIdParam = request.getParameter("productId");
            String importPriceParam = request.getParameter("importPrice");
            String[] sizes = request.getParameterValues("sizes[]");
            String[] quantities = request.getParameterValues("quantities[]");

            logWriter.println("Received parameters:");
            logWriter.println("productId: " + productIdParam);
            logWriter.println("importPrice: " + importPriceParam);
            logWriter.println("sizes: " + Arrays.toString(sizes));
            logWriter.println("quantities: " + Arrays.toString(quantities));
            logWriter.flush();

            int productId = Integer.parseInt(productIdParam);
            float importPrice = Float.parseFloat(importPriceParam);

            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.updateProductWithSizes(productId, importPrice, sizes, quantities);

            if (success) {
                jsonResponse.addProperty("status", "success");
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Failed to update product in the database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", e.getMessage());
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
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
