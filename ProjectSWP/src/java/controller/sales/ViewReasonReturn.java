package controller.sales;

import dal.RequestReturnDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.RequestReturn;
import com.google.gson.Gson;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ViewReasonReturn", urlPatterns = {"/viewreasonreturn"})
public class ViewReasonReturn extends HttpServlet {

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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        RequestReturnDAO rDao = new RequestReturnDAO();
        RequestReturn requestReturn = rDao.getRequestByOrderID(orderId);
        
        // Convert the requestReturn object to JSON
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(requestReturn);
        
        System.out.println("JSON Response: " + jsonResponse); // Debug log
        
        out.print(jsonResponse);
        out.flush();
        
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
