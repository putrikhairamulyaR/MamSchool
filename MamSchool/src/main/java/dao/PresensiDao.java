package dao;

import classes.JDBC;
import java.sql.*;

public class PresensiDao {
    public boolean addKehadiran(int id_siswa, Date tanggal, String kehadiran){
        String query = "insert into attendance (student_id, date, status) VALUES (?, ?, ?)";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }
            
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id_siswa);
            preparedStatement.setDate(2, tanggal);
            preparedStatement.setString(3, kehadiran);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
