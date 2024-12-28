/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.GradesDAO;
import model.nilai;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Royal
 */
@WebServlet(name = "GradesServlet", urlPatterns = {"/GradesServlet"})
public class GradesServlet extends HttpServlet {

    private final GradesDAO gradesDAO = new GradesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String role = (String) request.getSession().getAttribute("role");

        if (role == null || !role.equals("kepsek")) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "list":
                handleList(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported");
                break;
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String className = request.getParameter("kelas");

        // Ambil daftar semua kelas untuk filter
        List<String> classList = gradesDAO.getAllClasses();

        // Ambil nilai berdasarkan kelas yang dipilih (jika ada)
        List<nilai> grades = (className == null || className.isEmpty())
                ? gradesDAO.getGradesByClass(null) // Kirim null untuk semua kelas
                : gradesDAO.getGradesByClass(className);

        // Kirim data ke JSP
        request.setAttribute("classList", classList);
        request.setAttribute("grades", grades);
        request.setAttribute("selectedClass", className);
        request.getRequestDispatcher("/frontEnd/Kepsek/GradesList.jsp").forward(request, response);
    }

}
