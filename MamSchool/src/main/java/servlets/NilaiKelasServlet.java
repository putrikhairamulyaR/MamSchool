/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import dao.gradeDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author putri
 */
@WebServlet(name = "NilaiKelasServlet", urlPatterns = {"/NilaiKelasServlet"})
public class NilaiKelasServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String nim = request.getParameter("nim");
        String className = request.getParameter("className");
        String message;

        if (action == null || nim == null || className == null) {
            response.getWriter().write("Parameter tidak valid.");
            return;
        }

        switch (action) {
            case "add":
                try {
                    double uts = Double.parseDouble(request.getParameter("uts"));
                    double uas = Double.parseDouble(request.getParameter("uas"));
                    double tugas = Double.parseDouble(request.getParameter("tugas"));

                    boolean isAdded = gradeDao.setNilaiSiswa(nim, className, uts, uas, tugas);
                    message = isAdded ? "Nilai berhasil ditambahkan!" : "Gagal menambahkan nilai.";
                } catch (NumberFormatException e) {
                    message = "Nilai UTS, UAS, atau tugas tidak valid.";
                }
                break;

            case "edit":
                try {
                    double newUts = Double.parseDouble(request.getParameter("uts"));
                    double newUas = Double.parseDouble(request.getParameter("uas"));
                    double newTugas = Double.parseDouble(request.getParameter("tugas"));

                    boolean isUpdated = gradeDao.updateNilaiSiswa(nim, className, newUts, newUas, newTugas);
                    message = isUpdated ? "Nilai berhasil diperbarui!" : "Gagal memperbarui nilai.";
                } catch (NumberFormatException e) {
                    message = "Nilai UTS, UAS, atau tugas tidak valid.";
                }
                break;

            case "delete":
                boolean isDeleted = gradeDao.deleteNilaiSiswa(nim, className);
                message = isDeleted ? "Nilai berhasil dihapus!" : "Gagal menghapus nilai.";
                break;

            default:
                message = "Aksi tidak valid.";
        }

        response.setContentType("text/plain");
        try (PrintWriter out = response.getWriter()) {
            out.write(message);
        }
    }

    @Override
    public void destroy() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing database connection: " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
