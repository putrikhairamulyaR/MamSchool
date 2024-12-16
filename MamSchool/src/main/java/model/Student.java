/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDate;
import java.util.Date;
/**
 *
 * @author Dafi
 */
public class Student {
    private int id;                // ID Siswa
    private String nis;            // Nomor Induk Siswa (NIS)
    private String name;           // Nama Siswa
    private int level;             // Tingkat (1, 2, 3)
    private String major;          // Jurusan (IPA, IPS)
    private boolean hasClass;      // Apakah sudah memiliki kelas?
    private Date dateOfBirth; // Tanggal Lahir
    private int enrollmentYear;    // Tahun Masuk
    private int classId;           // ID Kelas (merujuk ke kelas di tabel Classes)
    private int teacherId;         // ID Wali Kelas (merujuk ke pengajar/teacher)
     private int userId;   

    // Constructor
    public Student(int id, String nis, String name, int level, String major, boolean hasClass,
                   Date dateOfBirth, int enrollmentYear, int classId, int teacherId) {
        this.id = id;
        this.nis = nis;
        this.name = name;
        this.level = level;
        this.major = major;
        this.hasClass = hasClass;
        this.dateOfBirth = dateOfBirth;
        this.enrollmentYear = enrollmentYear;
        this.classId = classId;
        this.teacherId = teacherId;
    }

    // Constructor tanpa parameter (untuk pembuatan objek default)
    public Student() {}

    // Getter and Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNis() {
        return nis;
    }

    public void setNis(String nis) {
        this.nis = nis;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public boolean isHasClass() {
        return hasClass;
    }

    public void setHasClass(boolean hasClass) {
        this.hasClass = hasClass;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public void setUserId(int userId) {
       this.userId=userId;
    }

    public int getEnrollmentYear() {
        return enrollmentYear;
    }

    public void setEnrollmentYear(int enrollmentYear) {
        this.enrollmentYear = enrollmentYear;
    }

    public int getClassId() {
        return classId;
    }
    
    public int getUserId() {
        return userId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", nis='" + nis + '\'' +
                ", name='" + name + '\'' +
                ", level=" + level +
                ", major='" + major + '\'' +
                ", hasClass=" + hasClass +
                ", dateOfBirth=" + dateOfBirth +
                ", enrollmentYear=" + enrollmentYear +
                ", classId=" + classId +
                ", teacherId=" + teacherId +
                '}';
    }
}