package dao;

import classes.JDBC;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Raisa Lukman Hakim
 */
public class BagiKelasDAO {
    // Mengecek apakah semua siswa sudah memiliki kelas
    public boolean allStudentsHaveClasses() {
        String query = "SELECT COUNT(*) AS total FROM students WHERE class_id IS NULL";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt("total") == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Mendapatkan jumlah siswa
    public int getTotalStudents() {
        String query = "SELECT COUNT(*) AS total FROM students";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Memasukkan siswa ke kelas
    public boolean assignStudentsToClass(int classId, List<Integer> studentIds) {
        String query = "UPDATE students SET class_id = ? WHERE id = ?";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            for (int studentId : studentIds) {
                preparedStatement.setInt(1, classId);
                preparedStatement.setInt(2, studentId);
                preparedStatement.addBatch();
            }

            preparedStatement.executeBatch();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Mendapatkan daftar siswa tanpa kelas
    public List<String> getStudentsWithoutClass() {
        List<String> students = new ArrayList<>();
        String query = "SELECT id, name FROM students WHERE class_id IS NULL";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                students.add(resultSet.getInt("id") + "-" + resultSet.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}
