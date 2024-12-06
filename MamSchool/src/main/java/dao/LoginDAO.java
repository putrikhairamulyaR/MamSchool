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

    public boolean validateUser(String username, String password) {
        // Query untuk validasi user
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Mendapatkan koneksi dari JDBC
            connection = JDBC.getConnection();
            
            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }

            // Mempersiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            // Eksekusi query
            resultSet = preparedStatement.executeQuery();

            // Jika ada hasil, berarti user valid
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // Tutup resource
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
