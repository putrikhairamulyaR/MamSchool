<%@page import="dao.ListTeacherDAO"%>
<%@page import="model.Classes"%>
<%@page import="dao.ClassesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>

<%
    ClassesDAO classesDao = new ClassesDAO();
    TeacherDAO  TeacherDAO = new TeacherDAO();
    List<Teacher> teachers = TeacherDAO.getAllTeachers(); 
    List<Classes> classes = classesDao.getAllClasses();

    String selectedNip = request.getParameter("nip");
     String selectedClass = request.getParameter("name");
    String subject = null;
    
    

    if (selectedNip != null) {
        for (Teacher teacher : teachers) {
            if (teacher.getNip().equals(selectedNip)) {
                subject = teacher.getSubject();
                break;
            }
        }
    }
       
    

%>

<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tambah Jadwal</title>
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
            <h3>Tambah Jadwal</h3>
            <!-- Menampilkan Pesan Error jika ada bentrok -->
        <div class="alert alert-danger" style="<%= request.getAttribute("errorMessage") == null ? "display: none;" : "" %>" role="alert">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </div>
            <div class="form-container">
                <form id="addJadwalForm" action="${pageContext.request.contextPath}/Jadwal" method="post">
                      <input type="hidden" name="action" value="add">
                    <!-- Pilih NIP Guru -->
                    <div class="mb- 3">
                        <label for="nip" class="form-label">NIP Guru</label>
                         <select name="nip" id="class" class="form-select" required onchange="fetchTeacherDetails()">
                            <%  for (Teacher teacher : teachers) {%>
                            <option value="<%= teacher.getNip()%> "><%= teacher.getNip()%>  <%= teacher.getName()%>  <%= teacher.getSubject()%> </option>                        
                            <%  }%>
                         </select>
                     </div>

                    
                    <!-- Input Kelas -->
                    <div class="mb-3">
                        <label for="class" class="form-label">Kelas</label>
                        <select name="kelas" id="kelas" class="form-select" required>
                            <%
                                for (Classes cls : classes) {
                                  
                            %>
                            <option value="<%= cls.getId() %>">
                                <%= cls.getName()%>
                            </option>
                            <%
                                
                                }
                            %>
                        </select>
                    </div>


                    <!-- Input Hari -->
                    <div class="mb-3">
                        <label for="hari" class="form-label">Hari</label>
                        <select name="hari" id="hari" class="form-select" required>
                            
                            
                            
                            
                            <option value="" disabled selected>Pilih Hari</option>
                            <option value="senin">Senin</option>
                            <option value="selasa">Selasa</option>
                            <option value="rabu">Rabu</option>
                            <option value="kamis">Kamis</option>
                            <option value="jumat">Jumat</option>
                            <option value="sabtu">Sabtu</option>
                        </select>
                    </div>

                    <!-- Input Jam Mulai -->
                    <div class="mb-3">
                        <label for="jamMulai" class="form-label">Jam Mulai</label>
                        <input type="time" name="jam" id="jamMulai" class="form-control" required>
                    </div>

                    <!-- Input Jam Selesai -->
                    <div class="mb-3">
                        <label for="jamSelesai" class="form-label">Jam Selesai</label>
                        <input type="time" name="jamSelesai" id="jamSelesai" class="form-control" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Simpan Jadwal</button>
                </form>
            </div>
        </div>
    </body>
</html> 

