<%-- 
    Document   : deleteNilaiSiswa
    Created on : 9 Dec 2024, 08.17.42
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
    <title>Hapus Nilai Siswa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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

        /* Styling untuk informasi siswa */
        .info-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .info-container .info-label {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .btn-custom {
            display: inline-block;
            margin-top: 20px;
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

    <!-- Konten Utama -->
    <div class="content">
        <h3>Informasi Nilai Siswa</h3>

        <!-- Tampilkan Informasi Nilai Siswa -->
        <div class="info-container">">
            <% 
                String id = request.getParameter("id");
                gradeDao gd = new gradeDao();
                nilai grade = null;

                try {
                    if (id != null) {
                        grade = gd.getGradeById(Integer.parseInt(id));
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }

                if (grade == null) {
            %>
                <p>Data tidak ditemukan atau ID tidak valid.</p>
                <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                    <i class="bi bi-arrow-left me-2"></i> Kembali
                </a>
            <% return; } %>
 
            <div class="mb-3">
                <div class="info-label">ID Nilai:</div>
                <div><%= grade.getIdNilai() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Nama:</div>
                <div><%= grade.getName() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">NISN:</div>
                <div><%= grade.getNis() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Kelas:</div>
                <div><%= grade.getKelas() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Nilai UTS:</div>
                <div><%= grade.getUts() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Nilai UAS:</div>
                <div><%= grade.getUas() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Nilai Tugas:</div>
                <div><%= grade.getTugas() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Total Nilai:</div>
                <div><%= grade.getGrade() %></div>
            </div>
            <div class="mb-3">
                <div class="info-label">Kategori:</div>
                <div><%= grade.getKategori() %></div>
            </div>

            <!-- Tombol Hapus -->
            <div class="text-end">
                <form action="${pageContext.request.contextPath}/nilaiServlet" method="post" style="display: inline;">
                    <input type="hidden" name="id" value="<%= grade.getIdNilai() %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-danger btn-custom">
                        <i class="bi bi-trash me-2"></i> Hapus
                    </button>
                </form>
                <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                    <i class="bi bi-arrow-left me-2"></i> Kembali
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
