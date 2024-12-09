/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDate;
/**
 *
 * @author Dafi Utomo
 */
public class Teacher {
    private int id;
    private int userId;
    private String nip;
    private String name;
    private LocalDate dateOfBirth;
    private String subject;
    private LocalDate hireDate;

    public Teacher(int id, int userId, String nip, String name, LocalDate dateOfBirth, String subject, LocalDate hireDate) {
        this.id = id;
        this.userId = userId;
        this.nip = nip;
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.subject = subject;
        this.hireDate = hireDate;
    }

    public Teacher() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getNip() {
        return nip;
    }

    public void setNip(String nip) {
        this.nip = nip;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public LocalDate getHireDate() {
        return hireDate;
    }

    public void setHireDate(LocalDate hireDate) {
        this.hireDate = hireDate;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "id=" + id +
                ", userId=" + userId +
                ", nip='" + nip + '\'' +
                ", name='" + name + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", subject='" + subject + '\'' +
                ", hireDate=" + hireDate +
                '}';
    }
}
