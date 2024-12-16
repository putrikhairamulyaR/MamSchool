/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Teacher;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author luthfiah
 */
public class teacherDAO {
    // Add new teacher
    
    // Edit teacher subject only
    public boolean editTeacherSubject(int id, String subject) {
        String query = "UPDATE teachers SET subject = ? WHERE id = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, subject);
            preparedStatement.setInt(2, id);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Delete teacher
    
    // Get all teachers
    public List<Teacher> getAllTeachers() {
        String query = "SELECT * FROM teachers";
        List<Teacher> allTeachers = new ArrayList<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
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
                allTeachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allTeachers;
    }
    
    // Get teacher by ID
    public Teacher getTeacherById(int id) {
        String query = "SELECT * FROM teachers WHERE id = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setId(rs.getInt("id"));
                teacher.setUserId(rs.getInt("user_id"));
                teacher.setNip(rs.getString("nip"));
                teacher.setName(rs.getString("name"));
                teacher.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                teacher.setSubject(rs.getString("subject"));
                teacher.setHireDate(rs.getDate("hire_date").toLocalDate());
                return teacher;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
