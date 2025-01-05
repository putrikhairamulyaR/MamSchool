/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.DashboardSiswaDAO;

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
@WebServlet(name = "DashboardSiswaServlet", urlPatterns = {"/DashboardSiswa"})
public class DashboardSiswaServlet extends HttpServlet {

    private final DashboardSiswaDAO dashboardSiswaDAO = new DashboardSiswaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the logged-in student's ID from session
        Integer studentId = (Integer) request.getSession().getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Fetch today's schedule
        List<Map<String, Object>> jadwalHariIni = dashboardSiswaDAO.getJadwalHariIni(studentId);

        // Fetch all schedules
        List<Map<String, Object>> semuaJadwal = dashboardSiswaDAO.getSemuaJadwal(studentId);

        // Set data to request attributes
        request.setAttribute("jadwalHariIni", jadwalHariIni);
        request.setAttribute("semuaJadwal", semuaJadwal);

        // Forward to DashboardSiswa.jsp
        request.getRequestDispatcher("/frontEnd/Murid/DashboardSiswa.jsp").forward(request, response);
    }
}