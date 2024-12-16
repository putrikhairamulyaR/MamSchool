package dao;

import classes.JDBC;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
                   "JOIN classes c ON g.kelas = c.id " +
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

    // Metode untuk menambahkan nilai siswa
   public boolean setNilaiSiswa(double uts, double uas, double tugas) {
        // Query untuk memasukkan nilai ke tabel grades
        String query = "INSERT INTO grades (nis, nama_siswa, kelas, uts, uas, tugas, grade, kategori) " +
                       "SELECT s.nis, s.name, c.name, ?, ?, ?, ?, ? " +
                       "FROM students s " +
                       "JOIN classes c ON s.class_id = c.id " +
                       "WHERE s.nis = ? AND c.name = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }

            // Hitung grade dan tentukan kategori
                nilai grade = new nilai(); 
                double total = grade.calculateTotal(uts, uas, tugas);
                String kategori = total > 50 ? "lulus" : "tidak lulus";
                grade.setIdNilai(grade.getIdNilai());
                grade.setNis(grade.getNis());
                grade.setName(grade.getName());
                grade.setUts(uts);
                grade.setUas(uas);
                grade.setTugas(tugas);
                grade.setGrade(total);
                grade.setKategori(kategori);

     
            // Persiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, grade.getIdNilai());
            preparedStatement.setString(2, grade.getName());
            preparedStatement.setString(3, grade.getNis());
            preparedStatement.setDouble(4, uts);
            preparedStatement.setDouble(5, uas);
            preparedStatement.setDouble(6, tugas); 
            preparedStatement.setDouble(7, total);
            preparedStatement.setString(8, kategori); 

            // Eksekusi query
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Data berhasil ditambahkan.");
                return true;
            } else {
                System.out.println("Gagal menambahkan data.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean updateNilaiSiswa(double uts, double uas, double tugas) {
        String query = "UPDATE grades g " +
                             "JOIN students s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "SET g.uts = ?, g.uas = ?, g.tugas = ?, g.grade = ? " +
                             "WHERE s.nis = ? AND c.name = ?";

         Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }

            // Hitung grade dan tentukan kategori
                nilai grade = new nilai(); 
                double total = grade.calculateTotal(uts, uas, tugas);
                String kategori = total > 50 ? "lulus" : "tidak lulus";
                grade.setIdNilai(grade.getIdNilai());
                grade.setNis(grade.getNis());
                grade.setName(grade.getName());
                grade.setUts(uts);
                grade.setUas(uas);
                grade.setTugas(tugas);
                grade.setGrade(total);
                grade.setKategori(kategori);

     
            // Persiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, grade.getIdNilai());
            preparedStatement.setString(2, grade.getName());
            preparedStatement.setString(3, grade.getNis());
            preparedStatement.setDouble(4, uts);
            preparedStatement.setDouble(5, uas);
            preparedStatement.setDouble(6, tugas); 
            preparedStatement.setDouble(7, total);
            preparedStatement.setString(8, kategori); 

            // Eksekusi query
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Data berhasil diupdate.");
                return true;
            } else {
                System.out.println("Gagal mengedit data.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public boolean deleteNilaiSiswa(int id) {
        String query = "DELETE g FROM grades g " +
                             "JOIN students s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "WHERE s.nis = ? AND c.name = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting nilai siswa: " + e.getMessage());
            return false;
        }
   }



}
