/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.SigninDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet(name = "SigninServlet", urlPatterns = {"/SigninServlet"})
public class SigninServlet extends HttpServlet {

    private final SigninDAO SigninDAO = new SigninDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("SigninServlet doGet called with action: " + request.getParameter("action"));
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("tu")) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }
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
        List<User> userList = SigninDAO.getAllUser();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/frontEnd/TU/UserList.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = SigninDAO.getUserById(id);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class not found with ID: " + id);
            return;
        }

        // Kirim data kelas dan guru ke JSP
        request.setAttribute("user", user);
        request.getRequestDispatcher("/frontEnd/TU/editUser.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean isDeleted = SigninDAO.deleteClass(id);

        if (!isDeleted) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete class with ID: " + id);
            return;
        }

        response.sendRedirect("SigninServlet?action=list");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("SigninServlet doPost called with action: " + action);

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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Log payload values
        System.out.println("Payload received:");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("Role: " + role);

        // Server-side validation
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || role == null || role.trim().isEmpty()) {

            System.out.println("Validation error: Missing required fields.");
            request.setAttribute("error", "Semua kolom wajib diisi!");
            request.getRequestDispatcher("/frontEnd/TU/addUser.jsp").forward(request, response);
            return;
        }
        System.out.println("Adding new class: username=" + username + ", password=" + password + ", role=" + role);

        User newUser = new User(username, password, role);
        boolean isSuccess = SigninDAO.addUser(newUser);

        System.out.println("Add user operation success: " + isSuccess);
        response.sendRedirect("SigninServlet?action=list");
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        System.out.println("Updating user with ID: " + id);
        User updatedUser = new User(id, username, password, role);
        boolean isUpdated = SigninDAO.updateUser(updatedUser);

        if (!isUpdated) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update class with ID: " + id);
            return;
        }

        response.sendRedirect("SigninServlet?action=list");
    }
}
