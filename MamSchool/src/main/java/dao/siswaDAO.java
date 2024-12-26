/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Classes;
import model.Student;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author luthfiah
 */
public class siswaDAO {

     // Add new student
    public boolean addSiswa(int id, int userId, String nis, String name, LocalDate dateOfBirth, int enrollmentYear, Classes classData, String major) {
        String query = "INSERT INTO students (user_id, nis, name, date_of_birth, enrollment_year, class_id, major) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, nis);
            preparedStatement.setString(3, name);
            preparedStatement.setDate(4, Date.valueOf(dateOfBirth));
            preparedStatement.setInt(5, enrollmentYear);

            if (classData != null) {
                preparedStatement.setInt(6, classData.getId());
            } else {
                preparedStatement.setNull(6, Types.INTEGER);
            }

            preparedStatement.setString(7, major);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Edit student data
    public boolean editSiswa(int id, int userId, String nis, String name, LocalDate dateOfBirth, int enrollmentYear, Classes classData, String major) {
        String query = "UPDATE students SET user_id = ?, nis = ?, name = ?, date_of_birth = ?, enrollment_year = ?, class_id = ?, major = ? WHERE id = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, nis);
            preparedStatement.setString(3, name);
            preparedStatement.setDate(4, Date.valueOf(dateOfBirth));
            preparedStatement.setInt(5, enrollmentYear);

            if (classData != null) {
                preparedStatement.setInt(6, classData.getId());
            } else {
                preparedStatement.setNull(6, Types.INTEGER);
            }

            preparedStatement.setString(7, major);
            preparedStatement.setInt(8, id);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete student
    public boolean delSiswa(int id) {
        String query = "DELETE FROM students WHERE id = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

   // Get all students
    public List<Student> getAllSiswa() {
        String query = "SELECT * FROM students";
        List<Student> allSiswa = new ArrayList<>();
        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setNis(rs.getString("nis"));
                student.setName(rs.getString("name"));
                student.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                student.setEnrollmentYear(rs.getInt("enrollment_year"));
                student.setClassId(rs.getObject("class_id") != null ? rs.getInt("class_id") : null);
                student.setMajor(rs.getString("major"));
                allSiswa.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allSiswa;
    }

   // Get student by ID
    public Student getSiswaById(int id) {
        String query = "SELECT * FROM students WHERE id = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setNis(rs.getString("nis"));
                student.setName(rs.getString("name"));
                student.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                student.setEnrollmentYear(rs.getInt("enrollment_year"));
                student.setClassId(rs.getObject("class_id") != null ? rs.getInt("class_id") : null);
                student.setMajor(rs.getString("major"));
                return student;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}