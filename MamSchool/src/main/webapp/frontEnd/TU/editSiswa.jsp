<%-- 
    Document   : editSiswa
    Created on : 15 Dec 2024, 23.11.39
    Author     : luthfiah
--%>

<%@page import="dao.siswaDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (!"tu".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Siswa</title>
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            } 

            .container {
                width: 100%;
                height: 100%;
                padding: 20px;
                background-color: white;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                box-sizing: border-box;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }
           
            .table-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            input[type="text"],
            input[type="number"],
            input[type="date"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            button {
               width: auto;
                padding: 10px 20px;
                background-color: #2E8B57;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                margin-top: 15px;
            }
            
            button:hover {
                background-color: #006400;
            }
            
            .btn-back {
                display: inline-block;
                padding: 10px 20px;
                background-color: #d9534f;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                 text-align: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            
            .btn-back:hover {
                background-color: #c9302c;
            }
            
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                color: #333;
           }
        </style>
    </head>
    <body>         
        <div class="container">
        <h3>Edit Data Siswa</h3>
            <%
                siswaDAO siswaDao = new siswaDAO();
                Student student = siswaDao.getSiswaById(Integer.parseInt(request.getParameter("id")));
                if (student == null) {
            %>
                <p style="color: red; text-align: center;">Data siswa tidak ditemukan!</p>
            <%
                } else {
            %>
            <form action="${pageContext.request.contextPath}/SiswaServlet" method="post">
                <!-- Parameter untuk menentukan aksi -->
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= student.getId() %>">
                
                <input type="hidden" name="userId" value="<%= student.getUserId() %>"

                <label for="nis">NIS:</label>
                <input type="text" name="nis" value="<%= student.getNis() %>" readonly>

                <label for="name">Nama:</label>
                <input type="text" name="name" value="<%= student.getName() %>" readonly>

                <label for="dateOfBirth">Tanggal Lahir:</label>
                <input type="date" name="dateOfBirth" value="<%= student.getDateOfBirth() %>" required>

                <label for="enrollmentYear">Tahun Masuk:</label>
                <input type="number" name="enrollmentYear" value="<%= student.getEnrollmentYear() %>" required>

                <label for="major">Jurusan:</label>
                <select name="major" required>
                    <option value="IPA" <%= student.getMajor().equals("IPA") ? "selected" : "" %>>IPA</option>
                    <option value="IPS" <%= student.getMajor().equals("IPS") ? "selected" : "" %>>IPS</option>
                </select>

                <button type="submit">Edit Siswa</button>
            <a class="nav-link" href="${pageContext.request.contextPath}/SiswaServlet">
                    <button href="MenuSiswa.jsp" class="btn-back">Kembali</button>
            </a>
            </form>
            <% } %>
        </div>
        
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/feather-icons"></script>
        <script>
            feather.replace({color: '#000000'});
        </script>
        
    </body>
</html>