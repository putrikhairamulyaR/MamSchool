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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Classes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class StudentDAO {

    private static final Logger logger = LoggerFactory.getLogger(StudentDAO.class);

    public List<Map<String, Object>> getAllStudents(String major, Integer tingkat) {
        List<Map<String, Object>> studentList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder(
                "SELECT s.id, s.user_id, s.nis, s.name, s.date_of_birth, "
                + "(YEAR(CURDATE()) - s.enrollment_year + 1) AS tingkat, "
                + // Hitung tingkat langsung
                "s.major, c.name AS class_name "
                + "FROM students s "
                + "LEFT JOIN classes c ON s.class_id = c.id"
        );

        boolean hasCondition = false;

        if (major != null && !major.isEmpty()) {
            queryBuilder.append(" WHERE s.major = ?");
            hasCondition = true;
        }

        if (tingkat != null) {
            if (hasCondition) {
                queryBuilder.append(" AND");
            } else {
                queryBuilder.append(" WHERE");
            }
            queryBuilder.append(" (YEAR(CURDATE()) - s.enrollment_year ) = ?"); // Filter tingkat
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(queryBuilder.toString())) {

            int parameterIndex = 1;
            if (major != null && !major.isEmpty()) {
                preparedStatement.setString(parameterIndex++, major);
            }
            if (tingkat != null) {
                preparedStatement.setInt(parameterIndex++, tingkat);
            }

            System.out.println("Final Query: " + preparedStatement); // Debugging log

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Map<String, Object> studentData = new HashMap<>();
                    studentData.put("id", resultSet.getInt("id"));
                    studentData.put("user_id", resultSet.getInt("user_id"));
                    studentData.put("nis", resultSet.getString("nis"));
                    studentData.put("name", resultSet.getString("name"));
                    studentData.put("date_of_birth", resultSet.getDate("date_of_birth"));
                    studentData.put("tingkat", resultSet.getInt("tingkat")); // Tingkat hasil perhitungan
                    studentData.put("major", resultSet.getString("major"));
                    studentData.put("class_name", resultSet.getString("class_name")); // Nama kelas

                    studentList.add(studentData);
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
        String query = "UPDATE students SET class_id = NULL WHERE id = ?";

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

    public List<Classes> getFilteredClasses(String major, Integer tingkat) {
        List<Classes> classesList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM classes");

        if (major != null || tingkat != null) {
            queryBuilder.append(" WHERE");
            if (major != null) {
                queryBuilder.append(" major = ?");
            }
            if (tingkat != null) {
                if (major != null) {
                    queryBuilder.append(" AND");
                }
                queryBuilder.append(" tingkat = ?");
            }
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(queryBuilder.toString())) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return classesList;
            }

            int parameterIndex = 1;
            if (major != null) {
                preparedStatement.setString(parameterIndex++, major);
            }
            if (tingkat != null) {
                preparedStatement.setInt(parameterIndex++, tingkat);
            }

            logger.debug("Query executed: {}", queryBuilder);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Classes classes = new Classes(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("major"),
                            resultSet.getInt("teacher_id"),
                            resultSet.getInt("tingkat")
                    );
                    classesList.add(classes);
                }
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return classesList;
    }
}
