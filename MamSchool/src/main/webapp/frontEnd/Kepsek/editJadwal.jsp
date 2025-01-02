<%-- 
    Document   : editJadwal
    Created on : Dec 15, 2024, 9:18:49 PM
    Author     : Necha
--%>

<%@page import="java.util.List"%>
<%@page import="model.Jadwal"%>
<%@page import="dao.JadwalDAO"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="model.Classes"%>
<%@page import="dao.ClassesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Jadwal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
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
                        <a class="nav-link" href="#">
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
            
<%
    JadwalDAO jadwalDAO = new JadwalDAO();
    ClassesDAO classesDao = new ClassesDAO();
     List<Classes> classes = classesDao.getAllClasses();
    Teacher teacher = null;
    int id = Integer.parseInt(request.getParameter("id"));
    Jadwal jadwal = jadwalDAO.getJadwalById(id);
    
    if (jadwal != null) {
        teacher = jadwalDAO.getTeacherId(jadwal.getTeacherId());
    }
%>

    <div class="container mt-5">
        <h2>Edit Jadwal</h2>
        <form action="${pageContext.request.contextPath}/Jadwal?action=update" method="post">
            <input type="hidden" name="id" value="<%= jadwal.getId() %>">
            
            <!-- NIP Guru (disabled) -->
            <div class="mb-3">
                <label for="nip" class="form-label">NIP Guru</label>
                <input type="text" class="form-control" id="nip" name="nip" value="<%= teacher.getNip() %>" disabled>
            </div>

            <!-- Nama Guru (disabled) -->
            <div class="mb-3">
                <label for="teacherName" class="form-label">Nama Guru</label>
                <input type="text" class="form-control" id="teacherName" name="teacherName" value="<%= teacher.getName() %>" disabled>
            </div>

            <!-- Mapel (disabled) -->
            <div class="mb-3">
                <label for="subject" class="form-label">Mapel</label>
                <input type="text" class="form-control" id="subject" name="subject" value="<%= teacher.getSubject() %>" disabled>
            </div>

             <!-- Input Kelas -->
                    <div class="mb-3">
                        <label for="class" class="form-label">Kelas</label>
                        <select name="kelas" id="kelas" class="form-select" required>
                            <%
                                for (Classes cls : classes) {
                                  
                            %>
                            <option value="<%= cls.getId() %>">
                                <%= cls.getName()%>
                            </option>
                            <%
                                
                                }
                            %>
                        </select>
                    </div>

            <!-- Input Hari -->
            <div class="mb-3">
                <label for="hari" class="form-label">Hari</label>
                <select name="hari" id="hari" class="form-select" required>
                    <option value="<%= jadwal.getDay() %>" selected><%= jadwal.getDay() %></option>
                    <option value="senin">Senin</option>
                    <option value="selasa">Selasa</option>
                    <option value="rabu">Rabu</option>
                    <option value="kamis">Kamis</option>
                    <option value="jumat">Jumat</option>
                    <option value="sabtu">Sabtu</option>
                </select>
            </div>

            <!-- Input Jam Mulai -->
            <div class="mb-3">
                <label for="jamMulai" class="form-label">Jam Mulai</label>
                <input type="time" name="jam" id="jamMulai" class="form-control" value="<%= jadwal.getStartTime() %>" required>
            </div>

            <!-- Input Jam Selesai -->
            <div class="mb-3">
                <label for="jamSelesai" class="form-label">Jam Selesai</label>
                <input type="time" name="jamSelesai" id="jamSelesai" class="form-control" value="<%= jadwal.getEndTime() %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Jadwal</button>
            <a href="listJadwal.jsp" class ="btn btn-secondary">Batal</a>
       
                
         
        </form>
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