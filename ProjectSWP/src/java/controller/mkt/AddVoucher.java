/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import controller.auth.Authorization;
import dal.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Staffs;
import model.Voucher;
import org.json.JSONObject;

/**
 *
 * @author dumspicy
 */
@WebServlet(name = "AddVoucher", urlPatterns = {"/AddVoucher"})
public class AddVoucher extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddVoucher at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            VoucherDAO vDAO = new VoucherDAO();
            Voucher voucher = new Voucher();
            voucher.setName(request.getParameter("name"));
            voucher.setPercent(Integer.parseInt(request.getParameter("percent")));
            voucher.setRequirement(Float.parseFloat(request.getParameter("requirement")));
            voucher.setDescription(request.getParameter("desc"));
            voucher.setStatus(Boolean.parseBoolean(request.getParameter("status")));
            //convert string to date
            String expiredDateStr = request.getParameter("expiredDate");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                voucher.setExpiredDate(sdf.parse(expiredDateStr));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            vDAO.Add(voucher);

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("name", voucher.getName());
            jsonResponse.put("percent", voucher.getPercent());
            jsonResponse.put("requirement", voucher.getRequirement());
            jsonResponse.put("desc", voucher.getDescription());
            jsonResponse.put("status", voucher.isStatus());
            jsonResponse.put("expiredDate", voucher.getExpiredDate());

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());
        }
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
