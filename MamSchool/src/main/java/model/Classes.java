/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dafi Utomo
 */
public class Classes {
    private int id;         // ID kelas
    private String name;    // Nama kelas (contoh: Kelas 1A, Kelas 2B, dll)
    private String major;   // Jurusan (IPA, IPS, dll)

    // Constructor
    public Classes(int id, String name, String major) {
        this.id = id;
        this.name = name;
        this.major = major;
    }

    // Constructor tanpa parameter (default)
    public Classes() {}

    // Getter dan Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    @Override
    public String toString() {
        return "Classes{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", major='" + major + '\'' +
                '}';
    }
}