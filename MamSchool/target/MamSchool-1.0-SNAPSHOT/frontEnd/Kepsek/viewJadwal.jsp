<%-- 
    Document   : deleteJadwal
    Created on : Dec 31, 2024, 9:26:30 AM
    Author     : Necha
--%>



<%@page import="model.Jadwal"%>
<%@page import="dao.JadwalDAO"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JadwalDAO jadwalDAO = new JadwalDAO();
    Teacher teacher = null;
    int id = Integer.parseInt(request.getParameter("id"));
    Jadwal jadwal = jadwalDAO.getJadwalById(id);
    
    if (jadwal != null) {
        teacher = jadwalDAO.getTeacherId(jadwal.getTeacherId());
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informasi Jadwal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Informasi Jadwal</h2>
        <form action="${pageContext.request.contextPath}/Jadwal?action=delete" method="post">
            <input type="hidden" name="id" value="<%= jadwal.getId() %>">
            
            <!-- Informasi Guru -->
            <div class="mb-3">
                <label for="nip" class="form-label">NIP Guru</label>
                <input type="text" class="form-control" id="nip" name="nip" value="<%= teacher.getNip() %>" disabled>
            </div>

            <div class="mb-3">
                <label for="teacherName" class="form-label">Nama Guru</label>
                <input type="text" class="form-control" id="teacherName" name="teacherName" value="<%= teacher.getName() %>" disabled>
            </div>

            <div class="mb-3">
                <label for="subject" class="form-label">Mapel</label>
                <input type="text" class="form-control" id="subject" name="subject" value="<%= teacher.getSubject() %>" disabled>
            </div>

            <!-- Informasi Jadwal -->
            <div class="mb-3">
                <label for="kelas" class="form-label">Kelas</label>
                <input type="text" class="form-control" id="kelas" name="kelas" value="<%= jadwal.getidKelas() %>" disabled>
            </div>

            <div class="mb-3">
                <label for="hari" class="form-label">Hari</label>
                <input type="text" class="form-control" id="hari" name="hari" value="<%= jadwal.getDay() %>" disabled>
            </div>

            <div class="mb-3">
                <label for="jamMulai" class="form-label">Jam Mulai</label>
                <input type="time" name="jam" id="jamMulai" class="form-control" value="<%= jadwal.getStartTime() %>" disabled>
            </div>

            <div class="mb-3">
                <label for="jamSelesai" class="form-label">Jam Selesai</label>
                <input type="time" name="jamSelesai" id="jamSelesai" class="form-control" value="<%= jadwal.getEndTime() %>" disabled>
            </div>

           
            <a href="listJadwal.jsp" class="btn btn-secondary">Kembali</a>
        </form>
    </div>
</body>
</html>
