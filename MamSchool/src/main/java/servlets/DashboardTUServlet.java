/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.DashboardTUDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Royal
 */
@WebServlet(name = "DashboardTUServlet", urlPatterns = {"/DashboardTU"})
public class DashboardTUServlet extends HttpServlet {

    private final DashboardTUDAO dashboardTUDAO = new DashboardTUDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check user role
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("tu")) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        // Fetch data from DAO
        int totalUsers = dashboardTUDAO.getTotalUsers();
        int totalStudents = dashboardTUDAO.getTotalStudents();
        int totalTeachers = dashboardTUDAO.getTotalTeachers();
        int totalClasses = dashboardTUDAO.getTotalClasses();
        int totalSubjects = dashboardTUDAO.getTotalSubjects();

        Map<String, Integer> studentDistributionByMajor = dashboardTUDAO.getStudentDistributionByMajor();
        Map<String, Double> averageMonthlyAttendance = dashboardTUDAO.getAverageMonthlyAttendance();
        List<Map<String, Object>> problematicStudents = dashboardTUDAO.getProblematicStudents(0.75); // Threshold = 75%
        List<Map<String, Object>> todaySchedules = dashboardTUDAO.getTodaySchedules();

        // Set data to request attributes
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalTeachers", totalTeachers);
        request.setAttribute("totalClasses", totalClasses);
        request.setAttribute("totalSubjects", totalSubjects);

        request.setAttribute("studentDistributionByMajor", studentDistributionByMajor);
        request.setAttribute("averageMonthlyAttendance", averageMonthlyAttendance);
        request.setAttribute("problematicStudents", problematicStudents);
        request.setAttribute("todaySchedules", todaySchedules);

        // Forward to DashboardTU JSP
        request.getRequestDispatcher("/frontEnd/TU/DashboardTU.jsp").forward(request, response);
    }
}