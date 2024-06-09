package controller.mkt;

import dal.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteBanner
 */
@WebServlet(name="DeleteBanner", urlPatterns={"/deleteBanner"})
public class DeleteBanner extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (var out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteBanner</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteBanner at " + request.getContextPath() + "</h1>");
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
        // Get the banner ID from the request
        int bannerID = Integer.parseInt(request.getParameter("sliderID"));

        // Create an instance of the DAO
        SliderDAO sliderDAO = new SliderDAO();

        // Delete the banner
        boolean isDeleted = sliderDAO.deleteSlider(bannerID);
        // Prepare the response
        response.setContentType("application/json");
        try (var out = response.getWriter()) {
            if (isDeleted) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.write("{\"message\": \"Banner deleted successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"message\": \"Error deleting banner\"}");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet that deletes a banner based on its ID";
    }
}