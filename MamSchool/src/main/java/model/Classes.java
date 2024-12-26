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
    private String name;    // Nama kelas
    private String major;   // Jurusan
    private int teacher_id; // ID guru
    private int tingkat;    // Tingkat kelas

    public Classes() { } // Konstruktor default

    public Classes(int id) { 
        this.id = id; 
    }
    
    // Constructor dengan ID (untuk operasi update atau retrieval)
    public Classes(int id, String name, String major, int teacher_id, int tingkat) {
        this.id = id;
        this.name = name;
        this.major = major;
        this.teacher_id = teacher_id;
        this.tingkat = tingkat;
    }

    // Constructor tanpa ID (untuk operasi add)
    public Classes(String name, String major, int teacher_id, int tingkat) {
        this.name = name;
        this.major = major;
        this.teacher_id = teacher_id;
        this.tingkat = tingkat;
    }

    // Getter dan Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        if (this.name == null || this.name.trim().isEmpty()) {
            throw new IllegalStateException("Class name cannot be null or empty");
        }
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

    public int getTeacher_id() {
        return teacher_id;
    }

    public void setTeacher_id(int teacher_id) {
        this.teacher_id = teacher_id;
    }

    public int getTingkat() {
        return tingkat;
    }

    public void setTingkat(int tingkat) {
        this.tingkat = tingkat;
    }

    @Override
    public String toString() {
        return "Classes{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", major='" + major + '\'' +
                ", teacher_id=" + teacher_id +
                ", tingkat=" + tingkat +
                '}';
    }
}
