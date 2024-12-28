/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import classes.JDBC;
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

/**
 *
 * @author ASUS
 */
@WebServlet(name = "TeacherServlet", urlPatterns = {"/TeacherServlet"})
public class TeacherServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private void addTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String nip = request.getParameter("nip");
            String name = request.getParameter("name");
            LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
            String subject = request.getParameter("subject");
            int hireDate = Integer.parseInt(request.getParameter("hireDate"));

            TeacherDAO dao = new TeacherDAO();
            boolean success = dao.addTeacher(userId, nip, name, dateOfBirth, subject, hireDate);

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
            default:
                showTeacherList(request, response);
                break;
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
                showTeacherList(request, response);
                break;
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
