package model;


/**
 *
 * @author Necha
 */


import java.time.LocalTime;

public class Jadwal {
    private int id;   
    private int idKelas;// ID jadwal
    private String kelas;          // Marsha butuh ini
    private int subjectId;         // ID mata pelajaran (FK ke tabel subjects)
    private int teacherId;         // ID guru (FK ke tabel teachers)
    private String day;            // Hari (ENUM: Senin, Selasa, dll)
    private LocalTime startTime;   // Waktu mulai mapel
    private LocalTime endTime;     // Waktu selesai mapel
    private String subjectName;    // Marsha butuh ini

  
    public Jadwal(int id, int kelas, int subjectId, int teacherId, String day, LocalTime startTime, LocalTime endTime) {
        this.id = id;
        this.idKelas = kelas;
        this.subjectId = subjectId;
        this.teacherId = teacherId;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Jadwal( int kelas, int subjectId, int teacherId, String day, LocalTime startTime, LocalTime endTime) {
        
        this.idKelas = kelas;
        this.subjectId = subjectId;
        this.teacherId = teacherId;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    //Marsha butuh ini
    public Jadwal(int id, int classId, String className, int subjectId, String subjectName, int teacherId, String day, LocalTime startTime, LocalTime endTime) {
        this.id = id;
        this.idKelas = classId;
        this.kelas = className;
        this.subjectId = subjectId;
        this.subjectName = subjectName;
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

    public int getidKelas() {
        return idKelas;
    }

    public void setidKelas(int kelas) {
        this.idKelas = kelas;
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
    
    // Marsha butuh ini
    public String getKelas() {
        return kelas;
    }

    public void setKelas(String kelas) {
        this.kelas = kelas;
    }

    public int getIdKelas() {
        return idKelas;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setIdKelas(int idKelas) {
        this.idKelas = idKelas;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    // jangan dihapus
    
    

    @Override
    public String toString() {
        return "Jadwal{" +
                "id=" + id +
                ", kelas='" + idKelas + '\'' +
                ", subjectId=" + subjectId +
                ", teacherId=" + teacherId +
                ", day='" + day + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}