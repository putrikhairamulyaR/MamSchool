/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.gradeDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.nilai;
/**
 *
 * @author putri
 */

@WebServlet("/nilaiServlet")
public class nilaiServlet extends HttpServlet {

    private gradeDao gradeDao = new gradeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "view":
                viewGrades(request, response);
                break;
            case "delete":
                deleteGrade(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void viewGrades(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String className = request.getParameter("kelas");

        try {
            List<nilai> grades = gradeDao.viewAllGradesByClass(className);
            request.getSession().setAttribute("grades", grades);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/frontEnd/Guru/nilaiMapel.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void deleteGrade(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id_nilai"));
        boolean isDeleted = gradeDao.deleteNilaiSiswa(id);
        if (isDeleted) {
            response.sendRedirect("nilaiServlet?action=view&className=");
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addGrade(request, response);
                break;
            case "update":
                updateGrade(request, response);
                break;
            case "delete":
                updateGrade(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void addGrade(HttpServletRequest request, HttpServletResponse response) throws IOException {
       try {
           // Validasi input dari parameter request
           String utsParam = request.getParameter("uts");
           String uasParam = request.getParameter("uas");
           String tugasParam = request.getParameter("tugas");

           if (utsParam == null || uasParam == null || tugasParam == null ||
               utsParam.isEmpty() || uasParam.isEmpty() || tugasParam.isEmpty()) {
               response.sendRedirect("error.jsp?message=Invalid input");
               return;
           }

           // Parsing input ke tipe double
           double uts = Double.parseDouble(utsParam);
           double uas = Double.parseDouble(uasParam);
           double tugas = Double.parseDouble(tugasParam);

           // Validasi nilai
           if (uts < 0 || uts > 100 || uas < 0 || uas > 100 || tugas < 0 || tugas > 100) {
               response.sendRedirect("error.jsp?message=Invalid grade range");
               return;
           }

           // Panggil DAO untuk menyimpan nilai
           boolean isAdded = gradeDao.setNilaiSiswa(uts, uas, tugas);

           // Redirect sesuai hasil penyimpanan
           if (isAdded) {
               response.sendRedirect("/frontEnd/Guru/nilaiMapel.jsp");
           } else {
               response.sendRedirect("error.jsp?message=Failed to add grade");
           }
       } catch (NumberFormatException e) {
           // Tangani error parsing
           response.sendRedirect("error.jsp?message=Invalid number format");
       } catch (Exception e) {
           // Tangani error umum lainnya
           response.sendRedirect("error.jsp?message=An unexpected error occurred");
       }
   }

    private void updateGrade(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Validasi input dari parameter request
            String utsParam = request.getParameter("uts");
            String uasParam = request.getParameter("uas");
            String tugasParam = request.getParameter("tugas");

            if (utsParam == null || uasParam == null || tugasParam == null ||
                utsParam.isEmpty() || uasParam.isEmpty() || tugasParam.isEmpty()) {
                response.sendRedirect("error.jsp?message=Invalid input");
                return;
            }

            // Parsing input ke tipe double
            double uts = Double.parseDouble(utsParam);
            double uas = Double.parseDouble(uasParam);
            double tugas = Double.parseDouble(tugasParam);

            // Validasi nilai
            if (uts < 0 || uts > 100 || uas < 0 || uas > 100 || tugas < 0 || tugas > 100) {
                response.sendRedirect("error.jsp?message=Invalid grade range");
                return;
            }

            // Panggil DAO untuk update
            boolean isUpdated = gradeDao.updateNilaiSiswa(uts, uas, tugas);

            // Redirect sesuai hasil penyimpanan
            if (isUpdated) {
                response.sendRedirect("/frontEnd/Guru/nilaiMapel.jsp");
            } else {
                response.sendRedirect("error.jsp?message=Failed to update grade");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid number format");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }

}
