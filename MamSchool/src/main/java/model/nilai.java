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
    private int idNilai;     // ID nilai
    private Classes kelas;   // Objek kelas
    private double uts;      // Nilai UTS
    private double uas;      // Nilai UAS
    private double tugas;    // Nilai tugas
    private String kategori; // Kategori (misalnya A, B, C, dll.)
    private double total;    // Total nilai

    // Constructor
    public nilai(Student student, int idNilai, Classes kelas, double uts, double uas, double tugas, String kategori, double total) {
        this.student = student;
        this.idNilai = idNilai;
        this.kelas = kelas;
        this.uts = uts;
        this.uas = uas;
        this.tugas = tugas;
        this.kategori = kategori;
        this.total = total;
    }

    public nilai() {}

    // Getter and Setter
    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public int getIdNilai() {
        return idNilai;
    }

    public void setIdNilai(int idNilai) {
        this.idNilai = idNilai;
    }

    public Classes getKelas() {
        return kelas;
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

    public void setKategori(String kategori) {
        this.kategori = kategori;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    // Method untuk menghitung total nilai
    public void calculateTotal() {
        this.total = (uts * 0.3) + (uas * 0.4) + (tugas * 0.3); // Contoh bobot
    }

    // Getter untuk nama dan nim melalui Student
    public String getName() {
        return student != null ? student.getName() : null;
    }

//    public String getNim() {
//        return student != null ? student.getNis() : null;
//    }
//
//    @Override
//    public String toString() {
//        return "Grade{" +
//                "name='" + getName() + '\'' +
//                ", nim='" + getNim() + '\'' +
//                ", idNilai=" + idNilai +
//                ", kelas=" + kelas +
//                ", uts=" + uts +
//                ", uas=" + uas +
//                ", tugas=" + tugas +
//                ", kategori='" + kategori + '\'' +
//                ", total=" + total +
//                '}';
//    }
}
