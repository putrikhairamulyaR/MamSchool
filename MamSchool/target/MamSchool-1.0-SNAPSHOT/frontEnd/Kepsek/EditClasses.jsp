<%-- 
    Document   : EditClasses
    Created on : 14 Dec 2024, 23.14.00
    Author     : Raisa Lukman Hakim
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Kelas</title>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/ClassesServlet">
                <i data-feather="arrow-left" class="align-middle"></i>
                <span class="align-middle fs-4 fw-bold">Kembali</span>
            </a>
            <div class="form-container">
                <h3>Edit Kelas</h3>
                <form action="ClassesServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${classes.id}">

                    <div class="mb-3">
                        <label for="name" class="form-label">Nama Kelas:</label>
                        <input type="text" name="name" class="form-control" id="name" value="${classes.name}" placeholder="Masukkan nama kelas" required>
                    </div>

                    <div class="mb-3">
                        <label for="major" class="form-label">Jurusan:</label>
                        <input type="text" name="major" class="form-control" id="major" value="${classes.major}" placeholder="Masukkan jurusan" required>
                    </div>

                    <div class="mb-3">
                        <label for="teacher_id" class="form-label">ID Guru:</label>
                        <input type="number" name="teacher_id" class="form-control" id="teacher_id" value="${classes.teacher_id}" placeholder="Masukkan ID guru" required>
                    </div>

                    <div class="mb-3">
                        <label for="tingkat" class="form-label">Tingkat:</label>
                        <input type="number" name="tingkat" class="form-control" id="tingkat" value="${classes.tingkat}" placeholder="Masukkan tingkat" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Kelas</button>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/feather-icons"></script>
    </body>
</html>
