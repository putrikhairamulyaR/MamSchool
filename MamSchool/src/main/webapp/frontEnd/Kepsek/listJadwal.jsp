<%-- 
    Document   : listJadwal
    Created on : Dec 29, 2024, 3:36:20 AM
    Author     : Necha
--%>


<%@page import="model.Jadwal"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jadwal List</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Bootstrap Link (optional for styling) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Sidebar -->
    <div class="d-flex">
        <nav class="sidebar bg-dark text-light p-3 vh-100">
            <h4 class="mb-4 text-center">Dashboard Siswa</h4>
            <ul class="nav flex-column">
                <li class="nav-item"><a href="#" class="nav-link text-light">🏠 Beranda</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">📅 Kelas</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">📊 Nilai</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">📘 Mapel</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">⚙️ Setting</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">❓ Bantuan</a></li>
                <li class="nav-item"><a href="#" class="nav-link text-light">🔑 Logout</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="container p-4">
            <h2 class="mb-4">List Jadwal</h2>
            <table class="table table-bordered table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Kelas</th>
                        <th>Mapel</th>
                        <th>Guru</th>
                        <th>Hari</th>
                        <th>Jam Mulai</th>
                        <th>Jam Selesai</th>
                         <th>Aksi</th> 
                    </tr>
                </thead>
                <tbody>
                    <tbody>
                    <%
                        List<Jadwal> scheduleList = (List<Jadwal>) request.getSession().getAttribute("scheduleList");
                        if (scheduleList != null) {
                            for (Jadwal jadwal : scheduleList) {
                    %>
                    <tr>
                        <td><%= jadwal.getId() %></td>
                        <td><%= jadwal.getidKelas() %></td>
                        <td><%= jadwal.getSubjectId() %></td>
                        <td><%= jadwal.getTeacherId() %></td>
                        <td><%= jadwal.getDay() %></td>
                        <td><%= jadwal.getStartTime() %></td>
                        <td><%= jadwal.getEndTime() %></td>
                        <td>

                               <a href="editJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-warning btn-sm">Edit</a>

                               <a href="deleteJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-danger btn-sm">Delete</a>

                               <a href="viewJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-info btn-sm">View</a>

                           </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" class="text-center">Tidak ada jadwal yang tersedia.</td>

                    </tr>

                    <%

                        }

                    %>
                </tbody>
            </table>
            <a href="addJadwal.jsp" class="btn btn-primary">Tambah Jadwal</a>
           
        </div>
    </div>
</body>
</html>