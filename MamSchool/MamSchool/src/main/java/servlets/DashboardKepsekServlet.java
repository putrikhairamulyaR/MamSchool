/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dafi Utomo
 */
@WebServlet(name = "DashboardKepsekServlet", urlPatterns = {"/DashboardKepsek"})
public class DashboardKepsekServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("kepsek")) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        request.getRequestDispatcher("frontEnd/Kepsek/DashboardKepsek.jsp").forward(request, response);
    }
}