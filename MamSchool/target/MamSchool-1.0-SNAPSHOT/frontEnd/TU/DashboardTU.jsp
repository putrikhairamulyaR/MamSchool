<%-- 
    Document   : DashboardTU
    Created on : 15 Dec 2024, 18.16.49
    Author     : luthfiah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (!"tu".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard TU</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Feather Icons -->
        <script src="https://unpkg.com/feather-icons"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <a class="nav-link active " href="${pageContext.request.contextPath}/DashboardTU">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/SiswaServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GradesServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ListPresensiServlet">
                            <i data-feather="pie-chart" class="align-middle"></i>
                            <span class="align-middle">Presensi Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ListClassServlet">
                            <i data-feather="table" class="align-middle"></i>
                            <span class="align-middle">Daftar Kelas</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">Guru</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/TeacherServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar Guru</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ClassScheduleServlet">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mengajar</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">User</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/SigninServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">Daftar User</span>
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
                    <%
                        if (username != null) {
                            out.print("<span class='username-display'>" + username + "</span>");
                        } else {
                            out.print("<span class='username-display'>Dashboard</span>");
                        }
                    %>
                </span>
            </nav>



            <!-- Page Content -->
            <div class="container mt-5">
                <h1>Dashboard Tata Usaha</h1>
                <div class="row mt-4">
                    <!-- Statistics -->
                    <div class="col-md-3">
                        <div class="card   mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Pengguna</h5>
                                <p class="card-text">${totalUsers}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card   mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Siswa</h5>
                                <p class="card-text">${totalStudents}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card   mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Guru</h5>
                                <p class="card-text">${totalTeachers}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card   mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Kelas</h5>
                                <p class="card-text">${totalClasses}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="row mt-4">
                    <!-- Pie Chart: Distribution of Students by Major -->
                    <div class="col-md-6">
                        <h3>Distribusi Siswa Berdasarkan Jurusan</h3>
                        <canvas id="studentDistributionChart"></canvas>
                    </div>

                    <!-- Bar Chart: Average Monthly Attendance -->
                    <div class="col-md-6">
                        <h3>Rata-rata Kehadiran Bulanan</h3>
                        <canvas id="attendanceChart"></canvas>
                    </div>
                </div>

                <!-- Problematic Students -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h3>Highlight Siswa Bermasalah</h3>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>NIS</th>
                                    <th>Nama Siswa</th>
                                    <th>Kehadiran (%)</th>
                                    <th>Kelas</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${problematicStudents}">
                                    <tr>
                                        <td>${student["nis"]}</td>
                                        <td>${student["name"]}</td>
                                        <td>${student["attendance"]}%</td>
                                        <td>${student["className"]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Today Schedules -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h3>Jadwal Pelajaran Hari Ini</h3>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Kelas</th>
                                    <th>Mata Pelajaran</th>
                                    <th>Jam Mulai</th>
                                    <th>Jam Selesai</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="schedule" items="${todaySchedules}">
                                    <tr>
                                        <td>${schedule["className"]}</td>
                                        <td>${schedule["subjectName"]}</td>
                                        <td>${schedule["startTime"]}</td>
                                        <td>${schedule["endTime"]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Activate Feather Icons -->
        <!-- Chart.js Scripts -->
        <script>
            // Student Distribution Chart
            const studentDistributionCtx = document.getElementById('studentDistributionChart').getContext('2d');
            const studentDistributionData = {
                labels: <c:out value="${studentDistributionByMajor.keySet()}"/>,
                datasets: [{
                        label: 'Jumlah Siswa',
                        data: <c:out value="${studentDistributionByMajor.values()}"/>,
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
                    }]
            };
            new Chart(studentDistributionCtx, {
                type: 'pie',
                data: studentDistributionData,
            });

            // Attendance Chart
            const attendanceCtx = document.getElementById('attendanceChart').getContext('2d');
            const attendanceData = {
                labels: <c:out value="${averageMonthlyAttendance.keySet()}"/>,
                datasets: [{
                        label: 'Kehadiran',
                        data: <c:out value="${averageMonthlyAttendance.values()}"/>,
                        backgroundColor: '#4BC0C0',
                    }]
            };
            new Chart(attendanceCtx, {
                type: 'bar',
                data: attendanceData,
            });
        
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