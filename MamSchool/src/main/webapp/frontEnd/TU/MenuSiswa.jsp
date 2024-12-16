<%-- 
    Document   : MenuSiswa
    Created on : 15 Dec 2024, 19.57.52
    Author     : luthfiah
--%>

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
            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid black;
            }

            th, td {
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            .action-buttons a {
                margin-right: 10px;
                text-decoration: none;
                padding: 5px 10px;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
            }

            .action-buttons a.delete {
                background-color: #dc3545;
            }
        </style>
    </head>
    <body>
        <h1>Daftar Siswa</h1>
        <!-- Button untuk menambahkan siswa -->
      
        <br><br>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>NIS</th>
                    <th>Nama</th>
                    <th>Tanggal Lahir</th>
                    <th>Tahun Masuk</th>
                    <th>Kelas</th>
                    <th>Jurusan</th>
                    <th>Wali Kelas</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Student> students = (List<Student>) request.getSession().getAttribute("siswa");

                    if (students != null && !students.isEmpty()) {
                        for (Student student : students) {
                
                    
                %>
                <tr>
                    <td><%= student.getId()%></td>
                    <td><%= student.getUserId()%></td>
                    <td><%= student.getNis()%></td>
                    <td><%= student.getName()%></td>
                    <td><%= student.getDateOfBirth()%></td>
                    <td><%= student.getEnrollmentYear()%></td>
                    <td><%= student.getClassId()%></td>
                    <td><%= student.getMajor()%></td>
                    <td><%= student.getTeacherId()  %></td>
                    <td class="action-buttons">
                        <!-- Tautan untuk edit siswa, mengarahkan ke edit.jsp -->
                        <a href="frontEnd/TU/addSiswa.jsp?id=<%= student.getId()%>">Add</a>
                        <a href="frontEnd/TU/editSiswa.jsp?id=<%= student.getId()%>">Edit</a>
                        <a href="SiswaServlet?action=delete&id=<%= student.getId()%>" class="delete" onclick="return confirm('Apakah Anda yakin ingin menghapus siswa ini?');">Hapus</a>
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
    </body>
</html>

