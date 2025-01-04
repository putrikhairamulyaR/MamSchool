<%-- 
    Document   : editNilaiSiswa
    Created on : 9 Dec 2024, 08.18.21
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
    <title>Tambah Nilai Siswa</title>
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/frontEnd/Guru/viewJadwalGuru.jsp">
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/frontEnd/Guru/menuRapot.jsp">
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

<div id="content" class="flex-grow-1">   
    <!-- Konten Utama -->
        <div class="content">
            <h3>Tambah Nilai Siswa</h3>

            <!-- Form Input Nilai Siswa -->
            <div class="form-container">
                <%String id = request.getParameter("id");
                    gradeDao gd = new gradeDao();
                    nilai grade = gd.getGradeById(Integer.parseInt(id));

                %>
                <form id="editNilaiForm" action="${pageContext.request.contextPath}/nilaiServlet" method="post">
                   <!-- Input id -->
                   <input type="hidden" name ="id" value ="<%=grade.getIdNilai()%>">
                    <input type="hidden" name="action" value ="update">
                    <!-- Input UTS -->
                   <div class="mb-3">
                       <label for="uts" class="form-label">Nilai UTS</label>
                       <input type="number" name="uts" id="uts" class="form-control" value="<%=grade.getUts()%>" required><br><br>
                   </div>

                   <!-- Input UAS -->
                   <div class="mb-3">
                       <label for="uas" class="form-label">Nilai UAS</label>
                       <input type="number" name="uas" id="uas" class="form-control" value="<%=grade.getUas()%>" required><br><br>
                   </div>

                   <!-- Input Tugas -->
                   <div class="mb-3">
                       <label for="tugas" class="form-label">Nilai Tugas</label>
                       <input type="number" name="tugas" id="tugas" class="form-control" value="<%=grade.getTugas()%>" required><br><br>
                   </div>

                   <!-- Tombol Submit -->
                   <div class="text-end">
                       <button type="submit" class="btn btn-primary btn-custom">
                            <i class="bi bi-save me-2"></i> Simpan
                        </button>
                       <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                           <i class="bi bi-arrow-left me-2"></i> Kembali
                       </a>
                   </div>
               </form>
            </div>
        </div>
 </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>

