package dao;

import classes.JDBC;
import model.Teacher;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import classes.JDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Teacher;

public class TeacherDAO {
    // Add new teacher
    public boolean addTeacher(int userId, String nip, String name, LocalDate dateOfBirth, String subject, LocalDate hireDate){
        String query = "INSERT INTO teachers (user_id, nip, name, date_of_birth, subject, hire_date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, nip);
            preparedStatement.setString(3, name);
            preparedStatement.setDate(4, Date.valueOf(dateOfBirth));
            preparedStatement.setString(5, subject);
            preparedStatement.setDate(6, Date.valueOf(hireDate));

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
     public boolean editTeacher(int id, int userId, String nip, String name, LocalDate dateOfBirth, String subject) {
        String query = "UPDATE teacher SET user_id = ?, nis = ?, name = ?, date_of_birth = ?, enrollment_year = ?, major = ? WHERE id = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, nip);
            preparedStatement.setString(3, name);
            preparedStatement.setDate(4, Date.valueOf(dateOfBirth));
            preparedStatement.setString(5, subject);
            preparedStatement.setInt(6, id);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
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
    public boolean delTeacher(int id) {
        String query = "DELETE FROM teachers WHERE id = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
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
                //teacher.setUserId(rs.getInt("user_id"));
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
    

    // Method to get teacher details by NIP
    public Teacher getTeacherByNip(String nip) {
        String sql = "SELECT id, nip, name, subject FROM teachers WHERE nip = ?";
        Teacher teacher = null;
        
        try (Connection connection = JDBC.getConnection(); // Get the database connection
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nip); // Set the NIP parameter in the SQL query
            try (ResultSet rs = stmt.executeQuery()) { // Execute the query
                if (rs.next()) { // If a result is found           
                    teacher = new Teacher(); // Create a new Teacher object
                    teacher.setId(rs.getInt("id")); // Set the ID
                    teacher.setNip(rs.getString("nip")); // Set the NIP
                    teacher.setName(rs.getString("name")); // Set the name
                    teacher.setSubject(rs.getString("subject")); // Set the subject
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print any SQL exceptions
        }
        return teacher; // Return the Teacher object or null if not found
    }
    
    public int getUserIdByName(String name) {
        String query = "SELECT id FROM users WHERE name = ?";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, name);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Mengembalikan -1 jika userId tidak ditemukan
    }

}