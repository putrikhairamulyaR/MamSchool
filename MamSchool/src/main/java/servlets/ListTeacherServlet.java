/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ListTeacherDAO;
import model.Teacher;
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
@WebServlet(name = "ListTeacherServlet", urlPatterns = {"/ListTeacherServlet"})
public class ListTeacherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subject = request.getParameter("subject");

        ListTeacherDAO listTeacherDAO = new ListTeacherDAO();
        List<Teacher> teachers = listTeacherDAO.getAllTeachers(subject);
        List<String> subjects = listTeacherDAO.getAllSubjects(); // Ambil semua mata pelajaran

        request.setAttribute("teachers", teachers);
        request.setAttribute("subjects", subjects); // Kirim daftar mata pelajaran ke JSP
        request.getRequestDispatcher("/frontEnd/Kepsek/ListTeacher.jsp").forward(request, response);
    }

}
