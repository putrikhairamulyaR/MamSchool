/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.LoginDAO;
import dao.TeacherDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dafi Utomo
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validasi input username dan password
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username dan password harus diisi.");
            request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
            return;
        }

        LoginDAO loginDAO = new LoginDAO();
        User user = loginDAO.getUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            if ("siswa".equals(user.getRole())) {
                int studentId = loginDAO.getStudentIdByUserId(user.getId()); // Tambahkan method ini ke LoginDAO
                session.setAttribute("studentId", studentId);
            }
            if ("guru".equals(user.getRole())) {
                TeacherDAO teacherDAO = new TeacherDAO();
                Integer teacherId = teacherDAO.getTeacherIdByUserId(user.getId());
                if (teacherId != null) {
                    session.setAttribute("teacherId", teacherId);
                }
            }
            // Redirect berdasarkan role
            switch (user.getRole()) {
                case "kepsek":
                    response.sendRedirect("DashboardKepsek");
                    break;
                case "guru":
                    response.sendRedirect("DashboardGuru");
                    break;
                case "tu":
                    response.sendRedirect("DashboardTU");
                    break;
                case "siswa":
                    response.sendRedirect("DashboardSiswa");
                    break;
                default:
                    session.invalidate();
                    request.setAttribute("errorMessage", "Role tidak dikenal.");
                    request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
                    break;
            }
        } else {
            // Username atau password salah
            request.setAttribute("errorMessage", "Username atau password salah.");
            request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect ke halaman login jika menggunakan metode GET
        request.getRequestDispatcher("/frontEnd/Login.jsp").forward(request, response);
    }

}
