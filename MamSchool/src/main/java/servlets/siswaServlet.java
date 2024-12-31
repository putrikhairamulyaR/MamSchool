/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import dao.SigninDAO;
import dao.siswaDAO;
import model.Student;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

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
            case "list":
                showSiswaList(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
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
            case "delete":
                deleteSiswa(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    private void addSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String role = request.getParameter("role");
            String nis = request.getParameter("nis");
            String name = request.getParameter("name");
            LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
            int enrollmentYear = Integer.parseInt(request.getParameter("enrollmentYear"));
            String major = request.getParameter("major");
            
            User user = new User(name, nis, role);
            SigninDAO SigninDao = new SigninDAO();
            boolean cekUser = SigninDao.addUser(user);
            int user_id = SigninDao.getUserIdByUsername(name, nis);
            siswaDAO dao = new siswaDAO();
            boolean success = dao.addSiswa(user_id, nis, name, dateOfBirth, enrollmentYear, major);

            if (success) {
                response.sendRedirect("SiswaServlet?action=list");
            } else {
                response.getWriter().println("Error adding student.");
            }
        } catch (NumberFormatException | DateTimeParseException e) {
            response.getWriter().println("Invalid input: " + e.getMessage());
        }
    }

    private void editSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String nis = request.getParameter("nis");
            String name = request.getParameter("name");
            LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
            int enrollmentYear = Integer.parseInt(request.getParameter("enrollmentYear"));
            String major = request.getParameter("major");

            siswaDAO dao = new siswaDAO();
            boolean success = dao.editSiswa(id, userId, nis, name, dateOfBirth, enrollmentYear, major);

            if (success) {
                response.sendRedirect("SiswaServlet?action=list");
            } else {
                response.getWriter().println("Error editing student.");
            }
        } catch (NumberFormatException | DateTimeParseException e) {
            response.getWriter().println("Invalid input: " + e.getMessage());
        }
    }

        private void deleteSiswa(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            siswaDAO dao = new siswaDAO();
            boolean success = dao.delSiswa(id);

            if (success) {
                response.sendRedirect("SiswaServlet?action=list");
            } else {
                response.getWriter().println("Error deleting student.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid ID: " + e.getMessage());
        }
    }
        
    private void showSiswaList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        siswaDAO dao = new siswaDAO();
        List<Student> siswa = dao.getAllSiswa();
        request.getSession().setAttribute("siswa", siswa);
        request.getRequestDispatcher("frontEnd/TU/MenuSiswa.jsp").forward(request, response);
    }
}