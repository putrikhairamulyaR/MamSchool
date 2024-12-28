<%-- 
    Document   : UserList
    Created on : 28 Dec 2024, 20.12.52
    Author     : Raisa Lukman Hakim
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="users" items="${userList}">
                <tr>
                    <td>${users.id}</td>
                    <td>${users.username}</td>
                    <td>${users.password}</td>
                    <td>${users.role}</td>
                    <td>
                        <a href="SigninServlet?action=edit&id=${users.id}" class="btn btn-warning btn-sm">
                            <i class="bi bi-pencil"></i> Edit
                        </a>
                        <a href="SigninServlet?action=delete&id=${users.id}" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus siswa ini?');">
                            <i class="bi bi-trash"></i> Hapus
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
