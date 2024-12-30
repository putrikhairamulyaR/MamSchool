/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author luthfiah
 */
public class rapot {
    
    private String nama;
    private String kelas;
    private String nis;
    private double biologi;
    private double kimia;
    private double matematika;
    private double fisika;
    private double inggris;
    private double ekonomi;
    private double sejarah;
    private double geografi;
    private double rataRata;
    private String kategori;

    // Constructor
    public rapot(String nama, String kelas, String nis, double biologi, double kimia, double matematika, 
                 double fisika, double inggris, double ekonomi, double sejarah, double geografi, double rataRata, String kategori) {
        this.nama = nama;
        this.kelas = kelas;
        this.nis = nis;
        this.biologi = biologi;
        this.kimia = kimia;
        this.matematika = matematika;
        this.fisika = fisika;
        this.inggris = inggris;
        this.ekonomi = ekonomi;
        this.sejarah = sejarah;
        this.geografi = geografi;
        this.rataRata = rataRata;
        this.kategori = kategori;
    }

    // Default Constructor
    public rapot() {}

    // Getters and Setters

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getKelas() {
        return kelas;
    }

    public void setKelas(String kelas) {
        this.kelas = kelas;
    }

    public String getNis() {
        return nis;
    }

    public void setNis(String nis) {
        this.nis = nis;
    }

    public double getBiologi() {
        return biologi;
    }

    public void setBiologi(double biologi) {
        this.biologi = biologi;
    }

    public double getKimia() {
        return kimia;
    }

    public void setKimia(double kimia) {
        this.kimia = kimia;
    }

    public double getMatematika() {
        return matematika;
    }

    public void setMatematika(double matematika) {
        this.matematika = matematika;
    }

    public double getFisika() {
        return fisika;
    }

    public void setFisika(double fisika) {
        this.fisika = fisika;
    }

    public double getInggris() {
        return inggris;
    }

    public void setInggris(double inggris) {
        this.inggris = inggris;
    }

    public double getEkonomi() {
        return ekonomi;
    }

    public void setEkonomi(double ekonomi) {
        this.ekonomi = ekonomi;
    }

    public double getSejarah() {
        return sejarah;
    }

    public void setSejarah(double sejarah) {
        this.sejarah = sejarah;
    }

    public double getGeografi() {
        return geografi;
    }

    public void setGeografi(double geografi) {
        this.geografi = geografi;
    }

    public double getRataRata() {
        return rataRata;
    }

    public void setRataRata(double rataRata) {
        this.rataRata = rataRata;
    }

    public String getKategori() {
        return kategori;
    }

    public void setKategori(String kategori) {
        this.kategori = kategori;
    }

    // Method untuk menghitung rata-rata nilai
    public void hitungRataRata() {
        this.rataRata = (biologi + kimia + matematika + fisika + inggris + ekonomi + sejarah + geografi) / 8;
        tentukanKategori();
    }

    // Method untuk menentukan kategori
    public void tentukanKategori() {
        if (rataRata >= 85) {
            this.kategori = "A";
        } else if (rataRata >= 70) {
            this.kategori = "B";
        } else if (rataRata >= 50) {
            this.kategori = "C";
        } else if (rataRata >= 40){
            this.kategori = "D";
        } else {
            this.kategori = "E";
        }
    }
}