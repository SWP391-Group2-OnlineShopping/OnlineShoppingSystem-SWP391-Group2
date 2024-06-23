/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import controller.auth.Authorization;
import dal.OrderDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Customers;
import model.Email;
import model.Orders;
import model.Products;

/**
 *
 * @author DELL
 */
@WebServlet(name = "OrderDetail", urlPatterns = {"/orderdetail"})
public class OrderDetail extends HttpServlet {

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
            out.println("<title>Servlet OrderDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetail at " + request.getContextPath() + "</h1>");
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
        Customers cus = (Customers) session.getAttribute("acc");
        int orderID = 0;
        try {
            orderID = Integer.parseInt(request.getParameter("orderID"));
        } catch (Exception e) {
        }
        if (cus == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect("login?error=You must login to see your order&redirect=orderdetail?orderID=" + orderID);
            return;
        }

        List<model.OrderDetail> listorderdetail = new ArrayList<>();
        try {
            orderID = Integer.parseInt(request.getParameter("orderID"));
        } catch (Exception e) {
        }
        ProductDAO pdao = new ProductDAO();
        List<Products> products = pdao.getLastestProducts();
        OrderDAO dao = new OrderDAO();
        List<model.OrderDetail> odlist = new ArrayList<>();
        odlist = dao.getOrderDetailByOrderID(orderID);
        Orders order = new Orders();

        try {
            String check = request.getParameter("check");
            if (check != null || !check.isEmpty()) {
                if (check.equals("1")) {
                    boolean var = dao.updateOrder(orderID, 6);
                    if (var) {
                        request.setAttribute("message", "The Order has been cancelled");
                        for (model.OrderDetail od : odlist) {
                            dao.retunOrderToProducCS(orderID, pdao.getProductCSIDByProducIDAndSize(od.getProductID(), od.getSize()));
                        }
                    } else {
                        request.setAttribute("message", "The Order cannot be cancelled");

                    }
                } else if (check.equals("2")) {
                    boolean var = dao.updateOrder(orderID, 5);
                    if (var) {

                        if (cus.getEmail() != null) {
                            Email e = new Email();

                            String feedbackLink = "http://localhost:9999/ProjectSWP/orderdetail?orderID=" + orderID; // Thay đổi URL theo link xác nhận của bạn

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
                                    + "        .feedback-button { display: inline-block; margin: 20px 0; padding: 15px 30px; font-size: 16px; color: #ffffff; background-color: #ce4b40; border-radius: 5px; text-decoration: none; }\n"
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
                                    + "            <div class=\"header-icon\"><img src=\"https://cdn-icons-png.flaticon.com/512/684/684908.png\" alt=\"Thank You Icon\"></div>\n"
                                    + "        </div>\n"
                                    + "        <div class=\"content\">\n"
                                    + "            <h1>Thank You for Your Purchase!</h1>\n"
                                    + "            <p>Hi " + cus.getFull_name() + ",</p>\n"
                                    + "            <p>We hope you are enjoying your new purchase from DiLuRi Sneaker! We strive to provide the best quality products and services, and your feedback is very important to us.</p>\n"
                                    + "            <p>We would appreciate it if you could take a moment to share your experience with us. Your feedback helps us improve and continue providing excellent service.</p>\n"
                                    + "            <a href=\"" + feedbackLink + "\" class=\"feedback-button\" style=\"color: white;\">Write a Feedback</a>\n"
                                    + "        </div>\n"
                                    + "        <div class=\"footer\">\n"
                                    + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                                    + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                                    + "        </div>\n"
                                    + "    </div>\n"
                                    + "</body>\n"
                                    + "</html>";

                            e.sendEmail(cus.getEmail(), "Enjoying Your Purchase? Tell Us!", emailContent);
                            request.setAttribute("message", "Your have confirmed to pick up your order");
                            for (model.OrderDetail od : odlist) {
                                dao.retunOrderToProducCS(orderID, pdao.getProductCSIDByProducIDAndSize(od.getProductID(), od.getSize()));
                            }
                        } else {
                            response.sendRedirect("error.jsp");
                        }
                    } else {
                        request.setAttribute("message", "You cannot pick up your order");
                    }
                }
            }
        } catch (Exception e) {
        }
        order = dao.getOrderByOrderID(orderID);
        listorderdetail = dao.getOrderDetailByOrderID(orderID);
        Customers c = dao.getCustomerInfoByOrderID(orderID);
        session.setAttribute("totalOrderPrice", order.getTotalCost());
        request.setAttribute("order", order);
        session.setAttribute("order", order);
        request.setAttribute("orderDetail", listorderdetail);
        request.setAttribute("cus", c);
        request.setAttribute("products", products);
        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
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