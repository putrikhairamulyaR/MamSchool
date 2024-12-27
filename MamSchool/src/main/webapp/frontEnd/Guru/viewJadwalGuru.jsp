<%@page import="model.Jadwal"%>
<%@page import="model.Classes"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="classes.JDBC"%>
<%@page import="dao.PresensiDao"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.*" %>
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
        
        // Get the current date and time
        LocalDate currentDate = LocalDate.now();
        
        // Format the date using Indonesian locale
        String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy", Locale.forLanguageTag("id")));
        LocalTime currentTime = LocalTime.now();
        
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
        List<Jadwal> jadwal = new ArrayList<>();
        try (Connection conn = JDBC.getConnection()) {
            String query = "SELECT classes.id, classes.name, classes.major, "
                           + "class_schedule.day, class_schedule.start_time, class_schedule.end_time FROM classes "
                           + "JOIN class_schedule ON classes.id = class_schedule.class_id "
                           + "WHERE class_schedule.teacher_id = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, idGuru);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Classes kelas = new Classes();
                Jadwal sched = new Jadwal();
                kelas.setId(resultSet.getInt("id"));
                kelas.setMajor(resultSet.getString("major"));
                kelas.setName(resultSet.getString("name"));
                sched.setId(resultSet.getInt("id"));
                sched.setDay(resultSet.getString("day"));
                sched.setStartTime(LocalTime.parse(resultSet.getTime("start_time").toString()));
                sched.setEndTime(LocalTime.parse(resultSet.getTime("end_time").toString()));
                classes.add(kelas);
                jadwal.add(sched);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

        String selectedClassId = request.getParameter("classId");
    %>

    <body class="bg-light">
        <div class="container my-5">
            <!-- Display current date and time -->
            <h3 class="text-center text-primary">Hari: <%= formattedDate %> - Waktu : <%= currentTime %></h3>

            <h1 class="text-center text-primary">Jadwal</h1>

            <form action="${pageContext.request.contextPath}/PresensiServlet" method="POST">
                <input type="hidden" name="action" value="add">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Class ID</th>
                                <th>Class Name</th>
                                <th>Major</th>
                                <th>Day</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                // Iterate through the classes list to display the class data and schedule info
                                // Filter to display only today's classes
                                for (int i = 0; i < classes.size(); i++) {
                                    Classes kelas = classes.get(i);
                                    Jadwal sched = jadwal.get(i);
                                    String classId = String.valueOf(kelas.getId());
                                    
                                    // Check if the class day is today (in lower case for comparison)
                                    //ini lagi hardcode dulu buat nampilin senin
                                    if (sched.getDay().equalsIgnoreCase("Senin")) {
                            %>
                            <tr>
                                <td><%= classId %></td>
                                <td><%= kelas.getName() %></td>
                                <td><%= kelas.getMajor() %></td>
                                <td><%= sched.getDay() %></td>
                                <td><%= sched.getStartTime() %></td>
                                <td><%= sched.getEndTime() %></td>
                                <td>
                                    <button type="submit" class="btn btn-primary">Add Attendance</button>
                                    <button type="submit" class="btn btn-primary">Edit Attendance</button>
                                </td>
                            </tr>
                            <% 
                                    }
                                } 
                            %>
                        </tbody>
                    </table>

            </form>
        </div>
    </body>
</html>
