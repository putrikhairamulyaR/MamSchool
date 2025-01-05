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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dafi Utomo
 */
public class ListPresensiDAO {

    // Method to fetch attendance data with filters for class name and date
    private static final Logger LOGGER = Logger.getLogger(ListPresensiDAO.class.getName());

    public List<Map<String, Object>> getAttendance(String className, Date date) {
        List<Map<String, Object>> attendanceList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT a.id AS attendance_id, a.student_id, a.date, a.status, "
                + "s.nis AS student_nis, s.name AS student_name, c.name AS class_name "
                + "FROM attendance a "
                + "JOIN students s ON a.student_id = s.id "
                + "JOIN classes c ON s.class_id = c.id "
                + "WHERE 1=1"
        );

        if (className != null && !className.isEmpty()) {
            query.append(" AND c.name = ?");
        }
        if (date != null) {
            query.append(" AND a.date = ?");
        }

        LOGGER.log(Level.INFO, "Executing query: {0}", query);

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (className != null && !className.isEmpty()) {
                stmt.setString(paramIndex++, className);
            }
            if (date != null) {
                stmt.setDate(paramIndex++, new java.sql.Date(date.getTime()));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                LOGGER.log(Level.INFO, "Processing row: ID={0}, StudentID={1}, NIS={2}, Name={3}, ClassName={4}",
                        new Object[]{
                            rs.getInt("attendance_id"),
                            rs.getInt("student_id"),
                            rs.getString("student_nis"),
                            rs.getString("student_name"),
                            rs.getString("class_name")
                        });

                Map<String, Object> attendance = new HashMap<>();
                attendance.put("id", rs.getInt("attendance_id"));
                attendance.put("studentId", rs.getInt("student_id"));
                attendance.put("studentNis", rs.getString("student_nis"));
                attendance.put("studentName", rs.getString("student_name"));
                attendance.put("className", rs.getString("class_name"));
                attendance.put("date", rs.getDate("date"));
                attendance.put("status", rs.getString("status"));

                attendanceList.add(attendance);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error executing query in getAttendance", e);
        }

        return attendanceList;
    }

    public List<String> getAvailableClasses() {
        List<String> classNames = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM classes";

        LOGGER.log(Level.INFO, "Executing query to fetch available classes: {0}", query);

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                classNames.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error executing query in getAvailableClasses", e);
        }

        return classNames;
    }

    public List<Date> getAvailableDates(String className) {
        List<Date> dates = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT DISTINCT a.date FROM attendance a "
                + "JOIN students s ON a.student_id = s.id "
                + "JOIN classes c ON s.class_id = c.id WHERE 1=1");

        if (className != null && !className.isEmpty()) {
            query.append(" AND c.name = ?");
        }
        query.append(" ORDER BY a.date ASC");

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            if (className != null && !className.isEmpty()) {
                stmt.setString(1, className);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                dates.add(rs.getDate("date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dates;
    }

}
