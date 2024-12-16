<%-- 
    Document   : editSiswa
    Created on : 15 Dec 2024, 23.11.39
    Author     : luthfiah
--%>

<%@page import="dao.siswaDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Siswa</title>
</head>
<body>
    <h2>Edit Data Siswa</h2>
   <%  siswaDAO siswaDao= new siswaDAO();
       
        Student student = siswaDao.getSiswaById(Integer.parseInt(request.getParameter("id"))); %>
    <form action="${pageContext.request.contextPath}/SiswaServlet" method="post">
        <!-- Parameter untuk menentukan aksi -->
        <input type="hidden" name="action" value="edit">
        
        <input type="hidden" name="id" value= <%= request.getParameter("id") %> >
        <label for="userId">User ID:</label>
        <input type="number" name="userId" value="<%= student.getUserId() %>"  required><br><br>

        <label for="nis">NIS:</label>
        <input type="text" name="nis"  value="<%= student.getNis() %>" required><br><br>

        <label for="name">Nama:</label>
        <input type="text" name="name"  value="<%= student.getName() %>"  required><br><br>

        <label for="dateOfBirth">Tanggal Lahir:</label>
        <input type="date" name="dateOfBirth"  value="<%= student.getDateOfBirth()   %>"  required><br><br>

        <label for="enrollmentYear">Tahun Masuk:</label>
        <input type="number" name="enrollmentYear"  value="<%= student.getEnrollmentYear()  %>" required><br><br>

        <label for="classId">Kelas ID:</label>
        <input type="number" name="classId"  value="<%= student.getClassId() %>" required><br><br>

        <label for="major">Jurusan:</label>
        <input type="text" name="major"  value="<%= student.getMajor() %>" required><br><br>

        <label for="teacherId">Guru ID:</label>
        <input type="number" name="teacherId"  value="<%= student.getUserId() %>" required><br><br>

        <button type="submit">Edit Siswa</button>
    </form>
</body>
</html>

