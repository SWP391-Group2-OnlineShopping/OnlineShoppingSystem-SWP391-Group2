/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import controller.auth.Authorization;
import dal.MarketingDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.BrandTotal;
import model.OrderDetail;
import model.Orders;
import model.Staffs;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "MKTDashboard", urlPatterns = {"/dashboardmkt"})
public class MKTDashboard extends HttpServlet {

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
        HttpSession session = request.getSession();

        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {

            MarketingDAO dao = new MarketingDAO();

            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDate earningDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String datee = earningDate.format(formatter);
            System.out.println(datee);

            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            LocalDateTime startDate;
            LocalDateTime endDate;

            if (startDateStr == null || startDateStr.isEmpty()) {
                LocalDateTime sevenDaysAgo = LocalDateTime.now().minusDays(7);
                startDate = sevenDaysAgo;
            } else {
                startDate = LocalDateTime.parse(startDateStr, inputFormatter);
            }

            if (endDateStr == null || endDateStr.isEmpty()) {
                LocalDateTime today = LocalDateTime.now();
                endDate = today;
            } else {
                endDate = LocalDateTime.parse(endDateStr, inputFormatter);
            }

            String formattedStartDate = startDate.format(outputFormatter);
            String formattedEndDate = endDate.format(outputFormatter);
            System.out.println(formattedStartDate);
            System.out.println(formattedEndDate);

            //lay all customer
            int countCustomer = dao.getCustomer();
            int countNewCus = dao.getNewCustomer(formattedStartDate, formattedEndDate);
            int countOldCus = countCustomer - countNewCus;
            float percent = 100 + (((countNewCus - countOldCus) / (float) countOldCus) * 100);
            request.setAttribute("percent", percent);
            request.setAttribute("cus", countCustomer);
            request.setAttribute("newCus", countNewCus);

            //lay all post
            int countPost = dao.getAllPost();
            int countNewPost = dao.getTotalPost(formattedStartDate, formattedEndDate);
            int countOldPost = countPost - countNewPost;

            float percentP;
            if (countOldPost == 0) {
                percentP = countNewPost > 0 ? 100.0f : 0.0f;
            } else {
                percentP = 100 + (((countNewPost - countOldPost) / (float) countOldPost) * 100);
            }

            request.setAttribute("percentP", percentP);
            request.setAttribute("post", countPost);
            int countFeedbacks = dao.getAllFeedbacks();
            int countNewFeedbacks = dao.getTotalFeedbacks(formattedStartDate, formattedEndDate);
            int countOldFeedbacks = countFeedbacks - countNewFeedbacks;

            float percentF;
            if (countOldFeedbacks == 0) {
                percentF = countNewFeedbacks > 0 ? 100.0f : 0.0f;
            } else {
                percentF = 100 + (((countNewFeedbacks - countOldFeedbacks) / (float) countOldFeedbacks) * 100);
            }

            request.setAttribute("percentF", percentF);
            request.setAttribute("feedbacks", countFeedbacks);
            //Display the doashboard of all products
            int revenue = dao.countRevenue();
            request.setAttribute("revenue", revenue);
            int order = dao.countTotalOrder();
            request.setAttribute("order", order);
            int revenue7day = dao.countRevenue7Day(formattedStartDate, formattedEndDate);
            request.setAttribute("revenue7day", revenue7day);

            int differenceRevenue = revenue - revenue7day;
            request.setAttribute("drevenue", differenceRevenue);
            String year = request.getParameter("year");
            //Thong ke theo thang 
            List<Orders> list = dao.getRevenue("2024");
            request.setAttribute("listr", list);

            int erning = dao.getEarningDay(datee);
            System.out.println(erning);
            request.setAttribute("erning", erning);

            Orders highest = dao.getHighestMonth();
            Orders lowest = dao.getLowestMonth();
            request.setAttribute("high", highest);
            request.setAttribute("low", lowest);

            List<BrandTotal> listbt = dao.getTotalByBrand();
            request.setAttribute("listbt", listbt);

            List<OrderDetail> listo = dao.getProductBestSeller();
            request.setAttribute("listo", listo);

            request.setAttribute("start", startDateStr);
            request.setAttribute("end", endDateStr);

            request.getRequestDispatcher("mktdashboard.jsp").forward(request, response);

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
        processRequest(request, response);
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
