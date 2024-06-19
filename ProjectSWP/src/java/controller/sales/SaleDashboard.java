/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.sales;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.OrderDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;
import model.BrandTotal;
import model.OrderSummary;
import model.Products;
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name="SaleDashboard", urlPatterns={"/saledashboard"})
public class SaleDashboard extends HttpServlet {
   
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
            out.println("<title>Servlet SaleDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleDashboard at " + request.getContextPath () + "</h1>");
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
        OrderDAO oDAO = new OrderDAO();
        
         List<BrandTotal> totalByBrand = oDAO.getTotalRevenueByBrand();
         List<Products> top5BestSeller = oDAO.getTop5BestSeller();

      
      
        

        // Set the list as a request attribute and forward to the JSP page
        request.setAttribute("totalByBrand", totalByBrand);
        request.setAttribute("bestSeller", top5BestSeller);
        request.getRequestDispatcher("saledashboard.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staffs sale = (Staffs) session.getAttribute("staff");
        
         response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Parse JSON data from request body
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String jsonString = sb.toString();

        // Convert JSON string to JSON object
        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);

        // Retrieve parameters from JSON object
        String startDate = jsonObject.get("startdate").getAsString();
        String endDate = jsonObject.get("enddate").getAsString();
        int salerId = 0;
        if(sale != null){
            salerId = sale.getStaffID();
  
        }
       
        // Fetch data based on the parameters
        OrderDAO oDAO = new OrderDAO();
        List<OrderSummary> orders = oDAO.getOrdersByDateAndSaler(startDate, endDate, salerId);

        // Prepare data for JSON response
        List<String> labels = new ArrayList<>();
        List<Integer> revenueData = new ArrayList<>();
        List<Integer> orderData = new ArrayList<>();

        for (OrderSummary order : orders) {
            labels.add(order.getOrderDate().toString()); // Adjust as needed
            revenueData.add(order.getTotalRevenue());
            orderData.add(order.getTotalOrders());
        }

        // Create JSON response
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.add("labels", gson.toJsonTree(labels));
        jsonResponse.add("revenue", gson.toJsonTree(revenueData));
        jsonResponse.add("orders", gson.toJsonTree(orderData));

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
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
