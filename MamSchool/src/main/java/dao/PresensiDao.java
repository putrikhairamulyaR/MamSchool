package dao;

import classes.JDBC;
import java.sql.*;

public class PresensiDao {

    public boolean addKehadiran(int id_siswa, java.util.Date tanggal, String kehadiran) {
        String query = "INSERT INTO attendance (student_id, date, status) VALUES (?, ?, ?)";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id_siswa);
             java.sql.Date releaseDateSql = new java.sql.Date(tanggal.getTime());
            preparedStatement.setDate(2,  releaseDateSql); // Ensure 'tanggal' is java.sql.Date
            preparedStatement.setString(3, kehadiran);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Check for any SQL errors
            return false;
        }
    }

    public boolean editKehadiran(int id_siswa, Date tanggal, String kehadiran) {
        String query = "UPDATE attendance SET status = '" + kehadiran + "' WHERE student_id = " + id_siswa + " AND date = '" + tanggal + "'";
        try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id_siswa);
            preparedStatement.setDate(2, tanggal);
            preparedStatement.setString(3, kehadiran);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
