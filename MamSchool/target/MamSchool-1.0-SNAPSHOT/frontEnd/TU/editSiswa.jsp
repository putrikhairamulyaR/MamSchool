<%-- 
    Document   : editSiswa
    Created on : 15 Dec 2024, 23.11.39
    Author     : luthfiah
--%>

<%@page import="dao.siswaDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Siswa</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: #f8f9fa;
                color: #333;
            }

            h2 {
                text-align: center;
                margin-top: 20px;
                color: #007bff;
            }

            .container {
                width: 90%;
                max-width: 600px;
                margin: 30px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            label {
                display: block;
                margin: 10px 0 5px;
                font-weight: bold;
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
                display: block;
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #218838;
            }

            /* Responsif */
            @media (max-width: 768px) {
                .container {
                    width: 95%;
                }
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
        <h2>Edit Data Siswa</h2>
        <div class="container">
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

                <label for="nis">NIS:</label>
                <input type="text" name="nis" value="<%= student.getNis() %>" required>

                <label for="name">Nama:</label>
                <input type="text" name="name" value="<%= student.getName() %>" required>

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
            </form>
            <% } %>
        </div>
    </body>
</html>