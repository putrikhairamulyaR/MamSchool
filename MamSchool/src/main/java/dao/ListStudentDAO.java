/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import classes.JDBC;
import model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 *
 * @author Royal
 */
public class ListStudentDAO {

    public List<Map<String, Object>> getAllStudents(String major, Integer tingkat) {
        List<Map<String, Object>> students = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT s.*, c.name AS class_name, t.name AS teacher_name FROM students s " +
                "LEFT JOIN classes c ON s.class_id = c.id " +
                "LEFT JOIN teachers t ON c.teacher_id = t.id WHERE 1=1"
        );

        if (major != null && !major.isEmpty()) {
            query.append(" AND s.major = ?");
        }
        if (tingkat != null) {
            query.append(" AND (YEAR(CURDATE()) - s.enrollment_year) + 1 = ?");
        }

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (major != null && !major.isEmpty()) {
                stmt.setString(paramIndex++, major);
            }
            if (tingkat != null) {
                stmt.setInt(paramIndex++, tingkat);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> studentData = new HashMap<>();
                studentData.put("id", rs.getInt("id"));
                studentData.put("userId", rs.getInt("user_id"));
                studentData.put("nis", rs.getString("nis"));
                studentData.put("name", rs.getString("name"));
                studentData.put("dateOfBirth", rs.getDate("date_of_birth"));
                studentData.put("enrollmentYear", rs.getInt("enrollment_year"));
                studentData.put("classId", rs.getObject("class_id", Integer.class));
                studentData.put("major", rs.getString("major"));

                // Additional fields from joins
                studentData.put("className", rs.getString("class_name"));
                studentData.put("teacherName", rs.getString("teacher_name"));

                students.add(studentData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }
}
