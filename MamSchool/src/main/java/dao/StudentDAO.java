/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dao;

import classes.JDBC;
import model.Student;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class StudentDAO {

    private static final Logger logger = LoggerFactory.getLogger(StudentDAO.class);

    public List<Student> getAllStudents(String major, Integer tingkat) {
        List<Student> studentList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM students");

        boolean hasCondition = false;

        if (major != null && !major.isEmpty()) {
            queryBuilder.append(" WHERE major = ?");
            hasCondition = true;
        }

        if (tingkat != null) {
            if (hasCondition) {
                queryBuilder.append(" AND");
            } else {
                queryBuilder.append(" WHERE");
            }
            queryBuilder.append(" ? - enrollment_year + 1 = ?");
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(queryBuilder.toString())) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return studentList;
            }

            int parameterIndex = 1;
            if (major != null && !major.isEmpty()) {
                preparedStatement.setString(parameterIndex++, major);
            }
            if (tingkat != null) {
                preparedStatement.setInt(parameterIndex++, LocalDate.now().getYear());
                preparedStatement.setInt(parameterIndex, tingkat);
            }

            logger.debug("Query executed: {}", preparedStatement);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Student student = new Student(
                            resultSet.getInt("id"),
                            resultSet.getInt("user_id"),
                            resultSet.getString("nis"),
                            resultSet.getString("name"),
                            resultSet.getDate("date_of_birth").toLocalDate(),
                            resultSet.getInt("enrollment_year"),
                            (Integer) resultSet.getObject("class_id"), // Nullable
                            resultSet.getString("major")
                    );
                    studentList.add(student);
                }
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return studentList;
    }

    public int countStudentsWithClass() {
        String query = "SELECT COUNT(*) FROM students WHERE class_id IS NOT NULL";
        return countStudents(query);
    }

    public int countStudentsWithoutClass() {
        String query = "SELECT COUNT(*) FROM students WHERE class_id IS NULL";
        return countStudents(query);
    }

    private int countStudents(String query) {
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet resultSet = preparedStatement.executeQuery()) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return 0;
            }

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public boolean addStudent(Student student) {
        String query = "INSERT INTO students (user_id, nis, name, date_of_birth, enrollment_year, class_id, major) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setInt(1, student.getUserId());
            preparedStatement.setString(2, student.getNis());
            preparedStatement.setString(3, student.getName());
            preparedStatement.setDate(4, Date.valueOf(student.getDateOfBirth()));
            preparedStatement.setInt(5, student.getEnrollmentYear());
            preparedStatement.setObject(6, student.getClassId());
            preparedStatement.setString(7, student.getMajor());

            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateStudent(Student student) {
        String query = "UPDATE students SET user_id = ?, nis = ?, name = ?, date_of_birth = ?, enrollment_year = ?, class_id = ?, major = ? WHERE id = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setInt(1, student.getUserId());
            preparedStatement.setString(2, student.getNis());
            preparedStatement.setString(3, student.getName());
            preparedStatement.setDate(4, Date.valueOf(student.getDateOfBirth()));
            preparedStatement.setInt(5, student.getEnrollmentYear());
            preparedStatement.setObject(6, student.getClassId());
            preparedStatement.setString(7, student.getMajor());
            preparedStatement.setInt(8, student.getId());

            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteStudent(int id) {
        String query = "DELETE FROM students WHERE id = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setInt(1, id);

            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public Student getStudentById(int id) {
        String query = "SELECT * FROM students WHERE id = ?";
        Student student = null;

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return null;
            }

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            logger.debug("Query executed: {}", query);

            if (resultSet.next()) {
                logger.debug("Processing row with ID: {}", resultSet.getInt("id"));
                student = new Student(
                        resultSet.getInt("id"),
                        resultSet.getInt("user_id"),
                        resultSet.getString("nis"),
                        resultSet.getString("name"),
                        resultSet.getDate("date_of_birth").toLocalDate(),
                        resultSet.getInt("enrollment_year"),
                        (Integer) resultSet.getObject("class_id"), // Nullable
                        resultSet.getString("major")
                );
                logger.debug("Student retrieved: {}", student);
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return student;
    }
}
