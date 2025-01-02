package dao;

import classes.JDBC;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Classes;
import model.Student;
import model.Teacher;
import model.nilai;

/**
 *
 * @author putri
 */
public class gradeDao {

    private Connection connection;

        //view seluruh nilai siswa berdasarkan kelas 
        public List<nilai> viewAllGradesByClass(String className) throws SQLException {
        List<nilai> gradeList = new ArrayList<>();
        String query = "SELECT g.id_nilai,s.nis, s.name AS nama_siswa, g.uts, g.uas, g.tugas, g.grade, g.kategori " +
                       "FROM grades g " +
                       "JOIN students s ON g.nis = s.nis " +
                       "JOIN classes c ON g.kelas = c.name " +
                       "WHERE c.name = ? " +
                       "ORDER BY s.name";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set parameter untuk kelas
            stmt.setString(1, className); 

            // Eksekusi query
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Ambil data dari ResultSet
                    int id_nilai = rs.getInt("id_nilai");
                    String nis = rs.getString("nis");
                    String name = rs.getString("nama_siswa");
                    double uts = rs.getDouble("uts");
                    double uas = rs.getDouble("uas");
                    double tugas = rs.getDouble("tugas");
                    double total = rs.getDouble("grade");
                    String kategori = rs.getString("kategori");

                    // Buat objek nilai dan isi data
                    nilai grade = new nilai();
                    grade.setIdNilai(id_nilai);
                    grade.setNis(nis);
                    grade.setName(name);
                    grade.setUts(uts);
                    grade.setUas(uas);
                    grade.setTugas(tugas);
                    grade.setGrade(total);
                    grade.setKategori(kategori);

                    // Tambahkan ke daftar
                    gradeList.add(grade);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saat mengambil data nilai siswa berdasarkan kelas: " + e.getMessage());
        }
        return gradeList;
    }
        // untuk dapat nilai berdasarkan idnya
    public nilai getGradeById(int id) {
        String query = "SELECT g.id_nilai, s.nis, s.name AS nama_siswa, g.uts, g.uas, g.tugas, g.grade, g.kategori " +
                       "FROM grades g " +
                       "JOIN students s ON g.nis = s.nis " +
                       "WHERE g.id_nilai = ?";
        nilai grade = null;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set parameter ID dulu
            stmt.setInt(1, id);

            // Eksekusi querynya
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Ambil data dari ResultSet
                    int idNilai = rs.getInt("id_nilai");
                    String nis = rs.getString("nis");
                    String name = rs.getString("nama_siswa");
                    double uts = rs.getDouble("uts");
                    double uas = rs.getDouble("uas");
                    double tugas = rs.getDouble("tugas");
                    double total = rs.getDouble("grade");
                    String kategori = rs.getString("kategori");

                    // Buat objek nilai dan isi data
                    grade = new nilai();
                    grade.setIdNilai(idNilai);
                    grade.setNis(nis);
                    grade.setName(name);
                    grade.setUts(uts);
                    grade.setUas(uas);
                    grade.setTugas(tugas);
                    grade.setGrade(total);
                    grade.setKategori(kategori);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saat mengambil nilai siswa berdasarkan ID: " + e.getMessage());
        }
        return grade;
    }

    public boolean updateNilaiSiswa(int id_nilai,double uts, double uas, double tugas) {
        String query = "UPDATE grades g " +
                             "JOIN students s ON g.nis = s.nis " +
                             "JOIN classes c ON g.kelas = c.name " +
                             "SET g.uts = ?, g.uas = ?, g.tugas = ?, g.grade = ?, g.kategori = ?" +
                             "WHERE g.id_nilai = ?";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }
                
            // Hitung grade dan tentukan kategori
                nilai grade = new nilai(); 
                double total = grade.calculateTotal(uts, uas, tugas);
                String kategori = total > 50 ? "lulus" : "tidak lulus";
                grade.setIdNilai(id_nilai);
                grade.setUts(uts);
                grade.setUas(uas);
                grade.setTugas(tugas);
                grade.setGrade(total);
                grade.setKategori(kategori);

     
            // Persiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setDouble(1, uts);
            preparedStatement.setDouble(2, uas);
            preparedStatement.setDouble(3, tugas); 
            preparedStatement.setDouble(4, total);
            preparedStatement.setString(5, kategori);
            preparedStatement.setInt(6, id_nilai); 

            // Eksekusi query
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Data berhasil diupdate.");
                return true;
            } else {
                System.out.println("Gagal mengedit data.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
       public boolean deleteNilaiSiswa(int id) {
        String query = "DELETE FROM grades WHERE id_nilai = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return false;
            }
               
            // Persiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id); 

            // Eksekusi query
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Data berhasil diupdate.");
                return true;
            } else {
                System.out.println("Gagal mengedit data.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean setNilaiSiswa(String nis, String c_name, double uts, double uas, double tugas,int idGuru) {
            // Query untuk memasukkan nilai ke tabel grades
            String query = "INSERT INTO grades (nis, nama_siswa, kelas, uts, uas, tugas, grade, kategori,idGuru,rata2) " +
                           "SELECT s.nis, s.name, c.name, ?, ?, ?, ?, ?, ?, ? " +
                           "FROM students s " +
                           "JOIN classes c ON s.class_id = c.id " +
                           "WHERE s.nis = ? AND c.name = ?";
           
            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                connection = JDBC.getConnection();

                if (connection == null) {
                    System.out.println("Koneksi database gagal.");
                    return false;
                }

                // Hitung grade dan tentukan kategori
                    nilai grade = new nilai(); 
                    double total = grade.calculateTotal(uts, uas, tugas);
                    double rata2 = grade.calculateRata2(uts, uas, tugas);
                    String kategori = total > 50 ? "lulus" : "tidak lulus";
                    grade.setIdNilai(grade.getIdNilai());
                    grade.setNis(nis);
                    grade.setName(grade.getName());
                    grade.setUts(uts);
                    grade.setUas(uas);
                    grade.setTugas(tugas);
                    grade.setGrade(total);
                    grade.setKategori(kategori);

                   
                // Persiapkan query
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setDouble(1, uts);
                preparedStatement.setDouble(2, uas);
                preparedStatement.setDouble(3, tugas);
                preparedStatement.setDouble(4, total);
                preparedStatement.setString(5, kategori);
                preparedStatement.setInt(6, idGuru);
                preparedStatement.setDouble(7, rata2);
                preparedStatement.setString(8, nis);
                preparedStatement.setString(9, c_name);
               

                // Eksekusi query
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Data berhasil ditambahkan.");
                    return true;
                } else {
                    System.out.println("Gagal menambahkan data.");
                    return false;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            } finally {
                try {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    JDBC.closeConnection(connection);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

    //untuk mendapatkan siswa berdasarkan kelas
    public List<Student> getSiswaByKelas(String kelas) {
      List<Student> siswaList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String query = "SELECT * FROM students JOIN classes ON students.class_id = classes.id WHERE classes.name = ?";
        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
   
            }
               
            // Persiapkan query
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, kelas); 
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Student siswa = new Student();
                siswa.setNis(rs.getString("nis"));
                siswa.setName(rs.getString("name"));
                siswaList.add(siswa);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
      return siswaList;
  }
        public List<Classes> getAllClassesByTeacherID(int id) {
        List<Classes> classesList = new ArrayList<>();
        String query = "SELECT DISTINCT " +
                       "    c.id AS class_id, " +
                       "    c.name AS class_name, " +
                       "    c.major, " +
                       "    c.tingkat " +
                       "FROM " +
                       "    class_schedule s " +
                       "JOIN " +
                       "    classes c " +
                       "ON " +
                       "    s.class_id = c.id " +
                       "WHERE " +
                       "    s.teacher_id = ?;";

        try (Connection connection = JDBC.getConnection()) {
            if (connection == null) {
                System.out.println("Failed to establish database connection.");
                return classesList;
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, id);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Classes classes = new Classes(
                                resultSet.getInt("class_id"),      // untuk ngambil class_id
                                resultSet.getString("class_name"), // untuk ngambil class_name
                                resultSet.getString("major"),      // untuk ngambil major
                                id,                                // untuk ngambil langsung dari parameter
                                resultSet.getInt("tingkat")        // untuk ngambil tingkat
                        );
                        classesList.add(classes);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return classesList;
    }
        
      public Teacher getTeacherByUserId(int id) {
    String query = "SELECT " +
                   "    t.id, t.user_id, t.nip, t.name, t.date_of_birth, t.subject, t.hire_date " +
                   "FROM " +
                   "    teachers t " +
                   "JOIN " +
                   "    users u " +
                   "ON " +
                   "    t.user_id = u.id " +
                   "WHERE " +
                   "    u.id = ?";

    try (Connection connection = JDBC.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query)) {
        // Set parameter
        stmt.setInt(1, id);

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setId(rs.getInt("id"));
                teacher.setUserId(rs.getInt("user_id"));
                teacher.setNip(rs.getString("nip"));
                teacher.setName(rs.getString("name"));
                teacher.setDateOfBirth(rs.getDate("date_of_birth").toLocalDate());
                teacher.setSubject(rs.getString("subject"));
                teacher.setHireDate(rs.getDate("hire_date").toLocalDate());
                return teacher;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // kalo guru tidak ada atau nulll
    return null;
}



}