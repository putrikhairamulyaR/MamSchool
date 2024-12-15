<%-- 
    Document   : editJadwal
    Created on : Dec 15, 2024, 9:18:49 PM
    Author     : Necha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Jadwal</title>
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
        <h3>Edit Jadwal</h3>
        <!-- Form Input Jadwal -->
        <div class="form-container">
            <form id="editJadwalForm" action="${pageContext.request.contextPath}/jadwal" method="post">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" value="${jadwal.id}" />

                <div class="mb-3">
                    <label for="kelas" class="form-label">Kelas</label>
                    <input type="text" name="kelas" id="kelas" class="form-control" value="${jadwal.kelas}" required>
                </div>

                <div class="mb-3">
                    <label for="subjectId" class="form-label">Mata Pelajaran ID</label>
                    <input type="number" name="subjectId" id="subjectId" class="form-control" value="${jadwal.subjectId}" required>
                </div>

                <div class="mb-3">
                    <label for="teacherId" class="form-label">Guru ID</label>
                    <input type="number" name="teacherId" id="teacherId" class="form-control" value="${jadwal.teacherId}" required>
                </div>

                <div class="mb- 3">
                    <label for="day" class="form-label">Hari</label>
                    <select name="day" id="day" class="form-select" required>
                        <option value="Senin" <c:if test="${jadwal.day == 'Senin'}">selected</c:if>>Senin</option>
                        <option value="Selasa" <c:if test="${jadwal.day == 'Selasa'}">selected</c:if>>Selasa</option>
                        <option value="Rabu" <c:if test="${jadwal.day == 'Rabu'}">selected</c:if>>Rabu</option>
                        <option value="Kamis" <c:if test="${jadwal.day == 'Kamis'}">selected</c:if>>Kamis</option>
                        <option value="Jumat" <c:if test="${jadwal.day == 'Jumat'}">selected</c:if>>Jumat</option>
                        <option value="Sabtu" <c:if test="${jadwal.day == 'Sabtu'}">selected</c:if>>Sabtu</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="startTime" class="form-label">Waktu Mulai</label>
                    <input type="time" name="startTime" id="startTime" class="form-control" value="${jadwal.startTime}" required>
                </div>

                <div class="mb-3">
                    <label for="endTime" class="form-label">Waktu Selesai</label>
                    <input type="time" name="endTime" id="endTime" class="form-control" value="${jadwal.endTime}" required>
                </div>

                <div class="text-end">
                    <button type="button" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#confirmModal">
                        <i class="bi bi-save me-2"></i> Simpan
                    </button>
                    <a href="${pageContext.request.contextPath}/jadwal?action=list" class="btn btn-secondary btn-custom">
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
                    <button type="submit" class="btn btn-primary" form="editJadwalForm">Ya, Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
