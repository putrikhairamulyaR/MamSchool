/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.LoginDAO;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginDAO loginDAO = new LoginDAO();
        String role = loginDAO.getUserRole(username, password);

        if (role != null) {
            request.getSession().setAttribute("username", username);
            request.getSession().setAttribute("role", role);

            switch (role) {
                case "kepsek":
                    response.sendRedirect("frontEnd/Kepsek/DashboardKepsek.jsp");
                    break;
                case "guru":
                    response.sendRedirect("frontEnd/Guru/DashboardGuru.jsp");
                    break;
                case "siswa":
                    response.sendRedirect("frontEnd/Murid/DashboardSiswa.jsp");
                    break;
                default:
                    request.setAttribute("errorMessage", "Role tidak dikenal.");
                    request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
                    break;
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
