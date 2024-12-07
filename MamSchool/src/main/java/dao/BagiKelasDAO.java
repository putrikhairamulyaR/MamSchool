package dao;

import classes.JDBC;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {
        public int getTotalStudents() {
        String query = "SELECT COUNT(*) AS total FROM students WHERE YEAR(CURDATE()) - enrollment_year = ? AND major = ?";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalStudentsWithClass() {
        String query = "SELECT COUNT(*) AS total FROM students WHERE YEAR(CURDATE()) - enrollment_year = ? AND major = ? AND class_id IS NOT NULL";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<BagiKelasDAO> getStudentsWithClass() {
        String query = "SELECT * FROM students WHERE YEAR(CURDATE()) - enrollment_year = ? AND major = ? AND class_id IS NOT NULL";
        List<BagiKelasDAO> students = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BagiKelasDAO student = new BagiKelasDAO();
                    student.setId(resultSet.getInt("id"));
                    student.setName(resultSet.getString("name"));
                    student.setEnrollmentYear(resultSet.getInt("enrollment_year"));
                    student.setMajor(resultSet.getString("major"));
                    student.setClassId(resultSet.getInt("class_id"));

                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students; 
    }
    
    public List<BagiKelasDAO> getAllStudents() {
        String query = "SELECT * FROM students WHERE YEAR(CURDATE()) - enrollment_year = ? AND major = ?";
        List<BagiKelasDAO> students = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BagiKelasDAO student = new BagiKelasDAO();
                    student.setId(resultSet.getInt("id"));
                    student.setName(resultSet.getString("name"));
                    student.setEnrollmentYear(resultSet.getInt("enrollment_year"));
                    student.setMajor(resultSet.getString("major"));
                    student.setClassId(resultSet.getInt("class_id"));

                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students; 
    }
    
    public List<BagiKelasDAO> getStudentsInClass() {
        String query = "SELECT * FROM students WHERE class_id =?";
        List<BagiKelasDAO> students = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BagiKelasDAO student = new BagiKelasDAO();
                    student.setId(resultSet.getInt("id"));
                    student.setName(resultSet.getString("name"));
                    student.setEnrollmentYear(resultSet.getInt("enrollment_year"));
                    student.setMajor(resultSet.getString("major"));
                    student.setClassId(resultSet.getInt("class_id"));

                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students; 
    }
    
    public boolean assignStudentToClass(int studentId, int classId) {
    String query = "UPDATE students SET class_id = ? WHERE id = ?";
    try (Connection connection = JDBC.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

        // Set values for the placeholders
        preparedStatement.setInt(1, classId);
        preparedStatement.setInt(2, studentId);

        // Execute the update query
        int rowsAffected = preparedStatement.executeUpdate();

        // Check if any rows were updated
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; 
}
    
    public boolean addClass(String name, String major) {
        String query = "INSERT INTO class (name, major) VALUES (?, ?)";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, name);
            preparedStatement.setString(2, major);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }

    
    private void setId(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void setName(String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void setEnrollmentYear(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void setMajor(String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void setClassId(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
