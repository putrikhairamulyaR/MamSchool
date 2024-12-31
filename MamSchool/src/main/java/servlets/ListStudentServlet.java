/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import classes.JDBC;
import model.Student;
import dao.ListStudentDAO;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Royal
 */
@WebServlet(name = "ListStudentServlet", urlPatterns = {"/ListStudentServlet"})
public class ListStudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String major = request.getParameter("major");
        String tingkatParam = request.getParameter("tingkat");
        Integer tingkat = null;

        if (tingkatParam != null && !tingkatParam.isEmpty()) {
            try {
                tingkat = Integer.parseInt(tingkatParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        ListStudentDAO listStudentDAO = new ListStudentDAO();
        List<Student> students = listStudentDAO.getAllStudents(major, tingkat);

        request.setAttribute("students", students);
        request.getRequestDispatcher("/frontEnd/Kepsek/ListStudent.jsp").forward(request, response);
    }
}
