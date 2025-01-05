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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 *
 * @author Royal
 */
public class DashboardGuruDAO {

    public List<Map<String, Object>> getJadwalHariIni(int teacherId) {
        List<Map<String, Object>> jadwalHariIni = new ArrayList<>();
        String query = "SELECT cs.start_time, cs.end_time, c.name AS class_name, s.name AS subject_name "
                + "FROM class_schedule cs "
                + "JOIN classes c ON cs.class_id = c.id "
                + "JOIN subjects s ON cs.subject_id = s.id "
                + "WHERE cs.teacher_id = ? AND cs.day = DAYNAME(CURDATE()) "
                + "ORDER BY cs.start_time ASC";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> jadwal = new TreeMap<>();
                jadwal.put("startTime", rs.getTime("start_time"));
                jadwal.put("endTime", rs.getTime("end_time"));
                jadwal.put("className", rs.getString("class_name"));
                jadwal.put("subjectName", rs.getString("subject_name"));

                jadwalHariIni.add(jadwal);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jadwalHariIni;
    }

    public List<Map<String, Object>> getJadwalMingguan(int teacherId) {
        List<Map<String, Object>> jadwalMingguan = new ArrayList<>();
        String query = "SELECT cs.day, cs.start_time, cs.end_time, c.name AS class_name, s.name AS subject_name "
                + "FROM class_schedule cs "
                + "JOIN classes c ON cs.class_id = c.id "
                + "JOIN subjects s ON cs.subject_id = s.id "
                + "WHERE cs.teacher_id = ? "
                + "ORDER BY FIELD(cs.day, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'), cs.start_time ASC";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> jadwal = new TreeMap<>();
                jadwal.put("day", rs.getString("day"));
                jadwal.put("startTime", rs.getTime("start_time"));
                jadwal.put("endTime", rs.getTime("end_time"));
                jadwal.put("className", rs.getString("class_name"));
                jadwal.put("subjectName", rs.getString("subject_name"));

                jadwalMingguan.add(jadwal);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jadwalMingguan;
    }
}
