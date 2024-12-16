package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.List;

import dao.JadwalDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Jadwal;

@WebServlet("/Jadwal")
public class JadwalServlet extends HttpServlet {
    private JadwalDAO jadwalDAO;

    @Override
    public void init() throws ServletException {
        // Instantiate the JadwalDAO when the servlet is initialized
        jadwalDAO = new JadwalDAO();
    }


    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "list":
                listJadwals(request, response);
                break;
            case "edit":
                editJadwal(request, response);
                break;
            case "delete":
                deleteJadwal(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addJadwal(request, response);
                break;
            case "update":
                updateJadwal(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    private void listJadwals(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Jadwal> Jadwals = jadwalDAO.getAllJadwals();
        request.getSession().setAttribute("scheduleList", Jadwals);
        response.sendRedirect("/MamSchool/frontEnd/Kepsek/listJadwal.jsp");
    }

    private void addJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String kelas = request.getParameter("kelas");
        String mapel = request.getParameter("mapel"); // Subject
        String nip = request.getParameter("nip"); // Teacher NIP
        String hari = request.getParameter("hari"); // Day
        String startTime = request.getParameter("jam"); // Start time
        String endTime = request.getParameter("jamSelesai"); // End time
        
       
        int idMapel=0; 
        
        
        if(mapel.equals("matematika")){
            idMapel=1;
        }else if(mapel.equals("bahasaing")){
            idMapel=2;
        }else if(mapel.equals("fisika")){
            idMapel=3;
        }else if(mapel.equals("kimia")){
            idMapel=4;
        }else if(mapel.equals("biologi")){
            idMapel=5;
        }else if(mapel.equals("sejarah")){
            idMapel=6;
        }else if(mapel.equals("geografi")){
            idMapel=7;
        }else if(mapel.equals("ekonomi")){
            idMapel=8;
        } 

       
        LocalTime start = LocalTime.parse(startTime);
        LocalTime end = LocalTime.parse(endTime);

        try {
            
            int teacherId = jadwalDAO.getTeacherId(nip);
           
           
            Jadwal jadwal = new Jadwal(kelas, idMapel, teacherId, hari, start, end);

           boolean cek = jadwalDAO.addJadwal(jadwal);
            response.sendRedirect("Jadwal?action=list"); // Redirect to the list after adding
        } catch (SQLException e) {
            throw new ServletException("Error adding Jadwal", e);
        }
    }

    private void editJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Jadwal Jadwal = jadwalDAO.getJadwalById(id);
        request.setAttribute("Jadwal", Jadwal);
        request.getRequestDispatcher("editJadwal.jsp").forward(request, response);
    }

    private void updateJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String kelas = request.getParameter("kelas");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String day = request.getParameter("day");
        LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
        LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

        Jadwal Jadwal = new Jadwal(id, kelas, subjectId, teacherId, day, startTime, endTime);

        jadwalDAO.updateJadwal(Jadwal);
        response.sendRedirect("Jadwal?action=list");
    }

    private void deleteJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        jadwalDAO.deleteJadwal(id);
        response.sendRedirect("Jadwal?action=list");
    }

    private int getSubjectId(String mapel) throws SQLException {
    String sql = "SELECT id FROM subjects WHERE name = ?";
    try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/subjects", "your_username", "your_password");
         PreparedStatement stmt = connection.prepareStatement(sql)) {
        
        stmt.setString(1, mapel); 

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("id");
            } else {
                throw new SQLException("Subject not found: " + mapel); 
            }
        }
    }
}


}
