package servlets;

import dao.BagiKelasDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet(name = "BagiKelasServlet", urlPatterns = {"/BagiKelasServlet"})
public class BagiKelasServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] studentIds = request.getParameterValues("studentIds");
        int classId = Integer.parseInt(request.getParameter("classId"));

        BagiKelasDAO dao = new BagiKelasDAO();
        List<Integer> selectedStudentIds = new ArrayList<>();

        int getTotalStudents = dao.getTotalStudents();
        if (getTotalStudents > 0) {

        }

        boolean allStudentsHaveClasses = dao.allStudentsHaveClasses();
        if (allStudentsHaveClasses) {
            request.setAttribute("message", "Semua siswa sudah memiliki kelas.");
        } else {
            request.setAttribute("error", "Siswa belum memiliki kelas.");
        }

        boolean success = dao.assignStudentsToClass(classId, selectedStudentIds);
        if (success) {
            request.setAttribute("message", "Siswa berhasil dimasukkan ke kelas.");
        } else {
            request.setAttribute("error", "Gagal memasukkan siswa ke kelas.");
        }

        request.getRequestDispatcher("BagiKelas.jsp").forward(request, response);
    }
}
