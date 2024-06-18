/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import model.Staffs;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateStaffServlet", urlPatterns = {"/updateStaff"})
@MultipartConfig
public class UpdateStaffServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateStaffServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStaffServlet at " + request.getContextPath() + "</h1>");
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
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse = null;

        // Get parameters from the request
        String staffIdParam = request.getParameter("staffId");
        String roleParam = request.getParameter("role");
        String statusParam = request.getParameter("status");

        if (staffIdParam == null || staffIdParam.isEmpty() || roleParam == null || roleParam.isEmpty() || statusParam == null || statusParam.isEmpty()) {
            jsonResponse = "{\"status\":\"error\",\"message\":\"Missing parameters.\"}";
            out.write(jsonResponse);
            out.flush();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int staffId;
        int role;
        int status;

        try {
            staffId = Integer.parseInt(staffIdParam);
            role = Integer.parseInt(roleParam);
            status = Integer.parseInt(statusParam);
        } catch (NumberFormatException e) {
            jsonResponse = "{\"status\":\"error\",\"message\":\"Invalid parameters.\"}";
            out.write(jsonResponse);
            out.flush();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            // Fake a DAO call (Replace this with your actual logic)
            StaffDAO staffDAO = new StaffDAO(); // Assuming StaffDAO doesn't need a connection in constructor

            // Update staff role and status
            boolean isUpdated = staffDAO.updateStaffRoleAndStatus(staffId, role, status);

            if (isUpdated) {
                jsonResponse = "{\"status\":\"success\"}";
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Failed to update staff.\"}";
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

            out.write(jsonResponse);
            out.flush();

        } catch (Exception e) {
            jsonResponse = "{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}";
            e.printStackTrace();
            out.write(jsonResponse);
            out.flush();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.close();
        }
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
