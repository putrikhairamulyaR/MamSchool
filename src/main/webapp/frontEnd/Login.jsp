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
        <style>
            body {
                background-color: #f0f8ff; 
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .login-container {
                background: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 400px;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .btn-custom {
                background-color: #6ec1e4;
                color: white;
                font-weight: bold;
                border: none;
            }
            .btn-custom:hover {
                background-color: #5ba9cd;
            }
            .toggle-password {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h1>Login</h1>
            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username"required>
                </div>
                <div class="mb-3 position-relative">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" required>
                        <span class="input-group-text toggle-password" id="togglePassword">
                            <i class="bi bi-eye-slash" id="iconPassword"></i>
                        </span>
                    </div>
                </div>
                <button type="submit" class="btn btn-custom w-100">Login</button>
                <div class="text-center mt-3">
                    <p>Belum punya akun? <a href="SignIn.jsp" class="text-primary">Daftar di sini!</a></p>
                </div>
            </form>
        </div>

        <!-- JavaScript untuk Toggle Password -->
        <script>
            const togglePassword = document.querySelector("#togglePassword");
            const passwordField = document.querySelector("#password");
            const iconPassword = document.querySelector("#iconPassword");

            togglePassword.addEventListener("click", function () {
                // Toggle jenis input
                const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
                passwordField.setAttribute("type", type);

                // Ubah ikon
                iconPassword.classList.toggle("bi-eye");
                iconPassword.classList.toggle("bi-eye-slash");
            });
        </script>
    </body>
</html>
