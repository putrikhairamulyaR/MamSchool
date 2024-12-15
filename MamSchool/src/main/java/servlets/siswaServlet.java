/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import dao.siswaDAO;
import model.Classes;
import model.Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
/**
 *
 * @author luthfiah
 */
@WebServlet("/SiswaServlet")
public class siswaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "delete":
                deleteSiswa(request, response);
                break;
            default:
                showSiswaList(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "add":
                addSiswa(request, response);
                break;
            case "edit":
                editSiswa(request, response);
                break;
            default:
                showSiswaList(request, response);
                break;
        }
    }

    private void addSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Collect data from form
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String nis = request.getParameter("nis");
        String name = request.getParameter("name");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
        int enrollmentYear = Integer.parseInt(request.getParameter("enrollmentYear"));
        Classes classData = new Classes();
        classData.setId(Integer.parseInt(request.getParameter("classId")));
        String major = request.getParameter("major");
        Teacher teacher = new Teacher();
        teacher.setId(Integer.parseInt(request.getParameter("teacherId")));

        siswaDAO dao = new siswaDAO();
        boolean success = dao.addSiswa(id, userId, nis, name, dateOfBirth, enrollmentYear, classData, major, teacher);

        if (success) {
            response.sendRedirect("SiswaServlet?action=list");
        } else {
            response.getWriter().println("Error adding student.");
        }
    }

    private void editSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Collect data from form
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String nis = request.getParameter("nis");
        String name = request.getParameter("name");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
        int enrollmentYear = Integer.parseInt(request.getParameter("enrollmentYear"));
        Classes classData = new Classes();
        classData.setId(Integer.parseInt(request.getParameter("classId")));
        String major = request.getParameter("major");
        Teacher teacher = new Teacher();
        teacher.setId(Integer.parseInt(request.getParameter("teacherId")));

        siswaDAO dao = new siswaDAO();
        boolean success = dao.editSiswa(id, userId, nis, name, dateOfBirth, enrollmentYear, classData, major, teacher);

        if (success) {
            response.sendRedirect("SiswaServlet?action=list");
        } else {
            response.getWriter().println("Error editing student.");
        }
    }

    private void deleteSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        siswaDAO dao = new siswaDAO();
        boolean success = dao.delSiswa(id);

        if (success) {
            response.sendRedirect("SiswaServlet?action=list");
        } else {
            response.getWriter().println("Error deleting student.");
        }
    }
    private void showSiswaList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve data for students (this requires an additional DAO method to list students)
        // Example: List<Student> students = dao.getAllSiswa();
        // For simplicity, this part is omitted

        // Set attributes for the JSP page (add your attributes here)
        request.setAttribute("students", null); // Replace with the actual list of students

        // Forward to JSP
        request.getRequestDispatcher("frontEnd/TU/MenuSiswa.jsp").forward(request, response);
    }
}