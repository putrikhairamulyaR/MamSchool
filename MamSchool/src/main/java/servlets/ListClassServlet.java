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
        // Ambil role dari session
        String role = (String) request.getSession().getAttribute("role");

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        ListClassDAO listClassDAO = new ListClassDAO();

        // Ambil parameter filter
        String major = request.getParameter("major");
        String tingkatParam = request.getParameter("tingkat");
        Integer tingkat = tingkatParam != null && !tingkatParam.isEmpty() ? Integer.parseInt(tingkatParam) : null;

        // Dapatkan hasil filter
        List<Classes> classList = listClassDAO.getFilteredClasses(major, tingkat);

        // Set atribut untuk JSP
        request.setAttribute("classList", classList);

        // Tentukan target JSP berdasarkan role
        String targetJSP;
        switch (role) {
            case "tu":
                targetJSP = "/frontEnd/TU/ListClass.jsp";
                break;
            case "kepsek":
                targetJSP = "/frontEnd/Kepsek/ListClass.jsp";
                break;
            default:
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have access to this page");
                return;
        }

        // Arahkan ke JSP
        request.getRequestDispatcher(targetJSP).forward(request, response);
    }
}
