/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.Serializable;
import model.Customers;

/**
 *
 * @author dumspicy
 */
public class CustomerInfo extends HttpServlet implements Serializable {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet CustomerInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerInfo at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        CustomersDAO cDAO = new CustomersDAO();
        Customers customer = cDAO.GetCustomerByID(id);
        session.setAttribute("userInfo", customer);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
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
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullname");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));


            String err = "";
            if (fullName.isEmpty() || fullName == null) {
                err += "Full name is required.";
            } else if (address.isEmpty() || address == null) {
                err += "Address is required";
            } else if (!isValidPhone(phone)) {
                err += "Phone number is invalid";
            }

           
            if (!err.isEmpty()) {
                request.setAttribute("error", err);
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            } else {
                CustomersDAO cDAO = new CustomersDAO();
                boolean isUpdate = cDAO.UpdateCustomer(id, fullName, address, phone, gender);
                if (isUpdate) {
                    HttpSession session = request.getSession();
                    Customers updateCustomer = cDAO.GetCustomerByID(id);
                    session.setAttribute("userInfo", updateCustomer);
                    request.getRequestDispatcher("userProfile.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to update user information.");
                    request.getRequestDispatcher("userProfile.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private boolean isValidPhone(String phone) {
        // Regex to check if the phone number is a natural number between 7 and 11 digits
        String regex = "\\d{7,11}";
        return phone != null && phone.matches(regex);
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
