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
import java.lang.System.Logger;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import model.Staffs;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddStaffServlet", urlPatterns = {"/addStaff"})
@MultipartConfig
public class AddStaffServlet extends HttpServlet {

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
            out.println("<title>Servlet AddStaffServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddStaffServlet at " + request.getContextPath() + "</h1>");
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

        StaffDAO d = new StaffDAO();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse = null;

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String dobParam = request.getParameter("dob");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String roleParam = request.getParameter("role");
            String genderParam = request.getParameter("gender");
            String address = request.getParameter("address");
            Part filePart = request.getPart("avatar");
            String avatar = filePart != null ? filePart.getSubmittedFileName() : null;

            if (username == null || username.isEmpty() || password == null || password.isEmpty() ||
                dobParam == null || dobParam.isEmpty() || fullName == null || fullName.isEmpty() ||
                email == null || email.isEmpty() || mobile == null || mobile.isEmpty() ||
                roleParam == null || roleParam.isEmpty() || genderParam == null || genderParam.isEmpty() ||
                address == null || address.isEmpty()) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"All fields are required.\"}";
            } else if (d.isUsernameExists(username)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Username already exists.\"}";
            } else if (d.isEmailExists(email)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Email already exists.\"}";
            } else if (d.isMobileExists(mobile)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Phone number already exists.\"}";
            } else {
                int role = Integer.parseInt(roleParam);
                boolean gender = Boolean.parseBoolean(genderParam);
                Date dob = Date.valueOf(dobParam);
                String hashedPassword = hashMd5(password);

                Staffs newStaff = new Staffs();
                newStaff.setUsername(username);
                newStaff.setPassword(hashedPassword);
                newStaff.setDob(dob);
                newStaff.setFullName(fullName);
                newStaff.setEmail(email);
                newStaff.setMobile(mobile);
                newStaff.setRole(role);
                newStaff.setGender(gender);
                newStaff.setAddress(address);
                newStaff.setAvatar(avatar);

                boolean isAdded = d.addStaffs(newStaff);
                if (isAdded) {
                    // Chỉ tải lên avatar sau khi nhân viên được thêm thành công
                    if (filePart != null) {
                        String uploadDirectory = "C:\\Users\\admin\\Documents\\NetBeansProjects\\OnlineShoppingSystem-SWP391-Group2\\ProjectSWP\\web\\avatar";
                        Files.copy(filePart.getInputStream(), Paths.get(uploadDirectory, avatar), StandardCopyOption.REPLACE_EXISTING);
                    }
                    jsonResponse = "{\"status\":\"success\"}";
                } else {
                    jsonResponse = "{\"status\":\"error\",\"message\":\"Add employees fail.\"}";
                }
            }
        } catch (Exception e) {
            jsonResponse = "{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}";
            e.printStackTrace(out);
        } finally {
            out.write(jsonResponse);
            out.flush();
        }
    }

    // Helper method to hash passwords
   private String hashMd5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
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

