package controller.auth;

import java.io.IOException;
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
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

public class StaffValidate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewResetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("stafflogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        StaffDAO staffDAO = new StaffDAO();
        Staffs staff = null;
        try {
            staff = staffDAO.getStaffByUsername(username);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (staff != null) {
            String hashedPassword = hashMd5(password);
            if (staff.getPassword().equals(hashedPassword)) {
                Cookie loginCookie = new Cookie("user", username);
                loginCookie.setMaxAge(30 * 60); // 30 minutes
                response.addCookie(loginCookie);
                Staffs s = staffDAO.loginStaff(username, hashedPassword);
                session.setAttribute("staff", s);
                switch (s.getRole()) {
                    case 1:
                        // admin
                        response.sendRedirect("homepage");
                        break;
                    case 2:
                        // sale manager
                        response.sendRedirect("homepage");
                        break;
                    case 3:
                        // sale
                        response.sendRedirect("homepage");
                        break;
                    default:
                        // marketer
                        response.sendRedirect("homepage");
                        break;
                }
            } else {
                request.setAttribute("errorMessage", "Invalid  password.");
                request.setAttribute("username", username);
                request.setAttribute("password", password);
                request.getRequestDispatcher("stafflogin.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username ");
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.getRequestDispatcher("stafflogin.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Staff validation servlet";
    }
}
