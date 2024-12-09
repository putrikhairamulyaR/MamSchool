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

        // Validasi input
        if (tingkat == null || tingkat.isEmpty() || jurusan == null || jurusan.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Invalid parameters\"}");
            return;
        }

        // Gunakan DAO untuk menghitung jumlah kelas dan siswa
        BagiKelasDAO dao = new BagiKelasDAO();
        int jumlahSiswa = dao.countStudentsNoClass(tingkat, jurusan);
        int jumlahAllSiswa = dao.countAllStudentsByTingkatAndMajor(tingkat, jurusan);

        // Kembalikan hasil dalam format JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"jumlahAllSiswa\": " + jumlahAllSiswa + ", \"jumlahSiswa\": " + jumlahSiswa  +"}");
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
