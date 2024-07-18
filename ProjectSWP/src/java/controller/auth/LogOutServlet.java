/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "LogOutServlet", urlPatterns = {"/logout"})
public class LogOutServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        Customers acc = (Customers) session.getAttribute("acc");
        Staffs staff = (Staffs) session.getAttribute("staff");
        //in case new account just create
        String userName = (String) session.getAttribute("username");
        String passWord = (String) session.getAttribute("pass");
        String phoneNumber = (String) session.getAttribute("phone_number");
        String address = (String) session.getAttribute("address");
        String gender = (String) session.getAttribute("gender");
        String dob = (String) session.getAttribute("dob");
        String fullName = (String) session.getAttribute("fullname");

        if (acc != null) {
            session.removeAttribute("acc");
            session.removeAttribute("cod_disabled_until");
            session.removeAttribute("cod_disabled_forever");
            //in case new account just create
            if (userName != null || passWord != null || phoneNumber != null || address != null || gender != null || dob != null || fullName != null) {
                session.removeAttribute("username");
                session.removeAttribute("pass");
                session.removeAttribute("phone_number");
                session.removeAttribute("address");
                session.removeAttribute("gender");
                session.removeAttribute("dob");
                session.removeAttribute("fullname");
                session.removeAttribute("product");
                session.removeAttribute("fullName");
                session.removeAttribute("phoneNumber");
                session.removeAttribute("orderNotes");
                session.removeAttribute("wantreturnorder");
                session.removeAttribute("pendingorder");
                session.removeAttribute("unpaidorder");
                
            }
            response.sendRedirect("homepage");
        }
        if (staff != null) {
            session.removeAttribute("staff");
            response.sendRedirect("homepage");
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