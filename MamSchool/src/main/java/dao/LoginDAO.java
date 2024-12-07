/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import java.sql.*;

/**
 *
 * @author Dafi Utomo
 */
public class LoginDAO {

    public String getUserRole(String username, String password) {
        String query = "SELECT role FROM users WHERE username = ? AND password = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return null;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getString("role"); 
            } else {
                return null; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}