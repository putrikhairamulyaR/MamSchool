/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
/**
 *
 * @author Dafi Utomo
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DashboardKepsekDAO {

    private static final Logger logger = Logger.getLogger(DashboardKepsekDAO.class.getName());

    public int getTotalSiswa() {
        String query = "SELECT COUNT(*) AS total FROM students";
        logger.log(Level.INFO, "Executing getTotalSiswa query: {0}", query);
        return getTotal(query);
    }

    public int getTotalGuru() {
        String query = "SELECT COUNT(*) AS total FROM teachers";
        logger.log(Level.INFO, "Executing getTotalGuru query: {0}", query);
        return getTotal(query);
    }

    public int getTotalKelas() {
        String query = "SELECT COUNT(*) AS total FROM classes";
        logger.log(Level.INFO, "Executing getTotalKelas query: {0}", query);
        return getTotal(query);
    }

    public int getTotalUsers() {
        String query = "SELECT COUNT(*) AS total FROM users";
        logger.log(Level.INFO, "Executing getTotalUsers query: {0}", query);
        return getTotal(query);
    }

    public int getTotalRole(String role) {
        String query = "SELECT COUNT(*) AS total FROM users WHERE role = ?";
        logger.log(Level.INFO, "Executing getTotalRole query: {0} with role: {1}", new Object[]{query, role});
        int total = 0;

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getTotalRole", e);
        }

        return total;
    }

    public Map<String, Integer> getSiswaPerKelas() {
        String query = "SELECT class_name, COUNT(*) AS total FROM students GROUP BY class_name";
        logger.log(Level.INFO, "Executing getSiswaPerKelas query: {0}", query);
        Map<String, Integer> siswaPerKelas = new HashMap<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                siswaPerKelas.put(rs.getString("class_name"), rs.getInt("total"));
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getSiswaPerKelas", e);
        }

        return siswaPerKelas;
    }

    public List<Double> getRataRataKehadiranBulanan() {
        String query = "SELECT AVG(attendance) AS rata_rata FROM attendance_records GROUP BY MONTH(date)";
        logger.log(Level.INFO, "Executing getRataRataKehadiranBulanan query: {0}", query);
        List<Double> rataRata = new ArrayList<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                rataRata.add(rs.getDouble("rata_rata"));
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getRataRataKehadiranBulanan", e);
        }

        return rataRata;
    }

    public List<String> getJadwalKegiatan() {
        String query = "SELECT event_name, event_date FROM school_events ORDER BY event_date ASC";
        logger.log(Level.INFO, "Executing getJadwalKegiatan query: {0}", query);
        List<String> kegiatan = new ArrayList<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                kegiatan.add(rs.getString("event_name") + " - " + rs.getDate("event_date"));
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getJadwalKegiatan", e);
        }

        return kegiatan;
    }

    public List<String> getJadwalPelajaranHariIni() {
        String query = "SELECT c.name AS class_name, s.name AS subject_name, cs.start_time, cs.end_time "
                + "FROM class_schedule cs "
                + "JOIN classes c ON cs.class_id = c.id "
                + "JOIN subjects s ON cs.subject_id = s.id "
                + "WHERE cs.day = DAYNAME(CURDATE()) "
                + "ORDER BY cs.start_time";
        List<String> jadwal = new ArrayList<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                jadwal.add(rs.getString("class_name") + " - " + rs.getString("subject_name") + " ("
                        + rs.getTime("start_time") + " - " + rs.getTime("end_time") + ")");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getJadwalPelajaranHariIni", e);
        }

        return jadwal;
    }

    public Map<String, Double> getRataRataNilaiPerKelas() {
    String query = "SELECT c.name AS class_name, AVG(g.grade) AS rata_rata " +
                   "FROM grades g " +
                   "JOIN classes c ON g.class_id = c.id " +
                   "GROUP BY c.name";
    Map<String, Double> rataRataNilai = new HashMap<>();

    try (Connection connection = JDBC.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            rataRataNilai.put(rs.getString("class_name"), rs.getDouble("rata_rata"));
        }

    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error in getRataRataNilaiPerKelas", e);
    }

    return rataRataNilai;
}


    public Map<String, Integer> getDistribusiPengguna() {
        String query = "SELECT role, COUNT(*) AS total FROM users GROUP BY role";
        logger.log(Level.INFO, "Executing getDistribusiPengguna query: {0}", query);
        Map<String, Integer> distribusiPengguna = new HashMap<>();

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                distribusiPengguna.put(rs.getString("role"), rs.getInt("total"));
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getDistribusiPengguna", e);
        }

        return distribusiPengguna;
    }

    private int getTotal(String query) {
        logger.log(Level.INFO, "Executing getTotal query: {0}", query);
        int total = 0;

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getTotal", e);
        }

        return total;
    }
}
