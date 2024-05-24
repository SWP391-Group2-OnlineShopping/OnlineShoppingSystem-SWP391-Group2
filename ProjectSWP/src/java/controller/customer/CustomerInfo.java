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
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CustomerInfo extends HttpServlet implements Serializable{

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

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            String err = "";
            if (fullName.isEmpty() || fullName == null) {
                err = "Full name is required.";
            } else if (address.isEmpty() || address == null) {
                err = "Address is required";
            } else if (phone.isEmpty() || phone == null || phone.length() < 10) {
                err = "Phone number is invalid";
            }

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Handle file upload
            Part filePart = request.getPart("img-file");
            String fileName = extractFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                // Save the file on the server
                filePart.write(uploadPath + File.separator + fileName);
            }

            if (!err.isEmpty()) {
                request.setAttribute("error", err);
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            } else {
                CustomersDAO cDAO = new CustomersDAO();
                boolean isUpdate = cDAO.UpdateCustomer(id, fullName, address, phone, gender, fileName);
                if (isUpdate) {
                    HttpSession session = request.getSession();
                    Customers updateCustomer = cDAO.GetCustomerByID(id);
                    session.setAttribute("userInfo", updateCustomer);
                    request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to update user information.");
                    request.getRequestDispatcher("userProfile.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
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
