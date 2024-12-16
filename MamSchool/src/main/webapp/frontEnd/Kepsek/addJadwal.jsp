<%-- 
    Document   : addJadwal
    Created on : Dec 15, 2024, 8:13:13 PM
    Author     : Necha
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="id">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Jadwal</title>
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


        /* Form Styling */

        .form-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }


        .form-label {
            font-weight: bold;
        }


        .btn-custom {
            display: inline-block;
            margin-top: 10px;
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
        <h3>Tambah Jadwal1</h3>
        <!-- Form Input Jadwal -->

        <div class="form-container">
            <form id="addJadwalForm" action="${pageContext.request.contextPath}/Jadwal" method="post">
                <input type="hidden"  name="action" value="add">
                <!-- Pilih Kategori Jadwal -->
                <div class="mb-3">
                    <label for="mapel" class="form-label">Pilihan Jadwal</label>
                    <select name="mapel" id="mapel" class="form-select" required>
                        <option value="" disabled selected>Pilih Jadwal</option>
                        <option value="matematika">Matematika</option>
                        <option value="bahasaing">Bahasa Inggris</option>
                        <option value="fisika">Fisika</option>
                        <option value="kimia">Kimia</option>
                        <option value="biologi">Biologi</option>
                        <option value="sejarah">Sejarah</option>
                        <option value="geografi">Geografi</option>
                        
                        <option value="ekonomi">Ekonomi</option>
                        

                    </select>

                </div>


                <!-- Input NIP -->

                <div class="mb-3">
                    <label for="nip" class ="form-label">NIP Guru</label>
                    <input type="text" name="nip" id="nip" class="form-control" placeholder="Masukkan NIP Guru" required>
                </div>


                <div class="mb-3">
                    <label for="kelas" class="form-label">Kelas</label>
                    <input type="text" name="kelas" id="kelas" class="form-control" placeholder="Masukkan Kelas" required>
                </div>


                <div class="mb-3">
                    <label for="hari" class="form-label">Hari</label>
                    <select name="hari" id="hari" class="form-select" required>
                        <option value="" disabled selected>Pilih Hari</option>
                        <option value="senin">Senin</option>
                        <option value="selasa">Selasa</option>
                        <option value="rabu">Rabu</option>
                        <option value="kamis">Kamis</option>
                        <option value="jumat">Jumat</option>
                        <option value="sabtu">Sabtu</option>
                    </select>

                </div>


   <div class="mb-3">
    <label for="jamMulai" class="form-label">Jam Mulai</label>
    <input type="time" name="jam" id="jamMulai" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="jamSelesai" class="form-label">Jam Selesai</label>
        <input type="time" name="jamSelesai" id="jamSelesai" class="form-control" required>
    </div>



                <div class="text-end">
                    <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        <i class="bi bi-save me-2"></i> Simpan
                    </button>

                    <a href="nilaiGuruMatkul.jsp" class="btn btn-secondary btn-custom">
                        <i class="bi bi-arrow-left me-2"></i> Kembali

                    </a>

                </div>
            </form>

        </div>

    </div>


    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Konfirmasi Penyimpanan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    Apakah Anda yakin ingin menyimpan data ini?
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary" form="addJadwalForm">Ya, Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

