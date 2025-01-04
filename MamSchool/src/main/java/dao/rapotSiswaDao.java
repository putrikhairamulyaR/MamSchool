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
import model.Student;
import model.Teacher;
import model.rapot;

/**
 *
 * @author putri
 */



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
public class rapotSiswaDao {
    
    // Set rapot siswa
    public rapot getRapot(String nis) {
    String query = """
        SELECT 
            students.name AS nama_siswa,
            students.class_id AS kelas,
            students.nis,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Matematika' THEN grades.rata2 ELSE 0 END), 0) AS Matematika,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Geografi' THEN grades.rata2 ELSE 0 END), 0) AS Geografi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Biologi' THEN grades.rata2 ELSE 0 END), 0) AS Biologi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Fisika' THEN grades.rata2 ELSE 0 END), 0) AS Fisika,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Kimia' THEN grades.rata2 ELSE 0 END), 0) AS Kimia,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Ekonomi' THEN grades.rata2 ELSE 0 END), 0) AS Ekonomi,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Sejarah' THEN grades.rata2 ELSE 0 END), 0) AS Sejarah,
            COALESCE(SUM(CASE WHEN teachers.subject = 'Inggris' THEN grades.rata2 ELSE 0 END), 0) AS Inggris
        FROM 
            students
        LEFT JOIN 
            grades ON grades.nis = students.nis
        LEFT JOIN 
            teachers ON grades.idGuru = teachers.id
        WHERE 
            students.nis = ?
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
                
                // Tentukan kategori berdasarkan rata-rata
                rapot.tentukanKategori();

                // Return objek rapot
                return rapot;
            } else {
                System.out.println("Data tidak ditemukan untuk NIS: " + nis);
                return null;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return null; // Error terjadi
    }
}

    public Student getStudentUserId(int id) {
         String query = "SELECT * FROM students WHERE user_id = ?";
         Student student = null;

         try (Connection connection = JDBC.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {

             if (connection == null) {
                 return null;
             }

             preparedStatement.setInt(1, id);
             ResultSet resultSet = preparedStatement.executeQuery();

             if (resultSet.next()) {

                 student = new Student(
                         resultSet.getInt("id"),
                         resultSet.getInt("user_id"),
                         resultSet.getString("nis"),
                         resultSet.getString("name"),
                         resultSet.getDate("date_of_birth").toLocalDate(),
                         resultSet.getInt("enrollment_year"),
                         (Integer) resultSet.getObject("class_id"), // Nullable
                         resultSet.getString("major")
                 );
             }

         } catch (SQLException e) {
             e.printStackTrace();
         }

         return student;
     }


     // Set rapot siswa
    public nilai getRapotBySubject(String nis, String subject) {
     String query = """
         SELECT 
             students.name AS nama_siswa,
             students.class_id AS kelas,
             students.nis,
             grades.uts AS uts,
             grades.uas AS uas,
             grades.tugas AS tugas,
             grades.grade AS grade,
             grades.kategori AS kategori
         FROM 
             students
         LEFT JOIN 
             grades ON grades.nis = students.nis
         LEFT JOIN 
             teachers ON grades.idGuru = teachers.id
         WHERE 
             students.nis = ? AND teachers.subject = ?
     """;

     try (Connection connection = JDBC.getConnection();
          PreparedStatement stmt = connection.prepareStatement(query)) {

         // Set parameters for NIS and subject
         stmt.setString(1, nis);
         stmt.setString(2, subject);

         try (ResultSet rs = stmt.executeQuery()) {
             if (rs.next()) {

                 nilai Nilai = new nilai();
                 Nilai.setNama(rs.getString("nama_siswa"));
                 Nilai.setNamaKelas(rs.getString("kelas"));
                 Nilai.setNis(rs.getString("nis"));
                 Nilai.setSubject(subject);
                 Nilai.setUts(rs.getDouble("uts"));
                 Nilai.setUas(rs.getDouble("uas"));
                 Nilai.setTugas(rs.getDouble("tugas"));
                 Nilai.setGrade(Nilai.calculateTotal(rs.getDouble("uts"), rs.getDouble("uas"), rs.getDouble("tugas")));
                 Nilai.setKategori();

                 // Calculate the average score
                 double rataRata = Nilai.calculateRata2(rs.getDouble("uts"), rs.getDouble("uas"), rs.getDouble("tugas"));
   

                 // Return the NILAI object
             return Nilai;
             } else {
                 System.out.println("Data not found for NIS: " + nis + " and subject: " + subject);
                 return null;
             }
         }
     } catch (SQLException e) {
         e.printStackTrace();
         return null; // Return null in case of error
     }
 }

}