<%-- 
    Document   : Profile
    Created on : 30 Dec 2024, 15.26.46
    Author     : Dafi Utomo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <!-- Card for Username and Password -->
                    <c:if test="${not empty userProfile}">
                        <div class="card mb-4 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="bi bi-person-circle me-2"></i>Username and Password
                                </h5>
                                <p class="card-text">
                                    <strong>Username:</strong> ${userProfile.username}<br>
                                    <strong>Password:</strong> ${userProfile.password}
                                </p>
                            </div>
                        </div>

                        <!-- Role-Specific Details -->
                        <c:choose>
                            <c:when test="${role == 'kepsek'}">
                                <div class="card mb-4 shadow-sm">
                                    <div class="card-body">
                                        <h5 class="card-title">Kepala Sekolah</h5>
                                        <p class="card-text">
                                            <strong>Username:</strong> ${roleDetails.username}<br>
                                            <strong>Password:</strong> ${roleDetails.password}<br>
                                            <strong>Tanggal Dibuat:</strong> ${roleDetails.createdAt}
                                        </p>
                                    </div>
                                </div>
                            </c:when>

                            <c:when test="${role == 'siswa'}">
                                <div class="card mb-4 shadow-sm">
                                    <div class="card-body">
                                        <h5 class="card-title">Siswa</h5>
                                        <p class="card-text">
                                            <strong>Nama:</strong> ${roleDetails.name}<br>
                                            <strong>NIS:</strong> ${roleDetails.nis}<br>
                                            <strong>Kelas:</strong> ${roleDetails.classId}<br>
                                            <strong>Jurusan:</strong> ${roleDetails.major}<br>
                                            <strong>Tanggal Lahir:</strong> ${roleDetails.dateOfBirth}
                                        </p>
                                    </div>
                                </div>
                            </c:when>

                            <c:when test="${role == 'guru'}">
                                <div class="card mb-4 shadow-sm">
                                    <div class="card-body">
                                        <h5 class="card-title">Guru</h5>
                                        <p class="card-text">
                                            <strong>Nama:</strong> ${roleDetails.name}<br>
                                            <strong>NIP:</strong> ${roleDetails.nip}<br>
                                            <strong>Mata Pelajaran:</strong> ${roleDetails.subject}<br>
                                            <strong>Tanggal Lahir:</strong> ${roleDetails.dateOfBirth}<br>
                                            <strong>Tanggal Bergabung:</strong> ${roleDetails.hireDate}
                                        </p>
                                    </div>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="alert alert-danger" role="alert">
                                    Role pengguna tidak dikenali.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <c:if test="${empty userProfile}">
                        <div class="alert alert-danger" role="alert">
                            Data profil tidak ditemukan.
                        </div>
                    </c:if>

                    <!-- Back Button -->
                    <div class="text-center mt-4">
                        <a href="javascript:history.back()" class="btn btn-secondary">Kembali</a>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
