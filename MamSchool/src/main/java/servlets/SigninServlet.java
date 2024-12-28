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

/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet(name = "SigninServlet", urlPatterns = {"/SigninServlet"})
public class SigninServlet extends HttpServlet {
    private final SigninDAO SigninDAO = new SigninDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("SigninServlet doPost called with action: " + action);

        switch (action) {
            case "add":
                handleAdd(request, response);
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

        System.out.println("Add class operation success: " + isSuccess);
        response.sendRedirect("SigninServlet?action=add");
    }
}
