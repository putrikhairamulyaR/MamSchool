
/**
 *
 * @author DELL
 */
package dao;

import model.Jadwal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JadwalDAO {
    private Connection connection;

    public JadwalDAO(Connection connection) {
        this.connection = connection;
    }

    // Create a new Jadwal
    public void addJadwal(Jadwal jadwal) throws SQLException {
        String sql = "INSERT INTO jadwal (kelas, subjectId, teacherId, day, startTime, endTime) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, jadwal.getKelas());
            statement.setInt(2, jadwal.getSubjectId());
            statement.setInt(3, jadwal.getTeacherId());
            statement.setString(4, jadwal.getDay());
            statement.setTime(5, Time.valueOf(jadwal.getStartTime()));
            statement.setTime(6, Time.valueOf(jadwal.getEndTime()));
            statement.executeUpdate();
        }
    }

    // Read a Jadwal by ID
    public Jadwal getJadwalById(int id) throws SQLException {
        String sql = "SELECT * FROM jadwal WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return mapRowToJadwal(resultSet);
            }
        }
        return null;
    }

    // Read all Jadwals
    public List<Jadwal> getAllJadwals() throws SQLException {
        List<Jadwal> jadwals = new ArrayList<>();
        String sql = "SELECT * FROM jadwal";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                jadwals.add(mapRowToJadwal(resultSet));
            }
        }
        return jadwals;
    }

    // Update a Jadwal
    public void updateJadwal(Jadwal jadwal) throws SQLException {
        String sql = "UPDATE jadwal SET kelas = ?, subjectId = ?, teacherId = ?, day = ?, startTime = ?, endTime = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, jadwal.getKelas());
            statement.setInt(2, jadwal.getSubjectId());
            statement.setInt(3, jadwal.getTeacherId());
            statement.setString(4, jadwal.getDay());
            statement.setTime(5, Time.valueOf(jadwal.getStartTime()));
            statement.setTime(6, Time.valueOf(jadwal.getEndTime()));
            statement.setInt(7, jadwal.getId());
            statement.executeUpdate();
        }
    }

    // Delete a Jadwal
    public void deleteJadwal(int id) throws SQLException {
        String sql = "DELETE FROM jadwal WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // Helper method to map ResultSet to Jadwal object
    private Jadwal mapRowToJadwal(ResultSet resultSet) throws SQLException {
        Jadwal jadwal = new Jadwal();
        jadwal.setId(resultSet.getInt("id"));
        jadwal.setKelas(resultSet.getString("kelas"));
        jadwal.setSubjectId(resultSet.getInt("subjectId"));
        jadwal.setTeacherId(resultSet.getInt("teacherId"));
        jadwal.setDay(resultSet.getString("day"));
        jadwal.setStartTime(resultSet.getTime("startTime").toLocalTime());
        jadwal.setEndTime(resultSet.getTime("endTime").toLocalTime());
        return jadwal;
    }
}