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
    <body class="bg-light d-flex justify-content-center align-items-center login-container">

        <div class="card p-4 shadow" style="min-width: 400px">
            <h1 class="text-center mb-3">HALO!</h1>
            <p class="text-center mb-4">Silahkan login menggunakan akunmu!</p>
            <p>Context Path: ${pageContext.request.contextPath}</p>


            <!-- Pesan Error atau Sukses -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger text-center" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success text-center" role="alert">
                    ${message}
                </div>
            </c:if>

            <!-- Form Login -->
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <!-- Input Username -->
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           pattern="^[a-zA-Z0-9._-]{3,20}$" 
                           title="Username harus berupa 3-20 karakter alfanumerik" required>
                </div>

                <!-- Input Password User -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           minlength="6" title="Password minimal 6 karakter" required>
                </div>

                <!-- Tombol Login -->
                <button type="submit" class="btn btn-mam-1 w-100">Login</button>

                <!-- Link ke Halaman Daftar -->
                <div class="text-center mt-3">
                    <p>Belum punya akun? <a href="SignIn.jsp" class="text-primary">Daftar di sini!</a></p>
                </div>
            </form>
        </div>

    </body>

</html>

