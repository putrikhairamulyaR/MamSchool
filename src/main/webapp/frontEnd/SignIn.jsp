<%-- 
    Document   : SignIn
    Created on : 19 Nov 2024, 19.10.07
    Author     : putri
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f5f5;
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
            background-color:#6ec1e4;
            color: white;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #008f7a;
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
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Create Account</h1>
        <form>
            <div class="form-group">
                <label for="username">Username (Tidak dapat diubah!)</label>
                <input type="text" id="username" placeholder="Enter username" >
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" placeholder="Enter password">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="dob">Tanggal Lahir</label>
                <input type="date" id="dob">
            </div>
            <div class="form-group">
                <label for="gender">Jenis Kelamin</label>
                <select id="gender">
                    <option value="" disabled selected>Pilih...</option>
                    <option value="male">Laki-laki</option>
                    <option value="female">Perempuan</option>
                </select>
            </div>
            <div class="form-group">
                <label for="role">Posisi</label>
                <select id="role">
                    <option value="" disabled selected>Pilih...</option>
                    <option value="student">Siswa/Siswi</option>
                    <option value="teacher">Guru</option>
                </select>
            </div>
            <button type="submit" class="btn">Sign Up</button>
            <div class="login-link">
                Sudah memiliki akun? <a href="Login.jsp">Log in disini!</a>
            </div>
        </form>
    </div>
</body>
</html>

