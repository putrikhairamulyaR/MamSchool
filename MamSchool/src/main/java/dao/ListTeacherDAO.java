/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Teacher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Royal
 */
public class ListTeacherDAO {

    public List<Teacher> getAllTeachers(String subject) {
        List<Teacher> teachers = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM teachers WHERE 1=1");

        if (subject != null && !subject.isEmpty()) {
            query.append(" AND subject = ?");
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            if (subject != null && !subject.isEmpty()) {
                stmt.setString(1, subject);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setId(rs.getInt("id"));
                teacher.setUserId(rs.getInt("user_id"));
                teacher.setNip(rs.getString("nip"));
                teacher.setName(rs.getString("name"));
                teacher.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                teacher.setSubject(rs.getString("subject"));
                teacher.setHireDate(rs.getDate("hire_date").toLocalDate());
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return teachers;
    }

    public List<String> getAllSubjects() {
        List<String> subjects = new ArrayList<>();
        String query = "SELECT DISTINCT subject FROM teachers WHERE subject IS NOT NULL";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                subjects.add(rs.getString("subject"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return subjects;
    }

}
