/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.nilai;

/**
 *
 * @author putri
 */
public class rapotSiswaDao {
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
                 Nilai.setKategori(rs.getString("kategori"));

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
