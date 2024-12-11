package dao;

import classes.JDBC;
import java.sql.*;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {

    // Metode untuk menghitung jumlah siswa yang memiliki kelas
    public int countStudentsWithClass(String tingkat, String jurusan) {
        String query = "SELECT COUNT(*) FROM students s "
                     + "JOIN classes c ON s.class_id = c.id "
                     + "WHERE c.name LIKE ? AND c.major = ?";
        int count = 0;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setString(1, tingkat + "%");
            preparedStatement.setString(2, jurusan);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // Metode untuk menghitung jumlah siswa yang tidak memiliki kelas
    public int countStudentsWithoutClass(String tingkat, String jurusan) {
        String query = "SELECT COUNT(*) FROM students s "
                     + "LEFT JOIN classes c ON s.class_id = c.id "
                     + "WHERE s.class_id IS NULL AND s.major = ? AND YEAR(CURRENT_DATE) - s.enrollment_year = ?";
        int count = 0;

        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setString(1, jurusan);
            preparedStatement.setString(2, tingkat);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
}
    
//    public List<BagiKelasDAO> getStudentsByTingkatAndMajor(String tingkat, String major) {
//        String query = "SELECT s.id, s.name, s.age, s.gender, c.name as class_name, c.major " +
//                       "FROM students s " +
//                       "JOIN classes c ON s.class_id = c.id " +
//                       "WHERE c.name LIKE ? AND c.major = ?";
//        List<BagiKelasDAO> students = new ArrayList<>();
//
//        try (Connection connection = JDBC.getConnection();
//             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
//
//            if (connection == null) {
//                throw new SQLException("Failed to establish a database connection.");
//            }
//
//            preparedStatement.setString(1, tingkat + "%");
//            preparedStatement.setString(2, major);
//
//            try (ResultSet resultSet = preparedStatement.executeQuery()) {
//                while (resultSet.next()) {
//                    BagiKelasDAO student = new BagiKelasDAO();
//                    student.setId(resultSet.getInt("id"));
//                    student.setName(resultSet.getString("name"));
//                    student.setAge(resultSet.getInt("age"));
//                    student.setGender(resultSet.getString("gender"));
//                    student.setClassName(resultSet.getString("class_name"));
//                    student.setMajor(resultSet.getString("major"));
//                    students.add(student);
//                }
//            }
//        } catch (SQLException e) {
//            System.err.println("Error fetching students by tingkat and major: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        return students;
//    }