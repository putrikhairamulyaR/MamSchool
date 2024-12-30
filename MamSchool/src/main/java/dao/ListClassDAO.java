/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import classes.JDBC;
import model.Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Royal
 */
public class ListClassDAO {
    private static final Logger logger = Logger.getLogger(ListClassDAO.class.getName());

    public List<Classes> getFilteredClasses(String major, Integer tingkat) {
        List<Classes> classesList = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM classes WHERE 1=1");

        if (major != null && !major.isEmpty()) {
            query.append(" AND major = ?");
        }
        if (tingkat != null) {
            query.append(" AND tingkat = ?");
        }

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (major != null && !major.isEmpty()) {
                stmt.setString(paramIndex++, major);
            }
            if (tingkat != null) {
                stmt.setInt(paramIndex++, tingkat);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Classes classes = new Classes();
                classes.setId(rs.getInt("id"));
                classes.setName(rs.getString("name"));
                classes.setMajor(rs.getString("major"));
                classes.setTeacher_id(rs.getInt("teacher_id"));
                classes.setTingkat(rs.getInt("tingkat"));
                classesList.add(classes);
            }

            logger.log(Level.INFO, "Number of filtered classes fetched: {0}", classesList.size());

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error: {0}", e.getMessage());
        }

        return classesList;
    }
}