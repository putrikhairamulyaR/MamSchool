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
import model.Classes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class TUStudentDAO {

    private static final Logger logger = LoggerFactory.getLogger(TUStudentDAO.class);
    
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

    public List<Student> getStudentsWithClassInfo(String major, Integer tingkat) {
        List<Student> studentList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder(
                "SELECT s.*, c.id AS class_id, c.name AS class_name, c.major AS class_major, "
                + "c.tingkat AS class_tingkat, c.teacher_id AS class_teacher_id "
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
            queryBuilder.append(" ? - s.enrollment_year + 1 = ?");
        }

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(queryBuilder.toString())) {

            int parameterIndex = 1;
            if (major != null && !major.isEmpty()) {
                preparedStatement.setString(parameterIndex++, major);
            }
            if (tingkat != null) {
                preparedStatement.setInt(parameterIndex++, LocalDate.now().getYear());
                preparedStatement.setInt(parameterIndex, tingkat);
            }

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    // Buat objek Student
                    Student student = new Student(
                            resultSet.getInt("id"),
                            resultSet.getInt("user_id"),
                            resultSet.getString("nis"),
                            resultSet.getString("name"),
                            resultSet.getDate("date_of_birth").toLocalDate(),
                            resultSet.getInt("enrollment_year"),
                            resultSet.getInt("class_id"),
                            resultSet.getString("major")
                    );

                    // Buat objek Classes
                    Classes classInfo = null;
                    if (resultSet.getObject("class_id") != null) {
                        classInfo = new Classes(
                                resultSet.getInt("class_id"),
                                resultSet.getString("class_name"),
                                resultSet.getString("class_major"),
                                resultSet.getInt("class_teacher_id"),
                                resultSet.getInt("class_tingkat")
                        );
                    }
                    student.setClassInfo(classInfo);
                    studentList.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return studentList;
    }

}
