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
        String className = request.getParameter("classId");
        String day = request.getParameter("day");

        ClassScheduleDAO classScheduleDAO = new ClassScheduleDAO();
        List<Map<String, Object>> schedules = classScheduleDAO.getAllSchedules(className, day);

        List<String> availableDays = classScheduleDAO.getAvailableDays();
        List<String> availableClasses = classScheduleDAO.getAvailableClasses();

        request.setAttribute("schedules", schedules);
        request.setAttribute("availableDays", availableDays);
        request.setAttribute("availableClasses", availableClasses);

        request.getRequestDispatcher("/frontEnd/Kepsek/ClassSchedule.jsp").forward(request, response);
    }

}
