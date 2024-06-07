package controller.customer;
import controller.sales.SalesAssigner;
import dal.CustomersDAO;
import dal.OrderDAO;
import dal.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Customers;
import model.Email;
import model.Products;
import model.Staffs;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ConfirmationShipCOD", urlPatterns = {"/confirmationshipcod"})
public class ConfirmationShipCOD extends HttpServlet {



    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConfirmationShipCOD</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmationShipCOD at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Kiểm tra xem email đã được gửi chưa
        Boolean emailSent = (Boolean) session.getAttribute("emailSent");
        if (emailSent != null && emailSent) {
            // Email đã được gửi, chuyển hướng đến trang thành công
            request.getRequestDispatcher("confirmordersuccessCOD.jsp").forward(request, response);
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
            request.setAttribute("fullName", fullName);
            request.setAttribute("address", address);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("orderNotes", orderNotes);
            request.setAttribute("products", products);
            request.setAttribute("email", customers.getEmail());
            session.setAttribute("ShipCOD", "Ship COD");

            StaffDAO staffDAO = new StaffDAO();
            CustomersDAO cDAO = new CustomersDAO();
            OrderDAO oDAO = new OrderDAO();

            // Get sale with least orders
            List<Staffs> staffSaleList = staffDAO.getAllStaffSales();
            Staffs assignedSales = SalesAssigner.getNextSales(staffSaleList, "shipCOD");
            int idStaff = assignedSales.getStaffID();

            int numberOfItems = 0;
            float totalPrice = 0;
            for (Products p : products) {
                if (p.getQuantity() != 0 && p.getSalePrice() != 0) {
                    numberOfItems++;
                    totalPrice += p.getSalePrice() * p.getQuantity();
                }
            }

            // Get receiver id information
            int receiverID = cDAO.GetReceiverIDByNameAddressPhone(fullName, phoneNumber, address);

            // Create new order
            oDAO.CreateNewOrder(customers.getCustomer_id(), totalPrice, numberOfItems, 1, idStaff, receiverID, orderNotes);
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
                    + "            <p>Thank you for your order, we will send the goods to you soon, happy to serve you. </p>\n"
                    + "            <h3 class=\"h3 mb-3\">Order Information</h3>\n"
                    + "            <p><strong>Full Name:</strong> " + fullName + "</p>\n"
                    + "            <p><strong>Address:</strong> " + address + "</p>\n"
                    + "            <p><strong>Phone Number:</strong> " + phoneNumber + "</p>\n"
                    + "            <p><strong>Order Notes:</strong> " + orderNotes + "</p>\n"
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

            e.sendEmail(customers.getEmail(), "Verify your email", emailContent);

            // Đặt cờ đã gửi email trong session
            session.setAttribute("emailSent", true);

            request.getRequestDispatcher("confirmordersuccessCOD.jsp").forward(request, response);
        }
    }

   

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}