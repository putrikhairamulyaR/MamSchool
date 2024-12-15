package dao;

import classes.JDBC;
import java.sql.*;

public class PresensiDao {
    public boolean addKehadiran(int id_siswa, Date tanggal, String kehadiran){
        String query = "insert into attendance (student_id, date, status) VALUES (?, ?, ?)";
        try (Connection connection = JDBC.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id_siswa); 
            preparedStatement.setDate(2, tanggal); 
            preparedStatement.setString(3, kehadiran); 

            return preparedStatement.executeUpdate() > 0; // Mengembalikan true jika berhasil
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Mengembalikan false jika terjadi kesalahan
        }
    }
    
    public boolean editKehadiran(int id_siswa, Date tanggal, String kehadiran){
        String query = "update attendance set status";
        try (Connection connection = JDBC.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id_siswa); 
            preparedStatement.setDate(2, tanggal); 
            preparedStatement.setString(3, kehadiran); 

            return preparedStatement.executeUpdate() > 0; // Mengembalikan true jika berhasil
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Mengembalikan false jika terjadi kesalahan
        }
    }
}
