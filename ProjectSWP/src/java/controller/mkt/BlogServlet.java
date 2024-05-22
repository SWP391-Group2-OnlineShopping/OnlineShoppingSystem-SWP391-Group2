/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import dal.MarketingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
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
        MarketingDAO dao = new MarketingDAO();
        List<Posts> posts = dao.showAllPosts("",0, 0);
        List<PostCategoryList> cate = dao.getAllPostCategories();
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
        int sortCriteria = 0;
        int sortOptions = 0;
        
        String search = "";
        MarketingDAO dao = new MarketingDAO();
        try {
            sortCriteria = Integer.parseInt(request.getParameter("sortCriteria"));
            sortOptions = Integer.parseInt(request.getParameter("sortOptions"));
            search = request.getParameter("txt");
        } catch (Exception e) {

        }

        List<Posts> posts = new ArrayList<>();
        List<PostCategoryList> cate = dao.getAllPostCategories();

        String[] selectedCategories = request.getParameterValues("category");
        String categoriesParam = "";
        if (selectedCategories != null && selectedCategories.length > 0) {
            categoriesParam = String.join(",", selectedCategories);
        }
        if (selectedCategories != null && selectedCategories.length > 0) {
            posts = dao.getPostsByCategoriesAndFilter(selectedCategories, search,sortCriteria, sortOptions);
            for (PostCategoryList pcl : cate) {
                for (String selectedCategory : selectedCategories) {
                    if (pcl.getPostCL() == Integer.parseInt(selectedCategory)) {
                        pcl.setChecked(true);
                        break;
                    }
                }
            }
        } else {
            posts = dao.showAllPosts(search,sortCriteria, sortOptions);
        }
        request.setAttribute("search", search);
        request.setAttribute("sortCriteria", sortCriteria);
        request.setAttribute("sortOptions", sortOptions);
        request.setAttribute("categoriesParam", categoriesParam);
        request.setAttribute("category", cate);
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("blog.jsp").forward(request, response);
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
