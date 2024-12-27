/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.rapot;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author luthfiah
 */
public class rapotDAO {
    // View seluruh rapot siswa berdasarkan kelas
    public List<rapot> viewRapotByClass(String className) {
        List<rapot> rapotList = new ArrayList<>();
        String query = "SELECT r.id_rapot, s.nis, s.name AS nama_siswa, r.biologi, r.kimia, r.matematika, r.fisika, " +
                       "r.inggris, r.ekonomi, r.sejarah, r.geografi, r.rata_rata, r.kategori " +
                       "FROM rapot r " +
                       "JOIN students s ON r.nis = s.nis " +
                       "JOIN classes c ON s.class_id = c.id " +
                       "WHERE c.name = ? " +
                       "ORDER BY s.name";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, className);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    rapot rapot = new rapot();
                    rapot.setIdRapot(rs.getInt("id_rapot"));
                    rapot.setNis(rs.getString("nis"));
                    rapot.setNama(rs.getString("nama_siswa"));
                    rapot.setBiologi(rs.getDouble("biologi"));
                    rapot.setKimia(rs.getDouble("kimia"));
                    rapot.setMatematika(rs.getDouble("matematika"));
                    rapot.setFisika(rs.getDouble("fisika"));
                    rapot.setInggris(rs.getDouble("inggris"));
                    rapot.setEkonomi(rs.getDouble("ekonomi"));
                    rapot.setSejarah(rs.getDouble("sejarah"));
                    rapot.setGeografi(rs.getDouble("geografi"));
                    rapot.setRataRata(rs.getDouble("rata_rata"));
                    rapot.setKategori(rs.getString("kategori"));

                    rapotList.add(rapot);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rapotList;
    }
    
    // Get rapot siswa berdasarkan ID
    public rapot getRapotById(int id) {
        String query = "SELECT r.id_rapot, s.nis, s.name AS nama_siswa, r.biologi, r.kimia, r.matematika, r.fisika, " +
                       "r.inggris, r.ekonomi, r.sejarah, r.geografi, r.rata_rata, r.kategori " +
                       "FROM rapot r " +
                       "JOIN students s ON r.nis = s.nis " +
                       "WHERE r.id_rapot = ?";
        rapot rapot = null;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    rapot = new rapot();
                    rapot.setIdRapot(rs.getInt("id_rapot"));
                    rapot.setNis(rs.getString("nis"));
                    rapot.setNama(rs.getString("nama_siswa"));
                    rapot.setBiologi(rs.getDouble("biologi"));
                    rapot.setKimia(rs.getDouble("kimia"));
                    rapot.setMatematika(rs.getDouble("matematika"));
                    rapot.setFisika(rs.getDouble("fisika"));
                    rapot.setInggris(rs.getDouble("inggris"));
                    rapot.setEkonomi(rs.getDouble("ekonomi"));
                    rapot.setSejarah(rs.getDouble("sejarah"));
                    rapot.setGeografi(rs.getDouble("geografi"));
                    rapot.setRataRata(rs.getDouble("rata_rata"));
                    rapot.setKategori(rs.getString("kategori"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rapot;
    }
    
    // Set rapot siswa
    public boolean setRapotSiswa(String nis, double biologi, double kimia, double matematika, double fisika, double inggris,
                                 double ekonomi, double sejarah, double geografi) {
        String query = "INSERT INTO rapot (nis, biologi, kimia, matematika, fisika, inggris, ekonomi, sejarah, geografi, rata_rata, kategori) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Hitung rata-rata dan tentukan kategori
            rapot rapot = new rapot();
            rapot.setNis(nis);
            rapot.setBiologi(biologi);
            rapot.setKimia(kimia);
            rapot.setMatematika(matematika);
            rapot.setFisika(fisika);
            rapot.setInggris(inggris);
            rapot.setEkonomi(ekonomi);
            rapot.setSejarah(sejarah);
            rapot.setGeografi(geografi);
            rapot.hitungRataRata();
            rapot.tentukanKategori();

            // Isi parameter query
            stmt.setString(1, nis);
            stmt.setDouble(2, biologi);
            stmt.setDouble(3, kimia);
            stmt.setDouble(4, matematika);
            stmt.setDouble(5, fisika);
            stmt.setDouble(6, inggris);
            stmt.setDouble(7, ekonomi);
            stmt.setDouble(8, sejarah);
            stmt.setDouble(9, geografi);
            stmt.setDouble(10, rapot.getRataRata());
            stmt.setString(11, rapot.getKategori());

            // Eksekusi query
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}