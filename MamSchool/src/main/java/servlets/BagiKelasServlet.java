/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import dao.BagiKelasDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet(name = "BagiKelasServlet", urlPatterns = {"/BagiKelasServlet"})
public class BagiKelasServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tingkat = request.getParameter("tingkat");
        String jurusan = request.getParameter("jurusan");

        if (tingkat == null || tingkat.isEmpty() || jurusan == null || jurusan.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Invalid parameters\"}");
            return;
        }

        BagiKelasDAO dao = new BagiKelasDAO();
        int jumlahSiswaDenganKelas = dao.countStudentsHasClass(tingkat, jurusan);
        int jumlahSiswaTanpaKelas = dao.countStudentsNoClass(tingkat, jurusan);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"jumlahSiswaDenganKelas\": " + jumlahSiswaDenganKelas + ", \"jumlahSiswaTanpaKelas\": " + jumlahSiswaTanpaKelas + "}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}