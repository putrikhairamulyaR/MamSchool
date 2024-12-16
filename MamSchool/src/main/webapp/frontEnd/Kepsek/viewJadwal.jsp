<%-- 
    Document   : viewJadwal
    Created on : Dec 15, 2024, 8:40:05 PM
    Author     : Necha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Jadwal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #34495e;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 15px;
            position: fixed;
            height: 100%;
        }

        .sidebar h4 {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }

        .sidebar a:hover {
            background-color: #2980b9;
        }

        .sidebar a i {
            margin-right: 10px;
        }

        /* Konten */
        .content {
            margin-left: 260px;
            padding: 20px;
            flex: 1;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

        /* Table Styling */
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table th, .table td {
            text-align: center;
        }
    </style>
</head>

<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4>Dashboard Siswa</h4>
        <a href="#"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="#"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="#"><i class="bi bi-clipboard2-check"></i> Nilai</a>
        <a href="#"><i class="bi bi-book"></i> Mapel</a>
        <hr>
        <a href="#"><i class="bi bi-gear"></i> Setting</a>
        <a href="#"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="#"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

    <!-- Konten Utama -->
    <div class="content">
        <h3>View Jadwal</h3>
        <!-- Table for Jadwal -->
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Kelas</th>
                        <th>Mata Pelajaran</th>
                        <th>Guru</th>
                        <th>Hari</th>
                        <th>Jam</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="Jadwal" items="${JadwalList}">
                        <tr>
                            <td>${Jadwal.index + 1}</td>
                            <td>${Jadwal.kelas}</td>
                            <td>${Jadwal.mapel}</td>
                            <td>${Jadwal.nipGuru}</td>
                            <td>${Jadwal.hari}</td>
                            <td>${Jadwal.jam}</td>
                            <td>
                                <a href="editJadwal.jsp?id=${Jadwal.id}" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i> Edit
                                </a>
                                <a href="deleteJadwal?id=${Jadwal.id}" class="btn btn-danger btn-sm">
                                    <i class="bi bi-trash"></i> Hapus
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3. 0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>