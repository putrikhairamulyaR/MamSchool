package servlets;

import dao.BagiKelasDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Student;
import model.Classes;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Mendapatkan parameter dari form
        String tingkat = request.getParameter("tingkat");
        String jurusan = request.getParameter("jurusan");

        // Debugging untuk memastikan parameter diterima dengan benar
        System.out.println("Tingkat: " + tingkat);  // Tingkat: "1", "2", atau "3"
        System.out.println("Jurusan: " + jurusan);  // Jurusan: "IPA" atau "IPS"

        // Buat instance BagiKelasDAO untuk mengambil data
        BagiKelasDAO bagiKelasDAO = new BagiKelasDAO();

        // Menghitung tahun pendaftaran berdasarkan tingkat
        int enrollmentYear = bagiKelasDAO.calculateEnrollmentYear(tingkat);

        // Ambil jumlah siswa yang memiliki kelas dan tidak memiliki kelas berdasarkan tingkat dan jurusan
        int siswaDenganKelas = bagiKelasDAO.getSiswaDenganKelas(jurusan, enrollmentYear);
        int siswaTanpaKelas = bagiKelasDAO.getSiswaTanpaKelas(jurusan, enrollmentYear);

        // Ambil semua siswa dan kelas mereka
        List<Student> students = bagiKelasDAO.getAllSiswaAndClasses();
        List<Classes> classes = bagiKelasDAO.getAllClasses();

        // Set atribut untuk diteruskan ke JSP
        request.setAttribute("siswaDenganKelas", siswaDenganKelas);
        request.setAttribute("siswaTanpaKelas", siswaTanpaKelas);
        request.setAttribute("students", students);  // Kirim data siswa
        request.setAttribute("classes", classes);    // Kirim data kelas

        // Forward ke JSP untuk menampilkan hasil
        RequestDispatcher dispatcher = request.getRequestDispatcher("frontEnd/Kepsek/BagiKelas.jsp");
        dispatcher.forward(request, response);
    }
}