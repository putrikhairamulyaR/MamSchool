package dao;

import classes.JDBC;
import model.Classes;
import model.Teacher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class ClassesDAO {

    private static final Logger logger = LoggerFactory.getLogger(ClassesDAO.class);

    public List<Classes> getAllClasses() {
        List<Classes> classesList = new ArrayList<>();
        String query = "SELECT * FROM classes";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet resultSet = preparedStatement.executeQuery()) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return classesList;
            }

            logger.debug("Fetching all classes...");
            logger.debug("Query executed: {}", query);

            while (resultSet.next()) {
                logger.debug("Processing row with ID: {}", resultSet.getInt("id"));
                Classes classes = new Classes(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("major"),
                        resultSet.getInt("teacher_id"),
                        resultSet.getInt("tingkat")
                );
                classesList.add(classes);
                logger.debug("Class added to list: {}", classes);
            }

            logger.info("Total classes retrieved: {}", classesList.size());

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return classesList;
    }

    public List<Classes> getFilteredClasses(String major, Integer tingkat) {
        List<Classes> classesList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM classes");

        // Tambahkan kondisi filter hanya jika parameter tidak null atau kosong
        if ((major != null && !major.isEmpty()) || tingkat != null) {
            queryBuilder.append(" WHERE");
            if (major != null && !major.isEmpty()) {
                queryBuilder.append(" major = ?");
            }
            if (tingkat != null) {
                if (major != null && !major.isEmpty()) {
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
            if (major != null && !major.isEmpty()) {
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

    public Classes getClassById(int id) {
        String query = "SELECT * FROM classes WHERE id = ?";
        Classes classes = null;

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
                classes = new Classes(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("major"),
                        resultSet.getInt("teacher_id"),
                        resultSet.getInt("tingkat")
                );
                logger.debug("Class retrieved: {}", classes);
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return classes;
    }

    public boolean addClass(Classes classes) {
        String query = "INSERT INTO classes (name, major, tingkat) VALUES (?, ?, ?)";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            // Log values before setting parameters
            logger.debug("PreparedStatement values - Name: {}, Major: {}, , Tingkat: {}",
                    classes.getName(), classes.getMajor(), classes.getTingkat());

            preparedStatement.setString(1, classes.getName());
            preparedStatement.setString(2, classes.getMajor());
            preparedStatement.setInt(3, classes.getTingkat());

            logger.debug("Executing query: {}", query);
            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateClass(Classes classes) {
        String query = "UPDATE classes SET name = ?, major = ?, teacher_id = ?, tingkat = ? WHERE id = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setString(1, classes.getName());
            preparedStatement.setString(2, classes.getMajor());
            preparedStatement.setInt(3, classes.getTeacher_id());
            preparedStatement.setInt(4, classes.getTingkat());
            preparedStatement.setInt(5, classes.getId());

            logger.debug("Executing query: {}", query);
            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteClass(int id) {
        String query = "DELETE FROM classes WHERE id = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setInt(1, id);

            logger.debug("Executing query: {}", query);
            int rowsAffected = preparedStatement.executeUpdate();
            logger.info("Rows affected: {}", rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
