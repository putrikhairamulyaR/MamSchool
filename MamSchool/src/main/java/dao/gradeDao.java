package dao;

import classes.JDBC;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Student;
import model.nilai;

/**
 *
 * @author putri
 */
public class gradeDao {

    private Connection connection;


        //view seluruh nilai siswa berdasarkan kelas 
        public List<nilai> viewAllGradesByClass(String className) throws SQLException {
        List<nilai> gradeList = new ArrayList<>();
        String query = "SELECT g.id_nilai,s.nis, s.name AS nama_siswa, g.uts, g.uas, g.tugas, g.grade, g.kategori " +
                       "FROM grades g " +
                       "JOIN students s ON g.nis = s.nis " +
                       "JOIN classes c ON g.kelas = c.name " +
                       "WHERE c.name = ? " +
                       "ORDER BY s.name";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set parameter untuk kelas
            stmt.setString(1, className); 

            // Eksekusi query
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Ambil data dari ResultSet
                    int id_nilai = rs.getInt("id_nilai");
                    String nis = rs.getString("nis");
                    String name = rs.getString("nama_siswa");
                    double uts = rs.getDouble("uts");
                    double uas = rs.getDouble("uas");
                    double tugas = rs.getDouble("tugas");
                    double total = rs.getDouble("grade");
                    String kategori = rs.getString("kategori");

                    // Buat objek nilai dan isi data
                    nilai grade = new nilai();
                    grade.setIdNilai(id_nilai);
                    grade.setNis(nis);
                    grade.setName(name);
                    grade.setUts(uts);
                    grade.setUas(uas);
                    grade.setTugas(tugas);
                    grade.setGrade(total);
                    grade.setKategori(kategori);

                    // Tambahkan ke daftar
                    gradeList.add(grade);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saat mengambil data nilai siswa berdasarkan kelas: " + e.getMessage());
        }
        return gradeList;
    }
}