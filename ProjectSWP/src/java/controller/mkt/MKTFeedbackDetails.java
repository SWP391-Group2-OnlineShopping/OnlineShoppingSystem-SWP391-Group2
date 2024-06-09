package controller.mkt;

import com.google.gson.Gson;
import controller.auth.Authorization;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedbacks;
import dal.FeedbackDAO;
import jakarta.servlet.http.HttpSession;
import model.Staffs;

/**
 * @author Admin
 */
@WebServlet(name = "MKTFeedbackDetails", urlPatterns = {"/MKTFeedbackDetails"})
public class MKTFeedbackDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            
            // Retrieve the sliderID parameter from the request
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));

            // Create an instance of SliderDAO to interact with the database
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            // Call the getSliderByID method to fetch the slider details by its ID
            Feedbacks feedback = feedbackDAO.getFeedbackWithFeedbackID(feedbackID);

            // Set the content type of the response to JSON
            response.setContentType("application/json");

            // Get the PrintWriter object to write the response
            PrintWriter out = response.getWriter();

            // Convert the slider object to JSON using Gson library
            Gson gson = new Gson();
            String feedbackJson = gson.toJson(feedback);

            // Write the JSON response back to the client-side JavaScript code
            out.println(feedbackJson);
        }
        
    }
}
