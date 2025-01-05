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
public class DashboardTUDAO {

    // Total Counts
    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) AS total FROM users");
    }

    public int getTotalStudents() {
        return getCount("SELECT COUNT(*) AS total FROM students");
    }

    public int getTotalTeachers() {
        return getCount("SELECT COUNT(*) AS total FROM teachers");
    }

    public int getTotalClasses() {
        return getCount("SELECT COUNT(*) AS total FROM classes");
    }

    public int getTotalSubjects() {
        return getCount("SELECT COUNT(*) AS total FROM subjects");
    }

    private int getCount(String query) {
        int count = 0;
        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Distribution of Students by Majors
    public Map<String, Integer> getStudentDistributionByMajor() {
        Map<String, Integer> distribution = new HashMap<>();
        String query = "SELECT major, COUNT(*) AS total FROM students GROUP BY major";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                distribution.put(rs.getString("major"), rs.getInt("total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // Average Monthly Attendance
    public Map<String, Double> getAverageMonthlyAttendance() {
        Map<String, Double> attendanceStats = new LinkedHashMap<>();
        String query = "SELECT DATE_FORMAT(date, '%Y-%m') AS month, AVG(CASE WHEN status = 'Hadir' THEN 1 ELSE 0 END) AS average "
                + "FROM attendance GROUP BY month ORDER BY month ASC";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                attendanceStats.put(rs.getString("month"), rs.getDouble("average"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceStats;
    }

    // Highlight Problematic Students
    public List<Map<String, Object>> getProblematicStudents(double threshold) {
        List<Map<String, Object>> students = new ArrayList<>();
        String query = "SELECT s.id, s.name, s.nis, c.name AS class_name, COUNT(a.id) AS total_attendance, "
                + "SUM(CASE WHEN a.status = 'Hadir' THEN 1 ELSE 0 END) AS present_count "
                + "FROM students s "
                + "JOIN attendance a ON s.id = a.student_id "
                + "JOIN classes c ON s.class_id = c.id "
                + "GROUP BY s.id, s.name, s.nis, c.name "
                + "HAVING (present_count / total_attendance) < ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setDouble(1, threshold);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();
                student.put("id", rs.getInt("id"));
                student.put("name", rs.getString("name"));
                student.put("nis", rs.getString("nis"));
                student.put("className", rs.getString("class_name"));
                student.put("attendanceRate", rs.getDouble("present_count") / rs.getInt("total_attendance"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Today's Class Schedules
    public List<Map<String, Object>> getTodaySchedules() {
        List<Map<String, Object>> schedules = new ArrayList<>();
        String query = "SELECT c.name AS class_name, s.name AS subject_name, t.name AS teacher_name, "
                + "cs.day, cs.start_time, cs.end_time "
                + "FROM class_schedule cs "
                + "JOIN classes c ON cs.class_id = c.id "
                + "JOIN subjects s ON cs.subject_id = s.id "
                + "JOIN teachers t ON cs.teacher_id = t.id "
                + "WHERE cs.day = DAYNAME(CURDATE()) "
                + "ORDER BY cs.start_time ASC";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> schedule = new HashMap<>();
                schedule.put("className", rs.getString("class_name"));
                schedule.put("subjectName", rs.getString("subject_name"));
                schedule.put("teacherName", rs.getString("teacher_name"));
                schedule.put("day", rs.getString("day"));
                schedule.put("startTime", rs.getTime("start_time"));
                schedule.put("endTime", rs.getTime("end_time"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
}
