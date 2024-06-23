
import dal.FeedbackDAO;
import dal.ImageDAO;
import dal.OrderDAO;
import dal.RequestReturnDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedbacks;
import model.Images;
import model.RequestReturn;

@WebServlet(name = "ReturnOrder", urlPatterns = {"/returnorder"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ReturnOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReturnOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReturnOrder at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Handle text fields
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            String reason = request.getParameter("reason");
            String phoneNumber = request.getParameter("phonenumber");
            String bankAccount = request.getParameter("bankaccount");

            // Get customerID
            OrderDAO orderDAO = new OrderDAO();
            int customerID = orderDAO.getOrderByOrderID(orderID).getCustomerID();

            // Handle file upload
            List<Part> fileParts = (List<Part>) request.getParts();
            List<String> imageLinks = new ArrayList<>();
            for (Part filePart : fileParts) {
                if (filePart.getName().equals("image") && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    if (fileName != null && !fileName.isEmpty()) {
                        String applicationPath = request.getServletContext().getRealPath("");
                        String uploadFilePath = applicationPath + File.separator + "uploads";
                        File uploadDir = new File(uploadFilePath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        filePart.write(uploadFilePath + File.separator + fileName);
                        imageLinks.add("uploads/" + fileName);
                    }
                }
            }

            // Create RequestReturn object
            RequestReturn requestReturn = new RequestReturn();
            requestReturn.setOrderID(orderID);
            requestReturn.setCustomerID(customerID);
            requestReturn.setReason(reason);
            requestReturn.setPhoneNumber(phoneNumber);
            requestReturn.setBankAccount(bankAccount);
            requestReturn.setDate(Date.valueOf(LocalDate.now()));

            // Insert requestReturn into the database
            RequestReturnDAO rDao = new RequestReturnDAO();
            int isInserted = rDao.insertRequestReturn(requestReturn);

            if (isInserted != 0) {
                int requestID = rDao.getRequestWithRequestID(isInserted).getRequestID();
                out.println("Inserted RequestReturn ID: " + requestID);

                if (!imageLinks.isEmpty()) {
                    ImageDAO imageDAO = new ImageDAO();
                    for (String imageLink : imageLinks) {
                        Images image = new Images();
                        image.setLink(imageLink);
                        int imageID = imageDAO.insertImage(image);
                        out.println("Inserted Image ID: " + imageID);
                        imageDAO.insertImageMapping(5, requestID, imageID);
                        out.println("Image mapping inserted: requestID=" + requestID + ", imageID=" + imageID);
                    }
                }
                orderDAO.changeStatusOrder(orderID, 13);
                response.getWriter().write("RequestReturn submitted successfully!");
                response.sendRedirect("orderdetail?orderID=" + orderID);
            } else {
                response.getWriter().write("Error submitting RequestReturn.");
                response.sendRedirect("error.jsp");

            }
        } catch (SQLException ex) {
            Logger.getLogger(ReturnOrder.class.getName()).log(Level.SEVERE, "Error inserting RequestReturn", ex);
            response.getWriter().write("Error submitting RequestReturn: " + ex.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(ReturnOrder.class.getName()).log(Level.SEVERE, "General error", ex);
            response.getWriter().write("General error: " + ex.getMessage());
        } finally {
            out.close();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
