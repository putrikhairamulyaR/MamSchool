<%-- 
    Document   : MenuSiswa
    Created on : 15 Dec 2024, 19.57.52
    Author     : luthfiah
--%>

<%@page import="dao.siswaDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Siswa</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #007bff;
                margin-top: 20px;
            }

            .container {
                width: 80%;
                margin: 0 auto;
                background: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding: 20px;
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9ecef;
            }

            .action-buttons a {
                text-decoration: none;
                padding: 6px 12px;
                color: white;
                border-radius: 5px;
            }

            .action-buttons a.edit {
                background-color: #28a745;
            }

            .action-buttons a.delete {
                background-color: #dc3545;
            }

            .btn-add {
                display: inline-block;
                padding: 8px 15px;
                color: white;
                background-color: #17a2b8;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
            }

            .btn-add:hover {
                background-color: #138496;
            }
        </style>
    </head>
    <body>
        <h1>Daftar Siswa</h1>
        <div class="container">
            <!-- Tombol Add Siswa -->
            <a href="frontEnd/TU/addSiswa.jsp" class="btn-add">+ Tambah Siswa</a>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>NIS</th>
                        <th>Nama</th>
                        <th>Tanggal Lahir</th>
                        <th>Tahun Masuk</th>
                        <th>Jurusan</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Ambil data siswa dari DAO
                        siswaDAO dao = new siswaDAO();
                        List<Student> students = dao.getAllSiswa();

                        if (students != null && !students.isEmpty()) {
                            for (Student student : students) {
                    %>
                    <tr>
                        <td><%= student.getId() %></td>
                        <td><%= student.getUserId() %></td>
                        <td><%= student.getNis() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getDateOfBirth() %></td>
                        <td><%= student.getEnrollmentYear() %></td>
                        <td><%= (student.getMajor() != null ? student.getMajor() : "Tidak Ada") %></td>
                        <td class="action-buttons">
                            <!-- Edit dan Hapus -->
                            <a href="frontEnd/TU/editSiswa.jsp?id=<%= student.getId() %>" class="edit">Edit</a>
                            <a href="SiswaServlet?action=delete&id=<%= student.getId() %>" class="delete" onclick="return confirm('Apakah Anda yakin ingin menghapus siswa ini?');">Hapus</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="10" style="text-align: center;">Tidak ada data siswa.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>