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
import model.Email;
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
                jsonResponse = "{\"status\":\"error\",\"message\":\"Tất cả các trường là bắt buộc.\"}";
            } else if (d.isUsernameExists(username)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Tên người dùng đã tồn tại.\"}";
            } else if (d.isEmailExists(email)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Email đã tồn tại.\"}";
            } else if (d.isMobileExists(mobile)) {
                jsonResponse = "{\"status\":\"error\",\"message\":\"Số điện thoại đã tồn tại.\"}";
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
                    // Gửi email
                    String emailContent = "<!DOCTYPE html>\n"
                            + "<html>\n"
                            + "<head>\n"
                            + "    <style>\n"
                            + "        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }\n"
                            + "        .email-container { max-width: 600px; margin: 40px auto; background-color: #ffffff; padding: 20px; border: 1px solid #dddddd; border-radius: 10px; }\n"
                            + "        .header { text-align: center; padding: 10px 0; background-color: #ce4b40; border-radius: 10px 10px 0 0; color: #ffffff; font-size: 24px; font-weight: bold; }\n"
                            + "        .header img { height: 50px; }\n"
                            + "        .header-icon { margin: 20px 0; }\n"
                            + "        .header-icon img { height: 50px; }\n"
                            + "        .content { padding: 20px; text-align: center; }\n"
                            + "        .content h1 { color: #333333; }\n"
                            + "        .content p { font-size: 16px; line-height: 1.5; color: #555555; }\n"
                            + "        .verify-button { display: inline-block; margin: 20px 0; padding: 15px 30px; font-size: 16px; color: #ffffff; background-color: #ce4b40; border-radius: 5px; text-decoration: none; }\n"
                            + "        .footer { text-align: center; padding: 20px; font-size: 14px; color: #aaaaaa; }\n"
                            + "        .footer p { margin: 5px 0; }\n"
                            + "        .footer a { color: #ce4b40; text-decoration: none; }\n"
                            + "        .social-icons { margin: 20px 0; }\n"
                            + "        .social-icons img { height: 24px; margin: 0 10px; }\n"
                            + "    </style>\n"
                            + "</head>\n"
                            + "<body>\n"
                            + "    <div class=\"email-container\">\n"
                            + "        <div class=\"header\">\n"
                            + "            DiLuri<span>.</span>\n"
                            + "            <div class=\"header-icon\"><img src=\"https://cdn-icons-png.freepik.com/512/9840/9840606.png\" alt=\"Email Icon\"></div>\n"
                            + "        </div>\n"
                            + "        <div class=\"content\">\n"
                            + "            <h1>Welcome to the company!</h1>\n"
                            + "            <p>Hi " + fullName + ",</p>\n"
                            + "            <p>Your account has been created successfully. Here are your credentials:</p>\n"
                            + "            <p>Username: " + username + "</p>\n"
                            + "            <p>Password: " + password + "</p>\n"
                            + "        </div>\n"
                            + "        <div class=\"footer\">\n"
                            + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                            + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                            + "        </div>\n"
                            + "    </div>\n"
                            + "</body>\n"
                            + "</html>";

                    Email.sendEmail(email, "Welcome to the company!", emailContent);
                    jsonResponse = "{\"status\":\"success\"}";
                } else {
                    jsonResponse = "{\"status\":\"error\",\"message\":\"Thêm nhân viên thất bại.\"}";
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

