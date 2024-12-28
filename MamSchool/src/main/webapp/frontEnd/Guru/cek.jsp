<%-- 
    Document   : cek
    Created on : 28 Dec 2024, 17.02.19
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><%= request.getParameter("message") %></h1>
        <a href="/MamSchool/nilaiServlet?action=view">Lihat nilai</a>
    </body>
</html>
