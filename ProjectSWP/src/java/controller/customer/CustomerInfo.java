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
import java.nio.file.Paths;
import model.Customers;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class CustomerInfo extends HttpServlet implements Serializable {

    private static final long serialVersionUID = 1L;

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

            // Xử lý upload avatar
            Part filePart = request.getPart("avatar");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String avatarPath = null;
            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + "uploads";
                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(uploadFilePath + File.separator + fileName);
                avatarPath = "uploads/" + fileName; // Đường dẫn tương đối đến ảnh avatar
            }

            String err = "";
            if (fullName.isEmpty() || fullName == null) {
                err += "Full name is required.";
            } else if (address.isEmpty() || address == null) {
                err += "Address is required";
            } else if (!isValidPhone(phone)) {
                err += "Phone number is invalid";
            }

            if (!err.isEmpty()) {
                request.setAttribute("error", err);
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            } else {
                CustomersDAO cDAO = new CustomersDAO();
                boolean isUpdate = cDAO.UpdateCustomer(id, fullName, address, phone, gender, avatarPath);
                if (isUpdate) {
                    HttpSession session = request.getSession();
                    Customers updateCustomer = cDAO.GetCustomerByID(id);
                    session.setAttribute("userInfo", updateCustomer);
                    request.getRequestDispatcher("userProfile.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to update user information.");
                    request.getRequestDispatcher("userProfile.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private boolean isValidPhone(String phone) {
        // Regex to check if the phone number is a natural number between 7 and 11 digits
        String regex = "\\d{7,11}";
        return phone != null && phone.matches(regex);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
