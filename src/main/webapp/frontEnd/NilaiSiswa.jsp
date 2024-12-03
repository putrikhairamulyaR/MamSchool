<%-- 
    Document   : Nilai
    Created on : 20 Nov 2024, 14.46.14
    Author     : putri
--%>

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

        .info-container p strong {
            color: #3366cc;
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
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h4 class="mb-4 mt-2 px-2">Dashboard Siswa</h4>
        <a href="profileSiswa.jsp"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="DasboardSiswa.jsp#beranda"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="kelasSiswa.jsp"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="nilai.jsp"><i class="bi bi-clipboard2-check"></i> Nilai</a>
        <a href="mapelSiswa.jsp"><i class="bi bi-book"></i> Mapel</a>
        <hr>
        <a href="#setting"><i class="bi bi-gear"></i> Setting</a>
        <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

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
