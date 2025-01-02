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
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            /* Sidebar */
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

            /* Konten */
            .content {
                margin-left: 260px;
                padding: 20px;
                flex: 1;
                background-color: #f8f9fa;
                overflow-y: auto;
            }

            /* Filter */
            .filter-container {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
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
                padding: 8px;
                text-align: center;
            }

            th {
                background-color: #e9ecef;
            }

            .action-icons i {
                cursor: pointer;
                margin: 0 5px;
                color: #495057;
            }

            .action-icons i:hover {
                color: #007bff;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <h4>Dashboard Siswa</h4>
            <a href="#"><i class="bi bi-house-door-fill"></i> Beranda</a>
            <a href="#"><i class="bi bi-list-check"></i> Kelas</a>
            <a href="#"><i class="bi bi-clipboard2-check"></i> Nilai</a>
            <a href="#"><i class="bi bi-book"></i> Mapel</a>
            <hr>
            <a href="#"><i class="bi bi-gear"></i> Setting</a>
            <a href="#"><i class="bi bi-question-circle"></i> Bantuan</a>
            <a href="#"><i class="bi bi-box-arrow-left"></i> Logout</a>
        </div>

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
                                Teacher guru =  KelasDao.getTeacherByUserId(user.getId());
                                List<Classes> Kelas = KelasDao.getAllClassesByTeacherID(guru.getId());
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
                                <td><%= grade.getKategori()%></td>
                                <td class="action-icons">
                                    <a href="<%= request.getContextPath() %>/frontEnd/Guru/editNilaiSiswa.jsp?id=<%= grade.getIdNilai() %>"><i class="bi bi-pencil-square" title="Edit"></i></a>
                                    <a href="<%= request.getContextPath() %>/frontEnd/Guru/deleteNilaiSiswa.jsp?id=<%= grade.getIdNilai() %>"><i class="bi bi-trash"></i></a>
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
    </body>
</html>

