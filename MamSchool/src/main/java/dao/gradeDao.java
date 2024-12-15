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
    //view seluruh nilai siswa berdasarkan kelas 
    public void viewAllGradesByClass(String className) {
        String query = "SELECT s.nis, s.name AS student_name, g.uts, g.uas, g.tugas, g.grade " +
                       "FROM grades g " +
                       "JOIN students s ON g.nis = s.nis " +
                       "JOIN classes c ON g.class_id = c.id " +
                       "WHERE c.name = ? " +
                       "ORDER BY s.name";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            // Set parameter untuk nama kelas
            stmt.setString(1, className);

            // Eksekusi query dan tampilkan hasil
            ResultSet resultSet = stmt.executeQuery();
            System.out.printf("%-10s %-25s %-10s %-10s %-10s %-10s%n", 
                              "NIS", "Nama Siswa", "UTS", "UAS", "Tugas", "Total Grade");
            System.out.println("===============================================================");
            while (resultSet.next()) {
                String nis = resultSet.getString("nis");
                String studentName = resultSet.getString("student_name");
                double uts = resultSet.getDouble("uts");
                double uas = resultSet.getDouble("uas");
                double tugas = resultSet.getDouble("tugas");
                double grade = resultSet.getDouble("grade");

                // Buat nampilin
                System.out.printf("%-10s %-25s %-10.2f %-10.2f %-10.2f %-10.2f%n", 
                                  nis, studentName, uts, uas, tugas, grade);
            }
        } catch (SQLException e) {
            System.err.println("Error saat mengambil data nilai siswa berdasarkan kelas: " + e.getMessage());
        }
    }

    // Metode untuk menambahkan nilai siswa
    public boolean setNilaiSiswa(String nis, String className, double uts, double uas, double tugas) {
        boolean isSuccess = false;

        // Query untuk mengambil ID kelas berdasarkan className dan memvalidasi nim
        String queryFetch = "SELECT s.name AS student_name, c.id AS class_id " +
                            "FROM students s " +
                            "JOIN classes c ON s.class_id = c.id " +
                            "WHERE s.nis = ? AND c.name = ?";
       
        // Query untuk memasukkan nilai ke tabel grades
        String queryInsert = "INSERT INTO grades (nis, nama_siswa, kelas, UTS, UAS, TUGAS, grade) " +
                             "SELECT s.nis, s.name, s.class_id, ?, ?, ?, ? " +
                             "FROM students s " + 
                             "JOIN classes c ON s.class_id = c.id " + 
                             "WHERE s.nis = ? AND c.name = ? " +
                             "AND s.nis NOT IN (SELECT nis FROM grades)";

        try (
            PreparedStatement fetchStmt = connection.prepareStatement(queryFetch);
            PreparedStatement insertStmt = connection.prepareStatement(queryInsert)
        ) {
            // Step 1: Validasi dan ambil data yang diperlukan
            fetchStmt.setString(1, nis);
            fetchStmt.setString(2, className);

            ResultSet resultSet = fetchStmt.executeQuery();
            if (!resultSet.next()) {
                System.err.println("Data tidak ditemukan untuk nim: " + nis + " dan kelas: " + className);
                return false;
            }

            String studentName = resultSet.getString("students.name");
            int classId = resultSet.getInt("class_id");

            // Step 2: Hitung total nilai
            double total = (uts * 0.3) + (uas * 0.4) + (tugas * 0.3);

            // Step 3: Masukkan data ke tabel grades
            insertStmt.setString(1, nis);
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
                             "JOIN students s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "SET g.uts = ?, g.uas = ?, g.tugas = ?, g.grade = ? " +
                             "WHERE s.nis = ? AND c.name = ?";

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
                             "JOIN students s ON g.nim = s.nim " +
                             "JOIN classes c ON g.class_id = c.id " +
                             "WHERE s.nis = ? AND c.name = ?";

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
