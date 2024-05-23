/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.Customers;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        if (session.getAttribute("staff") != null) {
            Authorization.redirectToHome(session, response);
        } else {
            
        String errorMessage = request.getParameter("error");
        if(errorMessage != null){
          request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("login.jsp").forward(request, response);  
        }
        
        
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String r = request.getParameter("rem");

            Cookie cusername = new Cookie("cusername", userName);
            Cookie cpass = new Cookie("cpass", passWord);
            Cookie cr = new Cookie("crem", r);

            if (r != null) {
                cusername.setMaxAge(60 * 60 * 24 * 7);
                cpass.setMaxAge(60 * 60 * 24 * 7);
                cr.setMaxAge(60 * 60 * 24 * 7);
            } else {
                cusername.setMaxAge(0);
                cpass.setMaxAge(0);
                cr.setMaxAge(0);
            }

            response.addCookie(cusername);
            response.addCookie(cpass);
            response.addCookie(cr);

            String pass = hashMd5(passWord);
            CustomersDAO d = new CustomersDAO();
            Customers a = d.login(userName, pass);

            if (a == null) {               
                request.setAttribute("error", "Your email or password is incorrect");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {

                session.setAttribute("acc", a);

                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    response.sendRedirect(redirect + ".jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            }
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
        processRequest(request, response);
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
