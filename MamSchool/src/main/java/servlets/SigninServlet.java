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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "delete":
                deleteUser(request, response);
                break;
            case "list":
                showUser(request, response);
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
                addUser(request, response);
                break;
            case "edit":
                editUser(request, response);
                break;
            case "delete":
                showUser(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        SigninDAO dao = new SigninDAO();
        User User = new User(username, password, role);
        boolean success = dao.addUser(User);

        if (success) {
            response.sendRedirect("SigninServlet?action=list");
        } else {
            response.getWriter().println("Error adding student.");
        }

    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
            String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        SigninDAO dao = new SigninDAO();
        User User = new User(username, password, role);
        boolean success = dao.updateUser(User);

            if (success) {
                response.sendRedirect("SigninServlet?action=list");
            } else {
                response.getWriter().println("Error editing student.");
            }
        
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
            int id = Integer.parseInt(request.getParameter("id"));

            SigninDAO dao = new SigninDAO();
            boolean success = dao.deleteUser(id);

            if (success) {
                response.sendRedirect("SigninServlet?action=list");
            } else {
                response.getWriter().println("Error deleting student.");
            }
        
    }

    private void showUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SigninDAO dao = new SigninDAO();
        List<User> user = dao.getAllUser();
        request.getSession().setAttribute("user", user);
        request.getRequestDispatcher("frontEnd/TU/UserList.jsp").forward(request, response);
    }
}
