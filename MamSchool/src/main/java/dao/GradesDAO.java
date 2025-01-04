/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.nilai;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Classes;

/**
 *
 * @author Royal
 */
public class GradesDAO {

    public Classes getClassByName(String className) {
        Classes kelas = null;
        String query = "SELECT * FROM classes WHERE name = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, className);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                kelas = new Classes();
                kelas.setId(rs.getInt("id")); // Sesuaikan dengan kolom tabel `classes`
                kelas.setName(rs.getString("name")); // Kolom nama di tabel `classes`
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return kelas;
    }

    // Ambil semua nilai berdasarkan kelas
    public List<nilai> getGradesByClass(String className) {
        List<nilai> gradeList = new ArrayList<>();
        String query = (className == null || className.isEmpty())
                ? "SELECT g.id_nilai, g.nis, g.nama_siswa, g.kelas, g.uts, g.uas, g.tugas, g.grade, g.kategori FROM grades g"
                : "SELECT g.id_nilai, g.nis, g.nama_siswa, g.kelas, g.uts, g.uas, g.tugas, g.grade, g.kategori FROM grades g WHERE g.kelas = ?";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            if (className != null && !className.isEmpty()) {
                stmt.setString(1, className); // Set parameter jika ada filter kelas
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                nilai grade = new nilai();
                grade.setIdNilai(rs.getInt("id_nilai"));
                grade.setNis(rs.getString("nis"));
                grade.setName(rs.getString("nama_siswa"));
                grade.setKelas(getClassByName(rs.getString("kelas"))); // Jika kelas adalah objek
                grade.setUts(rs.getDouble("uts"));
                grade.setUas(rs.getDouble("uas"));
                grade.setTugas(rs.getDouble("tugas"));
                grade.setGrade(rs.getDouble("grade"));
                grade.setKategori();
                gradeList.add(grade);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return gradeList;
    }

    public List<String> getAllClasses() {
        List<String> classList = new ArrayList<>();
        String query = "SELECT name FROM classes";

        try (Connection connection = JDBC.getConnection(); PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                classList.add(rs.getString("name"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return classList;
    }

}
