/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


/**
 *
 * @author putri
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlets;

import dao.PresensiDao;
import dao.rapotSiswaDao;
import model.Student;
import model.User;
import model.nilai;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rapotDiSiswa")
public class rapotDiSiswa extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil user dari session
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Ambil data siswa berdasarkan user ID
        rapotSiswaDao rapotDao = new rapotSiswaDao();
        Student siswa = rapotDao.getStudentUserId(user.getId());

        if (siswa == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Data siswa tidak ditemukan.");
            return;
        }

        // Simpan data siswa ke session
        request.getSession().setAttribute("siswa", siswa);

        // Inisialisasi listNilai
        List<nilai> listNilai = new ArrayList<>();

        // Ambil rapot berdasarkan jurusan siswa
          if ("IPA".equalsIgnoreCase(siswa.getMajor())) {
              nilai matematika = rapotDao.getRapotBySubject(siswa.getNis(), "Matematika");
              if (matematika != null) listNilai.add(matematika);

              nilai fisika = rapotDao.getRapotBySubject(siswa.getNis(), "Fisika");
              if (fisika != null) listNilai.add(fisika);

              nilai kimia = rapotDao.getRapotBySubject(siswa.getNis(), "Kimia");
              if (kimia != null) listNilai.add(kimia);

              nilai biologi = rapotDao.getRapotBySubject(siswa.getNis(), "Biologi");
              if (biologi != null) listNilai.add(biologi);
          } else if ("IPS".equalsIgnoreCase(siswa.getMajor())) {
              nilai ekonomi = rapotDao.getRapotBySubject(siswa.getNis(), "Ekonomi");
              if (ekonomi != null) listNilai.add(ekonomi);

              nilai geografi = rapotDao.getRapotBySubject(siswa.getNis(), "Geografi");
              if (geografi != null) listNilai.add(geografi);

              nilai sejarah = rapotDao.getRapotBySubject(siswa.getNis(), "Sejarah");
              if (sejarah != null) listNilai.add(sejarah);
          }


        // Simpan listNilai ke session
        request.getSession().setAttribute("listNilai", listNilai);

        // Hitung total kelulusan
        long totalKelulusan = listNilai.stream().filter(n -> "Lulus".equalsIgnoreCase(n.getKategori())).count();

        // Simpan total kelulusan ke session
        request.getSession().setAttribute("totalKelulusan", totalKelulusan);

        // Ambil data presensi
        PresensiDao presensiDao = new PresensiDao();
      //  int kehadiranHadir = presensiDao.getTotalKehadiranByStudent(siswa.getId(), "Hadir");
      //  int totalSakit = presensiDao.getTotalKehadiranByStudent(siswa.getId(), "Sakit");
      //  int totalIzin = presensiDao.getTotalKehadiranByStudent(siswa.getId(), "Izin");
      //  int totalAlpa = presensiDao.getTotalKehadiranByStudent(siswa.getId(), "Alpa");
//
        // Simpan presensi ke session
      //  request.getSession().setAttribute("kehadiranHadir", kehadiranHadir);
      //  request.getSession().setAttribute("totalSakit", totalSakit);
      //  request.getSession().setAttribute("totalIzin", totalIzin);
      //  request.getSession().setAttribute("totalAlpa", totalAlpa);

        // Redirect ke JSP
        response.sendRedirect("frontEnd/Murid/NilaiSiswa.jsp");
    }
}
