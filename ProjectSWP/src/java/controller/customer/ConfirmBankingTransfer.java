/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.customer;

import dal.CustomersDAO;
import dal.OrderDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customers;
import model.Products;
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name="ConfirmBankingTransfer", urlPatterns={"/confirmbankingtransfer"})
public class ConfirmBankingTransfer extends HttpServlet {
   
    /**   
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ConfirmBankingTransfer</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmBankingTransfer at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        StaffDAO staffDAO = new StaffDAO();
        CustomersDAO cDAO = new CustomersDAO();
        OrderDAO oDAO = new OrderDAO();
        List<Staffs> staffIDList = staffDAO.getStaffHaveLeastOrder();
///////////////////////////////////////////////////////////////////////////////////////////////////////
        Staffs staffID = staffIDList.get(0);
        int idStaff = staffID.getStaffID();
        Customers customer = (Customers) session.getAttribute("acc");
        List<Products> product = (List<Products>) session.getAttribute("products");
///////////////////////////////////////////////////////////////////////////////////////////////////////////
        int numberOfItems = 0;
        for (Products p : product) {
            if (p.getQuantity() != 0) {
                numberOfItems++;
            }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////        
        int totalPriceInt = (int) session.getAttribute("totalPrice");
        float totalPriceFloat = (float) totalPriceInt;

        String fullName = (String) session.getAttribute("fullName");

        String address = (String) session.getAttribute("address");
        String phone = (String) session.getAttribute("phoneNumber");
//        String email = (String) session.getAttribute("email");
        String notes = (String) session.getAttribute("orderNotes");

        int receiverID = cDAO.GetReceiverIDByNameAddressPhone(fullName, phone, address);

        oDAO.CreateNewOrder(customer.getCustomer_id(), totalPriceFloat, numberOfItems, 1, idStaff, receiverID, notes);
        request.getRequestDispatcher("bankingtransferonline.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
