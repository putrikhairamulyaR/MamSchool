<%-- 
    Document   : addJadwal
    Created on : Dec 31, 2024, 6:59:01 PM
    Author     : Necha
--%>

<%@page import="model.Classes"%>
<%@page import="dao.ClassesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>

<%
    ClassesDAO classesDao = new ClassesDAO();
    TeacherDAO  TeacherDAO = new TeacherDAO();
    List<Teacher> teachers = TeacherDAO.getTeachersSubject(); 
    List<Classes> classes = classesDao.getAllClasses();

    String selectedNip = request.getParameter("nip");
     String selectedClass = request.getParameter("name");
    String subject = null;
    
    

    if (selectedNip != null) {
        for (Teacher teacher : teachers) {
            if (teacher.getNip().equals(selectedNip)) {
                subject = teacher.getSubject();
                break;
            }
        }
    }
       
    

%>

<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tambah Jadwal</title>
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


        <!-- Page Content -->
            <div class="p-3">
                <div class="table-container">
                    <h3>Tambah Jadwal</h3>
            
        
                <form id="addJadwalForm" action="${pageContext.request.contextPath}/Jadwal" method="post">
                      <input type="hidden" name="action" value="add">
                    
                      <!-- Pilih NIP Guru -->
                    <div class="mb- 3">
                        <label for="nip" class="form-label">NIP - Nama - Mapel Guru</label>
                         <select name="nip" id="class" class="form-select" required onchange="fetchTeacherDetails()">
                            <%  for (Teacher teacher : teachers) {%>
                            <option value="<%= teacher.getNip()%> "><%= teacher.getNip()%> - <%= teacher.getName()%> - <%= teacher.getSubject()%> </option>                        
                            <%  }%>
                         </select>
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
                            
                            
                            
                            
                            <option value="" disabled selected>Pilih Hari</option>
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
                        <input type="time" name="jam" id="jamMulai" class="form-control" required>
                    </div>

                    <!-- Input Jam Selesai -->
                    <div class="mb-3">
                        <label for="jamSelesai" class="form-label">Jam Selesai</label>
                        <input type="time" name="jamSelesai" id="jamSelesai" class="form-control" required>
                    </div>
                    
                    <div class="text-end">
                    <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        <i class="bi bi-save me-2"></i> Simpan
                    </button>
                    <a href="ClassSchedule.jsp" class="btn btn-secondary btn-custom">
                        <i class="bi bi-arrow-left me-2"></i> Kembali
                        
                    </a>
                </div>
            </form>
        </div>
    </div>
                    
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Konfirmasi Penyimpanan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Apakah anda yakin ingin menyimpan jadwal ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary" form="addJadwalForm">Ya, Simpan</button>
                </div>
            </div>
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

