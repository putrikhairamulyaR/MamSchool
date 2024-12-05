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
        <div class="info-container">
            <p><strong>Pilih Tingkat dan Jurusan!</strong></p>
            <select name="Choose">
                <option disabled>Choose</option>
                <option>10 IPA</option>
                <option>10 IPS</option>
                <option>11 IPA</option>
                <option>11 IPS</option>
                <option>12 IPA</option>
                <option>12 IPS</option>
            </select>
            <p>
                            <strong>Jumlah Siswa:</strong>
                            <span id="jumlah">xxx</span>
                        </p>
                        <<form>
                            
                        </form>
        </div>
        
        <div class="table-container">
                <h4>Daftar Siswa</h4>
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Nama Siswa</th>
                        <th>Tingkat</th>
                        <th>Jurusan</th>
                        <th>Kelas<th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Raisa</td>
                        <td>1</td>
                        <td>IPA</td>
                        <td>10 IPA 1</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>