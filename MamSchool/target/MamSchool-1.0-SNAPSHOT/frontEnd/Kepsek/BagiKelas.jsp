<%-- 
Document   : BagiKelas
Created on : 5 Dec 2024, 19.47.03
Author     : Raisa Lukman Hakim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pembagian Kelas</title>
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

            .sidebar h2 {
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
                background-color: #628ab1;
            }

            .sidebar a i {
                margin-right: 10px;
            }

            .content {
                margin-left: 260px;
                padding: 20px;
                flex: 1;
                background-color: #f5f5f5;
                overflow-y: auto;
            }

            .info-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .info-container p {
                margin: 10px 0;
                font-size: 16px;
            }

            .form-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
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

            .form-row {
                display: flex;
                gap: 15px;
            }

            .form-row > div {
                flex: 1;
            }

            .btn-cust{
                background-color: #4682b4;
                color: white;
            }
            .btn-cust:hover{
                background-color: #3e75a2;
                color: white;
            }

            /* Custom styles to separate containers */
            .tab-container {
                margin-top: 20px;
            }
            .nav-link.active {
                background-color: #4682b4 !important;  /* Ganti dengan warna pilihan Anda */
                color: white !important;  /* Mengubah warna teks saat tab aktif */
                border: 20px;
            }


        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <h4 class="mb-4 mt-2 px-2">Dashboard Kepsek</h4>
            <a href="#"><i class="bi bi-person-circle"></i> Profile</a>
            <a href="#"><i class="bi bi-house-door-fill"></i> Beranda</a>
            <a href="#"><i class="bi bi-list-check"></i> Pembagian Kelas</a>
            <a href="#"><i class="bi bi-clipboard2-check"></i> Nilai Siswa</a>
            <a href="#"><i class="bi bi-book"></i> Pembagian Mapel</a>
            <hr>
            <a href="#setting"><i class="bi bi-gear"></i> Setting</a>
            <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
            <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Container for Jumlah Siswa -->
            <div class="info-container"> 
                <h4>Pilih Tingkat dan Jurusan!</h4>
                <form action="${pageContext.request.contextPath}/BagiKelasServlet" method="get">
                    <div class="row">
                        <div class="col-md-6">
                            <p><b>Pilih Tingkat:</b></p>
                            <select name="tingkat" id="tingkatDropdown" class="form-select">
                                <option selected disabled value="">Pilih Tingkat</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <p><b>Pilih Jurusan:</b></p>
                            <select name="jurusan" id="jurusanDropdown" class="form-select">
                                <option selected disabled value="">Pilih Jurusan</option>
                                <option value="IPA">IPA</option>
                                <option value="IPS">IPS</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <p><strong>Jumlah Siswa Ada Kelas:</strong></p>
                            <input type="number" id="SiswaHasKelas" class="form-control" value="${siswaDenganKelas}" readonly>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Jumlah Siswa Tidak Ada Kelas</strong></p>
                            <input type="number" id="SiswaNoKelas" class="form-control" value="${siswaTanpaKelas}" readonly>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Tampilkan Data</button>
                </form>
            </div>

            <!-- Tab Container -->
            <div class="tab-container">
                <div class="info-container"> 
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h3>Data Kelas</h3>
                        <a href="addKelas.jsp" class="btn btn-success btn-sm">
                            <i class="bi bi-plus"></i> Tambah Kelas
                        </a>
                    </div>

                    <nav>
                        <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                            <button class="nav-link active border border-black" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Kelas</button>
                            <button class="nav-link border border-black" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Siswa</button>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <!-- Tab Kelas -->
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nama Kelas</th>
                                        <th>Jurusan</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="kelas" items="${classes}">
                                    <tr>
                                        <td>${kelas.id}</td>
                                        <td>${kelas.name}</td>
                                        <td>${kelas.major}</td>
                                        <td>
                                            <a href="editKelas.jsp?id=${kelas.id}" class="btn btn-warning btn-sm">
                                                <i class="bi bi-pencil"></i> Edit
                                            </a>
                                            <a href="deleteKelas?id=${kelas.id}" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus kelas ini?');">
                                                <i class="bi bi-trash"></i> Hapus
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Tab Siswa -->
                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nama Siswa</th>
                                        <th>NIS</th>
                                        <th>Jurusan</th>
                                        <th>Kelas</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="siswa" items="${students}">
                                    <tr>
                                        <td>${siswa.id}</td>
                                        <td>${siswa.name}</td>
                                        <td>${siswa.nis}</td>
                                        <td>${siswa.major}</td>
                                        <td>
                                    <c:forEach var="kelas" items="${classes}">
                                        <c:if test="${kelas.id == siswa.classId}">
                                            ${kelas.name}
                                        </c:if>
                                    </c:forEach>
                                    </td>
                                    <td>
                                        <a href="editSiswa.jsp?id=${siswa.id}" class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil"></i> Edit
                                        </a>
                                        <a href="deleteSiswa?id=${siswa.id}" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus siswa ini?');">
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
            </div>
        </div>

        <!-- Load Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
