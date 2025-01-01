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
        

        // Get the current date and time
        LocalDate currentDate = LocalDate.now();

        // Format the date using Indonesian locale
        String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy", Locale.forLanguageTag("id")));
        LocalTime currentTime = LocalTime.now();
        PresensiDao dao = new PresensiDao();
        int idGuru = dao.getTeacherIdByUserId(user.getId());
        List<Classes>classes= dao.getClassByTeacherId(idGuru);
        List<Jadwal>jadwal=dao.getAllJadwalByTeacherId(idGuru);
   %>
   

    <body class="bg-light">
        <div class="container my-5">
            <!-- Display current date and time -->
            <h3 class="text-center text-primary">Hari: <%= formattedDate%> - Waktu : <%= currentTime%></h3>

            <h1 class="text-center text-primary">Jadwal</h1>

            <form action="${pageContext.request.contextPath}/PresensiServlet" method="get">
                <input type="hidden" name="action" value="view">
                
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Class ID</th>
                            <th>Class Name</th>
                            <th>Subject</th>
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
                            for(Jadwal jad:jadwal) {

                                // Check if the class day is today (in lower case for comparison)
                                //ini lagi hardcode dulu buat nampilin senin
                        %>
                        <tr>
                            <td><%= jad.getIdKelas()%></td>
                            <td><%= jad.getKelas() %></td>
                            <td><%= jad.getSubjectName() %></td>
                            <td><%= jad.getDay() %></td>
                            <td><%= jad.getStartTime()%></td>
                            <td><%= jad.getEndTime()%></td>
                            <td>
                                
                                <button type="submit" name="classId" value="<%= jad.getIdKelas() %>" class="btn btn-primary">Add Attendance</button>
                                <button type="submit" name="classId" value="<%= jad.getIdKelas() %>" class="btn btn-primary">Edit Attendance</button>
                            </td>
                        </tr>
                        <%
                                
                            }
                        %>
                    </tbody>
                </table>
            </form>

        </div>
    </body>
</html>