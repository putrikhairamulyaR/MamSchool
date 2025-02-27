/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author putri
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

public class nilai {
    private Student student; // Objek Student untuk mendapatkan nim dan nama
    private int idNilai;  
    private String nis;
    private Classes kelas;   // Objek kelas
    private double uts;      // Nilai UTS
    private double uas;      // Nilai UAS
    private double tugas;    // Nilai tugas
    private String kategori; // Kategori (misalnya lulus tidak)
    private double grade;    // Total nilai
    private String nama;
    private String namaKelas;
    private String subject;
    private String idGuru;

    public String getIdGuru() {
        return idGuru;
    }

    public void setIdGuru(String idGuru) {
        this.idGuru = idGuru;
    }

    // Constructor
    public nilai(Student student,String nis, int idNilai, Classes kelas, double uts, double uas, double tugas, String kategori, double total) {
        this.student = student;
        this.idNilai = idNilai;
        this.nis =nis;
        this.kelas = kelas;
        this.uts = uts;
        this.uas = uas;
        this.tugas = tugas;
        this.kategori = kategori;
       
    }

    public nilai() {}

    // Getter and Setter
    public Student getStudent() {
        return student;
    }
    
    public void setStudent(Student student) {
        this.student = student;
    }

    public String getNis() {
        return nis;
    }
    
    public String getName() {
        return nama;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getSubject() {
        return subject;
    }
    
    public void setNis(String nis) {
        this.nis = nis;
    }
     public String getNis(String nis) {
        return this.nis;
    }
    public int getIdNilai() {
        return idNilai;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public void setIdNilai(int idNilai) {
        this.idNilai = idNilai;
    }

    public Classes getKelas() {
        return kelas;
    }
    public String getNamaKelas() {
        return namaKelas;
    }

    public void setNamaKelas(String namaKelas) {
        this.namaKelas = namaKelas;
    }

    public void setKelas(Classes kelas) {
        this.kelas = kelas;
    }

    public double getUts() {
        return uts;
    }

    public void setUts(double uts) {
        this.uts = uts;
    }

    public double getUas() {
        return uas;
    }

    public void setUas(double uas) {
        this.uas = uas;
    }

    public double getTugas() {
        return tugas;
    }

    public void setTugas(double tugas) {
        this.tugas = tugas;
    }

    public String getKategori() {
        return kategori;
    }

    public void setKategori() {
          if (grade >= 85) {
            this.kategori = "A";
        } else if (grade >= 70) {
            this.kategori = "B";
        } else if (grade >= 50) {
            this.kategori = "C";
        } else if (grade >= 40){
            this.kategori = "D";
        } else {
            this.kategori = "E";
        }
    }
    

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        this.grade = grade;
    }

    // Method untuk menghitung total nilai
    public double calculateTotal(Double uts, Double uas, Double tugas) {
        grade = (uts * 0.3) + (uas * 0.4) + (tugas * 0.3);
        return grade;
    }
    
    public void setName(String nama) {
        this.nama=nama;
    }


}
