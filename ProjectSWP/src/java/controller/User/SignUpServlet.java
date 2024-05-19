/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

import dal.CustomersDAO;
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
        request.getRequestDispatcher("register.jsp").forward(request, response);

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
        String fullName = lastName + " " + firstName;

//        dao.signup(userName, passWord, phoneNumber, email, address, fullName, gender, dob);
//        PrintWriter out = response.getWriter();
//        out.println(firstName+"\n");
//        out.println(lastName);
//        out.println(userName);
//        out.println(passWord);
//        out.println(confirmPassword);
//        out.println(phoneNumber);
//        out.println(email);
//        out.println(address);
//        out.println(gender);
//        out.println(dob);
//        out.println(fullName);
        if (!passWord.equals(confirmPassword)) {
            request.setAttribute("error", "Password and re-enter password are not the same");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {

            Customers customerAccount = dao.checkAccount(email);
            if (customerAccount == null) {
                Customers customerAccount1 = dao.checkAccountName(userName);
                if (customerAccount1 == null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", userName);
                    session.setAttribute("pass", passWord);
                    session.setAttribute("phone_number", phoneNumber);
                    session.setAttribute("email", email);
                    session.setAttribute("address", address);
                    session.setAttribute("gender", gender);
                    session.setAttribute("dob", dob);
                    session.setAttribute("fullname", fullName);

                    Email e = new Email();
                    String verifyLink = "http://localhost:9999/ProjectSWP/verifyaccount"; // Thay đổi URL theo link xác nhận của bạn

                    String emailContent = "<!DOCTYPE html>\n"
                            + "<html>\n"
                            + "<head>\n"
                            + "</head>\n"
                            + "<body>\n"
                            + "<p>Please verify your email by clicking the following link:</p>\n"
                            + "<a href=\"" + verifyLink + "\">Verify Email</a>\n"
                            + "\n"
                            + "</body>\n"
                            + "</html>";

                    e.sendEmail(email, "Verify your email", emailContent);
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
