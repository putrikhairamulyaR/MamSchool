/**
 *
 * @author Necha
 */
package dao;

import classes.JDBC;
import model.Jadwal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import classes.JDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import model.Jadwal;

public class JadwalDAO {

    public boolean addJadwal(Jadwal jadwal) {
        String sql = "INSERT INTO class_schedule (class_id, subject_id, teacher_id, day, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?)";

        
        try (Connection connection = JDBC.getConnection()) {  
            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false; 
            }
             
             int classId=getKelasId(jadwal.getKelas());
          
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, classId); 
                statement.setInt(2, jadwal.getSubjectId()); 
                statement.setInt(3, jadwal.getTeacherId()); 
                statement.setString(4, jadwal.getDay()); 
                statement.setTime(5, Time.valueOf(jadwal.getStartTime())); 
                statement.setTime(6, Time.valueOf(jadwal.getEndTime())); 

                
                return statement.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read a Jadwal by ID
    public Jadwal getJadwalById(int id) {
        String sql = "SELECT * FROM class_schedule WHERE id = ?";

        
        try (Connection connection = JDBC.getConnection(); 
                 PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

    
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapRowToJadwal(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();         }
        return null;
    }
     
    
    public int getKelasId(String name) {
        String sql = "SELECT id FROM classes WHERE name = ?";
        
        try (Connection connection = JDBC.getConnection(); 
                 PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name);


            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return 0; 
    }

   
    public List<Jadwal> getAllJadwals() {
        List<Jadwal> jadwals = new ArrayList<>();
        String sql = "SELECT * FROM class_schedule";

       
        try (Connection connection = JDBC.getConnection(); 
                 Statement statement = connection.createStatement(); ResultSet resultSet = statement.executeQuery(sql)) {

           
            while (resultSet.next()) {
                jadwals.add(mapRowToJadwal(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();  
        }

        return jadwals;  
    }

    
    public boolean updateJadwal(Jadwal jadwal) {
    String sql = "UPDATE class_schedule SET class_id = ?, subject_id = ?, teacher_id = ?, day = ?, start_time = ?, end_time = ? WHERE id = ?";
    
   
    try (Connection connection = JDBC.getConnection();  
         PreparedStatement statement = connection.prepareStatement(sql)) {
        
       
        statement.setString(1, jadwal.getKelas());
        statement.setInt(2, jadwal.getSubjectId());
        statement.setInt(3, jadwal.getTeacherId());
        statement.setString(4, jadwal.getDay());
        statement.setTime(5, Time.valueOf(jadwal.getStartTime()));
        statement.setTime(6, Time.valueOf(jadwal.getEndTime()));
        statement.setInt(7, jadwal.getId());
        
       
        return statement.executeUpdate() > 0;  
    } catch (SQLException e) {
        e.printStackTrace();  
        return false;  
    }
}


  
    public boolean deleteJadwal(int id) {
    String sql = "DELETE FROM class_schedule WHERE id = ?";
    
  
    try (Connection connection = JDBC.getConnection(); 
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setInt(1, id); 
        
        
        return statement.executeUpdate() > 0;
        
    } catch (SQLException e) {
        e.printStackTrace();  
        return false;  
    }
}

    private Jadwal mapRowToJadwal(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String kelas = resultSet.getString("class_id");
        int subjectId = resultSet.getInt("subject_id");
        int teacherId = resultSet.getInt("teacher_id");
        String day = resultSet.getString("day");
        Time startTime = resultSet.getTime("start_time");
        Time endTime = resultSet.getTime("end_time");

       
        return new Jadwal(id, kelas, subjectId, teacherId, day, startTime.toLocalTime(), endTime.toLocalTime());
    }
    
    public int getTeacherId(String nip) throws SQLException {
    String sql = "SELECT id FROM teachers WHERE nip = ?";

   
    try (Connection connection = JDBC.getConnection(); 
         PreparedStatement stmt = connection.prepareStatement(sql)) {

        stmt.setString(1, nip);
        
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("id"); 
            } else {
                throw new SQLException("Teacher not found with NIP: " + nip); 
            }
        }
    }
}


}

