/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ClassScheduleDAO;

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
@WebServlet(name = "ClassScheduleServlet", urlPatterns = {"/ClassScheduleServlet"})
public class ClassScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil role dari session
        String role = (String) request.getSession().getAttribute("role");

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        // Ambil parameter filter
        String className = request.getParameter("classId");
        String day = request.getParameter("day");

        ClassScheduleDAO classScheduleDAO = new ClassScheduleDAO();
        List<Map<String, Object>> schedules = classScheduleDAO.getAllSchedules(className, day);
        List<String> availableDays = classScheduleDAO.getAvailableDays();
        List<String> availableClasses = classScheduleDAO.getAvailableClasses();

        // Set atribut untuk JSP
        request.setAttribute("schedules", schedules);
        request.setAttribute("availableDays", availableDays);
        request.setAttribute("availableClasses", availableClasses);

        // Tentukan target JSP berdasarkan role
        String targetJSP;
        switch (role) {
            case "tu":
                targetJSP = "/frontEnd/TU/ClassSchedule.jsp";
                break;
            case "kepsek":
                targetJSP = "/frontEnd/Kepsek/ClassSchedule.jsp";
                break;
            default:
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have access to this page");
                return;
        }

        // Arahkan ke JSP
        request.getRequestDispatcher(targetJSP).forward(request, response);
    }
}

