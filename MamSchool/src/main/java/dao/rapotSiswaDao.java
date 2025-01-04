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
               
             return Nilai;
             } else {
                 System.out.println("Data not found for NIS: " + nis + " and subject: " + subject);
                 return null;
             }
         }
     } catch (SQLException e) {
         e.printStackTrace();
         return null; // untuk case error
     }
 }

}