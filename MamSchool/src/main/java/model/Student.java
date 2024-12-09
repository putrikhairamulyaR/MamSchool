/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDate;
/**
 *
 * @author Dafi
 */
public class Student {
    private int id;
    private int userId;
    private String nis;
    private String name;
    private LocalDate dateOfBirth;
    private int enrollmentYear;
    private Classes classData;
    private String major;
    private Teacher teacher;

    // Constructor
    public Student(int id, int userId, String nis, String name, LocalDate dateOfBirth, int enrollmentYear, Classes classData, String major, Teacher teacher) {
        this.id = id;
        this.userId = userId;
        this.nis = nis;
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.enrollmentYear = enrollmentYear;
        this.classData = classData;
        this.major = major;
        this.teacher = teacher;
    }

    public Student() {}

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

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public int getEnrollmentYear() {
        return enrollmentYear;
    }

    public void setEnrollmentYear(int enrollmentYear) {
        this.enrollmentYear = enrollmentYear;
    }

    public Classes getClassData() {
        return classData;
    }

    public void setClassData(Classes classData) {
        this.classData = classData;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", userId=" + userId +
                ", nis='" + nis + '\'' +
                ", name='" + name + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", enrollmentYear=" + enrollmentYear +
                ", classData=" + classData +
                ", major='" + major + '\'' +
                ", teacher=" + teacher +
                '}';
    }
}
