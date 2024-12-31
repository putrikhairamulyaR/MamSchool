<%-- 
    Document   : editUser
    Created on : 28 Dec 2024, 19.53.14
    Author     : Raisa Lukman Hakim
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit User</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .content {
                padding: 20px;
                flex: 1;
                background-color: #f5f5f5;
            }

            .form-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .form-container h3 {
                margin-bottom: 20px;
            }

            .form-control {
                margin-bottom: 15px;
            }

            .btn-primary {
                background-color: #4682b4;
                border: none;
            }

            .btn-primary:hover {
                background-color: #3e75a2;
            }
        </style>
    </head>
    <body>
        <!-- Main Content -->
        <div class="content">
            <a class="nav-link" href="${pageContext.request.contextPath}/SigninServlet">
                <i data-feather="arrow-left" class="align-middle"></i>
                <span class="align-middle fs-4 fw-bold">Kembali</span>
            </a>
            <div class="form-container">
                <h3>Edit Pengguna</h3>
                <form action="SigninServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${user.id}">

                    <div class="mb-3">
                        <label for="username" class="form-label">Username:</label>
                        <input type="text" name="username" class="form-control" id="username" value="${user.username}" placeholder="Masukkan username" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" name="password" class="form-control" id="password" placeholder="Masukkan password" required>
                    </div>

                    <div class="mb-3">
                        <label for="role" class="form-label">Role:</label>
                        <select name="role" class="form-select" id="role">
                            <option value="kepsek" ${user.role == 'kepsek' ? 'selected' : ''}>Kepsek</option>
                            <option value="tu" ${user.role == 'tu' ? 'selected' : ''}>TU</option>
                            <option value="guru" ${user.role == 'guru' ? 'selected' : ''}>Guru</option>
                            <option value="siswa" ${user.role == 'siswa' ? 'selected' : ''}>Siswa</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Pengguna</button>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/feather-icons"></script>
        <script>
            feather.replace({color: '#000000'});
        </script>
    </body>
</html>

