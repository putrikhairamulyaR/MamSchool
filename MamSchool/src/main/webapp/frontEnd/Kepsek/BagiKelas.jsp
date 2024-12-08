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

            .btn{
                background-color: #4682b4;
                color: white;
            }
            .btn:hover{
                background-color: #3e75a2;
                color: white;
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
                <h4>Pilih Tingkat dan Jurusan!</h4>
                <div class="row">
                    <div class="col-md-6">
                        <p><b>Pilih Tingkat:</b></p>
                        <select name="tingkat" id="tingkatDropdown" class="form-select">
                            <option selected disabled value="">Pilih Tingkat</option>
                            <option value="X">1</option>
                            <option value="XI">2</option>
                            <option value="XII">3</option>
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
                        <p><strong>Jumlah Seluruh Siswa:</strong></p>
                        <input type="text" id="JumlahAllSiswa" class="form-control" value="-" readonly>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Jumlah Siswa di Kelas:</strong></p>
                        <input type="text" id="jumlahSiswa" class="form-control" value="-" readonly>
                    </div>
                </div>
                <div id="jumlahKelasContainer" style="display: none;">
                    <p><strong>Jumlah Kelas:</strong></p>
                    <input type="number" id="jumlahKelas" class="form-control" placeholder="Masukkan jumlah kelas yang ingin dibuat">
                    <div class="mt-3">
                        <button type="button" id="generateForms" class="btn">Buat Form</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function fetchData() {
                const tingkat = document.getElementById("tingkatDropdown").value;
                const jurusan = document.getElementById("jurusanDropdown").value;

                console.log("Tingkat terpilih:", tingkat);
                console.log("Jurusan terpilih:", jurusan);

                // Fetch data dari servlet
                fetch("<%= request.getContextPath()%>/BagiKelasServlet?jurusan=" + jurusan + "&tingkat=" + tingkat)
                        .then(function (response) {
                            console.log("Status Response:", response.status);
                            if (!response.ok) {
                                throw new Error("HTTP error " + response.status);
                            }
                            return response.json();
                        })
                        .then(function (data) {
                            console.log("Data diterima dari server:", data);
                            const jumlahKelasInput = document.getElementById("jumlahKelas");
                            const jumlahSiswaInput = document.getElementById("jumlahSiswa");
                            const jumlahKelasContainer = document.getElementById("jumlahKelasContainer");
                            jumlahKelasInput.value = data.jumlahKelas;
                            jumlahSiswaInput.value = data.jumlahSiswa;

                            if (data.jumlahKelas !== data.jumlahSiswa) {
                                jumlahKelasContainer.style.display = "block";
                            } else {
                                jumlahKelasContainer.style.display = "none";
                            }
                        })
                        .catch(function (error) {
                            console.error("Error:", error);
                        });
            }

            // Tambahkan event listener pada kedua dropdown
            document.getElementById("tingkatDropdown").addEventListener("change", fetchData);
            document.getElementById("jurusanDropdown").addEventListener("change", fetchData);
        </script>
    </body>
</html>
