<%-- 
    Document   : addNilaiSiswa
    Created on : 9 Dec 2024
    Author     : putri
--%>

<%@page import="model.Teacher"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.Student"%>
<%@page import="dao.gradeDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nilai Mata Pelajaran</title>
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
                        <a class="nav-link " href="${pageContext.request.contextPath}/DashboardGuru">
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
                        <span class=" text-white fw-bold">Menu</span>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JadwalServlet">
                            <i data-feather="calendar" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mengajar</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/frontEnd/Guru/viewJadwalGuru.jsp">
                            <i data-feather="user-check" class="align-middle"></i>
                            <span class="align-middle">Presensi Siswa</span>
                        </a>

                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nilaiServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/frontEnd/Guru/menuRapot.jsp">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Rapot Siswa</span>
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
        <div id="content" class="flex-grow-1">                
            <!-- Konten -->
            <div class="container mt-4">
                <h3 class="mb-4 text-center">Tambah Nilai Siswa</h3>
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <% 
                            String className = (String) request.getSession().getAttribute("kelas");
                            gradeDao dao = new gradeDao();
                            List<Student> siswaList = dao.getSiswaByKelas(className); 
                            User user = (User) request.getSession().getAttribute("user"); 
                            Teacher guru = dao.getTeacherByUserId(user.getId());
                        %>
                        <form id="addNilaiForm" action="${pageContext.request.contextPath}/nilaiServlet" method="post">
                            <!-- Input Hidden -->
                            <input type="hidden" name="kelas" value="<%= className %>">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="idGuru" value="<%= guru.getId() %>">

                            <!-- Dropdown Nama Siswa -->
                            <div class="mb-3">
                                <label for="siswa" class="form-label"><b>Nama Siswa</b></label>
                                <select name="siswa" id="siswa" class="form-select" required>
                                    <option value=""><b>Pilih Nama Siswa</b></option>
                                    <% 
                                        if (siswaList != null && !siswaList.isEmpty()) {
                                            for (Student siswa : siswaList) {
                                    %>
                                    <option value="<%= siswa.getNis() %>"><%= siswa.getName() %></option>
                                    <% 
                                            }
                                        } else {
                                    %>
                                    <option value="">Tidak ada siswa dalam kelas ini</option>
                                    <% 
                                        }
                                    %>
                                </select>
                            </div>

                            <!-- Input Nilai -->
                            <div class="mb-3">
                                <label for="uts" class="form-label"><b>Nilai UTS</b></label>
                                <input type="number" name="uts" id="uts" class="form-control" 
                                    placeholder="Masukkan nilai UTS (0-100)" min="0" max="100" required>
                            </div>
                            <div class="mb-3">
                                <label for="uas" class="form-label"><b>Nilai UAS</b></label>
                                <input type="number" name="uas" id="uas" class="form-control" 
                                    placeholder="Masukkan nilai UAS (0-100)" min="0" max="100" required>
                            </div>
                            <div class="mb-3">
                                <label for="tugas" class="form-label"><b>Nilai Tugas</b></label>
                                <input type="number" name="tugas" id="tugas" class="form-control" 
                                    placeholder="Masukkan nilai tugas (0-100)" min="0" max="100" required>
                            </div>

                            <!-- Tombol -->
                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="bi bi-save"></i> Simpan
                                </button>
                                <a href="nilaiMapel.jsp" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Kembali
                                </a>
                            </div>
                        </form>
                    </div>
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
