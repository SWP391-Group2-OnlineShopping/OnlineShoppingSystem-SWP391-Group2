/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import dal.BlogDAO;
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
@WebServlet(name = "BlogDetail", urlPatterns = {"/blogdetail"})
public class BlogDetail extends HttpServlet {

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
        BlogDAO dao = new BlogDAO();
        int postID;
        try {
            postID = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            // Handle the error, e.g., by redirecting to an error page
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }

        Posts post = dao.getPostByPostID(postID);
        if (post == null) {
            // Handle the case where the post does not exist
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
            return;
        }

        List<PostCategoryList> pcl = dao.getPostCategoriesByPostID(postID);
        List<Posts> posts = new ArrayList<>();

        if (!pcl.isEmpty()) {
            String[] categoryString = new String[pcl.size()];
            for(int i = 0; i<pcl.size();i++){
                categoryString[i] = String.valueOf(pcl.get(i).getPostCL());
            }
            List<Posts> tempPosts = dao.getPostsByCategoriesAndFilter(categoryString, "", 0, 0);

            for (int i = 0; i < pcl.size() && i < tempPosts.size() && i < 3; i++) {
                posts.add(tempPosts.get(i));
            }
        }

        request.setAttribute("recentPosts", posts);
        request.setAttribute("pcl", pcl);
        request.setAttribute("post", post);
        request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
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
