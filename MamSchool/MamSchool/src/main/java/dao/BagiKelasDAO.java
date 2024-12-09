package dao;

import classes.JDBC;
import java.sql.*;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {
    // Metode untuk menghitung jumlah seluruh siswa berdasarkan tingkat dan jurusan
    public int countAllStudentsByTingkatAndMajor(String tingkat, String major) {
       String query = "SELECT COUNT(*) " +
                   "FROM students " +
                   "WHERE (YEAR(CURRENT_DATE) - enrollment_year = " +
                   "        CASE " +
                   "            WHEN ? = 'X' THEN 1 " +
                   "            WHEN ? = 'XI' THEN 2 " +
                   "            WHEN ? = 'XII' THEN 3 " +
                   "        END) " +
                   "AND major = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return count;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, tingkat + "%");
            preparedStatement.setString(2, major);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }
    
    // Metode untuk menghitung jumlah kelas berdasarkan tingkat dan jurusan
    public int countClassesByTingkatAndMajor(String tingkat, String major) {
        String query = "SELECT COUNT(*) FROM classes WHERE name LIKE ? AND major = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return count;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, tingkat + "%"); // Filter tingkat, misalnya 'X%'
            preparedStatement.setString(2, major);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1); // Ambil jumlah kelas
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }

    // Metode untuk menghitung jumlah siswa di kelas berdasarkan tingkat dan jurusan
    public int countStudentsByTingkatAndMajor(String tingkat, String major) {
        String query = "SELECT COUNT(*) FROM students s "
                     + "JOIN classes c ON s.class_id = c.id "
                     + "WHERE c.name LIKE ? AND c.major = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;

        try {
            connection = JDBC.getConnection();

            if (connection == null) {
                System.out.println("Koneksi database gagal.");
                return count;
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, tingkat + "%"); // Filter tingkat, misalnya 'X%'
            preparedStatement.setString(2, major);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1); // Ambil jumlah siswa
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                JDBC.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
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

}
