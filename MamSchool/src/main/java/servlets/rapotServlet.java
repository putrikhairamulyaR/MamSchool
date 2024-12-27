/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ClassesDAO;
import dao.rapotDAO;
import dao.siswaDAO;
import model.rapot;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Classes;
import model.Student;

/**
 *
 * @author luthfiah
 */
@WebServlet("/rapotServlet")
public class rapotServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        

        if("viewByClass".equals(action)){
            response.sendRedirect("frontEnd/Guru/menuRapot.jsp");
        }else if("viewRapot".equals(action)){
            viewRapot(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        rapotDAO rapotDao = new rapotDAO();

        if (action == null || action.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parameter 'action' tidak ditemukan.");
            return;
        }
        
    }

    private double parseParameterAsDouble(HttpServletRequest request, String paramName, HttpServletResponse response) throws IOException {
        String paramValue = request.getParameter(paramName);
        try {
            return Double.parseDouble(paramValue);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nilai " + paramName + " tidak valid.");
            return 0; // Default value untuk menghentikan eksekusi lebih lanjut jika ada error
        }
    }
    
    private void viewRapot(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String kelas=request.getParameter("kelas");
        siswaDAO siswaDao=new siswaDAO();
        List<Student>students= siswaDao.getSiswaByClassId(Integer.parseInt(kelas));
        request.getSession().setAttribute("SiswaRapot", students);
        
        response.sendRedirect("frontEnd/Guru/menuRapot.jsp");  
        
    }
     
}