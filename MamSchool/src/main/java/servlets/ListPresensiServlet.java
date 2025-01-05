/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ListPresensiDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Royal
 */
@WebServlet(name = "ListPresensiServlet", urlPatterns = {"/ListPresensiServlet"})
public class ListPresensiServlet extends HttpServlet {

    private final ListPresensiDAO listPresensiDAO = new ListPresensiDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters for filtering
        String className = request.getParameter("className");
        String dateParam = request.getParameter("date");
        Date selectedDate = null;

        if (dateParam != null && !dateParam.isEmpty()) {
            try {
                selectedDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateParam);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // Fetch data based on filters
        List<Map<String, Object>> attendanceList = listPresensiDAO.getAttendance(className, selectedDate);
        List<String> availableClasses = listPresensiDAO.getAvailableClasses();
        List<Date> availableDates = listPresensiDAO.getAvailableDates(className);

        // Pass data to JSP
        request.setAttribute("attendanceList", attendanceList);
        request.setAttribute("availableClasses", availableClasses);
        request.setAttribute("availableDates", availableDates);
        request.setAttribute("selectedClass", className);
        request.setAttribute("selectedDate", dateParam);

        // Forward to JSP
        request.getRequestDispatcher("/frontEnd/TU/ListPresensi.jsp").forward(request, response);
    }
}
