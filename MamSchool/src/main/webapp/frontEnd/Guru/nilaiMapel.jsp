<%-- 
    Document   : nilaiMapel
    Created on : 9 Dec 2024, 08.18.52
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        /* Filter */
        .filter-container {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* Tabel */
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #dee2e6;
        }

        th, td {
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #e9ecef;
        }

        .action-icons i {
            cursor: pointer;
            margin: 0 5px;
            color: #495057;
        }

        .action-icons i:hover {
            color: #007bff;
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

    <!-- Konten -->
    <div class="content">
        <!-- Filter Kelas dan Kategori -->
        <div class="filter-container">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="kelas" class="form-label">Pilih Kelas</label>
                    <select class="form-select" id="kelas">
                        <option value="X">Kelas X</option>
                        <option value="XI">Kelas XI</option>
                        <option value="XII">Kelas XII</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="mata_pelajaran" class="form-label">Mata Pelajaran</label>
                    <select class="form-select" id="mata_pelajaran">
                        <option value="Matematika">Matematika</option>
                        <option value="IPA">IPA</option>
                        <option value="IPS">IPS</option>
                        <option value="Bahasa Indonesia">Bahasa Indonesia</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="kategori_nilai" class="form-label">Kategori Nilai</label>
                    <select class="form-select" id="kategori_nilai">
                        <option value="semua">Semua</option>
                        <option value="uts">UTS</option>
                        <option value="uas">UAS</option>
                        <option value="tugas">Tugas</option>
                    </select>
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <button class="btn btn-primary w-100">Tampilkan Nilai</button>
                </div>
            </div>
        </div>

        <!-- Tabel Data -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NIM</th>
                        <th>Nama</th>
                        <th>UTS</th>
                        <th>UAS</th>
                        <th>Tugas</th>
                        <th>Kriteria</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>130124</td>
                        <td>IRNA</td>
                        <td>90</td>
                        <td>85</td>
                        <td>80</td>
                        <td>Lulus</td>
                        <td class="action-icons">
                            <i class="bi bi-pencil-square" title="Edit"></i>
                            <i class="bi bi-trash" title="Hapus"></i>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>130125</td>
                        <td>ARIF</td>
                        <td>88</td>
                        <td>92</td>
                        <td>86</td>
                        <td>Lulus</td>
                        <td class="action-icons">
                            <i class="bi bi-pencil-square" title="Edit"></i>
                            <i class="bi bi-trash" title="Hapus"></i>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>130126</td>
                        <td>RANI</td>
                        <td>82</td>
                        <td>91</td>
                        <td>84</td>
                        <td>Lulus</td>
                        <td class="action-icons">
                            <i class="bi bi-pencil-square" title="Edit"></i>
                            <i class="bi bi-trash" title="Hapus"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

