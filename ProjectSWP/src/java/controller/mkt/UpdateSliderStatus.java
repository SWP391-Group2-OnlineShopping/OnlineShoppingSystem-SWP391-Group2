package controller.mkt;

import dal.SliderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateSliderStatus")
public class UpdateSliderStatus extends HttpServlet {

    private SliderDAO sliderDAO;

    @Override
    public void init() {
        sliderDAO = new SliderDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the parameters from the request
            int sliderID = Integer.parseInt(request.getParameter("sliderID"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            // Update the slider status
            boolean isUpdated = sliderDAO.updateSliderStatus(sliderID, status);

            // Send the response
            if (isUpdated) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Status updated successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error updating status");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid request");
        }
    }
}