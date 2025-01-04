<%@page import="dao.TeacherDAO"%>
<%@page import="model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
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
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Guru</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
                z-index: 1030; /* Tetap di atas konten utama */
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
                margin-left: 250px; /* Ruang default sidebar */
                transition: margin-left 0.3s ease;
            }

            #content.expanded {
                margin-left: 0; /* Konten memenuhi layar */
            }

            /* Nav Link */
            #sidebar .nav-link {
                color: #ffffff;
                border-radius: 5px;

            }
            #sidebar .nav-link:hover{
                background-color: #628ab1;
            }
            #sidebar .active{
                border-left: 3px solid #ffffff;
                background-color: #628ab1;
                font-weight: bold;
            }

            /* Content */
            #content {
                flex-grow: 1;
                margin-left: 250px; /* Ruang default sidebar */
                transition: margin-left 0.3s ease;
            }

            #content.expanded {
                margin-left: 0; /* Konten memenuhi layar */
            }

            .table-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid #ccc;
            }

            th, td {
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
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
                        <a class="nav-link " href="${pageContext.request.contextPath}/DashboardTU">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/SiswaServlet">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/ListClassServlet">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/TeacherServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar Guru</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ClassScheduleServlet">
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
        <div class="p-3">
                <div class="table-container">                    
                    <h1>Daftar Guru</h1>
                    <div class="container">
                        <!-- Tombol Add Guru -->
                        <a href="frontEnd/TU/addTeacher.jsp" class="btn btn-success btn-sm mb-3">
                        <i class="bi bi-plus"></i> Tambah Guru
                        </a>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>NIP</th>
                                    <th>Nama</th>
                                    <th>Tanggal Lahir</th>
                                    <th>Subyek</th>
                                    <th>Tahun Masuk</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Ambil data guru dari DAO
                                    TeacherDAO dao = new TeacherDAO();
                                    List<Teacher> teachers = dao.getAllTeachers();

                                    if (teachers != null && !teachers.isEmpty()) {
                                        for (Teacher teacher : teachers) {
                                %>
                                <tr>
                                    <td><%= teacher.getId() %></td>
                                    <td><%= teacher.getNip() %></td>
                                    <td><%= teacher.getName() %></td>
                                    <td><%= teacher.getDateOfBirth() %></td>
                                    <td><%= teacher.getSubject() %></td>
                                    <td><%= teacher.getHireDate()%></td>

                                    <td class="action-buttons">
                                        <!-- Edit dan Hapus -->
                                        <a href="frontEnd/TU/editTeacher.jsp?id=<%= teacher.getId() %>" class="btn btn-warning btn-sm edit">
                                            Edit
                                        </a>
                                        <a href="TeacherServlet?action=delete&id=<%= teacher.getId() %>" 
                                            class="btn btn-danger btn-sm delete" 
                                            onclick="return confirm('Apakah Anda yakin ingin menghapus Guru ini?');">
                                            Hapus
                                        </a>

                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="10" style="text-align: center;">Tidak ada data guru.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
            </div>
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