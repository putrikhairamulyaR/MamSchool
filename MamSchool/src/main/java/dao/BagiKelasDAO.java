package dao;

import classes.JDBC;
import java.sql.*;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {

    // Metode untuk menghitung jumlah kelas berdasarkan tingkat dan jurusan
    public int countClassesByTingkatAndMajor(String tingkat, String major) {
        String query = "SELECT COUNT(*) FROM classes WHERE name LIKE ? AND major = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return count;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, tingkat + "%"); // Filter tingkat, misalnya 'X%'
            preparedStatement.setString(2, major);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1); // Ambil jumlah kelas
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }

    // Metode untuk menghitung jumlah siswa berdasarkan tingkat dan jurusan
    public int countStudentsByTingkatAndMajor(String tingkat, String major) {
        String query = "SELECT COUNT(*) FROM students s "
                     + "JOIN classes c ON s.class_id = c.id "
                     + "WHERE c.name LIKE ? AND c.major = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return count;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, tingkat + "%"); // Filter tingkat, misalnya 'X%'
            preparedStatement.setString(2, major);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1); // Ambil jumlah siswa
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }
}