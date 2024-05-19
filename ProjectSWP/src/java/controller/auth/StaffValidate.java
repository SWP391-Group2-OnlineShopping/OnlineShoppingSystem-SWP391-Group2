package controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Staffs;
import dal.StaffDAO;

/**
 *
 * @author Admin
 */
public class StaffValidate extends HttpServlet {

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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        StaffDAO staffDAO = new StaffDAO();
        Staffs staff = null;
        try {
            staff = staffDAO.getStaffByUsername(username);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (staff != null && staff.getRole() == Integer.parseInt(role)) {
            String hashedPassword = hashMd5(password);
            if (staff.getPassword().equals(hashedPassword)) {
                Cookie loginCookie = new Cookie("user", username);
                loginCookie.setMaxAge(30 * 60); // 30 minutes
                response.addCookie(loginCookie);
                //TODO: send to jsp relatively to role
                if (role == "1") {
                    //admin page
                } else if (role == "2") {
                    //admin sale manager
                } else if (role == "3") {
                    //admin sale
                } else {
                    //admin marketer
                }
                return;
            }
        }

        request.setAttribute("errorMessage", "Invalid username or password.");
        request.getRequestDispatcher("stafflogin.jsp?role=" + role).forward(request, response);
    }

    // Helper method to hash password using MD5
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet request
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
     * @param response servlet request
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
        return "Staff validation servlet";
    }// </editor-fold>

}
