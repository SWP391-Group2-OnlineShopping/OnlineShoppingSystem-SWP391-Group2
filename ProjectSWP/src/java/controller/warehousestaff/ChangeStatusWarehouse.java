/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.warehousestaff;

import dal.CustomersDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import model.Customers;
import model.Email;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ChangeStatusWarehouse", urlPatterns = {"/changestatuswarehouse"})
public class ChangeStatusWarehouse extends HttpServlet {

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
            out.println("<title>Servlet ChangeStatusWarehouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeStatusWarehouse at " + request.getContextPath() + "</h1>");
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
        CustomersDAO cDAO = new CustomersDAO();
        OrderDAO oDAO = new OrderDAO();
        int order_id = Integer.parseInt(request.getParameter("order_id"));
        int status = Integer.parseInt(request.getParameter("status"));
        int value = Integer.parseInt(request.getParameter("value"));

        if (status == 2 && value == 11) {
            // Đang đóng gói
            oDAO.changeStatusOrder(order_id, value);
        } else if (status == 12 && value == 7) {
            // Đã trả lại
            oDAO.changeStatusOrder(order_id, value);
            oDAO.ReturnProduct(order_id);
            Customers customer = cDAO.getUserInforByOrderID(order_id);

            int failureOrder = oDAO.CountFailureOrder(customer.getCustomer_id());

            // Lấy trạng thái gửi email
            int emailSentStatus = cDAO.getEmailSentStatus(customer.getCustomer_id());

            if (failureOrder == 1 && (emailSentStatus & 1) == 0) {
                // Gửi email cảnh báo cho failureOrder == 1
                sendWarningEmail(customer, "Warning Letter!!!");
                emailSentStatus |= 1; // Cập nhật bit 0
                cDAO.setEmailSentStatus(customer.getCustomer_id(), emailSentStatus);
            } else if (failureOrder == 2 && (emailSentStatus & 2) == 0) {
                // Gửi email cảnh báo cho failureOrder == 2
                sendWarningEmail(customer, "Second Warning");
                emailSentStatus |= 2; // Cập nhật bit 1
                cDAO.setEmailSentStatus(customer.getCustomer_id(), emailSentStatus);
            } else if (failureOrder >= 3 && (emailSentStatus & 4) == 0) {
                // Gửi email cảnh báo cho failureOrder >= 3
                sendWarningEmail(customer, "Third Warning");
                emailSentStatus |= 4; // Cập nhật bit 2
                cDAO.setEmailSentStatus(customer.getCustomer_id(), emailSentStatus);
            }
        } else if (status == 11 && value == 10) {
            // Đã đóng gói
            oDAO.changeStatusOrder(order_id, value);
        } else if (status == 12 && value == 0) {
            oDAO.changeStatusOrder(order_id, 7);
            oDAO.ReturnProduct(order_id);
        }
        request.getRequestDispatcher("warehouseorderlist").forward(request, response);
    }

    private void sendWarningEmail(Customers customer, String warningMessage) {
        Email e = new Email();
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
                + "            <h1>Warning Letter !!!!</h1>\n"
                + "            <p>Hi " + customer.getFull_name() + ",</p>\n"
                + "            <p style=\"color: red\"><b>This is a warning letter to you.</b></p>\n"
                + "            <p>If you break our goods for the<b> 2nd time</b>, we will <b>disable COD Shipping within 1 week</b>, and if you break our goods for the <b>3rd time</b>, we will<b> disable your COD Shipping forever</b>.</p>\n"
                + "        </div>\n"
                + "        <div class=\"footer\">\n"
                + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";

        e.sendEmail(customer.getEmail(), warningMessage, emailContent);
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
