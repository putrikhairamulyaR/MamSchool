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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
                        <a class="nav-link active " href="${pageContext.request.contextPath}/DashboardKepsek">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/ListStudentServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">List Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ClassesServlet">
                            <i data-feather="shuffle" class="align-middle"></i>
                            <span class="align-middle">Bagi Kelas</span>
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
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">Guru</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ListTeacherServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">List Guru</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ClassScheduleServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mengajar</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/MamSchool/frontEnd/Kepsek/listJadwal.jsp">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Informasi Jadwal</span>
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
                   
                </span>
            </nav>

        <!-- Main Content -->
        <div class="container p-4">
            <h2 class="mb-4">List Jadwal</h2>
             <a href="addJadwal.jsp" class="btn btn-success btn-sm mb-3">
                        <i class="bi bi-plus"></i> Tambah Jadwal
                    </a>
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

                               <a href="editJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-warning btn-sm">
                                   
                                  <i class="bi bi-pencil"></i>Edit
                               </a>

                               <a href="deleteJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-danger btn-sm">
                               <i class="bi bi-trash"></i>Hapus
                               </a>
                               <a href="viewJadwal.jsp?id=<%= jadwal.getId() %>" class="btn btn-info btn-sm">
                               <i class="bi bi-eye"></i>View
                               </a>
                           </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    

                    <%

                        }

                    %>
                </tbody>
            </table>
            
           
        </div>
    </div>
     <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://unpkg.com/feather-icons"></script>
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