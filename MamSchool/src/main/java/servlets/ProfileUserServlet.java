/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ProfileUserDAO;
import model.Student;
import model.Teacher;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 *
 * @author Royal
 */
@WebServlet(name = "ProfileUserServlet", urlPatterns = {"/ProfileUser"})
public class ProfileUserServlet extends HttpServlet {

    private final ProfileUserDAO profileUserDAO = new ProfileUserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // Ambil userId dari session
        String role = (String) session.getAttribute("role"); // Ambil role dari session

        if (userId == null || role == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        ProfileUserDAO dao = new ProfileUserDAO();
        User user = dao.getDataUser(userId); // Ambil data user berdasarkan userId

        if (user != null) {
            request.setAttribute("userProfile", user);

            switch (role) {
                case "kepsek":
                    User kepsekDetails = dao.getKepsekByUserId(userId);
                    request.setAttribute("roleDetails", kepsekDetails);
                    break;

                case "siswa":
                    Student studentDetails = dao.getStudentByUserId(userId);
                    request.setAttribute("roleDetails", studentDetails);
                    break;

                case "guru":
                    Teacher teacherDetails = dao.getTeacherByUserId(userId);
                    request.setAttribute("roleDetails", teacherDetails);
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Role not recognized");
                    return;
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/ErrorPage.jsp");
            return;
        }

        request.getRequestDispatcher("/frontEnd/Profile.jsp").forward(request, response);
    }

}
