/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.CustomersDAO;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.UUID;
import model.Customers;
import model.Email;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/resetpassword"})
public class ResetPassword extends HttpServlet {

    private String email;
    private int expirationTimeMinutes;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        // Lấy giá trị thời gian hết hạn từ tham số ngữ cảnh trong web.xml
        String expirationTimeParam = config.getServletContext().getInitParameter("verifyLinkExpirationTime");
        expirationTimeMinutes = Integer.parseInt(expirationTimeParam);
    }

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
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
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

        Boolean emailSent = (Boolean) session.getAttribute("emailSent");
        if (emailSent != null && emailSent) {
            // Email đã được gửi, chuyển hướng đến trang thành công
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        email = request.getParameter("email");
        CustomersDAO d = new CustomersDAO();
        Customers a = d.checkAccount(email);
        if (a != null) {
            Email e = new Email();
            long expirationTimeMillis = System.currentTimeMillis() + (expirationTimeMinutes * 60 * 1000);
            String token = UUID.randomUUID().toString(); // Tạo token ngẫu nhiên

            // Lưu token và thời gian hết hạn vào ServletContext
            getServletContext().setAttribute(token, expirationTimeMillis);

            String verifyLink = "http://localhost:9999/ProjectSWP/newresetpassword?token=" + token;

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
                                + "            <h1>Reset Password</h1>\n"
                                + "            <p> Please click the button below to reset your password. <br>The link will expires in " + expirationTimeMinutes + " minutes.</p>\n"
                                + "            <a style=\"color: white\" href=\"" + verifyLink + "\" class=\"verify-button\">Reset Password</a>\n"
                                + "        </div>\n"
                                + "        <div class=\"footer\">\n"
                                + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                                + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                                + "        </div>\n"
                                + "    </div>\n"
                                + "</body>\n"
                                + "</html>";

            e.sendEmail(email, "Reset your password", emailContent);
             session.setAttribute("emailSent", true);
            request.setAttribute("Notification", "You need confirm email to Reset Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "This email doesn't exist");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
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
        String newpass = request.getParameter("newpass");
        String re_newpass = request.getParameter("re_newpass");
        if (!newpass.equals(re_newpass)) {
            request.setAttribute("error", "password and re-enter password are not the same");
            request.getRequestDispatcher("newpass.jsp").forward(request, response);
        } else {
            CustomersDAO d = new CustomersDAO();
            d.changePass(email, newpass);
            request.setAttribute("Notification", "Reset password successfully");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
