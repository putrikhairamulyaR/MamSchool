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
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rapot Siswa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .sidebar {
                width: 250px;
                background-color: #34495e;
                color: white;
                display: flex;
                flex-direction: column;
                padding: 15px;
                position: fixed;
                height: 100%;
            }

            .sidebar h4 {
                text-align: center;
                margin-bottom: 20px;
            }

            .sidebar a {
                text-decoration: none;
                color: white;
                font-size: 16px;
                padding: 10px 15px;
                border-radius: 5px;
                margin-bottom: 5px;
                display: flex;
                align-items: center;
            }

            .sidebar a:hover {
                background-color: #2980b9;
            }

            .sidebar a i {
                margin-right: 10px;
            }

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
        <div class="sidebar">
            <h4>Dashboard Siswa</h4>
            <a href="DashboardGuru.jsp"><i class="bi bi-house-door-fill"></i> Beranda</a>
            <hr>
            <a href="#"><i class="bi bi-gear"></i> Setting</a>
            <a href="#"><i class="bi bi-question-circle"></i> Bantuan</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="bi bi-box-arrow-left"></i> Logout</a>
        </div>

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

    </body>
</html>
