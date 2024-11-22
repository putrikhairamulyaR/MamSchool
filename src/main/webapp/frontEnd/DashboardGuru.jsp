<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Guru</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        /* Sidebar styling */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #34495e;
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
            z-index: 1000;
        }

        .sidebar h2 {
            font-size: 20px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            margin: 10px 0;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar a:hover {
            background-color: #2c3e50;
            padding: 10px;
            border-radius: 5px;
        }

        .content {
            margin-left: 260px;
            padding: 30px;
        }

        .stat-card {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-bottom: 20px;
        }

        .class-card {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .class-card h6 {
            color: #2c3e50;
        }

        .custom-image {
            width: 150px;
            height: auto;
            display: block;
            margin: 0 auto 10px;
        }

        .btn-primary {
            background-color: #34495e;
            border: none;
        }

        .btn-primary:hover {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Dashboard Guru</h2>
        <a href="profileGuru.jsp"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="DashboardGuru.jsp#beranda"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="#kelas"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="#jadwal"><i class="bi bi-calendar-event"></i> Jadwal</a>
        <a href="#presensi"><i class="bi bi-clipboard2-check"></i> Presensi</a>
        <a href="#nilai"><i class="bi bi-clipboard-data"></i> Nilai Siswa</a>
        <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

    <!-- Content -->
    <div class="content">
        <!-- Welcome Section -->
        <h1>Selamat Datang, Guru!</h1>
        <p class="text-muted">Berikut adalah statistik dan jadwal Anda hari ini.</p>

        <!-- Statistics -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Jumlah Kelas</h5>
                    <p><strong>5 Kelas</strong></p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Jumlah Siswa</h5>
                    <p><strong>120 Siswa</strong></p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Jumlah Mata Pelajaran</h5>
                    <p><strong>8 Mata Pelajaran</strong></p>
                </div>
            </div>
        </div>

        <!-- Jadwal Hari Ini -->
        <h3>Jadwal Hari Ini</h3>
        <div class="row">
            <div class="col-md-6">
                <div class="class-card">
                    <h6><strong>Matematika</strong></h6>
                    <p><strong>Jam:</strong> 07:30 - 09:00</p>
                    <p><strong>Kelas:</strong> 10 IPA</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="class-card">
                    <h6><strong>Fisika</strong></h6>
                    <p><strong>Jam:</strong> 10:00 - 11:30</p>
                    <p><strong>Kelas:</strong> 11 IPA</p>
                </div>
            </div>
        </div>

        <!-- Presensi dan Nilai -->
        <div class="row">
            <div class="col-md-6">
                <h3>Presensi</h3>
                <div class="stat-card">
                    <img src="/mamSchool/Image/prensensiiIlustrasi.png" alt="Presensi" class="custom-image">
                    <p>Lihat dan kelola kehadiran siswa Anda.</p>
                    <a href="#presensi" class="btn btn-primary">Kelola Presensi</a>
                </div>
            </div>
            <div class="col-md-6">
                <h3>Nilai Siswa</h3>
                <div class="stat-card">
                    <img src="/mamSchool/Image/gambarNilai.jpg" alt="Presensi" class="custom-image">
                    <p>Input dan periksa nilai siswa Anda.</p>
                    <a href="NilaiGuru.jsp" class="btn btn-primary">Kelola Nilai</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
