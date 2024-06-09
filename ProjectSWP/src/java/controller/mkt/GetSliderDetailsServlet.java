package controller.mkt;

import com.google.gson.Gson;
import controller.auth.Authorization;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Sliders;
import dal.SliderDAO;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Staffs;

@WebServlet(name = "GetSliderDetailsServlet", urlPatterns = {"/getSliderDetails"})
public class GetSliderDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            // Retrieve the sliderID parameter from the request
            int sliderID = Integer.parseInt(request.getParameter("sliderID"));

            // Create an instance of SliderDAO to interact with the database
            SliderDAO sliderDAO = new SliderDAO();

            // Call the getSliderByID method to fetch the slider details by its ID
            Sliders slider = sliderDAO.getSliderByID(sliderID);

            // Set the content type of the response to JSON
            response.setContentType("application/json");

            // Get the PrintWriter object to write the response
            PrintWriter out = response.getWriter();

            // Convert the slider object to JSON using Gson library
            Gson gson = new Gson();
            String sliderJson = gson.toJson(slider);

            // Write the JSON response back to the client-side JavaScript code
            out.println(sliderJson);
        }

    }
}
