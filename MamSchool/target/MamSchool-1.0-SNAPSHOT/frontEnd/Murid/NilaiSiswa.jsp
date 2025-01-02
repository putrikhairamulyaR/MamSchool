<%-- 
    Document   : Nilai
    Created on : 20 Nov 2024, 14.46.14
    Author     : putri
--%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Student" %>
<%@ page import="model.nilai" %>
<%@ page import="model.User" %>
<%@ page import="dao.PresensiDao" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapot Siswa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .info {
            margin-bottom: 20px;
        }
        .info p {
            margin: 5px 0;
            font-size: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
    <body>
        <div class="container">
            <h1>Rapot Siswa</h1>
            <div class="info">
                <%
                    User user = (User) request.getSession().getAttribute("user");
                    Student siswa = (Student) request.getSession().getAttribute("siswa");
                %>
                <p>Nama: <%= siswa.getName() %></p>
                <p>Kelas: <%= siswa.getClassId() %></p>
                <p>NIS: <%= siswa.getNis() %></p>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Mata Pelajaran</th>
                        <th>UTS</th>
                        <th>UAS</th>
                        <th>Tugas</th>
                        <th>Grades</th>
                        <th>Kategori</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<nilai> listNilai = (List<nilai>) request.getSession().getAttribute("listNilai");
                        int no = 1;
                        for (nilai n : listNilai) {
                            if (n != null) {
                    %>
                            <tr>
                                <td><%= no++ %></td>
                                <td><%= n.getSubject() %></td>
                                <td><%= n.getUts() %></td>
                                <td><%= n.getUas() %></td>
                                <td><%= n.getTugas() %></td>
                                <td><%= n.getGrade() %></td>
                                <td><%= n.getKategori() %></td>
                            </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>

            <p>Data Kehadiran:</p>
            <%
                int kehadiranHadir = (Integer) request.getSession().getAttribute("kehadiranHadir");
                int totalSakit = (Integer) request.getSession().getAttribute("totalSakit");
                int totalIzin = (Integer) request.getSession().getAttribute("totalIzin");
                int totalAlpa = (Integer) request.getSession().getAttribute("totalAlpa");
            %>
            <p>Jumlah Kehadiran Hadir: <%= kehadiranHadir %></p>
            <p>Jumlah Kehadiran Sakit: <%= totalSakit %></p>
            <p>Jumlah Kehadiran Izin: <%= totalIzin %></p>
            <p>Jumlah Kehadiran Alpa: <%= totalAlpa %></p>

            <p>Siswa dengan NIS <%= siswa.getNis() %> Dinyatakan 
                <% 
                    long totalKelulusan = (Long) request.getSession().getAttribute("totalKelulusan");
                    if (totalKelulusan >= 2) { 
                %>
                    <b>Lulus</b>
                <% 
                    } else { 
                %>
                    <b>Tidak Lulus</b>
                <% 
                    } 
                %>
                dan berhak lanjut ke semester berikutnya.
            </p>
        </div>
    </body>
</html>
