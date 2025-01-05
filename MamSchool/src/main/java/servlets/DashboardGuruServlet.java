/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.DashboardGuruDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Royal
 */
@WebServlet(name = "DashboardGuruServlet", urlPatterns = {"/DashboardGuru"})
public class DashboardGuruServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DashboardGuruServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil session user
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // Cek apakah pengguna adalah guru
        if (userId == null || role == null || !role.equals("guru")) {
            LOGGER.log(Level.WARNING, "Unauthorized access attempt to DashboardGuru");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        DashboardGuruDAO dao = new DashboardGuruDAO();

        // Ambil teacherId berdasarkan userId dari session
        Integer teacherId = getTeacherIdByUserId(userId);

        if (teacherId == null) {
            LOGGER.log(Level.WARNING, "Teacher ID not found for User ID: {0}", userId);
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Dapatkan jadwal hari ini dan mingguan
        List<Map<String, Object>> jadwalHariIni = dao.getJadwalHariIni(teacherId);
        List<Map<String, Object>> jadwalMingguan = dao.getJadwalMingguan(teacherId);

        // Debugging log untuk memastikan data terkirim
        LOGGER.log(Level.INFO, "Jadwal Hari Ini: {0}", jadwalHariIni);
        LOGGER.log(Level.INFO, "Jadwal Mingguan: {0}", jadwalMingguan);

        // Kirim data ke JSP
        request.setAttribute("jadwalHariIni", jadwalHariIni);
        request.setAttribute("jadwalMingguan", jadwalMingguan);

        // Forward ke JSP dashboard guru
        request.getRequestDispatcher("/frontEnd/Guru/DashboardGuru.jsp").forward(request, response);
    }

    // Method untuk mendapatkan teacherId berdasarkan userId
    private Integer getTeacherIdByUserId(Integer userId) {
        String query = "SELECT id FROM teachers WHERE user_id = ?";

        try (var connection = classes.JDBC.getConnection(); var stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching teacherId for userId: " + userId, e);
        }

        return null;
    }
}
