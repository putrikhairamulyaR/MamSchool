package dao;

import classes.JDBC;
import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import model.Classes;
import model.Jadwal;

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
    
    public List<Classes> getClassByTeacherId(int id) {
        String query = "SELECT * FROM classes WHERE teacher_id = ?";
        Classes classes = null;
        List<Classes>listClass=new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                classes = new Classes(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("major"),
                        resultSet.getInt("teacher_id"),
                        resultSet.getInt("tingkat")
                );
                listClass.add(classes);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listClass;
    }
    
    public List<Jadwal> getAllJadwalByTeacherId(int teacherId) {
    String query = "SELECT s.id, s.class_id, c.name AS class_name, c.major, c.tingkat, " +
                   "s.subject_id, subj.name AS subject_name, s.teacher_id, s.day, " +
                   "s.start_time, s.end_time " +
                   "FROM class_schedule s " +
                   "JOIN classes c ON s.class_id = c.id " +
                   "JOIN subjects subj ON s.subject_id = subj.id " +
                   "WHERE s.teacher_id = ?";
    List<Jadwal> listJadwal = new ArrayList<>();

    try (Connection connection = JDBC.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

        preparedStatement.setInt(1, teacherId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            Jadwal jadwal = new Jadwal(
                resultSet.getInt("id"),
                resultSet.getInt("class_id"),
                resultSet.getString("class_name"),
                resultSet.getInt("subject_id"),
                resultSet.getString("subject_name"),
                resultSet.getInt("teacher_id"),
                resultSet.getString("day"),
                LocalTime.parse(resultSet.getTime("start_time").toString()),
                LocalTime.parse(resultSet.getTime("end_time").toString())
            );
            listJadwal.add(jadwal);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return listJadwal;
}
    
    public int getTeacherIdByUserId(int userId) {
    int teacherId = -1; // Default value jika tidak ditemukan
    String query = "SELECT teachers.id AS teacher_id FROM teachers "
            + "JOIN users ON teachers.user_id = users.id WHERE users.id = ?";

    try (Connection conn = JDBC.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        // Set parameter userId
        pstmt.setInt(1, userId);

        // Eksekusi query
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            teacherId = rs.getInt("teacher_id");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return teacherId;
}

    

}