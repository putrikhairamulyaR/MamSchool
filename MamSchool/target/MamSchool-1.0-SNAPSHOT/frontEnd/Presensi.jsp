<%@page import="model.Classes"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Student"%>
<%@page import="java.sql.Connection"%>
<%@page import="classes.JDBC"%>
<%@page import="dao.PresensiDao"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Presensi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
    </head>

    <%
        User user = (User) request.getSession().getAttribute("user");
        int idGuru = 0;
        try (Connection conn = JDBC.getConnection()) {
            String query = "SELECT teachers.id AS teacher_id FROM teachers JOIN users ON teachers.user_id = users.id ";
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    idGuru = rs.getInt("teacher_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        List<Classes> classes = new ArrayList<>();
        try (Connection conn = JDBC.getConnection()) {
            String query = "SELECT classes.id, classes.name, classes.major FROM classes "
                           + "JOIN class_schedule ON classes.id = class_schedule.class_id "
                           + "WHERE class_schedule.teacher_id = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, idGuru);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Classes kelas = new Classes();
                kelas.setId(resultSet.getInt("id"));
                kelas.setMajor(resultSet.getString("major"));
                kelas.setName(resultSet.getString("name"));
                
                classes.add(kelas);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

        String selectedClassId = request.getParameter("classId");
        List<Student> students = new ArrayList<>();

        if (selectedClassId != null && !selectedClassId.isEmpty()) {
            try (Connection conn = JDBC.getConnection()) {
                // Query untuk id dan nama dari berdasarkan kelas id dari student id
                String studentQuery = "SELECT students.user_id, students.name FROM students "
                                    + "JOIN class_schedule ON students.class_id = class_schedule.class_id "
                                    + "WHERE students.class_id = ?";
                PreparedStatement preparedStatement = conn.prepareStatement(studentQuery);
                preparedStatement.setString(1, selectedClassId);  // Set the classId in the query
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    Student student = new Student();
                    student.setUserId(resultSet.getInt("user_id"));
                    student.setName(resultSet.getString("name"));
                    students.add(student);
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    %>

    <body class="bg-light">
        <div class="container my-5">
            <h1 class="text-center text-primary">Students Attendance Form</h1>

            <form action="${pageContext.request.contextPath}/PresensiServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <select name="classId" class="form-control mb-3">
                    <option value="">-- Select Class --</option>
                    <% 
                        for (Classes kelas : classes) {
                            String classId = String.valueOf(kelas.getId());
                            String className = kelas.getName();
                            String classMajor = kelas.getMajor();
                    %>
                    <option value="<%= classId %>" <%= selectedClassId != null && selectedClassId.equals(classId) ? "selected" : "" %> >
                        <%= className %> - <%= classMajor %>
                    </option>
                    <% } %>
                </select>
                <table class="table table-bordered table-striped">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Hadir</th>
                            <th>Sakit</th>
                            <th>Alpa</th>
                            <th>Izin</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Student student : students) {%>
                        <tr class="text-center">
                            <td><%= student.getUserId() %></td>
                            <td><%= student.getName() %></td>
                            <input type="hidden" name="id" value="<%= student.getUserId() %>">
                            <td><input type="radio" name="attendance" value="Hadir" class="form-check-input"></td>
                            <td><input type="radio" name="attendance" value="Sakit" class="form-check-input"></td>
                            <td><input type="radio" name="attendance" value="Alpa" class="form-check-input"></td>
                            <td><input type="radio" name="attendance" value="Izin" class="form-check-input"></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit Attendance</button>
                </div>
            </form>
        </div>
    </body>
</html>
