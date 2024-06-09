/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.CustomersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;

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
        try (var out = response.getWriter()) {
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
        HttpSession session1 = request.getSession();
        if (session1.getAttribute("acc") != null) {
            Authorization.redirectToHomeForCustomer(session1, response);
        } else if (session1.getAttribute("staff") != null) {
            Authorization.redirectToHome(session1, response);
        } else {
            CustomersDAO dao = new CustomersDAO();

            String expiresParam = request.getParameter("expire");
            //get expires time
            if (expiresParam != null) {
                long expirationTimeMillis = Long.parseLong(expiresParam);
                long currentTimeMillis = System.currentTimeMillis();
                //if is expires time 
                if (currentTimeMillis > expirationTimeMillis) {
                    request.setAttribute("errors", "The verify email link has expired!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    //if NOT expires time 
                    HttpSession session = request.getSession(false); // Use false to prevent creating a new session if one doesn't exist
                    if (session == null) {
                        response.sendRedirect("error.jsp"); // Redirect to an error page if session is not found
                        return;
                    }
                    //check email from jsp
                    String email = (String) session.getAttribute("email");
                    if (email == null) {
                        response.sendRedirect("error.jsp"); // Redirect to an error page if email is not found in session
                        return;
                    }

                    //if LOGIN but account is already verify and still not expires time
                    if (session.getAttribute("acc") != null && dao.isVerified(email) == 1) {
                        session.setAttribute("message", "Your account has already been verified.");
                        response.sendRedirect("homepage");
                        return;
                    }
                    //if account is ALREADY verify and still not expires time
                    if (dao.isVerified(email) == 1) {
                        request.setAttribute("error", "Your account has already been verified.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        //if account is NOT verify and still not expires time
                        String userName = (String) session.getAttribute("username");
                        String passWord = (String) session.getAttribute("pass");
                        String phoneNumber = (String) session.getAttribute("phone_number");
                        String address = (String) session.getAttribute("address");
                        String gender = (String) session.getAttribute("gender");
                        String dob = (String) session.getAttribute("dob");
                        String fullName = (String) session.getAttribute("fullname");

                        if (userName != null && passWord != null) {
                            request.setAttribute("Notification", "You have successfully verified");
                            dao.signup(userName, passWord, phoneNumber, email, address, fullName, gender, dob);
                            //create new card for new account
                            Customers acc = dao.getUserInfor(email);
                            dao.createCart(acc.getCustomer_id());

                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("error.jsp"); // Redirect to an error page if any critical session attribute is missing
                        }
                    }
                }
            } else {
                response.getWriter().println("Invalid URL.");
            }
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
