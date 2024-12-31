/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import classes.JDBC;
import model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Royal
 */
public class ListStudentDAO {

    public List<Student> getAllStudents(String major, Integer tingkat) {
        List<Student> students = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT *, YEAR(CURDATE()) - enrollment_year AS tingkat FROM students WHERE 1=1");

        if (major != null && !major.isEmpty()) {
            query.append(" AND major = ?");
        }
        if (tingkat != null) {
            query.append(" AND (YEAR(CURDATE()) - enrollment_year) + 1 = ?");
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
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setNis(rs.getString("nis"));
                student.setName(rs.getString("name"));
                student.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                student.setEnrollmentYear(rs.getInt("enrollment_year"));
                student.setClassId(rs.getObject("class_id", Integer.class));
                student.setMajor(rs.getString("major"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }
}

