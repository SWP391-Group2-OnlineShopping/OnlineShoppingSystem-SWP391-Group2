/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import dal.BlogDAO;
import dal.MarketingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import model.PostCategoryList;
import model.Posts;

/**
 *
 * @author DELL
 */
@WebServlet(name = "BlogServlet", urlPatterns = {"/blog"})
public class BlogServlet extends HttpServlet {

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
    request.setCharacterEncoding("UTF-8");
    int sortCriteria = 1;  // Default sortCriteria
    int sortOptions = 2;   // Default sortOptions
    String search = "";
    int page = 1;
    int recordsPerPage = 5; // Number of posts per page

    BlogDAO dao = new BlogDAO();

    try {
        if (request.getParameter("sortCriteria") != null) {
            sortCriteria = Integer.parseInt(request.getParameter("sortCriteria"));
        }
    } catch (NumberFormatException e) {
        // Handle exception
    }

    try {
        if (request.getParameter("sortOptions") != null) {
            sortOptions = Integer.parseInt(request.getParameter("sortOptions"));
        }
    } catch (NumberFormatException e) {
        // Handle exception
    }

    try {
        if (request.getParameter("txt") != null) {
            search = request.getParameter("txt");
        }
    } catch (Exception e) {
        // Handle exception
    }

    try {
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
    } catch (NumberFormatException e) {
        // Handle exception
    }

    List<Posts> posts = new ArrayList<>();
    List<PostCategoryList> cate = dao.getAllPostCategories();

    String[] selectedCategories = request.getParameterValues("category");
    String categoriesParam = "";
    if (selectedCategories != null && selectedCategories.length > 0) {
        categoriesParam = String.join(",", selectedCategories);
         categoriesParam = Arrays.stream(selectedCategories).map(num -> "&category=" + num).collect(Collectors.joining());
    }

    int count;
    if (selectedCategories != null && selectedCategories.length > 0) {
        count = dao.countPostsByCategoriesAndFilter(selectedCategories, search); // Adjust DAO method to get count of filtered posts
        posts = dao.getPostsByCategoriesAndFilter(selectedCategories, search, sortCriteria, sortOptions, page); // Add pagination parameters
        for (PostCategoryList pcl : cate) {
            for (String selectedCategory : selectedCategories) {
                if (pcl.getPostCL() == Integer.parseInt(selectedCategory)) {
                    pcl.setChecked(true);
                    break;
                }
            }
        }
    } else {
        count = dao.getCountAllPost(search, sortCriteria, sortOptions); // Adjust DAO method to get count of all posts with filters
        posts = dao.showAllPosts(search, sortCriteria, sortOptions, page); // Add pagination parameters
    }

    int endPage = (int) Math.ceil((double) count / recordsPerPage);

    request.setAttribute("endPage", endPage);
    request.setAttribute("currentPage", page);
    request.setAttribute("search", search);
    request.setAttribute("sortCriteria", sortCriteria);
    request.setAttribute("sortOptions", sortOptions);
    request.setAttribute("categoriesParam", categoriesParam);
    request.setAttribute("category", cate);
    request.setAttribute("posts", posts);
    request.getRequestDispatcher("blog.jsp").forward(request, response);
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
