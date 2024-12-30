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
            case "profile":
                profileSiswa(request, response);
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
            case "delete":
                deleteSiswa(request, response);
                break;
            case "profile":
                profileSiswa(request, response);
                break;
            default:
                showSiswaList(request, response);
                break;
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
    
    private void profileSiswa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int siswa_id = Integer.parseInt(request.getParameter("id"));
        siswaDAO siswadao = new siswaDAO();
        Student siswa = siswadao.getSiswaById(siswa_id);
        
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        SigninDAO signdao = new SigninDAO();
        User user = signdao.getUserById(user_id);

        if (siswa == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Student not found with ID: " + siswa_id);
            return;
        }

        // Kirim data kelas dan guru ke JSP
        request.setAttribute("siswa", siswa);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/frontEnd/Murid/profileSiswa.jsp").forward(request, response);
    }
}