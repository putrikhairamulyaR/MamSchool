<%-- 
    Document   : Login
    Created on : 19 Nov 2024, 19.11.26
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <style>
        .login-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }
        .btn-mam-1 {
            background-color: #4682b4;
            color: white;
            font-weight: bold;
        }
        .btn-mam-1:hover {
            background-color: #5ba9cd;
        }
    </style>
    <body class="bg-light d-flex justify-content-center align-items-center  login-container">

        <div class="card p-4 shadow" style="min-width: 400px">
            <h1 class="text-center mb-3">HALO!</h1>
            <p class="text-center mb-4">Silahkan login menggunakan akunmu!</p>

            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <button type="submit" class="btn btn-mam-1 w-100">Login</button>

                <div class="text-center mt-3">
                    <p>Belum punya akun? <a href="SignIn.jsp" class="text-primary">Daftar di sini!</a></p>
                </div>
            </form>
        </div>

    </body>
</html>

