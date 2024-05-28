package controller.mkt;

import dal.SliderDAO;
import model.Sliders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addBanner")
public class AddBanner extends HttpServlet {

    private SliderDAO sliderDAO;

    @Override
    public void init() {
        sliderDAO = new SliderDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form parameters
        boolean status = request.getParameter("status") != null;
        String imageLink = request.getParameter("imageLink");
        String backLink = request.getParameter("backLink");
        String title = request.getParameter("title");
        int staffID = Integer.parseInt(request.getParameter("staffID"));

        // Create a new Sliders object
        Sliders slider = new Sliders();
        slider.setStatus(status);
        slider.setImageLink(imageLink);
        slider.setBackLink(backLink);
        slider.setTitle(title);
        slider.setStaffID(staffID);

        // Insert the slider into the database
        boolean isInserted = sliderDAO.insertSlider(slider);

        // Send the response
        if (isInserted) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Banner added successfully");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error adding banner");
        }
    }
}