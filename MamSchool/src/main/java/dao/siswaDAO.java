/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import classes.JDBC;
import model.Classes;
import model.Teacher;
import java.sql.*;
import java.time.LocalDate;
/**
 *
 * @author luthfiah
 */
public class siswaDAO {
    // Add new student
    public boolean addSiswa(int id, int userId, String nis, String name, LocalDate dateOfBirth, int enrollmentYear, Classes classData, String major, Teacher teacher) {
        String query = "INSERT INTO students (id, user_id, nis, name, date_of_birth, "
                + "enrollment_year, class_id, major, teacher_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.setInt(2, userId);
            preparedStatement.setString(3, nis);
            preparedStatement.setString(4, name);
            preparedStatement.setDate(5, Date.valueOf(dateOfBirth));
            preparedStatement.setInt(6, enrollmentYear);
            preparedStatement.setInt(7, classData.getId()); // Assuming Classes has an getId() method
            preparedStatement.setString(8, major);
            preparedStatement.setInt(9, teacher.getId()); // Assuming Teacher has an getId() method

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    // Edit student data
    public boolean editSiswa(int id, int userId, String nis, String name, LocalDate dateOfBirth, int enrollmentYear, Classes classData, String major, Teacher teacher) {
        String query = "UPDATE students SET user_id = ?, nis = ?, name = ?, date_of_birth = ?, "
                + "enrollment_year = ?, class_id = ?, major = ?, teacher_id = ? WHERE id = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, nis);
            preparedStatement.setString(3, name);
            preparedStatement.setDate(4, Date.valueOf(dateOfBirth));
            preparedStatement.setInt(5, enrollmentYear);
            preparedStatement.setInt(6, classData.getId()); // Assuming Classes has an getId() method
            preparedStatement.setString(7, major);
            preparedStatement.setInt(8, teacher.getId()); // Assuming Teacher has an getId() method
            preparedStatement.setInt(9, id);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    // Delete student
    public boolean delSiswa(int id) {
        String query = "DELETE FROM students WHERE id = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
