<%@page import="model.nilai"%>
<%@page import="dao.gradeDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (!"guru".equals(role)) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nilai Mata Pelajaran</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

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

        /* Filter */
        .filter-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .form-select, .btn {
            border-radius: 5px;
        }

        .filter-container .row {
            margin-bottom: 10px;
        }

        /* Tabel */
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #dee2e6;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f8f9fa;
        }

        .action-icons i {
            cursor: pointer;
            margin: 0 5px;
            color: #495057;
        }

        .action-icons i:hover {
            color: #007bff;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            #sidebar {
                width: 200px;
            }

            #content {
                margin-left: 0;
            }

            #toggleSidebar {
                display: block;
            }

            .table-container table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <nav id="sidebar" class="border-end vh-100 shadow">
        <div class="p-3">
            <a class="navbar-brand d-flex align-items-center mb-3" href="#">
                <span class="align-middle">Mam School</span>
            </a>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <span class="text-sm text-white fw-bold">Pages</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/DashboardKepsek">
                        <i class="bi bi-house-door" class="align-middle"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-person" class="align-middle"></i>
                        <span class="align-middle">Profile</span>
                    </a>
                </li>
            </ul>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <span class="text-white fw-bold">Menu</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/JadwalServlet">
                        <i class="bi bi-calendar-check" class="align-middle"></i>
                        <span class="align-middle">Jadwal Mengajar</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/PresensiServlet">
                        <i class="bi bi-person-check" class="align-middle"></i>
                        <span class="align-middle">Presensi Siswa</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/nilaiServlet">
                        <i class="bi bi-bar-chart" class="align-middle"></i>
                        <span class="align-middle">Nilai Siswa</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rapotServlet">
                        <i class="bi bi-file-earmark" class="align-middle"></i>
                        <span class="align-middle">Rapot Siswa</span>
                    </a>
                </li>
            </ul>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">
                        <i class="bi bi-box-arrow-right" class="align-middle"></i>
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
                <% if (username != null) { out.print("<span class='username-display'>" + username + "</span>"); } else { out.print("<span class='username-display'>Dashboard</span>"); } %>
            </span>
        </nav>

        <!-- Konten -->
        <div class="content">
            <h3>Informasi Nilai Siswa</h3>

            <!-- Tampilkan Informasi Nilai Siswa -->
            <div class="info-container">
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
                    <p>Data tidak ditemukan atau ID tidak valid.</p>
                    <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                        <i class="bi bi-arrow-left me-2"></i> Kembali
                    </a>
                <% return; } %>

                <div class="mb-3">
                    <div class="info-label">ID Nilai:</div>
                    <div><%= grade.getIdNilai() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Nama:</div>
                    <div><%= grade.getName() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">NISN:</div>
                    <div><%= grade.getNis() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Kelas:</div>
                    <div><%= grade.getKelas() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Nilai UTS:</div>
                    <div><%= grade.getUts() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Nilai UAS:</div>
                    <div><%= grade.getUas() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Nilai Tugas:</div>
                    <div><%= grade.getTugas() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Total Nilai:</div>
                    <div><%= grade.getGrade() %></div>
                </div>
                <div class="mb-3">
                    <div class="info-label">Kategori:</div>
                    <div><%= grade.getKategori() %></div>
                </div>

                <!-- Tombol Hapus -->
                <div class="text-end">
                    <form action="${pageContext.request.contextPath}/nilaiServlet" method="post" style="display: inline;">
                        <input type="hidden" name="id" value="<%= grade.getIdNilai() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="btn btn-danger btn-custom">
                            <i class="bi bi-trash me-2"></i> Hapus
                        </button>
                    </form>
                    <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                        <i class="bi bi-arrow-left me-2"></i> Kembali
                    </a>
                </div>
            </div>
        </div>
    </div>
                        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
