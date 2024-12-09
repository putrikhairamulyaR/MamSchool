<%-- 
    Document   : DashboardSiswa
    Created on : 19 Nov 2024, 23.32.29
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Siswa</title>
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
                transition: transform 0.3s ease;
                z-index: 1000;
            }

            .sidebar.hidden {
                transform: translateX(-250px);
            }

            .sidebar h2 {
                font-size: 18px;
                text-align: center;
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
                text-decoration: underline;
            }

            /* Content styling */
            .content {
                margin-left: 250px;
                padding: 30px;
                transition: margin-left 0.3s ease;
            }

            .content.expanded {
                margin-left: 0;
            }

            /* Toggle Button styling */
            .toggle-btn {
                position: fixed;
                top: 20px;
                left: 250px;
                width: 30px;
                height: 30px;
                background-color: #4682b4;
                color: #fff;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                z-index: 1100;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                transition: left 0.3s ease;
            }

            .toggle-btn.hidden {
                left: 0;
            }

            .stat-card {
                background: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                text-align: center;
                margin-bottom: 20px;
            }

            .calendar-box {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .calendar {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
                margin-top: 10px;
            }

            .calendar div {
                padding: 8px;
                border-radius: 5px;
                background-color: #f9f9f9;
                color: #333;
            }

            .calendar .day-header {
                font-weight: bold;
                background-color: #4682b4;
                color: #fff;
            }
           
            .custom-image {
                width: 100px; 
                height: auto; 
                display: block; 
                margin: 0 auto; 
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <h2>Dashboard Siswa</h2>
            <a href="profileSiswa.jsp"><i class="bi bi-person-circle"></i> Profile</a>
            <a href="DasboardSiswa.jsp#beranda><i class="bi bi-house-door-fill"></i> Beranda</a>
            <a href="#kelas"><i class="bi bi-list-check"></i> Kelas</a>
            <a href="#nilai"><i class="bi bi-clipboard2-check"></i> Nilai</a>
            <a href="#mapel"><i class="bi bi-book"></i> Mapel</a>
            <a href="#setting"><i class="bi bi-gear"></i> Setting</a>
            <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
            <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
        </div>

        <!-- Toggle Button -->
        <div class="toggle-btn" id="toggle-btn">
            <i class="bi bi-chevron-left"></i>
        </div>

        <!-- Content -->
        <div class="content" id="content">
            <h1>Hi, Nama User</h1>
            <p>Semangat untuk hari ini!</p>

            <!-- Statistics -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="stat-card">
                        <h5>Jumlah Subjek</h5>
                        <p>10</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="stat-card">
                        <h5>Rata-Rata Nilai</h5>
                        <p>85.4</p>
                    </div>
                </div>
            </div>

            <h3 class="mb-3">Mata Pelajaran</h3>
            <div class="row mb-4">
                <div class="col-md-2">
                    <div class="stat-card">
                        <h6>MTK</h6>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card">
                        <h6>Bhs Indonesia</h6>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card">
                        <h6>PAI</h6>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card">
                        <h6>PJOK</h6>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card">
                        <h6>SBD</h6>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <h3 class="mb-3">Presensi</h3>
                    <div class="stat-card">
                        <img src="/mamSchool/Image/prensensiiIlustrasi.png" alt="logo" class="custom-image">
                        <p>Presensi dan Info Kehadiran</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <h3 class="mb-3">Kalender Akademik</h3>
                    <div class="calendar-box">
                        <div class="calendar">
                            <div class="day-header">Sun</div>
                            <div class="day-header">Mon</div>
                            <div class="day-header">Tue</div>
                            <div class="day-header">Wed</div>
                            <div class="day-header">Thu</div>
                            <div class="day-header">Fri</div>
                            <div class="day-header">Sat</div>
                            <div></div><div></div><div>1</div><div>2</div>
                            <div>3</div><div>4</div><div>5</div>
                            <div>6</div><div>7</div><div>8</div>
                            <div>9</div><div>10</div><div>11</div>
                        </div>
                        <p class="mt-3">2: Ujian Sekolah<br>10: Libur</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script>
            const sidebar = document.getElementById('sidebar');
            const content = document.getElementById('content');
            const toggleBtn = document.getElementById('toggle-btn');
            const icon = toggleBtn.querySelector('i');

            toggleBtn.addEventListener('click', () => {
                sidebar.classList.toggle('hidden');
                content.classList.toggle('expanded');
                toggleBtn.classList.toggle('hidden');

                // Ganti ikon
                if (sidebar.classList.contains('hidden')) {
                    icon.classList.remove('bi-chevron-left');
                    icon.classList.add('bi-chevron-right');
                } else {
                    icon.classList.remove('bi-chevron-right');
                    icon.classList.add('bi-chevron-left');
                }
            });
        </script>
    </body>
</html>
