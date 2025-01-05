<%-- 
    Document   : nilaiMapel
    Created on : 9 Dec 2024, 08.18.52
    Author     : putri
--%>

<%@page import="model.Teacher"%>
<%@page import="dao.gradeDao"%>
<%@page import="model.User"%>
<%@page import="model.Classes"%>
<%@page import="dao.ClassesDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.nilai"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nilai Mata Pelajaran</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Feather Icons -->
        <script src="https://unpkg.com/feather-icons"></script>
        <style>
        body {
            display: flex;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

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
            border: 1px solid black !important;
        }

        table, th, td {
            border: 1px solid #dee2e6;
            border: 1px solid black !important;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
             background-color: #d3d3d3 !important
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

    <div id="content" class="flex-grow-1">

            <!-- Konten -->
            <div class="content">
                <!-- Filter Kelas dan Kategori -->
                <div class="filter-container">
                    <form action="${pageContext.request.contextPath}/nilaiServlet" method="get">
                        <input type="hidden" name="action" value="view">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="kelas" class="form-label">Pilih Kelas</label>
                                <%
                                    gradeDao KelasDao = new gradeDao();
                                    User user= (User) request.getSession().getAttribute("user");
                                    Teacher guru=(Teacher) request.getSession().getAttribute("guru");
                                    List<Classes> Kelas = ( List<Classes>) request.getSession().getAttribute("ListKelas");
                                %>

                                <select class="form-select" id="kelas" name="kelas">
                                    <%
                                        if (Kelas != null && !Kelas.isEmpty()) {
                                            for (Classes kelas : Kelas) {
                                    %>
                                    <option value="<%= kelas.getName()%>"><%= kelas.getName()%></option>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <option value="">Tidak ada kelas tersedia</option>
                                    <%
                                        }
                                    %>
                                </select>

                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">Tampilkan Nilai</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="mb-3">
                    <a href="<%= request.getContextPath() %>/frontEnd/Guru/addNilaiSiswa.jsp" class="btn btn-success">
                        <i class="bi bi-plus-circle me-2"></i> Tambah Nilai Siswa
                    </a>

                </div>

                <!-- Tabel Data -->
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>NIM</th>
                                <th>Nama</th>
                                <th>UTS</th>
                                <th>UAS</th>
                                <th>Tugas</th>
                                <th>Grade</th>
                                <th>Kriteria</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <%
                            // Ambil atribut dari session
                            List<nilai> grades = (List<nilai>) request.getSession().getAttribute("grades");
                        %>


                            <tbody>
                                <% if (grades != null && !grades.isEmpty()) {
                                        int index = 1;
                                        for (nilai grade : grades) {%>
                                <tr>

                                    <td><%= grade.getIdNilai()%></td>
                                    <td><%= grade.getNis()%></td>
                                    <td><%= grade.getName()%></td>
                                    <td><%= grade.getUts()%></td>
                                    <td><%= grade.getUas()%></td>
                                    <td><%= grade.getTugas()%></td>
                                    <td><%= grade.getGrade()%></td>
                                    <td><%= grade.getKategori()%></td>
                                    <td class="action-icons">
                                        <a href="<%= request.getContextPath() %>/frontEnd/Guru/editNilaiSiswa.jsp?id=<%= grade.getIdNilai() %>" class = "btn btn-warning"><i class="bi bi-pencil-square " title="Edit"></i>Edit</a>
                                        <a href="<%= request.getContextPath() %>/frontEnd/Guru/deleteNilaiSiswa.jsp?id=<%= grade.getIdNilai() %>"class = "btn btn-danger"><i class="bi bi-trash"></i>Delete</a>
                                    </td>
                                </tr>
                                <%  }
                                } else { %>
                                <tr>
                                    <td colspan="8">Tidak ada data untuk ditampilkan.</td>
                                </tr>
                                <% }%>

                            </tbody>
                        </table>
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

