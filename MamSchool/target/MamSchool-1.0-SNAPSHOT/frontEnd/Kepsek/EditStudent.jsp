<%-- 
    Document   : EditStudent
    Created on : 14 Dec 2024, 23.45.00
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
        <title>Edit Siswa</title>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/StudentServlet">
                <i data-feather="arrow-left" class="align-middle"></i>
                <span class="align-middle fs-4 fw-bold">Kembali</span>
            </a>
            <div class="form-container">
                <h3>Edit Siswa</h3>
                <form action="StudentServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${student.id}">

                    <div class="mb-3">
                        <label for="user_id" class="form-label">User ID:</label>
                        <input type="number" name="user_id" class="form-control" id="user_id" value="${student.userId}" readonly required>
                    </div>

                    <div class="mb-3">
                        <label for="nis" class="form-label">NIS:</label>
                        <input type="text" name="nis" class="form-control" id="nis" value="${student.nis}" readonly required>
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label">Nama Siswa:</label>
                        <input type="text" name="name" class="form-control" id="name" value="${student.name}" required>
                    </div>

                    <div class="mb-3">
                        <label for="date_of_birth" class="form-label">Tanggal Lahir:</label>
                        <input type="date" name="date_of_birth" class="form-control" id="date_of_birth" value="${student.dateOfBirth}" readonly required>
                    </div>

                    <div class="mb-3">
                        <label for="enrollment_year" class="form-label">Tahun Masuk:</label>
                        <input type="number" name="enrollment_year" class="form-control" id="enrollment_year" value="${student.enrollmentYear}" readonly required>
                    </div>

                    <div class="mb-3">
                        <label for="major" class="form-label">Jurusan:</label>
                        <input type="text" name="major" class="form-control" id="major" value="${student.major}" readonly required>
                    </div>

                    <div class="mb-3">
                        <label for="class_id" class="form-label">Kelas:</label>
                        <select name="class_id" class="form-select" id="class_id">
                            <option value="">Pilih Kelas</option>
                            <c:forEach var="classes" items="${classesList}">
                                <option value="${classes.id}" ${student.classId == classes.id ? 'selected' : ''}>
                                    ${classes.name} - ${classes.major} - Tingkat ${classes.tingkat}
                                </option>
                            </c:forEach>

                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Siswa</button>
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
