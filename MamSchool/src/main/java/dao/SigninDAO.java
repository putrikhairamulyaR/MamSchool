/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class SigninDAO {

    private static final Logger logger = LoggerFactory.getLogger(SigninDAO.class);

    public List<User> getAllUser() {
        List<User> usersList = new ArrayList<>();
        String query = "SELECT * FROM users";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet resultSet = preparedStatement.executeQuery()) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return usersList;
            }

            logger.debug("Fetching all classes...");
            logger.debug("Query executed: {}", query);

            while (resultSet.next()) {
                logger.debug("Processing row with ID: {}", resultSet.getInt("id"));
                User user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("role")
                );
                usersList.add(user);
                logger.debug("User added to list: {}", user);
            }

            logger.info("Total user retrieved: {}", usersList.size());

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return usersList;
    }

    public User getUserById(int id) {
        String query = "SELECT * FROM users WHERE id = ?";
        User user = null;

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
                user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("role")
                );
                logger.debug("User retrieved: {}", user);
            }

        } catch (SQLException e) {
            logger.error("SQL Error: {}", e.getMessage());
            e.printStackTrace();
        }

        return user;
    }

    public boolean deleteClass(int id) {
        String query = "DELETE FROM users WHERE id = ?";

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

    public boolean addUser(User user) {
        String query = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            // Log values before setting parameters
            logger.debug("PreparedStatement values - Username: {}, Password: {}, Role: {}",
                    user.getUsername(), user.getPassword(), user.getRole());

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getRole());

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

    public boolean updateUser(User user) {
        String query = "UPDATE users SET username = ?, password = ?, role = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                logger.warn("Failed to establish database connection.");
                return false;
            }

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getRole());
            preparedStatement.setInt(4, user.getId());

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
