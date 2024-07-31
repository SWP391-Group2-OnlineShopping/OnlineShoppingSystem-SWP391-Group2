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
import java.sql.SQLException;
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
@WebServlet(name = "EditVoucher", urlPatterns = {"/EditVoucher"})
public class EditVoucher extends HttpServlet {

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
            out.println("<title>Servlet EditVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditVoucher at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {
            try {
                // Lấy dữ liệu từ form
                String name = request.getParameter("name");
                int percent = Integer.parseInt(request.getParameter("percent"));
                float requirement = Float.parseFloat(request.getParameter("requirement"));
                String desc = request.getParameter("desc");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                String expiredDateStr = request.getParameter("expiredDate");

                // Chuyển đổi chuỗi ngày tháng thành đối tượng Date
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date expiredDate = null;
                try {
                    expiredDate = sdf.parse(expiredDateStr);
                } catch (ParseException e) {
                    e.printStackTrace();
                    out.println("{\"success\":false, \"message\":\"Invalid date format.\"}");
                    return;
                }

                // Lấy ID của voucher
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));

                // Tạo đối tượng Voucher và cập nhật thông tin
                Voucher voucher = new Voucher();
                voucher.setId(voucherID);
                voucher.setName(name);
                voucher.setPercent(percent);
                voucher.setRequirement(requirement);
                voucher.setDescription(desc);
                voucher.setStatus(status);
                voucher.setExpiredDate(expiredDate);

                // Cập nhật voucher trong cơ sở dữ liệu
                VoucherDAO vDAO = new VoucherDAO();
                boolean updateSuccessful = vDAO.updateVoucher(voucher);

                // Gửi phản hồi JSON
                if (updateSuccessful) {
                    out.println("{\"success\":true}");
                } else {
                    out.println("{\"success\":false, \"message\":\"Update failed.\"}");
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.println("{\"success\":false, \"message\":\"Invalid input format.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("{\"success\":false, \"message\":\"An error occurred.\"}");
            } finally {
                out.flush();
                out.close();
            }
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
