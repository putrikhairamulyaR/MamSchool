/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Presensi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 *
 * @author Dafi Utomo
 */
public class ListPresensiDAO {

    // Method to fetch attendance data with filters for class name and date
    public List<Map<String, Object>> getAttendance(String className, Date date) {
        List<Map<String, Object>> attendanceList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT a.id, a.student_id, a.date, a.status, s.name AS student_name, "
                + "c.name AS class_name "
                + "FROM attendance a "
                + "JOIN students s ON a.student_id = s.id "
                + "JOIN classes c ON s.class_id = c.id "
                + "WHERE 1=1");

        if (className != null && !className.isEmpty()) {
            query.append(" AND c.name = ?");
        }
        if (date != null) {
            query.append(" AND a.date = ?");
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (className != null && !className.isEmpty()) {
                stmt.setString(paramIndex++, className);
            }
            if (date != null) {
                stmt.setDate(paramIndex++, new java.sql.Date(date.getTime())); // Fix applied here
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> attendance = new HashMap<>();
                attendance.put("id", rs.getInt("id"));
                attendance.put("studentId", rs.getInt("student_id"));
                attendance.put("studentName", rs.getString("student_name"));
                attendance.put("className", rs.getString("class_name"));
                attendance.put("date", rs.getDate("date"));
                attendance.put("status", rs.getString("status"));
                attendanceList.add(attendance);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return attendanceList;
    }

    // Method to fetch available class names from the database
    public List<String> getAvailableClasses() {
        List<String> classNames = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM classes";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                classNames.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return classNames;
    }

    // Method to fetch available dates from the attendance table
    public List<Date> getAvailableDates() {
        List<Date> dates = new ArrayList<>();
        String query = "SELECT DISTINCT date FROM attendance ORDER BY date ASC";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                dates.add(rs.getDate("date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dates;
    }
}
