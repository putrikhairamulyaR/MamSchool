<%-- 
    Document   : menuRapot
    Created on : 27 Dec 2024, 19.19.48
    Author     : luthfiah
--%>

<%@page import="dao.rapotDAO"%>
<%@page import="model.Student"%>
<%@page import="model.Classes"%>
<%@page import="dao.ClassesDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.rapot"%>
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
        <title>Rapot Siswa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Feather Icons -->
        <script src="https://unpkg.com/feather-icons"></script>
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            /* sidebar */
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
            
            /* NavBar */
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
            /*konten utama*/
            .content {
                margin-left: 260px;
                padding: 20px;
                flex: 1;
                background-color: #f8f9fa;
                overflow-y: auto;
            }

            .filter-container {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

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

            th {
                background-color: #34495e;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                padding: 10px;
                text-align: left;
                text-align: center;
                vertical-align: middle;
                text-transform: none;
            }

            td {
                padding: 10px;
                text-align: center;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #d1e7ff;
            }
        </style>
    </head>
    <body>
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
                        <a class="nav-link " href="${pageContext.request.contextPath}/frontEnd/Guru/DashboardGuru.jsp">
                            <i data-feather="sliders" class="align-middle"></i>
                            <span class="align-middle">Beranda</span>
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
        
        <div class="content">
            <div class="filter-container">
                <form action="${pageContext.request.contextPath}/rapotServlet" method="get">
                    <input type="hidden" name="action" value="viewRapot">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="kelas" class="form-label">Pilih Kelas</label>
                            <%
                                ClassesDAO kelasDao = new ClassesDAO();
                                List<Classes> kelasList = kelasDao.getAllClasses();
                                List<Student> studentList = (List<Student>) request.getSession().getAttribute("SiswaRapot");
                            %>
                            <select class="form-select" id="kelas" name="kelas">
                                <%
                                    if (kelasList != null && !kelasList.isEmpty()) {
                                        for (Classes kelas : kelasList) {
                                %>
                                <option value="<%= kelas.getId()%>"><%= kelas.getName()%></option>
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
                            <button type="submit" class="btn btn-primary w-100">Tampilkan Rapot</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <%
                            // Cek apakah studentList tidak kosong
                            if (studentList != null && !studentList.isEmpty()) {
                                for (int i = 0; i < studentList.size(); i++) {
                                    Student student = studentList.get(i);

                                    // Hanya tampilkan header sekali (untuk siswa pertama)
                                    if (i == 0) {
                        %>
                        <tr>
                            <th>Nama</th>
                            <th>Kelas</th>
                            <th>NIS</th>
                                <%
                                    if (student.getMajor().equals("IPA")) {
                                %>
                            <th>Matematika</th>
                            <th>Fisika</th>
                            <th>Kimia</th>
                            <th>Biologi</th>
                                <%
                                } else if (student.getMajor().equals("IPS")) {
                                %>
                            <th>Ekonomi</th>
                            <th>Geografi</th>
                            <th>Sejarah</th>
                                <%
                                    }
                                %>
                            <th>Rata-rata</th>
                            <th>Kategori</th>
                        </tr>
                        <%
                                    }
                                    break; // Keluar dari loop setelah menampilkan header
                                }
                            }
                        %>
                    </thead>
                    <tbody>
                        <%
                            if (studentList != null && !studentList.isEmpty()) {
                                for (Student student : studentList) {
                                    rapotDAO rapotDao = new rapotDAO();
                                    rapot rapot = rapotDao.getRapot(student.getNis());
                        %>
                        <tr>
                            <td><%= rapot.getNama()%></td>
                            <td><%= rapot.getKelas()%></td>
                            <td><%= rapot.getNis()%></td>
                            <%
                                if (student.getMajor().equals("IPA")) {
                            %>
                            <td><%= rapot.getMatematika()%></td>
                            <td><%= rapot.getFisika()%></td>
                            <td><%= rapot.getKimia()%></td>
                            <td><%= rapot.getBiologi()%></td>
                            <%
                            } else if (student.getMajor().equals("IPS")) {
                            %>
                            <td><%= rapot.getEkonomi()%></td>
                            <td><%= rapot.getGeografi()%></td>
                            <td><%= rapot.getSejarah()%></td>
                            <%
                                }
                            %>
                            <td><%= rapot.getRataRata()%></td>
                            <td><%= rapot.getKategori()%></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="10">Tidak ada data untuk ditampilkan.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
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
