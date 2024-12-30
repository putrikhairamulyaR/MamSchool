/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.DashboardKepsekDAO;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Dafi Utomo
 */
@WebServlet(name = "DashboardKepsekServlet", urlPatterns = {"/DashboardKepsek"})
public class DashboardKepsekServlet extends HttpServlet {

    private final DashboardKepsekDAO dashboardDAO = new DashboardKepsekDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("kepsek")) {
            response.sendRedirect(request.getContextPath() + "/frontEnd/Login.jsp");
            return;
        }

        // Statistik Ringkas
        int totalSiswa = dashboardDAO.getTotalSiswa();
        int totalGuru = dashboardDAO.getTotalGuru();
        int totalKelas = dashboardDAO.getTotalKelas();
        int totalUsers = dashboardDAO.getTotalUsers();

        // Grafik dan Diagram
        Map<String, Integer> siswaPerKelas = dashboardDAO.getSiswaPerKelas();
        List<Double> rataRataKehadiran = dashboardDAO.getRataRataKehadiranBulanan();
        Map<String, Double> rataRataNilaiPerKelas = dashboardDAO.getRataRataNilaiPerKelas();

        // Daftar Ringkasan
        List<String> jadwalKegiatan = dashboardDAO.getJadwalKegiatan();
        List<String> jadwalPelajaranHariIni = dashboardDAO.getJadwalPelajaranHariIni();
        
        // Distribusi Pengguna
        Map<String, Integer> distribusiPengguna = dashboardDAO.getDistribusiPengguna();

        // Set attributes for JSP
        request.setAttribute("totalSiswa", totalSiswa);
        request.setAttribute("totalGuru", totalGuru);
        request.setAttribute("totalKelas", totalKelas);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("siswaPerKelas", siswaPerKelas);
        request.setAttribute("rataRataKehadiran", rataRataKehadiran);
        request.setAttribute("rataRataNilaiPerKelas", rataRataNilaiPerKelas);
        request.setAttribute("jadwalKegiatan", jadwalKegiatan);
        request.setAttribute("jadwalPelajaranHariIni", jadwalPelajaranHariIni);
        request.setAttribute("distribusiPengguna", distribusiPengguna);

        request.getRequestDispatcher("frontEnd/Kepsek/DashboardKepsek.jsp").forward(request, response);
    }
}
