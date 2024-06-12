/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.vnpay.common.Config;
import controller.auth.Authorization;
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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import model.Customers;
import model.Email;
import model.Products;
import model.Staffs;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ConfirmationVNPay", urlPatterns = {"/vnpay"})
public class ConfirmationVNPay extends HttpServlet {

    /*
    9704198526191432198
    NGUYEN VAN A
    	07/15
     */
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
            out.println("<title>Servlet ConfirmationVNPay</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmationVNPay at " + request.getContextPath() + "</h1>");
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
        String redirect = request.getParameter("redirect");
        request.setAttribute("redirect", redirect);

        if (session.getAttribute("acc") == null) {
            request.setAttribute("error", "Please login first");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (session.getAttribute("staff") != null) {
            Authorization.redirectToHome(session, response);
        } else {
            request.getRequestDispatcher("vnpay_pay.jsp").forward(request, response);
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

        HttpSession session = request.getSession();

        //check token
        String sessionToken = (String) session.getAttribute("formToken");
        String requestToken = request.getParameter("formToken");

        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            // token invalid or used
            response.sendRedirect("confirmsuccessvnpay.jsp");
            return;
        }

        // token valid
        session.removeAttribute("formToken");

        // check email sent in session
        Boolean mailSent = (Boolean) session.getAttribute("mailSent");
        if (mailSent != null && mailSent) {
            // already sent and avoid resend
            response.sendRedirect("confirmsuccessvnpay.jsp");
            return;
        }

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
            int productCSID = Integer.parseInt(productObject.getString("productCSID"));
            int productID = Integer.parseInt(productObject.getString("productID"));
            String productTitle = productObject.getString("productTitle");
            float productPrice = productObject.getFloat("productPrice");
            String productSize = productObject.getString("productSize");
            int productQuantity = productObject.getInt("productQuantity");
            String productImage = productObject.getString("productImage");

            Products product = new Products(productID, productTitle, productPrice, productSize, productQuantity, productImage, productCSID);
            products.add(product);
        }

        if (customers.getEmail() != null) {
            session.setAttribute("email_vnpay", customers.getEmail());
            session.setAttribute("fullName_vnpay", fullName);
            session.setAttribute("address_vnpay", address);
            session.setAttribute("phoneNumber_vnpay", phoneNumber);
            session.setAttribute("orderNotes_vnpay", orderNotes);
            session.setAttribute("products_vnpay", products);

            StaffDAO staffDAO = new StaffDAO();
            CustomersDAO cDAO = new CustomersDAO();
            OrderDAO oDAO = new OrderDAO();

            // Get sale with least orders
            List<Staffs> staffSaleList = staffDAO.getAllLeastOrderCountFromSale();
            int idStaff = 0;
            float totalPrice = 0;
            int numberOfItems = 0;
            if (staffSaleList != null && !staffSaleList.isEmpty()) {
                Staffs assignedSales = staffSaleList.get(0);
                idStaff = assignedSales.getStaffID();
                if (products != null) {
                    for (Products p : products) {
                        if (p.getQuantity() > 0 && p.getSalePrice() > 0) {
                            numberOfItems++;
                            totalPrice += p.getSalePrice() * p.getQuantity();
                        }
                    }
                } else {
                    System.out.println("Product list is null.");
                }
            }

            // Get receiver id information
            int receiverID = cDAO.GetReceiverIDByNameAddressPhone(fullName, phoneNumber, address);

            // Create new order
            oDAO.CreateNewOrder(customers.getCustomer_id(), totalPrice, numberOfItems, 1, idStaff, receiverID, orderNotes, "VNPay");
            // Add orderdetail
            for (Products p : products) {
                if (p.getProductCSID() != 0) {
                    oDAO.AddToOrderDetail(customers.getCustomer_id(), p.getProductCSID(), p.getQuantity());
                }
            }

            //remove product order from cart and decrase quantities available
            for (Products p : products) {
                if (p.getProductCSID() != 0) {
                    cDAO.removeCartAfterOrder(p.getProductCSID(), p.getSalePrice() * p.getQuantity(), customers.getCustomer_id());
                    cDAO.decreseQuantitiesAfterOrder(p.getProductCSID(), p.getQuantity(), p.getSize());
                }
            }

            // Send Email Confirmation
            Email e = new Email();

            String verifyLink = "http://localhost:9999/ProjectSWP/product";

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
                    + "            <h1>Order Successful!</h1>\n"
                    + "            <p>Hi " + fullName + ",</p>\n"
                    + "            <p>Thank you for ordering at our store, if you have paid or chosen COD shipping, you can skip this payment information </p>\n"
                    + "            <p class=\"lead mb-5 \" style=\"color: red\"><b>If you have not paid yet, please complete your order by click again in Order History and find the Order payment by VNPay you are not complete order."
                    + "                 If you have not paid within 24 hours, your order will be canceled.</b> </p> \n"
                    + "            <h3 class=\"h3 mb-3\">Order Information</h3>\n"
                    + "            <p><strong>Full Name:</strong> " + fullName + "</p>\n"
                    + "            <p><strong>Address:</strong> " + address + "</p>\n"
                    + "            <p><strong>Phone Number:</strong> " + phoneNumber + "</p>\n"
                    + "            <p><strong>Order Notes:</strong> " + orderNotes + "</p>\n"
                    + "            <p><strong>Payment Method:</strong> Payment on delivery</p>\n"
                    + "            <h2 class=\"h4 mt-4\">Products</h4>\n"
                    + "            <table class=\"product-list\">\n"
                    + "                <thead>\n"
                    + "                    <tr>\n"
                    + "                        <th>Image</th>\n"
                    + "                        <th>Title</th>\n"
                    + "                        <th>Size</th>\n"
                    + "                        <th>Unit Price</th>\n"
                    + "                        <th>Total Price</th>\n"
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
                        + "                        <td>" + String.format("%,.2f", product.getSalePrice() * product.getQuantity()) + " VND</td>\n"
                        + "                        <td>" + product.getQuantity() + "</td>\n"
                        + "                    </tr>\n";
            }

            emailContent += "                </tbody>\n"
                    + "            </table>\n"
                    + "            <a style=\"color: white\" href=\"" + verifyLink + "\" class=\"verify-button\">Continue Shopping</a>\n"
                    + "        </div>\n"
                    + "        <div class=\"footer\">\n"
                    + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
                    + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";
            String email = (String) session.getAttribute("email_vnpay");
            e.sendEmail(email, "Confirm Order", emailContent);
            session.setAttribute("mailSent", true);
            // Đặt cờ đã gửi email trong session
            session.removeAttribute("email_vnpay");

            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";

            long amount = (long) (totalPrice * 100);

            String bankCode = request.getParameter("bankCode");

            String vnp_TxnRef = Config.getRandomNumber(8);
            String vnp_IpAddr = Config.getIpAddress(request);

            String vnp_TmnCode = Config.vnp_TmnCode;

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");

            if (bankCode != null && !bankCode.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
            vnp_Params.put("vnp_OrderType", orderType);

            String locate = request.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
            JsonObject job = new JsonObject();
            job.addProperty("code", "00");
            job.addProperty("message", "success");
            job.addProperty("data", paymentUrl);
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(job));
            request.getRequestDispatcher("vnpay_pay.jsp").forward(request, response);

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
