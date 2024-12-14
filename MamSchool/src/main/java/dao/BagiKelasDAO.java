package dao;

import classes.JDBC;
import model.Classes;
import model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {
    // Ambil semua kelas yang tersedia
    public List<Classes> getAllClasses() {
        List<Classes> classes = new ArrayList<>();
        String sql = "SELECT id, name, major FROM classes";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String major = rs.getString("major");

                // Buat objek Classes dan tambahkan ke dalam daftar
                classes.add(new Classes(id, name, major));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return classes;
    }

    // Ambil jumlah siswa yang memiliki kelas berdasarkan tingkat (menggunakan enrollment_year)
    public int getSiswaDenganKelas(String major, int enrollmentYear) {
        String sql = "SELECT COUNT(*) FROM students WHERE major = ? AND enrollment_year = ? AND class_id IS NOT NULL";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, major);  // jurusan (major)
            stmt.setInt(2, enrollmentYear);  // tahun pendaftaran (enrollment_year)
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Mengembalikan jumlah siswa dengan kelas
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Ambil jumlah siswa yang tidak memiliki kelas berdasarkan tingkat (menggunakan enrollment_year)
    public int getSiswaTanpaKelas(String major, int enrollmentYear) {
        String sql = "SELECT COUNT(*) FROM students WHERE major = ? AND enrollment_year = ? AND class_id IS NULL";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, major);  // jurusan (major)
            stmt.setInt(2, enrollmentYear);  // tahun pendaftaran (enrollment_year)
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Mengembalikan jumlah siswa tanpa kelas
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Fungsi untuk menghitung tahun pendaftaran berdasarkan tingkat
    public int calculateEnrollmentYear(String tingkat) {
        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

        // Misalnya, tingkat 1 untuk tahun pendaftaran saat ini
        if (tingkat.equals("1")) {
            return currentYear;
        } else if (tingkat.equals("2")) {
            return currentYear - 1;  // Tingkat 2 untuk tahun sebelumnya
        } else if (tingkat.equals("3")) {
            return currentYear - 2;  // Tingkat 3 untuk dua tahun sebelumnya
        }

        return currentYear;  // Default jika tingkat tidak dikenali
    }
}