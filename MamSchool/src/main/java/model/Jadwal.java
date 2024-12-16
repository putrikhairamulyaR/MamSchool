package model;


/**
 *
 * @author Necha
 */


import java.time.LocalTime;

public class Jadwal {
    private int id;                // ID jadwal
    private String kelas;          // Kelas (contoh: X-IPA-1)
    private int subjectId;         // ID mata pelajaran (FK ke tabel subjects)
    private int teacherId;         // ID guru (FK ke tabel teachers)
    private String day;            // Hari (ENUM: Senin, Selasa, dll)
    private LocalTime startTime;   // Waktu mulai mapel
    private LocalTime endTime;     // Waktu selesai mapel

  
    public Jadwal(int id, String kelas, int subjectId, int teacherId, String day, LocalTime startTime, LocalTime endTime) {
        this.id = id;
        this.kelas = kelas;
        this.subjectId = subjectId;
        this.teacherId = teacherId;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Jadwal( String kelas, int subjectId, int teacherId, String day, LocalTime startTime, LocalTime endTime) {
        
        this.kelas = kelas;
        this.subjectId = subjectId;
        this.teacherId = teacherId;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Jadwal() {}

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKelas() {
        return kelas;
    }

    public void setKelas(String kelas) {
        this.kelas = kelas;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Jadwal{" +
                "id=" + id +
                ", kelas='" + kelas + '\'' +
                ", subjectId=" + subjectId +
                ", teacherId=" + teacherId +
                ", day='" + day + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}