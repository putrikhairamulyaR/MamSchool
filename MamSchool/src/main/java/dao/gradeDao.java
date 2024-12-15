package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author putri
 */
public class gradeDao {
    private Connection connection;

    // Constructor untuk inisialisasi koneksi database
    public gradeDao(Connection connection) {
        this.connection = connection;
    }

    // Metode untuk menambahkan nilai siswa
    public boolean setNilaiSiswa(String nim, String className, double uts, double uas, double tugas) {
        boolean isSuccess = false;

        // Query untuk mengambil ID kelas berdasarkan className dan memvalidasi nim
        String queryFetch = "SELECT s.name AS student_name, c.id AS class_id " +
                            "FROM students s " +
                            "JOIN classes c ON s.class_id = c.id " +
                            "WHERE s.nis = ? AND c.name = ?";
        
        // Query untuk memasukkan nilai ke tabel grades
        String queryInsert = "INSERT INTO grades (nis, name, class_id, uts, uas, tugas, total) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
            PreparedStatement fetchStmt = connection.prepareStatement(queryFetch);
            PreparedStatement insertStmt = connection.prepareStatement(queryInsert)
        ) {
            // Step 1: Validasi dan ambil data yang diperlukan
            fetchStmt.setString(1, nim);
            fetchStmt.setString(2, className);

            ResultSet resultSet = fetchStmt.executeQuery();
            if (!resultSet.next()) {
                System.err.println("Data tidak ditemukan untuk nim: " + nim + " dan kelas: " + className);
                return false;
            }

            String studentName = resultSet.getString("student_name");
            int classId = resultSet.getInt("class_id");

            // Step 2: Hitung total nilai
            double total = (uts * 0.3) + (uas * 0.4) + (tugas * 0.3);

            // Step 3: Masukkan data ke tabel grades
            insertStmt.setString(1, nim);
            insertStmt.setString(2, studentName);
            insertStmt.setInt(3, classId);
            insertStmt.setDouble(4, uts);
            insertStmt.setDouble(5, uas);
            insertStmt.setDouble(6, tugas);
            insertStmt.setDouble(7, total);

            int rowsAffected = insertStmt.executeUpdate();
            isSuccess = rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error saat memasukkan nilai siswa: " + e.getMessage());
        }

        return isSuccess;
    }
    public boolean updateNilaiSiswa(String nim, String className, double uts, double uas, double tugas) {
        String queryUpdate = "UPDATE grades g " +
                             "JOIN student s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "SET g.uts = ?, g.uas = ?, g.tugas = ?, g.total = ? " +
                             "WHERE s.nim = ? AND c.class_name = ?";

        try (PreparedStatement stmt = connection.prepareStatement(queryUpdate)) {
            double total = (uts * 0.3) + (uas * 0.4) + (tugas * 0.3);
            stmt.setDouble(1, uts);
            stmt.setDouble(2, uas);
            stmt.setDouble(3, tugas);
            stmt.setDouble(4, total);
            stmt.setString(5, nim);
            stmt.setString(6, className);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating nilai siswa: " + e.getMessage());
            return false;
        }
    }
    public boolean deleteNilaiSiswa(String nim, String className) {
        String queryDelete = "DELETE g FROM grades g " +
                             "JOIN student s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "WHERE s.nim = ? AND c.class_name = ?";

        try (PreparedStatement stmt = connection.prepareStatement(queryDelete)) {
            stmt.setString(1, nim);
            stmt.setString(2, className);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting nilai siswa: " + e.getMessage());
            return false;
        }
   }


}
