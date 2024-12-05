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
                <div class="row"> 
                    <div class="col-md-4"> 
                        <p>
                            <strong>Pilih Tingkat dan Jurusan!</strong>
                        </p> 
                    </div> 
                    <div class="col-md-8"> 
                        <select name="Choose" class="form-select"> 
                            <option>10 IPA</option> 
                            <option>10 IPS</option> 
                            <option>11 IPA</option> 
                            <option>11 IPS</option> 
                            <option>12 IPA</option> 
                            <option>12 IPS</option> 
                        </select> 
                    </div>
                    <p>
                        <strong>Jumlah Siswa:</strong>
                        <span id="jumlah">xxx</span>
                    </p>
                    <form id="formContainer">
                        <div class="mb-3">
                            <label for="jumlahKelas" class="form-label">Jumlah Kelas:</label>
                            <input type="number" id="jumlahKelas" class="form-control" placeholder="Masukkan jumlah kelas">
                        </div>
                        <button type="button" id="generateForms" class="btn">Buat Form</button>
                        <div id="dynamicForms" class="mt-4"></div>
                        <button type="button" id="confirmForms" class="btn mt-3" style="display: none;">Confirm</button>
                    </form>
                </div>
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
                            <th>Kelas</th>
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

        <script>
            document.getElementById('generateForms').addEventListener('click', function () {
                const jumlahKelas = parseInt(document.getElementById('jumlahKelas').value);
                const dynamicForms = document.getElementById('dynamicForms');
                const confirmButton = document.getElementById('confirmForms');

                dynamicForms.innerHTML = '';

                if (!isNaN(jumlahKelas) && jumlahKelas > 0) {
                    for (let i = 1; i <= jumlahKelas; i++) {
                        const formRow = document.createElement('div');
                        formRow.classList.add('form-row', 'mb-2');
                        formRow.innerHTML = `
            <div>
                <label for="kelas${i}" class="form-label">Nama Kelas: 10 IPA (i)</label>
            </div>
            <div>
                <input type="number" id="jumlah" name="jumlah" class="form-control" placeholder="Masukkan jumlah siswa">
            </div>
        `;
                        dynamicForms.appendChild(formRow);
                    }
                    confirmButton.style.display = 'inline-block';
                } else {
                    alert('Masukkan jumlah kelas yang valid!');
                }
            });

            document.getElementById('confirmForms').addEventListener('click', function () {
                const jumlahKelas = parseInt(document.getElementById('jumlahKelas').value);
                const data = [];

                for (let i = 1; i <= jumlahKelas; i++) {
                    const namaKelas = document.getElementById(`kelas${i}`).value;
                    const jumlahSiswa = document.getElementById(`jumlah${i}`).value;

                    if (namaKelas && jumlahSiswa) {
                        data.push({namaKelas, jumlahSiswa});
                    } else {
                        alert(`Data pada kelas ${i} belum lengkap!`);
                        return;
                    }
                }

                console.log(data);
                alert('Data berhasil dikonfirmasi!');
            });

        </script>
    </body>
</html>
