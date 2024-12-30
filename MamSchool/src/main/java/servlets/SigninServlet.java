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
        System.out.println("UserServlet doGet called with action: " + request.getParameter("action"));

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        System.out.println("Action to perform: " + action);

        switch (action) {
            case "list":
                System.out.println("Fetching user list...");
                List<User> userList = SigninDAO.getAllUser();
                System.out.println("Number of users fetched: " + userList.size());
                for (User user : userList) {
                    System.out.println("User: " + user);
                }
                request.setAttribute("userList", userList);
                request.getRequestDispatcher("frontEnd/Kepsek/UserList.jsp").forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("Editing user with ID: " + id);
                User user = SigninDAO.getUserById(id);
                System.out.println("User fetched for edit: " + user);
                request.setAttribute("user", user);
                request.getRequestDispatcher("frontEnd/Kepsek/EditUser.jsp").forward(request, response);
                break;

            case "delete":
                id = Integer.parseInt(request.getParameter("id"));
                System.out.println("Deleting user with ID: " + id);
                SigninDAO.deleteClass(id);
                response.sendRedirect("/UserServlet?action=list");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("UserServlet doPost called with action: " + action);

        switch (action) {
            case "add":
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                System.out.println("Adding new user: " + username + ", role: " + role);
                User newUser = new User(username, password, role);
                SigninDAO.addUser(newUser);
                response.sendRedirect("UserServlet?action=list");
                break;

            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                username = request.getParameter("username");
                password = request.getParameter("password");
                role = request.getParameter("role");

                System.out.println("Updating user with ID: " + id);
                User updatedUser = new User(id, username, password, role, null);
                SigninDAO.updateUser(updatedUser);
                response.sendRedirect("UserServlet?action=list");
                break;
        }
    }
}
