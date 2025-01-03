<%-- 
    Document   : MenuSiswa
    Created on : 15 Dec 2024, 19.57.52
    Author     : luthfiah
--%>

<%@page import="dao.siswaDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (!"tu".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Siswa</title>
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
            
            #sidebar .nav-link {
                color: #ffffff;
                padding: 10px;
                text-decoration: none;
                display: block;
            }

            #sidebar .nav-link:hover {
                background-color: #628ab1;
            }

            /* Content */
            #content {
                margin-left: 250px;
                padding: 20px;
            }

            #content.expanded {
                margin-left: 0;
            }

            /* Nav Link */
            #sidebar .active{
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

            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: left;
                margin-top: 10px;
                color: #34495e;
            }

            .container {
                width: 80%;
                margin: 0 auto;
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
                background-color: #34495e;
                color: white;
            }

            .action-buttons a {
                text-decoration: none;
                padding: 6px 12px;
                color: white;
                border-radius: 5px;
            }

            .action-buttons a.edit {
                background-color:#FFD700;
            }

            .action-buttons a.delete {
                background-color: #dc3545;
            }

            .btn-add {
                display: inline-block;
                padding: 8px 15px;
                color: white;
                background-color: #2E8B57;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                margin-bottom: 20px;
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
                        <a class="nav-link active " href="${pageContext.request.contextPath}/frontEnd/TU/DashboardTU.jsp">
                            <i data-feather="sliders" class="align-middle"></i>
                            <span class="align-middle">Dashboard</span>
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
                            <span class="align-middle">Daftar Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/StudentServlet">
                            <i data-feather="user-check" class="align-middle"></i>
                            <span class="align-middle">Siswa dan Kelas</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GradesServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/PresensiServlet">
                            <i data-feather="pie-chart" class="align-middle"></i>
                            <span class="align-middle">Presensi Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/ListClassServlet">
                            <i data-feather="table" class="align-middle"></i>
                            <span class="align-middle">Daftar Kelas</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">Guru</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/TeacherServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar Guru</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JadwalServlet">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mengajar</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">User</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/SigninServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar User</span>
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
            <!-- Navbar -->
            <nav class="navbar navbar-light bg-light px-3 border-bottom">
                <button class="navbar-toggler border-0 outline-0" id="toggleSidebar" type="button">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <span class="navbar-brand mb-0 h1">
                    <%
                        if (username != null) {
                            out.print("<span class='username-display'>" + username + "</span>");
                        } else {
                            out.print("<span class='username-display'>Dashboard</span>");
                        }
                    %>
                </span>
            </nav>
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
                            <td><%= student.getId()%></td>
                            <td><%= student.getUserId()%></td>
                            <td><%= student.getNis()%></td>
                            <td><%= student.getName()%></td>
                            <td><%= student.getDateOfBirth()%></td>
                            <td><%= student.getEnrollmentYear()%></td>
                            <td><%= (student.getMajor() != null ? student.getMajor() : "Tidak Ada")%></td>
                            <td class="action-buttons">
                                <!-- Edit dan Hapus -->
                                <a href="frontEnd/TU/editSiswa.jsp?id=<%= student.getId()%>" class="edit">Edit</a>
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