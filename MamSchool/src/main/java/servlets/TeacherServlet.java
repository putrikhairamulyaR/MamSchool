/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import classes.JDBC;
import dao.SigninDAO;
import dao.TeacherDAO;
import model.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "TeacherServlet", urlPatterns = {"/TeacherServlet"})
public class TeacherServlet extends HttpServlet {
    
    private void addTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Data yang diterima dari form
            String role = request.getParameter("role");
            String nip = request.getParameter("nip");
            String name = request.getParameter("name");
            LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
            String subject = request.getParameter("subject");
            LocalDate hireDate = LocalDate.parse(request.getParameter("hireDate"));

            User user = new User(name, nip, role);
            SigninDAO SigninDao = new SigninDAO();
            boolean cekUser = SigninDao.addUser(user);
            int user_id = SigninDao.getUserIdByUsername(name, nip);
            TeacherDAO dao = new TeacherDAO();
            boolean success = dao.addTeacher(user_id, nip, name, dateOfBirth, subject, hireDate);

            if (success) {
                    response.sendRedirect("TeacherServlet?action=list");
                } else {
                    response.getWriter().println("Error adding teacher.");
                }
        } catch (NumberFormatException | DateTimeParseException e) {
            response.getWriter().println("Invalid input: " + e.getMessage());
        }
    }

    
    private void editTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nip = request.getParameter("nip");
            String name = request.getParameter("name");
            LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
            String subject = request.getParameter("subject");
            

            TeacherDAO dao = new TeacherDAO();
            boolean success = dao.editTeacherSubject(id, subject);
            if (success) {
                response.sendRedirect("TeacherServlet?action=list");
            } else {
                response.getWriter().println("Error editing teacher.");
            }
        } catch (NumberFormatException | DateTimeParseException e) {
            response.getWriter().println("Invalid input: " + e.getMessage());
        }
    }
    
    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            TeacherDAO dao = new TeacherDAO();
            boolean success = dao.delTeacher(id);

            if (success) {
                response.sendRedirect("TeacherServlet?action=list");
            } else {
                response.getWriter().println("Error deleting teacher.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid ID: " + e.getMessage());
        }
    }
    
    private void showTeacherList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TeacherDAO dao = new TeacherDAO();
        List<Teacher> teacher = dao.getAllTeachers();
        request.getSession().setAttribute("teacher", teacher);
        request.getRequestDispatcher("frontEnd/TU/MenuGuru.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "delete":
                deleteTeacher(request, response);
                break;
            case "list":
                showTeacherList(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "add":
                addTeacher(request, response);
                break;
            case "edit":
                editTeacher(request, response);
                break;
            case "delete":
                deleteTeacher(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
