<%-- 
    Document   : deleteNilaiSiswa
    Created on : 9 Dec 2024, 08.17.42
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hapus Nilai Siswa</title>
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
        <div class="info-container" action="${pageContext.request.contextPath}/nilaiServlet"" method="post">
            <div class="mb-3">
                <div class="info-label">ID Nilai:</div>
                <div>${grade.id_nilai}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">Nama:</div>
                <div>${grade.nama_siswa}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">NISN:</div>
                <div>${grade.nis}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">kelas:</div>
                <div>${grade.kelas}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">uts:</div>
                <div>${grade.uts}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">uas:</div>
                <div>${grade.uas}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">tugas:</div>
                <div>${grade.tugas}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">total :</div>
                <div>${grade.grade}</div>
            </div>
            <div class="mb-3">
                <div class="info-label">kategori:</div>
                <div>${grade.kategori}</div>
            </div>

            <!-- Tombol Hapus -->
            <div class="text-end">
                <button type="button" class="btn btn-danger btn-custom" data-bs-toggle="modal" data-bs-target="#deleteModal">
                    <i class="bi bi-trash me-2"></i> Hapus
                </button>
                <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                    <i class="bi bi-arrow-left me-2"></i> Kembali
                </a>
            </div>
        </div>
    </div>

    <!-- Modal Konfirmasi Hapus -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Konfirmasi Hapus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin ingin menghapus data nilai siswa ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form action="${pageContext.request.contextPath}/nilaiServlet" method="post">
                        <input type="hidden" name="idNilai" value="${grade.idNilai}">
                        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
