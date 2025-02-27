<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Jadwal"%>
<%@page import="dao.PresensiDao"%>
<%@page import="model.Presensi"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="model.Student"%>
<%@page import="model.Classes"%>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Records</title>
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
                        <a class="nav-link  " href="${pageContext.request.contextPath}/DashboardGuru">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/frontEnd/Guru/viewJadwalGuru.jsp">
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
        <h1 class="text-center text-dark">Presensi</h1>


            
            <!-- Filter Form -->
            <form method="get" action="">
                <div class="row mb-3 ">
                    <div class="col-md-4">
                        <label for="className" class="form-label">Kelas:</label>
                        <select name="className" id="className" class="form-control">
                            <option value="">Select Class</option>
                            <%
                                PresensiDao presensiDao = new PresensiDao();
                                List<String> classNames = presensiDao.getAllClassNames();
                                for (String className : classNames) {
                            %>
                            <option value="<%= className %>" <%= className.equals(request.getParameter("className")) ? "selected" : "" %>>
                                <%= className %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="filterDate" class="form-label">Tanggal:</label>
                        <input type="date" name="filterDate" id="filterDate" class="form-control" value="<%= request.getParameter("filterDate") != null ? request.getParameter("filterDate") : "" %>">
                    </div>
                </div>
            </form>

            <%
                String selectedClassName = request.getParameter("className");
                String dateParam = request.getParameter("filterDate");

                // Convert dateParam to java.sql.Date
                java.sql.Date filterDate = null;
                if (dateParam != null && !dateParam.isEmpty()) {
                    try {
                        filterDate = java.sql.Date.valueOf(dateParam); // Ensure format yyyy-MM-dd
                    } catch (IllegalArgumentException e) {
                        out.println("<p>Error: Invalid date format. Please use yyyy-MM-dd.</p>");
                    }
                }

                // Retrieve students by filter
                List<Student> students = null;
                if (selectedClassName != null && !selectedClassName.isEmpty()) {
                    students = presensiDao.getStudentsByFilter(selectedClassName, filterDate);
                }
            %>

            <% if (students != null && !students.isEmpty()) { %>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Nama</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Student student : students) {
                            java.sql.Date sqlFilterDate = (filterDate != null) ? new java.sql.Date(filterDate.getTime()) : null;
                            Presensi presensi = presensiDao.getPresensiByStudentIdAndDate(student.getId(), sqlFilterDate);
                        %>
                            <tr>
                                <td><%= student.getName() %></td>
                                <td><%= (presensi != null) ? presensi.getStatus() : "N/A" %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p>Belum mengisi presensi.</p>
            <% } %>

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