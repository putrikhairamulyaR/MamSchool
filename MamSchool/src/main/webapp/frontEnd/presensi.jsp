<%@page import="dao.PresensiDao"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Presensi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center">Presensi</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID Siswa</th>
                        <th>Tanggal</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        PresensiDao db = new PresensiDao();
                        if (db.isConnected) {
                            ResultSet rs = db.getData("SELECT * FROM barang");
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("") %></td>
                        <td><%= rs.getString("") %></td>
                    </tr>
                    <%
                            }
                            db.disconnect();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
