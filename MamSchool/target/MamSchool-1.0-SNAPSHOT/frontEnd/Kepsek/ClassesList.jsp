<%-- 
    Document   : ClassesList
    Created on : 14 Dec 2024, 23.14.00
    Author     : Raisa Lukman Hakim
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Kelas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/DashboardKepsek">
                            <i data-feather="sliders" class="align-middle"></i>
                            <span class="align-middle">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i data-feather="user" class="align-middle"></i>
                            <span class="align-middle">Profile</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class=" text-white fw-bold">Siswa</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Nama Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/ClassesServlet">
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
                        <a class="nav-link" href="#">
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
                        <a class="nav-link" href="#">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Nama Guru</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mengajar</span>
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
                <span class="navbar-brand mb-0 h1">Dashboard</span>
            </nav>

            <!-- Page Content -->
            <div class="p-3">
                <div class="table-container">
                    <h3>Daftar Kelas</h3>
                    <a href="frontEnd/Kepsek/AddClasses.jsp" class="btn btn-success btn-sm mb-3">
                        <i class="bi bi-plus"></i> Tambah Kelas
                    </a>
                    <form action="${pageContext.request.contextPath}/ClassesServlet" method="get" class="mb-4">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="major" class="form-label">Jurusan:</label>
                                <select name="major" id="major" class="form-select">
                                    <option value="">Semua Jurusan</option>
                                    <option value="IPA" ${param.major == 'IPA' ? 'selected' : ''}>IPA</option>
                                    <option value="IPS" ${param.major == 'IPS' ? 'selected' : ''}>IPS</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="tingkat" class="form-label">Tingkat:</label>
                                <select name="tingkat" id="tingkat" class="form-select">
                                    <option value="">Semua Tingkat</option>
                                    <option value="1" ${param.tingkat == '1' ? 'selected' : ''}>Tingkat 1</option>
                                    <option value="2" ${param.tingkat == '2' ? 'selected' : ''}>Tingkat 2</option>
                                    <option value="3" ${param.tingkat == '3' ? 'selected' : ''}>Tingkat 3</option>
                                </select>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">Filter</button>
                            </div>
                        </div>
                    </form>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nama Kelas</th>
                                <th>Jurusan</th>
                                <th>ID Guru</th>
                                <th>Tingkat</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="classes" items="${classesList}">
                                <tr>
                                    <td>${classes.id}</td>
                                    <td>${classes.name}</td>
                                    <td>${classes.major}</td>
                                    <td>${classes.teacher_id != null ? classes.teacher_id : 'Belum Ada'}</td>
                                    <td>${classes.tingkat}</td>
                                    <td>
                                        <a href="ClassesServlet?action=edit&id=${classes.id}" class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil"></i> Edit
                                        </a>
                                        <a href="ClassesServlet?action=delete&id=${classes.id}" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus kelas ini?');">
                                            <i class="bi bi-trash"></i> Hapus
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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
