<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.Student"%>
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

        /* Table */
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
                        <i class="bi bi-house-door"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-person"></i>
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
                        <i class="bi bi-calendar-check"></i>
                        <span class="align-middle">Jadwal Mengajar</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/PresensiServlet">
                        <i class="bi bi-person-check"></i>
                        <span class="align-middle">Presensi Siswa</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/nilaiServlet">
                        <i class="bi bi-bar-chart"></i>
                        <span class="align-middle">Nilai Siswa</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rapotServlet">
                        <i class="bi bi-file-earmark"></i>
                        <span class="align-middle">Rapot Siswa</span>
                    </a>
                </li>
            </ul>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">
                        <i class="bi bi-box-arrow-right"></i>
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
                <% if (username != null) { %>
                    <span class="username-display"><%= username %></span>
                <% } else { %>
                    <span class="username-display">Dashboard</span>
                <% } %>
            </span>
        </nav>

        <!-- Content -->
        <div class="container mt-4">
            <h3>Presensi Siswa</h3>

            <%
                List<Student> students = (List<Student>) request.getSession().getAttribute("listSiswa");
            %>
            <% if (students == null || students.isEmpty()) { %>
                <div class="alert alert-warning text-center">Tidak ada siswa untuk guru ini.</div>
            <% } else { %>
                <form action="${pageContext.request.contextPath}/PresensiServlet" method="POST">
                    <input type="hidden" name="action" value="add">

                    <div class="table-container">
                        <table class="table table-bordered table-striped">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th>ID Siswa</th>
                                    <th>Nama</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Student student : students) { %>
                                    <tr>
                                        <td><%= student.getId()%></td>
                                        <td><%= student.getName() %></td>
                                        <td>
                                            <select name="status_<%= student.getId()%>" class="form-select">
                                                <option value="Hadir">Hadir</option>
                                                <option value="Izin">Izin</option>
                                                <option value="Sakit">Sakit</option>
                                                <option value="Alpa">Alpa</option>
                                            </select>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <button type="submit" class="btn btn-success">Submit Presensi</button>
                    </div>
                </form>
            <% } %>
        </div>
    </div>
</body>
</html>