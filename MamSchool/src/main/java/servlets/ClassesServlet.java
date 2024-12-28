package servlets;

import dao.ClassesDAO;
import dao.TeacherDAO;
import model.*;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet(name = "ClassesServlet", urlPatterns = {"/ClassesServlet"})
public class ClassesServlet extends HttpServlet {

    private final ClassesDAO classesDAO = new ClassesDAO();
    private final TeacherDAO teacherDAO = new TeacherDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ClassesServlet doGet called with action: " + request.getParameter("action"));

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        System.out.println("Action to perform: " + action);

        switch (action) {
            case "list":
                handleList(request, response);
                break;

            case "edit":
                handleEdit(request, response);
                break;

            case "delete":
                handleDelete(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String major = request.getParameter("major");
        String tingkatParam = request.getParameter("tingkat");
        Integer tingkat = null;
        if (tingkatParam != null && !tingkatParam.trim().isEmpty()) {
            try {
                tingkat = Integer.parseInt(tingkatParam);
            } catch (NumberFormatException e) {
                tingkat = null; // Abaikan jika format tidak valid
            }
        }

        List<Classes> classesList = classesDAO.getFilteredClasses(major, tingkat);
        request.setAttribute("classesList", classesList);
        request.getRequestDispatcher("/frontEnd/Kepsek/ClassesList.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Classes classes = classesDAO.getClassById(id);

        if (classes == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class not found with ID: " + id);
            return;
        }

        // Ambil daftar semua guru
        List<Teacher> teachersList = teacherDAO.getAllTeachers();

        // Kirim data kelas dan guru ke JSP
        request.setAttribute("classes", classes);
        request.setAttribute("teachersList", teachersList);
        request.getRequestDispatcher("/frontEnd/Kepsek/EditClasses.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean isDeleted = classesDAO.deleteClass(id);

        if (!isDeleted) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete class with ID: " + id);
            return;
        }

        response.sendRedirect("ClassesServlet?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("ClassesServlet doPost called with action: " + action);

        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String major = request.getParameter("major");
        String teacherIdStr = request.getParameter("teacher_id");
        String tingkatStr = request.getParameter("tingkat");

        // Log payload values
        System.out.println("Payload received:");
        System.out.println("Name: " + name);
        System.out.println("Major: " + major);
        System.out.println("Teacher ID: " + teacherIdStr);
        System.out.println("Tingkat: " + tingkatStr);

        // Server-side validation
        if (name == null || name.trim().isEmpty()
                || major == null || major.trim().isEmpty()
                || teacherIdStr == null || teacherIdStr.trim().isEmpty()
                || tingkatStr == null || tingkatStr.trim().isEmpty()) {

            System.out.println("Validation error: Missing required fields.");
            request.setAttribute("error", "Semua kolom wajib diisi!");
            request.getRequestDispatcher("/frontEnd/Kepsek/AddClasses.jsp").forward(request, response);
            return;
        }

        int teacherId = Integer.parseInt(teacherIdStr);
        int tingkat = Integer.parseInt(tingkatStr);

        System.out.println("Adding new class: Name=" + name + ", Major=" + major + ", Teacher ID=" + teacherId + ", Tingkat=" + tingkat);

        Classes newClass = new Classes(name, major, teacherId, tingkat);
        boolean isSuccess = classesDAO.addClass(newClass);

        System.out.println("Add class operation success: " + isSuccess);
        response.sendRedirect("ClassesServlet?action=list");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String major = request.getParameter("major");
        int teacherId = Integer.parseInt(request.getParameter("teacher_id"));
        int tingkat = Integer.parseInt(request.getParameter("tingkat"));

        System.out.println("Updating class with ID: " + id);
        Classes updatedClass = new Classes(id, name, major, teacherId, tingkat);
        boolean isUpdated = classesDAO.updateClass(updatedClass);

        if (!isUpdated) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update class with ID: " + id);
            return;
        }

        response.sendRedirect("ClassesServlet?action=list");
    }
}
