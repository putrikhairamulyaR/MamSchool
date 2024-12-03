<%-- 
    Document   : SignIn
    Created on : 19 Nov 2024, 19.10.07
    Author     : putri
--%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #007bff;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #4682b4;
            color: white;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #3e75a2;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper i {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Create Account</h1>
        <form onsubmit="validateForm(event)">
            <div class="form-group">
                <label for="username">Username (Tidak dapat diubah!)</label>
                <input type="text" id="username" placeholder="Enter username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="password-wrapper">
                    <input type="password" id="password" placeholder="Enter password" required>
                </div>
            </div>
            <div class="form-group">
                <label for="nama">Nama</label>
                <input type="text" id="nama" placeholder="Masukkan nama lengkap" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="dob">Tanggal Lahir</label>
                <input type="date" id="dob" required>
            </div>
            <div class="form-group">
                <label for="gender">Jenis Kelamin</label>
                <select id="gender" required>
                    <option value="" disabled selected>Pilih...</option>
                    <option value="male">Laki-laki</option>
                    <option value="female">Perempuan</option>
                </select>
            </div>
            <div class="form-group">
                <label for="role">Posisi</label>
                <select id="role" onchange="toggleRoleFields()" required>
                    <option value="" disabled selected>Pilih...</option>
                    <option value="student">Siswa/Siswi</option>
                    <option value="teacher">Guru</option>
                    <option value="principal">Kepala Sekolah</option>
                </select>
            </div>
            <div id="student-field" class="form-group hidden">
                <label for="nis">NIS</label>
                <input type="text" id="nis" placeholder="Masukkan NIS">
            </div>
            <div id="teacher-field" class="form-group hidden">
                <label for="nip">NIP</label>
                <input type="text" id="nip" placeholder="Masukkan NIP">
            </div>
            <div id="specialization-field" class="form-group hidden">
                <label for="specialization">Spesialisasi</label>
                <input type="text" id="specialization" placeholder="Masukkan bidang spesialisasi">
            </div>
            <button type="submit" class="btn">Sign Up</button>
            <div class="login-link">
                Sudah memiliki akun? <a href="Login.jsp">Log in disini!</a>
            </div>
        </form>
    </div>
    <script>
        function toggleRoleFields() {
            const role = document.getElementById("role").value;
            const studentField = document.getElementById("student-field");
            const teacherField = document.getElementById("teacher-field");
            const specializationField = document.getElementById("specialization-field");

            if (role === "student") {
                studentField.classList.remove("hidden");
                teacherField.classList.add("hidden");
                specializationField.classList.add("hidden");
            } else if (role === "teacher" || role === "principal") {
                teacherField.classList.remove("hidden");
                specializationField.classList.remove("hidden");
                studentField.classList.add("hidden");
            } else {
                studentField.classList.add("hidden");
                teacherField.classList.add("hidden");
                specializationField.classList.add("hidden");
            }
        }

        function validateForm(event) {
            const fields = [
                document.getElementById("username"),
                document.getElementById("password"),
                document.getElementById("nama"),
                document.getElementById("email"),
                document.getElementById("dob"),
                document.getElementById("gender"),
                document.getElementById("role"),
            ];

            let isValid = true;

            fields.forEach(field => {
                if (!field.value) {
                    isValid = false;
                    field.style.borderColor = "red";
                } else {
                    field.style.borderColor = "#ccc";
                }
            });

            const role = document.getElementById("role").value;
            if (role === "student" && !document.getElementById("nis").value) {
                isValid = false;
                document.getElementById("nis").style.borderColor = "red";
            } else if ((role === "teacher" || role === "principal") && !document.getElementById("nip").value) {
                isValid = false;
                document.getElementById("nip").style.borderColor = "red";
            }
            if ((role === "teacher" || role === "principal") && !document.getElementById("specialization").value) {
                isValid = false;
                document.getElementById("specialization").style.borderColor = "red";
            }

            if (!isValid) {
                event.preventDefault();
                alert("Mohon isi semua field sebelum melanjutkan.");
            }
        }
    </script>
</body>
</html>
