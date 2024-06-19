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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;
import model.Email;

/**
 *
 * @author LENOVO
 */
public class SignUpServlet extends HttpServlet {

    private static final String EMAIL_SENT_SESSION_KEY = "emailSent";
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
            out.println("<title>Servlet SignUpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpServlet at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHomeForCustomer(session, response);
        } else if (session.getAttribute("staff") != null) {
            Authorization.redirectToHome(session, response);
        } else {
            session.removeAttribute(EMAIL_SENT_SESSION_KEY);
            request.getRequestDispatcher("register.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        if (session.getAttribute(EMAIL_SENT_SESSION_KEY) != null) {
            // If email has already been sent, just forward to success page
            session.removeAttribute("emailSent");
            request.getRequestDispatcher("confirmordersuccessCOD.jsp").forward(request, response);
            return;
        }

        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHomeForCustomer(session, response);
        } else {
            CustomersDAO dao = new CustomersDAO();
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");
            String phoneNumber = request.getParameter("phonenumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dob");
            String fullName = firstName + " " + lastName;
            if (!passWord.equals(confirmPassword)) {
                request.setAttribute("error", "Password and re-enter password are not the same");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {

                Customers customerAccount = dao.checkAccount(email);
                if (customerAccount == null) {
                    Customers customerAccount1 = dao.checkAccountName(userName);
                    if (customerAccount1 == null) {

                        session.setAttribute("username", userName);
                        session.setAttribute("pass", passWord);
                        session.setAttribute("phone_number", phoneNumber);
                        session.setAttribute("email", email);
                        session.setAttribute("address", address);
                        session.setAttribute("gender", gender);
                        session.setAttribute("dob", dob);
                        session.setAttribute("fullname", fullName);

                        Email e = new Email();
                        long expirationTimeMillis = System.currentTimeMillis() + (expirationTimeMinutes * 60 * 1000);

                        String verifyLink = "http://localhost:9999/ProjectSWP/verifyaccount?expire=" + expirationTimeMillis; // Thay đổi URL theo link xác nhận của bạn

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
                                + "            <h1>Email verification</h1>\n"
                                + "            <p>Hi " + fullName + ",</p>\n"
                                + "            <p>You're almost set to start enjoying DiLuRi Sneaker. Simply click the link below to verify your email address and get started. The link expires in " + expirationTimeMinutes + " minutes.</p>\n"
                                + "            <a style=\"color: white\" href=\"" + verifyLink + "\" class=\"verify-button\">Verify my email address</a>\n"
                                + "        </div>\n"
                                + "        <div class=\"footer\">\n"
                                + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                                + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                                + "        </div>\n"
                                + "    </div>\n"
                                + "</body>\n"
                                + "</html>";

                        e.sendEmail(email, "Do you like our product?", emailContent);
                        session.setAttribute(EMAIL_SENT_SESSION_KEY, true);
                        request.setAttribute("Notification", "You need confirm email to login");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Username are already exist");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("error", "Email are already exist");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            }
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