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

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "list":
                handleListByRole(request, response, role);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported");
                break;
        }
    }

    private void handleListByRole(HttpServletRequest request, HttpServletResponse response, String role) throws ServletException, IOException {
        switch (role) {
            case "tu":
                handleList(request, response, "/frontEnd/TU/GradesList.jsp");
                break;
            case "kepsek":
                handleList(request, response, "/frontEnd/Kepsek/GradesList.jsp");
                break;
            default:
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have access to this page");
                break;
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response, String targetJSP) throws ServletException, IOException {
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

        // Arahkan ke JSP yang sesuai dengan role
        request.getRequestDispatcher(targetJSP).forward(request, response);
    }

}
