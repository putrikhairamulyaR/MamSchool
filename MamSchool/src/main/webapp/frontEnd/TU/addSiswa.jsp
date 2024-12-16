<%-- 
    Document   : addSiswa
    Created on : 15 Dec 2024, 22.49.47
    Author     : luthfiah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Siswa</title>
</head>
<body>
    <h2>Tambah Data Siswa</h2>
    <form action="${pageContext.request.contextPath}/SiswaServlet" method="post">
        <!-- Parameter untuk menentukan aksi -->
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id" value= <%= request.getParameter("id") %> >

        <label for="userId">User ID:</label>
        <input type="number" name="userId" required><br><br>

        <label for="nis">NIS:</label>
        <input type="text" name="nis" required><br><br>

        <label for="name">Nama:</label>
        <input type="text" name="name" required><br><br>

        <label for="dateOfBirth">Tanggal Lahir:</label>
        <input type="date" name="dateOfBirth" required><br><br>

        <label for="enrollmentYear">Tahun Masuk:</label>
        <input type="number" name="enrollmentYear" required><br><br>

        <label for="classId">Kelas ID:</label>
        <input type="number" name="classId" required><br><br>

        <label for="major">Jurusan:</label>
        <input type="text" name="major" required><br><br>

        <label for="teacherId">Guru ID:</label>
        <input type="number" name="teacherId" required><br><br>

        <button type="submit">Tambah Siswa</button>
    </form>
</body>
</html>

