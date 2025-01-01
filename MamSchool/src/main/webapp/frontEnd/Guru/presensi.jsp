<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Student"%>
<%@page import="java.sql.Connection"%>
<%@page import="classes.JDBC"%>
<%@page import="dao.PresensiDao"%>
<%@ page import="java.sql.*" %>
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
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Guru</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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


    <%
       List<Student>students=(List<Student>) request.getSession().getAttribute("listSiswa");
    %>



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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nilaiServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/frontEnd/Guru/menuRapot.jsp">
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
                
        <div class="p-3">
            <h1 class="text-center text-primary">Students Attendance Form</h1>

            <% if (students.isEmpty()) { %>
            <div class="alert alert-warning text-center">No students found for this teacher.</div>
            <% } else { %>
            <!-- Form to submit attendance -->
            <form action="${pageContext.request.contextPath}/PresensiServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <input type="date" name="Date" class="form-control">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Hadir</th>
                            <th>Sakit</th>
                            <th>Alpa</th>
                            <th>Izin</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Student student : students) {%>
                        <tr class="text-center">
                            <td><%= student.getUserId()%></td>
                            <td><%= student.getName()%></td>
                            <!-- Radio inputs for attendance -->
                            <input type="hidden" name="id" value="<%= student.getUserId()%>">
                            <td>
                                <input type="radio" name="attendance" value="Hadir" class="form-check-input">
                            </td>
                            <td>
                                <input type="radio" name="attendance" value="Sakit" class="form-check-input">
                            </td>
                            <td>
                                <input type="radio" name="attendance" value="Alpa" class="form-check-input">
                            </td>
                            <td>
                                <input type="radio" name="attendance" value="Izin" class="form-check-input">
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <!-- Submit button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit Attendance</button>
                </div>
            </form>
            <% }%>
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