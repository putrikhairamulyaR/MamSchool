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
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import model.Jadwal;
import model.Teacher;

public class JadwalDAO {

public boolean addJadwal(Jadwal jadwal) {
    String conflictCheckSql = "SELECT * FROM class_schedule WHERE teacher_id = ? AND day = ? AND (start_time < ? AND end_time > ?)";
    
    try (Connection connection = JDBC.getConnection()) {
        if (connection == null) {
            System.out.println("Koneksi database gagal.");
            return false;
        }
        
        
        try (PreparedStatement conflictStatement = connection.prepareStatement(conflictCheckSql)) {
            conflictStatement.setInt(1, jadwal.getTeacherId());
            conflictStatement.setString(2, jadwal.getDay());
            conflictStatement.setTime(3, Time.valueOf(jadwal.getEndTime()));  
            conflictStatement.setTime(4, Time.valueOf(jadwal.getStartTime()));
            
            try (ResultSet resultSet = conflictStatement.executeQuery()) {
                if (resultSet.next()) {
                    System.out.println("Jadwal bentrok dengan jadwal lain.");
                    return false;  
                }
            }
        }

        String sql = "INSERT INTO class_schedule (class_id, subject_id, teacher_id, day, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, jadwal.getidKelas());
            statement.setInt(2, jadwal.getSubjectId());
            statement.setInt(3, jadwal.getTeacherId());
            statement.setString(4, jadwal.getDay());
            statement.setTime(5, Time.valueOf(jadwal.getStartTime()));
            statement.setTime(6, Time.valueOf(jadwal.getEndTime()));
            
            return statement.executeUpdate() > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public boolean checkScheduleConflict(int kelasId, String hari, LocalTime startTime, LocalTime endTime) {
    String query = "SELECT * FROM class_Schedule WHERE class_id = ? AND day = ? AND " +
                   "((startTime <= ? AND endTime > ?) OR " +
                   "(startTime < ? AND endTime >= ?) OR " +
                   "(startTime >= ? AND endTime <= ?))";

    try (Connection conn = JDBC.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setInt(1, kelasId);
        stmt.setString(2, hari);
        stmt.setTime(3, Time.valueOf(startTime));
        stmt.setTime(4, Time.valueOf(startTime));
        stmt.setTime(5, Time.valueOf(endTime));
        stmt.setTime(6, Time.valueOf(endTime));
        stmt.setTime(7, Time.valueOf(startTime));
        stmt.setTime(8, Time.valueOf(endTime));

        ResultSet rs = stmt.executeQuery();
        return rs.next(); 
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



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
        
       
        statement.setInt(1, jadwal.getidKelas());
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
        int idKelas = resultSet.getInt("class_id");
        int subjectId = resultSet.getInt("subject_id");
        int teacherId = resultSet.getInt("teacher_id");
        String day = resultSet.getString("day");
        Time startTime = resultSet.getTime("start_time");
        Time endTime = resultSet.getTime("end_time");

       
        return new Jadwal(id, idKelas, subjectId, teacherId, day, startTime.toLocalTime(), endTime.toLocalTime());
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
                throw new SQLException("Guru tidak ditemukan: " + nip); 
            }
        }
    }
    }
        public Teacher getSubjectByNip(String nip) throws SQLException {
        String sql = "SELECT name, subject FROM teachers WHERE nip = ?";
        Teacher teacher = null;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nip);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setNip(nip);
                    teacher.setName(rs.getString("name"));
                    teacher.setSubject(rs.getString("subject"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Guru dengan mapel tidak ditemukan: " + nip, e);
        }


        return teacher; 

    }
    public List<Teacher> getAllTeachers() {
    List<Teacher> teachers = new ArrayList<>();
    String sql = "SELECT nip,name FROM teachers";

    try (Connection connection = JDBC.getConnection();
         Statement statement = connection.createStatement();
         ResultSet resultSet = statement.executeQuery(sql)) {

        while (resultSet.next()) {
            Teacher teacher = new Teacher();
            teacher.setId(resultSet.getInt("id"));
            teacher.setNip(resultSet.getString("nip"));
            teacher.setName(resultSet.getString("name"));
            teacher.setSubject(resultSet.getString("subject"));
            teachers.add(teacher);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return teachers;
}
public Teacher getTeacherId(int teacherId) {
    String sql = "SELECT * FROM teachers WHERE id = ?";
    Teacher teacher = null;

    try (Connection connection = JDBC.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {
        statement.setInt(1, teacherId);
        try (ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                teacher = new Teacher();
                teacher.setId(resultSet.getInt("id"));
                teacher.setNip(resultSet.getString("nip"));
                teacher.setName(resultSet.getString("name"));
                teacher.setSubject(resultSet.getString("subject"));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return teacher;
}
public boolean isScheduleConflict(int teacherId, String day, LocalTime startTime, LocalTime endTime) {
    String sql = "SELECT * FROM class_schedule WHERE teacher_id = ? AND day = ? AND ((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?))";

    try (Connection connection = JDBC.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {
        
        statement.setInt(1, teacherId);
        statement.setString(2, day);
        statement.setTime(3, Time.valueOf(startTime));
        statement.setTime(4, Time.valueOf(endTime));
        statement.setTime(5, Time.valueOf(startTime));
        statement.setTime(6, Time.valueOf(endTime));
        
        try (ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                return true;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; 
}

}