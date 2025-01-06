
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
import dao.TeacherDAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import model.Classes;
import model.Jadwal;
import model.Teacher;

@WebServlet("/Jadwal")
public class JadwalServlet extends HttpServlet {
    private JadwalDAO jadwalDAO;

    @Override
    public void init() throws ServletException {
        jadwalDAO = new JadwalDAO();
    }


    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "list":
                listJadwals(request, response);
                break;
            
           
            default:
                response.sendRedirect("/MamSchool/frontEnd/Kepsek/ClassSchedule.jsp");
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
            case "delete":
                deleteJadwal(request, response);
                break;
            default:
                response.sendRedirect("/MamSchool/frontEnd/Kepsek/ClassSchedule.jsp");
                break;
        }
    }

    private void listJadwals(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
             String className = request.getParameter("classId");
        String day = request.getParameter("day");

        JadwalDAO JadwalDAO = new JadwalDAO();
        List<Map<String, Object>> schedules = JadwalDAO.getAllSchedules(className, day);

        List<String> availableDays = JadwalDAO.getAvailableDays();
        List<String> availableClasses = JadwalDAO.getAvailableClasses();

        request.setAttribute("schedules", schedules);
        request.setAttribute("availableDays", availableDays);
        request.setAttribute("availableClasses", availableClasses);

        request.getRequestDispatcher("/frontEnd/Kepsek/ClassSchedule.jsp").forward(request, response);
    
    }
    
    
    

private void addJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String nip = request.getParameter("nip");
    String kelas = request.getParameter("kelas"); 
    String hari = request.getParameter("hari"); 
    String startTime = request.getParameter("jam"); 
    String endTime = request.getParameter("jamSelesai"); 
    
    if (nip == null || nip.trim().isEmpty() ||
        kelas == null || kelas.trim().isEmpty() ||
        hari == null || hari.trim().isEmpty() ||
        startTime == null || startTime.trim().isEmpty() ||
        endTime == null || endTime.trim().isEmpty()) {

       request.setAttribute("errorMessage", "Semua kolom wajib diisi!");
        request.getRequestDispatcher("addJadwal.jsp").forward(request, response);
        return; 
    }

    
    TeacherDAO teacherDao = new TeacherDAO();
    Teacher teacher = teacherDao.getTeacherByNip(nip);
    
    
    String mapel = teacher.getSubject(); 

   
    int idMapel = 0; 
    if (mapel != null) {
        if (mapel.equals("Matematika")) {
            idMapel = 1;
        } else if (mapel.equals("Biologi")) {
            idMapel = 2;
        } else if (mapel.equals("Fisika")) {
            idMapel = 3;
        } else if (mapel.equals("Kimia")) {
            idMapel = 4;
        } else if (mapel.equals("Ekonomi")) {
            idMapel = 5;
        } else if (mapel.equals("Geografi")) {
            idMapel = 6;
        } else if (mapel.equals("Sejarah")) {
            idMapel = 7;
        } else if (mapel.equals("Inggris")) {
            idMapel = 8;
        } 
    


    LocalTime start = LocalTime.parse(startTime);
    LocalTime end = LocalTime.parse(endTime);
    
    int classId = Integer.parseInt(kelas);
    try {
        
        int teacherId = jadwalDAO.getTeacherId(nip);
        Jadwal jadwal = new Jadwal(classId, idMapel, teacherId, hari, start, end);

        boolean cek = jadwalDAO.addJadwal(jadwal);
        if (cek) {
            response.sendRedirect("Jadwal?action=list");  
         } else {
            response.getWriter().print("Jadwal tidak dapat ditambahkan. Silahkan coba lagi");
        }
    } catch (SQLException e) {
        throw new ServletException("Error adding Jadwal", e);
    }
}
}

    private void updateJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   
        
        String idParam = request.getParameter("id");
        String kelasParam = request.getParameter("kelas");
        String hari = request.getParameter("hari");
        String startTime = request.getParameter("jam");
        String endTime = request.getParameter("jamSelesai");

     

        
        int id = Integer.parseInt(idParam);
        int kelas = Integer.parseInt(kelasParam);
        LocalTime start = LocalTime.parse(startTime);
        LocalTime end = LocalTime.parse(endTime);

      
    try {
        
        Jadwal jadwal = jadwalDAO.getJadwalById(id);

        jadwal.setidKelas(kelas);
        jadwal.setDay(hari);
        jadwal.setStartTime(start);
        jadwal.setEndTime(end);

      
        boolean updated = jadwalDAO.updateJadwal(jadwal);
        if (updated) {
            response.sendRedirect("Jadwal?action=list"); 
         } else {
            response.getWriter().print("Jadwal tidak dapat ditambahkan. Silahkan coba lagi");
        }
    }catch (NumberFormatException e) {
        throw new ServletException("Error adding Jadwal", e);
    }
        
}
    

    

    private void deleteJadwal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    boolean isDeleted = jadwalDAO.deleteJadwal(id);
    if (!isDeleted) {
        request.setAttribute("errorMessage", "Gagal menghapus jadwal dengan ID: " + id);
        request.getRequestDispatcher("deleteJadwal.jsp").forward(request, response);
    } else {
        response.sendRedirect("Jadwal?action=list");
    }
    
}

    
    

  
}

