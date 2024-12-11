package dao;

import classes.JDBC;
import java.sql.*;
/**
 *
 * @author Raisa Lukman Hakim
 */

public class BagiKelasDAO {
    // Metode untuk menghitung jumlah siswa yang sudah punya kelas
    public int countStudentsHasClass(String tingkat, String major) {
        String query = "SELECT COUNT(*) " +
                       "FROM students " +
                       "WHERE (YEAR(CURRENT_DATE) - enrollment_year = " +
                       "        CASE " +
                       "            WHEN ? = 'X' THEN 1 " +
                       "            WHEN ? = 'XI' THEN 2 " +
                       "            WHEN ? = 'XII' THEN 3 " +
                       "        END) " +
                       "AND major = ? " +
                       "AND class_id IS NOT NULL";
        return executeCountQuery(query, tingkat, major);
    }

    // Metode untuk menghitung jumlah siswa yang belum punya kelas
    public int countStudentsNoClass(String tingkat, String major) {
        String query = "SELECT COUNT(*) " +
                       "FROM students " +
                       "WHERE (YEAR(CURRENT_DATE) - enrollment_year = " +
                       "        CASE " +
                       "            WHEN ? = 'X' THEN 1 " +
                       "            WHEN ? = 'XI' THEN 2 " +
                       "            WHEN ? = 'XII' THEN 3 " +
                       "        END) " +
                       "AND major = ? " +
                       "AND class_id IS NULL";
        return executeCountQuery(query, tingkat, major);
    }

    // Fungsi umum untuk menjalankan query menghitung jumlah siswa
    private int executeCountQuery(String query, String tingkat, String major) {
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            if (connection == null) {
                throw new SQLException("Failed to establish a database connection.");
            }

            preparedStatement.setString(1, tingkat);
            preparedStatement.setString(2, tingkat);
            preparedStatement.setString(3, tingkat);
            preparedStatement.setString(4, major);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error executing count query: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
}