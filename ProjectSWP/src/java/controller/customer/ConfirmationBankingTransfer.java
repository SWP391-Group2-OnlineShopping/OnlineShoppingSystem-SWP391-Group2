/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import jakarta.servlet.ServletConfig;
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
import model.Products;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ConfirmationBankingTransfer", urlPatterns = {"/confirmationbankingtransfer"})
public class ConfirmationBankingTransfer extends HttpServlet {

    private int expirationTimeMinutes;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        // Lấy giá trị thời gian hết hạn từ tham số ngữ cảnh trong web.xml
        String expirationTimeParam = config.getServletContext().getInitParameter("verifyLinkExpirationConfirmTime");
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
            out.println("<title>Servlet ConfirmationBankingTransfer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmationBankingTransfer at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("bankingtransferonline.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customers customers = (Customers) session.getAttribute("acc");

        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String orderNotes = request.getParameter("orderNotes");
        String productData = request.getParameter("productData");

        // Parse product data JSON
        List<Products> products = new ArrayList<>();
        JSONArray productsArray = new JSONArray(productData);

        for (int i = 0; i < productsArray.length(); i++) {
            JSONObject productObject = productsArray.getJSONObject(i);
            int productID = Integer.parseInt(productObject.getString("productID"));
            String productTitle = productObject.getString("productTitle");
            float productPrice = (float) productObject.getDouble("productPrice");
            String productSize = productObject.getString("productSize");
            int productQuantity = productObject.getInt("productQuantity");
            String productImage = productObject.getString("productImage");

            Products product = new Products(productID, productTitle, productPrice, productSize, productQuantity, productImage);
            products.add(product);
        }

        if (customers.getEmail() != null) {
            // Set attributes to be used in the JSP
            session.setAttribute("fullName", fullName);
            session.setAttribute("address", address);
            session.setAttribute("phoneNumber", phoneNumber);
            session.setAttribute("orderNotes", orderNotes);
            session.setAttribute("products", products);
            session.setAttribute("email", customers.getEmail());

            //Send Email Confirmation
            Email e = new Email();
            long expirationTimeMillis = System.currentTimeMillis() + (expirationTimeMinutes * 60 * 1000);

            String verifyLink = "http://localhost:9999/ProjectSWP/confirmbankingtransfer?expire=" + expirationTimeMillis; // Thay đổi URL theo link xác nhận của bạn

            String emailContent = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "<head>\n"
                    + "    <style>\n"
                    + "        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }\n"
                    + "        .email-container { max-width: 800px; margin: 40px auto; background-color: #ffffff; padding: 20px; border: 1px solid #dddddd; border-radius: 10px; }\n"
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
                    + "        .product-list { width: 100%; border-collapse: collapse; }\n"
                    + "        .product-list th, .product-list td { border: 1px solid #ddd; padding: 8px; text-align: left; }\n"
                    + "        .product-list th { background-color: #f2f2f2; }\n"
                    + "        .product-list img { max-width: 100px; height: auto; display: block; margin: auto; }\n"
                    + "        .product-item { background-color: #f9f9f9; }\n"
                    + "    </style>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "    <div class=\"email-container\">\n"
                    + "        <div class=\"header\">\n"
                    + "            DiLuri<span>.</span>\n"
                    + "            <div class=\"header-icon\"><img src=\"https://cdn-icons-png.freepik.com/512/9840/9840606.png\" alt=\"Email Icon\"></div>\n"
                    + "        </div>\n"
                    + "        <div class=\"content\">\n"
                    + "            <h1>Confirmation Order</h1>\n"
                    + "            <p>Hi " + fullName + ",</p>\n"
                    + "            <p>Please check your product and confirm by clicking the button below to complete your order. The link expires in " + expirationTimeMinutes + " minutes.</p>\n"
                    + "            <h1 class=\"h3 mb-3\">Order Confirmation</h1>\n"
                    + "            <p><strong>Full Name:</strong> " + fullName + "</p>\n"
                    + "            <p><strong>Address:</strong> " + address + "</p>\n"
                    + "            <p><strong>Phone Number:</strong> " + phoneNumber + "</p>\n"
                    + "            <p><strong>Order Notes:</strong> " + orderNotes + "</p>\n"
                    + "            <h2 class=\"h4 mt-4\">Products</h2>\n"
                    + "            <table class=\"product-list\">\n"
                    + "                <thead>\n"
                    + "                    <tr>\n"
                    + "                        <th>Image</th>\n"
                    + "                        <th>Title</th>\n"
                    + "                        <th>Size</th>\n"
                    + "                        <th>Price</th>\n"
                    + "                        <th>Quantity</th>\n"
                    + "                    </tr>\n"
                    + "                </thead>\n"
                    + "                <tbody>\n";

            for (Products product : products) {
                emailContent += "                    <tr class=\"product-item\">\n"
                        + "                        <td><img src=\"" + product.getThumbnailLink() + "\" alt=\"" + product.getTitle() + "\"></td>\n"
                        + "                        <td>" + product.getTitle() + "</td>\n"
                        + "                        <td>" + product.getSize() + "</td>\n"
                        + "                        <td>" + String.format("%,.2f", product.getSalePrice()) + " VND</td>\n"
                        + "                        <td>" + product.getQuantity() + "</td>\n"
                        + "                    </tr>\n";
            }

            emailContent += "                </tbody>\n"
                    + "            </table>\n"
                    + "            <a style=\"color: white\" href=\"" + verifyLink + "\" class=\"verify-button\">Confirm Order</a>\n"
                    + "        </div>\n"
                    + "        <div class=\"footer\">\n"
                    + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                    + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";

            e.sendEmail(customers.getEmail(), "Verify your email", emailContent);
            request.setAttribute("Notification", "You need confirm email to login");
            // Forward to confirmation page
            request.getRequestDispatcher("confirmordersuccess.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
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
