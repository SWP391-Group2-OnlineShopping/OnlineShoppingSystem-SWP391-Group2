/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.*;

public class Authorization extends HttpServlet {
    //cac ham check role

    
    public static boolean isAdmin(Staffs acc) {
        return acc != null && acc.getRole() == 1;
    }

    public static boolean isSaleManager(Staffs acc) {
        return acc != null && acc.getRole() == 2;
    }

    public static boolean isSaler(Staffs acc) {
        return acc != null && acc.getRole() == 3;
    }

    public static boolean isMarketer(Staffs acc) {
        return acc != null && acc.getRole() == 4;
    }


    public static void redirectToHome(HttpSession session, HttpServletResponse response)
            throws ServletException, IOException {
        //day ve trang home va thong bao
        session.setAttribute("message", "You do not have access!");
        response.sendRedirect("index.jsp");
    }
}
