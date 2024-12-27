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
    public rapot getRapot(String nis) {
    String query = """
        SELECT 
            students.name AS nama_siswa,
            students.class_id AS kelas,
            students.nis,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Matematika' THEN grades.rata2 ELSE 0 END), 0) AS matematika,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Geografi' THEN grades.rata2 ELSE 0 END), 0) AS geografi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Biologi' THEN grades.rata2 ELSE 0 END), 0) AS biologi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Fisika' THEN grades.rata2 ELSE 0 END), 0) AS fisika,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Kimia' THEN grades.rata2 ELSE 0 END), 0) AS kimia,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Ekonomi' THEN grades.rata2 ELSE 0 END), 0) AS ekonomi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Sejarah' THEN grades.rata2 ELSE 0 END), 0) AS sejarah,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Inggris' THEN grades.rata2 ELSE 0 END), 0) AS inggris
        FROM 
            students
        LEFT JOIN 
            grades ON grades.nis = students.nis
        LEFT JOIN 
            teachers ON grades.idGuru = teachers.id
        WHERE 
            students.nis = ?
        GROUP BY 
            students.name, students.class_id, students.nis;
    """;

    try (Connection connection = JDBC.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query)) {

        // Set parameter query
        stmt.setString(1, nis);

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                // Buat objek rapot
                rapot rapot = new rapot();
                rapot.setNama(rs.getString("nama_siswa"));
                rapot.setKelas(rs.getString("kelas"));
                rapot.setNis(rs.getString("nis"));
                rapot.setMatematika(rs.getDouble("matematika"));
                rapot.setGeografi(rs.getDouble("geografi"));
                rapot.setBiologi(rs.getDouble("biologi"));
                rapot.setFisika(rs.getDouble("fisika"));
                rapot.setKimia(rs.getDouble("kimia"));
                rapot.setEkonomi(rs.getDouble("ekonomi"));
                rapot.setSejarah(rs.getDouble("sejarah"));
                rapot.setInggris(rs.getDouble("inggris"));

                // Hitung rata-rata dari semua nilai
                double rataRata = (rapot.getMatematika() + rapot.getGeografi() + rapot.getBiologi() +
                                   rapot.getFisika() + rapot.getKimia() + rapot.getEkonomi() +
                                   rapot.getSejarah() + rapot.getInggris()) / 8.0;
                rapot.setRataRata(rataRata);

                // Return objek rapot
                return rapot;
            } else {
                System.out.println("Data tidak ditemukan untuk NIS: " + nis);
                return null; // Tidak ditemukan
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return null; // Error terjadi
    }
}


}