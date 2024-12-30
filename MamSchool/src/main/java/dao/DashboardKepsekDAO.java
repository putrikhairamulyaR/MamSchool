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

public class DashboardKepsekDAO {

    public int getTotalSiswa() {
        String query = "SELECT COUNT(*) AS total FROM students";
        return getTotal(query);
    }

    public int getTotalGuru() {
        String query = "SELECT COUNT(*) AS total FROM teachers";
        return getTotal(query);
    }

    public int getTotalKelas() {
        String query = "SELECT COUNT(*) AS total FROM classes";
        return getTotal(query);
    }

    public int getTotalUsers() {
        String query = "SELECT COUNT(*) AS total FROM users";
        return getTotal(query);
    }

    // Method untuk menghitung jumlah pengguna berdasarkan role
    public int getTotalRole(String role) {
        String query = "SELECT COUNT(*) AS total FROM users WHERE role = ?";
        int total = 0;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    // Method untuk mendapatkan jumlah siswa per kelas
    public Map<String, Integer> getSiswaPerKelas() {
        String query = "SELECT class_name, COUNT(*) AS total FROM students GROUP BY class_name";
        Map<String, Integer> siswaPerKelas = new HashMap<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                siswaPerKelas.put(rs.getString("class_name"), rs.getInt("total"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return siswaPerKelas;
    }

    // Method untuk rata-rata kehadiran bulanan
    public List<Double> getRataRataKehadiranBulanan() {
        String query = "SELECT AVG(attendance) AS rata_rata FROM attendance_records GROUP BY MONTH(date)";
        List<Double> rataRata = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                rataRata.add(rs.getDouble("rata_rata"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rataRata;
    }

    // Method untuk mendapatkan jadwal kegiatan sekolah
    public List<String> getJadwalKegiatan() {
        String query = "SELECT event_name, event_date FROM school_events ORDER BY event_date ASC";
        List<String> kegiatan = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                kegiatan.add(rs.getString("event_name") + " - " + rs.getDate("event_date"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return kegiatan;
    }

    // Method untuk mendapatkan jadwal pelajaran hari ini
    public List<String> getJadwalPelajaranHariIni() {
        String query = "SELECT subject_name, class_name, start_time, end_time FROM schedules WHERE DATE(date) = CURDATE()";
        List<String> jadwal = new ArrayList<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                jadwal.add(rs.getString("class_name") + " - " + rs.getString("subject_name") + " (" +
                        rs.getTime("start_time") + " - " + rs.getTime("end_time") + ")");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jadwal;
    }

    // Method untuk mendapatkan nilai rata-rata per kelas
    public Map<String, Double> getRataRataNilaiPerKelas() {
        String query = "SELECT class_name, AVG(grade) AS rata_rata FROM grades GROUP BY class_name";
        Map<String, Double> rataRataNilai = new HashMap<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                rataRataNilai.put(rs.getString("class_name"), rs.getDouble("rata_rata"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rataRataNilai;
    }

    // Method untuk distribusi pengguna berdasarkan role
    public Map<String, Integer> getDistribusiPengguna() {
        String query = "SELECT role, COUNT(*) AS total FROM users GROUP BY role";
        Map<String, Integer> distribusiPengguna = new HashMap<>();

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                distribusiPengguna.put(rs.getString("role"), rs.getInt("total"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return distribusiPengguna;
    }

    // Helper method untuk menjalankan query COUNT
    private int getTotal(String query) {
        int total = 0;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }
}

