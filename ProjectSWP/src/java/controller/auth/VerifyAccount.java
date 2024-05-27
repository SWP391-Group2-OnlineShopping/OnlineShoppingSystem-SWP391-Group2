/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author LENOVO
 */
public class VerifyAccount extends HttpServlet {

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
            out.println("<title>Servlet VerifyAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyAccount at " + request.getContextPath() + "</h1>");
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

        String expiresParam = request.getParameter("expire");
        if (expiresParam != null) {
            long expirationTimeMillis = Long.parseLong(expiresParam);
            long currentTimeMillis = System.currentTimeMillis();

            if (currentTimeMillis > expirationTimeMillis) {
                request.setAttribute("errors", "The verify email link has expired!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("Notification", "You have successfully verified");
                 request.getRequestDispatcher("login.jsp").forward(request, response);
                HttpSession session = request.getSession(false); // Use false to prevent creating a new session if one doesn't exist
                if (session == null) {
                    response.sendRedirect("error.jsp"); // Redirect to an error page if session is not found
                    return;
                }

//        HttpSession session = request.getSession();
                String userName = (String) session.getAttribute("username");
                String passWord = (String) session.getAttribute("pass");
                String phoneNumber = (String) session.getAttribute("phone_number");
                String email = (String) session.getAttribute("email");
                String address = (String) session.getAttribute("address");
                String gender = (String) session.getAttribute("gender");
                String dob = (String) session.getAttribute("dob");
                String fullName = (String) session.getAttribute("fullname");

                if (userName != null && passWord != null && email != null) {
                    CustomersDAO dao = new CustomersDAO();
                    dao.signup(userName, passWord, phoneNumber, email, address, fullName, gender, dob);
                    session.invalidate(); // Invalidate the session to clear stored attributes
                } else {
                    response.sendRedirect("error.jsp"); // Redirect to an error page if necessary
                }
            }
           
        } else {
            // Không có tham số expires, xử lý theo logic mặc định
            response.getWriter().println("Invalid URL.");
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
