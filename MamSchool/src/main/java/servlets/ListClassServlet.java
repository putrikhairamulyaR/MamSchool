/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import dao.ListClassDAO;
import model.Classes;

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
 * @author Royal
 */
@WebServlet(name = "ListClassServlet", urlPatterns = {"/ListClassServlet"})
public class ListClassServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ListClassDAO listClassDAO = new ListClassDAO();

        // Ambil parameter filter
        String major = request.getParameter("major");
        String tingkatParam = request.getParameter("tingkat");
        Integer tingkat = tingkatParam != null && !tingkatParam.isEmpty() ? Integer.parseInt(tingkatParam) : null;

        // Dapatkan hasil filter
        List<Classes> classList = listClassDAO.getFilteredClasses(major, tingkat);

        request.setAttribute("classList", classList);
        request.getRequestDispatcher("/frontEnd/Kepsek/ListClass.jsp").forward(request, response);
    }
}