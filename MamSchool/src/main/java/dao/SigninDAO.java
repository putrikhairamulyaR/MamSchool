/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import classes.JDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Raisa Lukman Hakim
 */
public class SigninDAO {
    private static final Logger logger = LoggerFactory.getLogger(SigninDAO.class);
    public boolean addUser(User user) {
        String query = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

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
}
