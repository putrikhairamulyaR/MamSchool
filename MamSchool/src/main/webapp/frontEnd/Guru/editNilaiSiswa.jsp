<%-- 
    Document   : editNilaiSiswa
    Created on : 9 Dec 2024, 08.18.21
    Author     : putri
--%>

<%@page import="model.nilai"%>
<%@page import="dao.gradeDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Nilai Siswa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #34495e;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 15px;
            position: fixed;
            height: 100%;
        }

        .sidebar h4 {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }

        .sidebar a:hover {
            background-color: #2980b9;
        }

        .sidebar a i {
            margin-right: 10px;
        }

        /* Konten */
        .content {
            margin-left: 260px;
            padding: 20px;
            flex: 1;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

        /* Form Styling */
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: bold;
        }

        .btn-custom {
            display: inline-block;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h4>Dashboard Siswa</h4>
        <a href="#"><i class="bi bi-house-door-fill"></i> Beranda</a>
        <a href="#"><i class="bi bi-list-check"></i> Kelas</a>
        <a href="#"><i class="bi bi-clipboard2-check"></i> Nilai</a>
        <a href="#"><i class="bi bi-book"></i> Mapel</a>
        <hr>
        <a href="#"><i class="bi bi-gear"></i> Setting</a>
        <a href="#"><i class="bi bi-question-circle"></i> Bantuan</a>
        <a href="#"><i class="bi bi-box-arrow-left"></i> Logout</a>
    </div>

    <!-- Konten Utama -->
    <div class="content">
        <h3>Tambah Nilai Siswa</h3>

        <!-- Form Input Nilai Siswa -->
        <div class="form-container">
            <%String id = request.getParameter("id");
                gradeDao gd = new gradeDao();
                nilai grade = gd.getGradeById(Integer.parseInt(id));
                
            %>
            <%=grade.getIdNilai()%>
            <form id="editNilaiForm" action="${pageContext.request.contextPath}/nilaiServlet" method="post">
               <!-- Input id -->
               <input type="hidden" name ="id" value ="<%=grade.getIdNilai()%>">
                <input type="hidden" name="action" value ="update">
                <!-- Input UTS -->
               <div class="mb-3">
                   <label for="uts" class="form-label">Nilai UTS</label>
                   <input type="number" name="uts" id="uts" class="form-control" value="<%=grade.getUts()%>" required><br><br>
               </div>

               <!-- Input UAS -->
               <div class="mb-3">
                   <label for="uas" class="form-label">Nilai UAS</label>
                   <input type="number" name="uas" id="uas" class="form-control" value="<%=grade.getUas()%>" required><br><br>
               </div>

               <!-- Input Tugas -->
               <div class="mb-3">
                   <label for="tugas" class="form-label">Nilai Tugas</label>
                   <input type="number" name="tugas" id="tugas" class="form-control" value="<%=grade.getTugas()%>" required><br><br>
               </div>

               <!-- Tombol Submit -->
               <div class="text-end">
                   <button type="submit" class="btn btn-primary btn-custom">
                        <i class="bi bi-save me-2"></i> Simpan
                    </button>
                   <a href="nilaiMapel.jsp" class="btn btn-secondary btn-custom">
                       <i class="bi bi-arrow-left me-2"></i> Kembali
                   </a>
               </div>
           </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>

