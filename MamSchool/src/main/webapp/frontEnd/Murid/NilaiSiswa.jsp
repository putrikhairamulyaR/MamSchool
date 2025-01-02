<%-- 
    Document   : Nilai
    Created on : 20 Nov 2024, 14.46.14
    Author     : putri
--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Siswa</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Feather Icons -->
        <script src="https://unpkg.com/feather-icons"></script>
        <style>
            /* Sidebar */
            #sidebar {
                width: 250px;
                transition: transform 0.3s ease, visibility 0.3s ease;
                overflow: auto;
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                z-index: 1030; /* Tetap di atas konten utama */
                background-color: #34495e;
                color: #ffffff;
            }

            #sidebar.hidden {
                transform: translateX(-100%);
                visibility: hidden;
            }

            /* Content */
            #content {
                flex-grow: 1;
                margin-left: 250px; /* Ruang default sidebar */
                transition: margin-left 0.3s ease;
            }

            #content.expanded {
                margin-left: 0; /* Konten memenuhi layar */
            }

            /* Nav Link */
            #sidebar .nav-link {
                color: #ffffff;
                border-radius: 5px;

            }
            #sidebar .nav-link:hover{
                background-color: #628ab1;
            }
            #sidebar .active{
                border-left: 3px solid #ffffff;
                background-color: #628ab1;
                font-weight: bold;
            }

            .username-display {
                display: inline-block;
                padding: 5px 15px;
                background-color: #f0f0f0;
                border-radius: 20px;
                color: #333;
                font-weight: bold;
                font-size: 14px;
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body class="d-flex">
        <!-- Sidebar -->
        <nav id="sidebar" class="border-end vh-100 shadow">
            <div class="p-3">
                <a class="navbar-brand d-flex align-items-center mb-3" href="#">
                    <span class="align-middle">Mam School</span>
                </a>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class=" text-sm text-white fw-bold">Pages</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/DasboardSiswa">
                            <i data-feather="sliders" class="align-middle"></i>
                            <span class="align-middle">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ProfileUser">
                            <i data-feather="user" class="align-middle"></i>
                            <span class="align-middle">Profile</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class=" text-white fw-bold">Siswa</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/siswaServlet">
                            <i data-feather="users" class="align-middle"></i>
                            <span class="align-middle">List Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/PresensiServlet">
                            <i data-feather="pie-chart" class="align-middle"></i>
                            <span class="align-middle">Presensi Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/JadwalServlet">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Jadwal Mata Pelajaran</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GradesServlet">
                            <i data-feather="bar-chart-2" class="align-middle"></i>
                            <span class="align-middle">Nilai Siswa</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GradesServlet">
                            <i data-feather="file-text" class="align-middle"></i>
                            <span class="align-middle">Raport Siswa</span>
                        </a>
                    </li>
                </ul>
                <hr>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <span class="  text-white fw-bold">Accounts</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">
                            <i data-feather="log-out" class="align-middle"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

 

    <!-- Main Content -->
    <div class="content">
        <div class="info-container container">
            <div class="row"> 
                <div class="col-md-6 px-5"> 
                    <p><strong>Kelas:</strong> 11.1</p> 
                </div> 
                <div class="col-md-6 px-5"> 
                    <p><strong>Jumlah Subjek:</strong> 9</p> 
                </div> 
                <div class="col-md-6 px-5"> 
                    <p><strong>Semester:</strong> 1</p> 
                </div> 
                <div class="col-md-6 px-5"> 
                    <p><strong>Rata-rata:</strong> 9.9</p> 
                </div> 
            </div> 
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <h4>Daftar Nilai</h4>
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Judul Mata Pelajaran</th>
                        <th>Nilai</th>
                        <th>Kategori</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data nilai -->
                    <tr>
                        <td>1</td>
                        <td>Matematika</td>
                        <td>95</td>
                        <td>Sangat Baik</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Bahasa Indonesia</td>
                        <td>88</td>
                        <td>Baik</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Fisika</td>
                        <td>85</td>
                        <td>Baik</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Kimia</td>
                        <td>78</td>
                        <td>Cukup</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>Biologi</td>
                        <td>92</td>
                        <td>Sangat Baik</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>Sejarah</td>
                        <td>80</td>
                        <td>Baik</td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>Geografi</td>
                        <td>84</td>
                        <td>Baik</td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>Sosiologi</td>
                        <td>75</td>
                        <td>Cukup</td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>Ekonomi</td>
                        <td>89</td>
                        <td>Baik</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
