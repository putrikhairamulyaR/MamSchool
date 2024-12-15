package servlets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.List;

import dao.JadwalDAO;
import model.Jadwal;

@WebServlet("/jadwal")
public class JadwalServlet extends HttpServlet {
    private JadwalDAO jadwalDAO;

    @Override
    public void init() throws ServletException {
        
        String jdbcURL = "jdbc:mysql://localhost:3306/class_schedule"; 
        String jdbcUsername = "your_username";
        String jdbcPassword = "your_password"; 

        try {
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            jadwalDAO = new JadwalDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            listJadwals(request, response);
        } else if ("edit".equals(action)) {
            editJadwal(request, response);
        } else if ("delete".equals(action)) {
            deleteJadwal(request, response);
        } else {
            response.sendRedirect("index.jsp"); // Redirect to a default page
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addJadwal(request, response);
        } else if ("update".equals(action)) {
            updateJadwal(request, response);
        } else {
            response.sendRedirect("index.jsp"); // Redirect to a default page
        }
    }

    private void listJadwals(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Jadwal> jadwals = jadwalDAO.getAllJadwals();
            request.setAttribute("jadwals", jadwals);
            request.getRequestDispatcher("listJadwal.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving jadwals", e);
        }
    }

    private void addJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String kelas = request.getParameter("kelas");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String day = request.getParameter("day");
 LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
        LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

        Jadwal jadwal = new Jadwal(0, kelas, subjectId, teacherId, day, startTime, endTime);

        try {
            jadwalDAO.addJadwal(jadwal);
            response.sendRedirect("jadwal?action=list");
        } catch (SQLException e) {
            throw new ServletException("Error adding jadwal", e);
        }
    }

    private void editJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Jadwal jadwal = jadwalDAO.getJadwalById(id);
            request.setAttribute("jadwal", jadwal);
            request.getRequestDispatcher("editJadwal.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving jadwal for edit", e);
        }
    }

    private void updateJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String kelas = request.getParameter("kelas");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String day = request.getParameter("day");
        LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
        LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

        Jadwal jadwal = new Jadwal(id, kelas, subjectId, teacherId, day, startTime, endTime);

        try {
            jadwalDAO.updateJadwal(jadwal);
            response.sendRedirect("jadwal?action=list");
        } catch (SQLException e) {
            throw new ServletException("Error updating jadwal", e);
        }
    }

    private void deleteJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            jadwalDAO.deleteJadwal(id);
            response.sendRedirect("jadwal?action=list");
        } catch (SQLException e) {
            throw new ServletException("Error deleting jadwal", e);
        }
    }

}