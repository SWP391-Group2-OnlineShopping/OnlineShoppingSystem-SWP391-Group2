package controller.mkt;

import com.google.gson.Gson;
import controller.auth.Authorization;
import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;
import model.Staffs;

@WebServlet(name = "MKTCustomerList", urlPatterns = {"/mktcustomerlist"})
public class MKTCustomerList extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        if (session.getAttribute("acc") != null) {
            Authorization.redirectToHome(session, response);
//            response.sendRedirect("index.jsp");
        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
            Authorization.redirectToHome(session, response);
        } else {

            CustomersDAO customerDao = new CustomersDAO();
            String status = request.getParameter("status");
            String search = request.getParameter("search");
            String sortField = request.getParameter("sortField");
            String sortOrder = request.getParameter("sortOrder");
            String gender = request.getParameter("gender");
            ArrayList<Customers> customerList;

            if (sortField == null || sortField.isEmpty()) {
                sortField = "CustomerID"; // Default sort field
            }

            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "ASC"; // Default sort order
            }

            if (gender == null || gender.isEmpty() || gender.equals("both")) {
                if (status == null || status.isEmpty()) {
                    if (search == null || search.isEmpty()) {
                        customerList = customerDao.SortAllCustomersMKTByField(sortField, sortOrder);
                    } else {
                        customerList = customerDao.SortAllCustomersMKTByFieldAndInformation(sortField, sortOrder, search, search, search, search);
                    }
                } else {
                    customerList = customerDao.SortAllCustomersMKTByFieldStatusAndInformation(sortField, sortOrder, status, search, search, search, search);
                }
            } else {
                boolean isMale = gender.equals("male");
                if (status == null || status.isEmpty()) {
                    customerList = customerDao.SortAllCustomersMKTByFieldGenderAndInformation(sortField, sortOrder, isMale, search, search, search, search);
                } else {
                    customerList = customerDao.SortAllCustomersMKTByFieldStatusGenderAndInformation(sortField, sortOrder, status, isMale, search, search, search, search);
                }
            }

            // Pagination
            int page = 1;
            int recordsPerPage = 10;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int start = (page - 1) * recordsPerPage;
            int end = Math.min(start + recordsPerPage, customerList.size());

            ArrayList<Customers> paginatedList = new ArrayList<>(customerList.subList(start, end));
            int noOfPages = (int) Math.ceil(customerList.size() * 1.0 / recordsPerPage);

            // Check if the request is an AJAX request
            String ajaxRequest = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(ajaxRequest)) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(paginatedList);
                out.print("{\"customers\": " + jsonResponse + ", \"noOfPages\": " + noOfPages + ", \"currentPage\": " + page + "}");
                out.flush();
                return;
            }

            request.setAttribute("customerList", paginatedList);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalRecords", customerList.size());
            request.setAttribute("status", status); // Pass the status to the JSP
            request.setAttribute("sortField", sortField); // Pass the sortField to the JSP
            request.setAttribute("sortOrder", sortOrder); // Pass the sortOrder to the JSP
            request.setAttribute("search", search); // Pass the search to the JSP
            request.setAttribute("gender", gender); // Pass the gender to the JSP

            request.getRequestDispatcher("mktcustomerlist.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
