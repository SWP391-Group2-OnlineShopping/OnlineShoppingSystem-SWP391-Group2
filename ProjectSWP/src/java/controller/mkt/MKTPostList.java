/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.mkt;

import controller.auth.Authorization;
import dal.BlogDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.PostCategoryList;
import model.Posts;
import model.Sliders;
import model.Staffs;

/**
 *
 * @author DELL
 */
@WebServlet(name = "MKTPostList", urlPatterns = {"/mktpostlist"})
public class MKTPostList extends HttpServlet {

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
            out.println("<title>Servlet MKTPostList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MKTPostList at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
//        if (session.getAttribute("acc") != null) {
//            Authorization.redirectToHome(session, response);
//            return; // Add return to prevent further execution
//        } else if (!Authorization.isMarketer((Staffs) session.getAttribute("staff"))) {
//            Authorization.redirectToHome(session, response);
//            return; // Add return to prevent further execution
//        } else {
        BlogDAO dao = new BlogDAO();
        // Initialize category list
        List<PostCategoryList> cate = dao.getAllPostCategories();
        request.setAttribute("cate", cate);
        List<Posts> list = new ArrayList<>();
        try {
            String selectedCategory = request.getParameter("category");
            if (selectedCategory != null && !selectedCategory.isEmpty() && !selectedCategory.equals("all")) {
                list = dao.getAllPostFromCategoryId(selectedCategory);
                int size = list.size();
                request.setAttribute("size", size);
                request.setAttribute("selectedCategory", selectedCategory);

            } else {
                list = dao.getAllPosts();
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
            list = dao.getAllPosts(); // Fallback to all posts in case of exception
        }

        request.setAttribute("list", list);
        request.getRequestDispatcher("mktpostlist.jsp").forward(request, response);
    }
    //}

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