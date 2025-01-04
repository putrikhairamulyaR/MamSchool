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

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rapot Siswa</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Feather Icons -->
        <script src="https://unpkg.com/feather-icons"></script>
        <style>
            /* Sidebar */
            #sidebar {
                width: 250px;
                transition: transform 0.3s ease, visibility 0.3s ease;
                overflow: auto;
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                z-index: 1030; 
                background-color: #34495e;
                color: #ffffff;
            }

            #sidebar.hidden {
                transform: translateX(-100%);
                visibility: hidden;
            }

            /* Content */
            #content {
                flex-grow: 1;
                margin-left: 250px;
                transition: margin-left 0.3s ease;
            }

            #content.expanded {
                margin-left: 0;
            }

            /* Nav Link */
            #sidebar .nav-link {
                color: #ffffff;
                border-radius: 5px;
            }

            #sidebar .nav-link:hover {
                background-color: #628ab1;
            }

            #sidebar .active {
                border-left: 3px solid #ffffff;
                background-color: #628ab1;
                font-weight: bold;
            }

            .username-display {
                display: inline-block;
                padding: 5px 15px;
                background-color: #f0f0f0;
                border-radius: 20px;
                color: #333;
                font-weight: bold;
                font-size: 14px;
                border: 1px solid #ccc;
            }

            /* Table Styling */
            table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
                margin-bottom: 30px;
                border: 1px solid black !important;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid black;
            }

            table thead th {
                  
                background-color: #d3d3d3 !important; 
                color: black; 
                border: 1px solid black;
                
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .info {
                margin-bottom: 20px;
            }
            .text-red {
                color: red;
            }
            .info p {
                font-size: 1.1em;
                font-weight: 500;
                margin-bottom: 10px;
            }

            .info b {
                font-size: 1.2em;
                color: #2ecc71;
            }

            h1 {
                font-size: 2em;
                font-weight: 600;
                margin-bottom: 30px;
                
            }

            .container {
                max-width: 1200px;
                margin-top: 50px;
            }
        </style>
    </head>
    <body class="d-flex">
        <!-- Sidebar -->
        <nav id="sidebar" class="border-end vh-100 shadow">
            <div class="p-3">
                <a class="navbar-brand d-flex align-items-center mb-3" href="#">
                    <span class="align-middle">Mam School</span>
                </a>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class=" text-sm text-white fw-bold">Pages</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/DasboardSiswa">
                            <i data-feather="sliders" class="align-middle"></i>
                            <span class="align-middle">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ProfileUser">
                            <i data-feather="user" class="align-middle"></i>
                            <span class="align-middle">Profile</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class=" text-white fw-bold">Siswa</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/siswaServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">List Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/PresensiServlet">
                            <i data-feather="pie-chart" class="align-middle"></i>
                            <span class="align-middle">Presensi Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JadwalServlet">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mata Pelajaran</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GradesServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/rapotDiSiswa">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Raport Siswa</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">Accounts</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">
                            <i data-feather="log-out" class="align-middle"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <div id="content" class="flex-grow-1">
            <div class="container">
                <h1 class="text-center text-primary mb-4">Rapot Siswa</h1>
                
                <div class="info">
                    <%
                        User user = (User) request.getSession().getAttribute("user");
                        Student siswa = (Student) request.getSession().getAttribute("siswa");
                    %>
                    <p>Nama: <%= siswa.getName() %></p>
                    <p>Id Kelas: <%= siswa.getClassId() %></p>
                    <p>NIS: <%= siswa.getNis() %></p>
                </div>
     
                <table class="table table-bordered">
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

                <p><b>Data Kehadiran:</b></p>
                <%
                    int kehadiranHadir = (Integer) request.getSession().getAttribute("kehadiranHadir");
                    int totalSakit = (Integer) request.getSession().getAttribute("totalSakit");
                    int totalIzin = (Integer) request.getSession().getAttribute("totalIzin");
                    int totalAlpa = (Integer) request.getSession().getAttribute("totalAlpa");
                %>
                <ul>
                    <li>Hadir: <%= kehadiranHadir %></li>
                    <li>Sakit: <%= totalSakit %></li>
                    <li>Izin: <%= totalIzin %></li>
                    <li>Alpa: <%= totalAlpa %></li>
                </ul>
                <p> </p>
                <p>Siswa dengan NIS <%= siswa.getNis() %> Dinyatakan 
                    <% 
                        long totalD = (Long) request.getSession().getAttribute("totD");
                        long totalE = (Long) request.getSession().getAttribute("totE");
                        if (totalD <= 0 && totalE <= 0 ) { 
                    %>
                        <b style="color: #006400;">Lulus</b>

                    <% 
                        } else { 
                    %>
                        <b class="text-red">Tidak Lulus</b>
                    <% 
                        } 
                    %>
                    pada semester ini.
                </p>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Activate Feather Icons -->
        <script>
            feather.replace({color: '#ffffff'});

            const toggleButton = document.getElementById("toggleSidebar");
            const sidebar = document.getElementById("sidebar");
            const content = document.getElementById("content");

            toggleButton.addEventListener("click", () => {
                // Toggle Sidebar
                if (sidebar.classList.contains("hidden")) {
                    sidebar.classList.remove("hidden");
                    content.classList.remove("expanded");
                } else {
                    sidebar.classList.add("hidden");
                    content.classList.add("expanded");
                }
            });
        </script>

    </body>
</html>
