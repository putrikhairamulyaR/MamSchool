/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.TUStudentDAO;
import model.Student;

import java.io.IOException;
import java.time.LocalDate;
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
@WebServlet(name = "TUStudentServlet", urlPatterns = {"/TUStudentServlet"})
public class TUStudentServlet extends HttpServlet {

    private final TUStudentDAO studentDAO = new TUStudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("TUStudentServlet doGet called");
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("tu")) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
            case "filter":
                TUhandleList(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
        }
    }

    private void TUhandleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String major = request.getParameter("major");
        String tingkatParam = request.getParameter("tingkat");
        Integer tingkat = null;
        if (tingkatParam != null && !tingkatParam.trim().isEmpty()) {
            try {
                tingkat = Integer.parseInt(tingkatParam);
            } catch (NumberFormatException e) {
                tingkat = null;
            }
        }

        List<Student> studentList = studentDAO.getStudentsWithClassInfo(major, tingkat);

        request.setAttribute("studentList", studentList);

        request.getRequestDispatcher("/frontEnd/TU/StudentList.jsp").forward(request, response);
    }

}
