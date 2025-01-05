/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
/**
 *
 * @author Royal
 */
public class DashboardSiswaDAO {

    // Method untuk mendapatkan jadwal hari ini berdasarkan studentId
    public List<Map<String, Object>> getJadwalHariIni(int studentId) {
        List<Map<String, Object>> jadwalHariIni = new ArrayList<>();
        String query = """
                SELECT s.name AS subject_name, t.name AS teacher_name, c.name AS class_name, 
                       cs.day, cs.start_time, cs.end_time
                FROM class_schedule cs
                JOIN classes c ON cs.class_id = c.id
                JOIN students st ON c.id = st.class_id
                JOIN subjects s ON cs.subject_id = s.id
                JOIN teachers t ON cs.teacher_id = t.id
                WHERE st.id = ? AND cs.day = DAYNAME(CURDATE())
                ORDER BY cs.start_time ASC
                """;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> jadwal = new HashMap<>();
                jadwal.put("subjectName", rs.getString("subject_name"));
                jadwal.put("teacherName", rs.getString("teacher_name"));
                jadwal.put("className", rs.getString("class_name"));
                jadwal.put("day", rs.getString("day"));
                jadwal.put("startTime", rs.getTime("start_time"));
                jadwal.put("endTime", rs.getTime("end_time"));

                jadwalHariIni.add(jadwal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jadwalHariIni;
    }

    // Method untuk mendapatkan semua jadwal pelajaran berdasarkan studentId
    public List<Map<String, Object>> getSemuaJadwal(int studentId) {
        List<Map<String, Object>> semuaJadwal = new ArrayList<>();
        String query = """
                SELECT s.name AS subject_name, t.name AS teacher_name, c.name AS class_name, 
                       cs.day, cs.start_time, cs.end_time
                FROM class_schedule cs
                JOIN classes c ON cs.class_id = c.id
                JOIN students st ON c.id = st.class_id
                JOIN subjects s ON cs.subject_id = s.id
                JOIN teachers t ON cs.teacher_id = t.id
                WHERE st.id = ?
                ORDER BY FIELD(cs.day, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'),
                         cs.start_time ASC
                """;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> jadwal = new HashMap<>();
                jadwal.put("subjectName", rs.getString("subject_name"));
                jadwal.put("teacherName", rs.getString("teacher_name"));
                jadwal.put("className", rs.getString("class_name"));
                jadwal.put("day", rs.getString("day"));
                jadwal.put("startTime", rs.getTime("start_time"));
                jadwal.put("endTime", rs.getTime("end_time"));

                semuaJadwal.add(jadwal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return semuaJadwal;
    }
}
