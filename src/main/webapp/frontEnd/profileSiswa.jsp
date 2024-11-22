<%-- 
    Document   : profile
    Created on : 20 Nov 2024, 09.57.58
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Siswa</title>
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
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #4682b4;
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .sidebar h2 {
            font-size: 25px;
            text-align: left;
            margin-bottom: 30px;
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            margin: 10px 0;
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar a:hover {
            text-decoration: underline;
        }

        .content {
            margin-left: 260px;
            padding: 20px;
            flex: 1;
            background-color: #f5f5f5;
        }

        .profile-container {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .profile-container h1 {
            margin-bottom: 20px;
        }

        .profile-container p {
            margin: 10px 0;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .profile-container strong {
            width: 150px; /* Lebar tetap untuk label agar sejajar */
            display: inline-block;
            text-align: right;
            margin-right: 5px;
        }

        .profile-container span,
        .profile-container input {
            flex: 1;
        }

        .edit-icon {
            position: absolute;
            top: 65px;
            right: 20px;
            color: gray;
            font-size: 24px;
            cursor: pointer;
        }

        .edit-icon:hover {
            color: #3366cc;
        }

        .save-btn {
            display: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <h2>Dashboard Siswa</h2>
        <a href="profileSiswa.jsp"><i class="bi bi-person-circle"></i> Profile</a>
        <a href="DasboardSiswa.jsp#beranda"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="kelas.jsp"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="#nilai"><i class="bi bi-clipboard2-check"></i> Nilai</a>
        <a href="#mapel"><i class="bi bi-book"></i> Mapel</a>
        <a href="#setting"><i class="bi bi-gear"></i> Setting</a>
        <a href="#bantuan"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="tampilanAwal.jsp" style="margin-top: auto;"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="profile-container">
            <!-- Edit Icon -->
            <i class="bi bi-pencil-square edit-icon" title="Edit Profile" id="editIcon"></i>
            <!-- Profile Title -->
            <h1>Profil Siswa</h1>
            <!-- Profile Details -->
            <form id="profileForm">
                <p>
                    <strong>Username:</strong>
                    <span id="username">xxx</span>
                </p>
                <p>
                    <strong>Password:</strong>
                    <span id="password">xxx</span>
                </p>
                <p>
                    <strong>Nama:</strong>
                    <span id="nama">xxx</span>
                </p>
                <p>
                    <strong>Email:</strong>
                    <span id="email">xxx@gmail.com</span>
                </p>
                <p>
                    <strong>Tanggal Lahir:</strong>
                    <span id="dob">2000-01-01</span>
                </p>
                <p>
                    <strong>Jenis Kelamin:</strong>
                    <span id="gender">Perempuan</span>
                </p>
                <p>
                    <strong>Posisi:</strong>
                    <span id="position">Siswa/Siswi</span>
                </p>
                <p>
                    <strong>NIS:</strong>
                    <span id="nis">1234567</span>
                </p>
                <button type="button" class="btn btn-primary save-btn" id="saveBtn">Simpan</button>
            </form>
        </div>
    </div>

    <script>
        const editIcon = document.getElementById('editIcon');
        const saveBtn = document.getElementById('saveBtn');
        const formFields = ['password', 'nama', 'email', 'dob', 'gender', 'nis'];

        editIcon.addEventListener('click', () => {
            formFields.forEach(id => {
                const span = document.getElementById(id);
                const value = span.innerText;
                const input = document.createElement('input');
                if (id === 'dob') {
                    input.type = 'date'; // Input untuk memilih tanggal
                } else if (id === 'password') {
                    input.type = 'password';
                } else {
                    input.type = 'text';
                }
                input.value = value;
                input.id = id;
                input.classList.add('form-control');
                span.replaceWith(input);
            });
            saveBtn.style.display = 'block'; // Tampilkan tombol simpan
        });

        saveBtn.addEventListener('click', () => {
            formFields.forEach(id => {
                const input = document.getElementById(id);
                const value = input.value;
                const span = document.createElement('span');
                span.id = id;
                span.innerText = value;
                input.replaceWith(span);
            });
            saveBtn.style.display = 'none'; // Sembunyikan tombol simpan
            alert('Perubahan berhasil disimpan!');
        });
    </script>
</body>
</html>
