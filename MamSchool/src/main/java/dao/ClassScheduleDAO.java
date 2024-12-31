/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Jadwal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Royal
 */
public class ClassScheduleDAO {

    public List<Map<String, Object>> getAllSchedules(String className, String day) {
        List<Map<String, Object>> schedules = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT cs.id, cs.class_id, c.name AS class_name, cs.subject_id, s.name AS subject_name, " +
            "cs.teacher_id, t.name AS teacher_name, cs.day, cs.start_time, cs.end_time " +
            "FROM class_schedule cs " +
            "LEFT JOIN classes c ON cs.class_id = c.id " +
            "LEFT JOIN subjects s ON cs.subject_id = s.id " +
            "LEFT JOIN teachers t ON cs.teacher_id = t.id WHERE 1=1"
        );

        if (className != null && !className.isEmpty()) {
            query.append(" AND c.name = ?");
        }
        if (day != null && !day.isEmpty()) {
            query.append(" AND cs.day = ?");
        }

        query.append(" ORDER BY FIELD(cs.day, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'), cs.start_time");

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (className != null && !className.isEmpty()) {
                stmt.setString(paramIndex++, className);
            }
            if (day != null && !day.isEmpty()) {
                stmt.setString(paramIndex++, day);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> schedule = new HashMap<>();
                schedule.put("id", rs.getInt("id"));
                schedule.put("classId", rs.getInt("class_id"));
                schedule.put("className", rs.getString("class_name"));
                schedule.put("subjectId", rs.getInt("subject_id"));
                schedule.put("subjectName", rs.getString("subject_name"));
                schedule.put("teacherId", rs.getInt("teacher_id"));
                schedule.put("teacherName", rs.getString("teacher_name"));
                schedule.put("day", rs.getString("day"));
                schedule.put("startTime", rs.getTime("start_time").toLocalTime());
                schedule.put("endTime", rs.getTime("end_time").toLocalTime());
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedules;
    }

    public List<String> getAvailableDays() {
        List<String> days = new ArrayList<>();
        String query = "SELECT DISTINCT day FROM class_schedule ORDER BY FIELD(day, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu')";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                days.add(rs.getString("day"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return days;
    }


    public List<String> getAvailableClasses() {
        List<String> classes = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM classes ORDER BY name";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                classes.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return classes;
    }
}
