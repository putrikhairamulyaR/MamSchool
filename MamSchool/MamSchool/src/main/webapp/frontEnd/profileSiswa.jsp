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
    <title>Profile Siswa</title>
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
        }
        .profile-card {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            margin-bottom: 20px;
        }
        .profile-card h4 {
            margin-bottom: 20px;
        }
        .profile-card p {
            margin: 10px 0;
            font-size: 16px;
            display: flex;
        }
        .profile-card strong {
            width: 150px;
            display: inline-block;
            margin-left: 50px;
        }
        .profile-card span,
        .profile-card input {
            flex: 1;
        }
        .edit-icon {
            position: absolute;
            top: 20px;
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
        .profile-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .profile-header i {
            font-size: 5rem; 
            color: grey;
        }
        .row-cols-2 > * {
            flex: 0 0 auto;
            width: 50%;
        }
        .btn{
            background-color: #4682b4;
            color: white;
        }
        .btn:hover{
            background-color: #3e75a2;
            color: white;
        }
        .d-flex-center {
            display: flex;
            justify-content: center;
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

    <div class="content">
        <div class="profile-header">
            <i class="bi bi-person-circle"></i>
            <h2 class="text-center">Profile Siswa</h2>
        </div>

        <div class="profile-card">
            <h4 class="text-center">Data Akun Siswa/Siswi</h4>
            <i class="bi bi-pencil-square edit-icon" title="Edit Profile" id="editIconAkun"></i>
            <form id="profileFormAkun">
                <div class="row row-cols-2">
                    <div>
                        <p>
                            <strong>Username:</strong>
                            <span id="username">xxx</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>Password:</strong>
                            <span id="password">xxx</span>
                        </p>
                    </div>
                </div>
                <div class="d-flex-center">
                    <button type="button" class="btn save-btn" id="saveBtnAkun">Save</button>
                </div>
            </form>
        </div>

        <div class="profile-card">
            <h4 class="text-center">Data Siswa/Siswi</h4>
            <i class="bi bi-pencil-square edit-icon" title="Edit Profile" id="editIconSiswa"></i>
            <form id="profileFormSiswa">
                <div class="row row-cols-2">
                    <div>
                        <p>
                            <strong>Nama:</strong>
                            <span id="nama">xxx</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>NIS:</strong>
                            <span id="nis">1234567</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>Email:</strong>
                            <span id="email">xxx@gmail.com</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>Tanggal Lahir:</strong>
                            <span id="dob">2000-01-01</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>Jenis Kelamin:</strong>
                            <span id="gender">Perempuan</span>
                        </p>
                    </div>
                    <div>
                        <p>
                            <strong>Posisi:</strong>
                            <span id="position">Siswa/Siswi</span>
                        </p>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="button" class="btn btn-primary save-btn" id="saveBtnSiswa">Save</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const formFieldsAkun = ['password'];
        const formFieldsSiswa = ['email'];

        function toggleEditMode(editIconId, saveBtnId, formFields) {
            const editIcon = document.getElementById(editIconId);
            const saveBtn = document.getElementById(saveBtnId);

            editIcon.addEventListener('click', () => {
                formFields.forEach(id => {
                    const span = document.getElementById(id);
                    const value = span.innerText;
                    const input = document.createElement('input');
                    if (id === 'dob') {
                        input.type = 'date'; // Input for date selection
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
                saveBtn.style.display = 'block'; // Show save button
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
                saveBtn.style.display = 'none'; // Hide save button
                alert('Changes saved successfully!');
            });
        }

        toggleEditMode('editIconAkun', 'saveBtnAkun', formFieldsAkun);
        toggleEditMode('editIconSiswa', 'saveBtnSiswa', formFieldsSiswa);
    </script>
</body>
</html>
