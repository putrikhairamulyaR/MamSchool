<%-- 
    Document   : deleteNilaiSiswa
    Created on : 9 Dec 2024
    Author     : putri
--%>


<%@page import="model.nilai"%>
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
                        <a class="nav-link active " href="${pageContext.request.contextPath}/DashboardGuru">
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
                    <li class="nav-item">
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

    <!-- Main Content -->
    <div id="content" class="flex-grow-1">
        <!-- Konten -->
        <div class="container mt-4">
        <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Informasi Nilai Siswa</h5>
                </div>
                <div class="card-body">
                    <% 
                        String id = request.getParameter("id");
                        gradeDao gd = new gradeDao();
                        nilai grade = null;

                        try {
                            if (id != null) {
                                grade = gd.getGradeById(Integer.parseInt(id));
                            }
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                        }

                        if (grade == null) {
                    %>
                        <p class="text-danger">Data tidak ditemukan atau ID tidak valid.</p>
                        <a href="nilaiMapel.jsp" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i> Kembali
                        </a>
                    <% return; } %>

                    <div class="mb-3">
                        <strong>ID Nilai:</strong>
                        <span class="text-secondary"><%= grade.getIdNilai() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Nama:</strong>
                        <span class="text-secondary"><%= grade.getName() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>NISN:</strong>
                        <span class="text-secondary"><%= grade.getNis() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Kelas:</strong>
                        <span class="text-secondary"><%= grade.getNamaKelas() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Nilai UTS:</strong>
                        <span class="text-secondary"><%= grade.getUts() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Nilai UAS:</strong>
                        <span class="text-secondary"><%= grade.getUas() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Nilai Tugas:</strong>
                        <span class="text-secondary"><%= grade.getTugas() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Total Nilai:</strong>
                        <span class="text-secondary"><%= grade.getGrade() %></span>
                    </div>
                    <div class="mb-3">
                        <strong>Kategori:</strong>
                        <span class="text-secondary"><%= grade.getKategori() %></span>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <form action="${pageContext.request.contextPath}/nilaiServlet" method="post" class="d-inline">
                        <input type="hidden" name="id" value="<%= grade.getIdNilai() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-trash me-2"></i> Hapus
                        </button>
                    </form>
                    <a href="nilaiMapel.jsp" class="btn btn-secondary">
                        <i class="bi bi-arrow-left me-2"></i> Kembali
                    </a>
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
