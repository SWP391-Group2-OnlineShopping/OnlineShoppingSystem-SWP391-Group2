package controller.mkt;

import com.google.gson.JsonObject;
import dal.SliderDAO;
import model.Sliders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditBanner", urlPatterns = {"/editBanner"})
public class EditBanner extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();

        try {
            // Retrieve parameters from the request
            String sliderIDStr = request.getParameter("sliderID");
            String statusStr = request.getParameter("status");
            String backLink = request.getParameter("backLink");
            String title = request.getParameter("title");
            String imageLink = request.getParameter("imageLink");

            // Parse the parameters
            int sliderID = Integer.parseInt(sliderIDStr);
            boolean status = "on".equals(statusStr); // Assuming status checkbox sends "on" when checked

            // Create a Sliders object with the updated details
            Sliders slider = new Sliders();
            slider.setSliderID(sliderID);
            slider.setStatus(status);
            slider.setBackLink(backLink);
            slider.setTitle(title);
            slider.setImageLink(imageLink);

            // Create an instance of SliderDAO to update the slider
            SliderDAO sliderDAO = new SliderDAO();
            boolean updateResult = sliderDAO.updateSlider(slider);

            // Set the response JSON object based on the result
            if (updateResult) {
                jsonResponse.addProperty("status", "success");
                jsonResponse.addProperty("message", "Banner edited successfully.");
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "Failed to update the slider.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "An error occurred while processing the request.");
        }

        // Send the JSON response
        response.getWriter().write(jsonResponse.toString());
    }
}
