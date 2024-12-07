<%-- 
    Document   : nilaiGuru
    Created on : 20 Nov 2024, 14.52.29
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jadwal Mata Pelajaran</title>
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
            gap: 10px; /* Menambahkan jarak antara ikon dan teks */
        }

        .sidebar a i {
            font-size: 18px; /* Ukuran ikon disesuaikan agar konsisten */
        }

        .sidebar a:hover {
            background-color: #4d88ff;
        }

        .content {
            margin-left: 260px; /* Matches the sidebar width */
            padding: 20px;
            flex: 1;
            background-color: #f5f5f5;
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

        .info-container p strong {
            color: #3366cc;
        }

        .sort-container {
            margin-bottom: 20px;
        }

        .subject-card {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }

        .subject-card h5 {
            margin: 0 0 10px;
            font-size: 18px;
            color: #3366cc;
        }

        .subject-card p {
            margin: 5px 0;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Dashboard Siswa</h2>
        <a href="profileSiswa.jsp"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="DasboardSiswa.jsp#beranda"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="#kelas"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="#nilai"><i class="bi bi-clipboard2-check"></i> Nilai</a>
        <a href="#mapel"><i class="bi bi-book"></i> Mapel</a>
        <a href="#setting"><i class="bi bi-gear"></i> Setting</a>
        <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <!-- Information Section -->
        <div class="info-container">
            <p><strong>Jumlah Subjek:</strong> 9</p>
        </div>

        <!-- Sorting Options -->
        <div class="sort-container">
            <label for="sortOption"><strong>Urutkan Berdasarkan:</strong></label>
            <select id="sortOption" class="form-select" style="width: 300px;">
                <option value="hari">waktu</option>
                <option value="abjad">Abjad</option>
            </select>
        </div>

        <!-- Subject Cards -->
        <div id="subjectContainer">
            <div class="subject-card" data-hari="2" data-jam="0730" data-nama="Seni Budaya">
                <h5>Seni Budaya</h5>
                <p><strong>Jadwal:</strong> Selasa, 07.30 - 12.00</p>
                <p><strong>Pengampu:</strong> xxxx</p>
            </div>
            <div class="subject-card" data-hari="1" data-jam="0930" data-nama="Matematika">
                <h5>Matematika</h5>
                <p><strong>Jadwal:</strong> Senin, 09.30 - 12.30</p>
                <p><strong>Pengampu:</strong> xxxx</p>
            </div>
            <div class="subject-card" data-hari="3" data-jam="0800" data-nama="Fisika">
                <h5>Fisika</h5>
                <p><strong>Jadwal:</strong> Rabu, 08.00 - 11.30</p>
                <p><strong>Pengampu:</strong> xxxx</p>
            </div>
        </div>
    </div>

    <script>
        const sortOption = document.getElementById('sortOption');
        const subjectContainer = document.getElementById('subjectContainer');

        sortOption.addEventListener('change', () => {
            const subjects = Array.from(subjectContainer.children);
            const sortBy = sortOption.value;

            if (sortBy === 'hari') {
                // Sort by day and time
                subjects.sort((a, b) => {
                    const dayA = parseInt(a.dataset.hari);
                    const dayB = parseInt(b.dataset.hari);
                    if (dayA === dayB) {
                        const timeA = parseInt(a.dataset.jam);
                        const timeB = parseInt(b.dataset.jam);
                        return timeA - timeB;
                    }
                    return dayA - dayB;
                });
            } else if (sortBy === 'abjad') {
                subjects.sort((a, b) => a.dataset.nama.localeCompare(b.dataset.nama));
            }

            subjectContainer.innerHTML = '';
            subjects.forEach(subject => subjectContainer.appendChild(subject));
        });
    </script>
</body>
</html>
