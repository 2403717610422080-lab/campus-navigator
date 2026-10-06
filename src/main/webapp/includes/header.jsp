<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    String currentUserName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find My Classroom – Campus Navigator</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom Theme Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-compass text-primary"></i>
            <span>CAMPUS NAVIGATOR</span>
            <span class="brand-badge ms-1">FIND MY CLASSROOM</span>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                                <i class="fa-solid fa-house me-1"></i> Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.active == 'find' ? 'active' : ''}" href="${pageContext.request.contextPath}/find-classroom">
                                <i class="fa-solid fa-magnifying-glass-location me-1"></i> Find Classroom
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.active == 'map' ? 'active' : ''}" href="${pageContext.request.contextPath}/campus-map">
                                <i class="fa-solid fa-map-location-dot me-1"></i> Campus Locations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.active == 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/profile">
                                <i class="fa-regular fa-user me-1"></i> My Profile
                            </a>
                        </li>

                        <c:if test="${sessionScope.userRole == 'ADMIN'}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-danger fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-gear me-1"></i> Admin Panel
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-gauge me-2 text-primary"></i>Admin Overview</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/classrooms"><i class="fa-solid fa-chalkboard-user me-2 text-primary"></i>Manage Classrooms</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/locations"><i class="fa-solid fa-building me-2 text-primary"></i>Manage Locations</a></li>
                                </ul>
                            </li>
                        </c:if>

                        <!-- User Profile Pill & Logout -->
                        <li class="nav-item ms-lg-2">
                            <div class="d-flex align-items-center gap-2 bg-light px-3 py-1 rounded-pill border">
                                <span class="badge ${sessionScope.userRole == 'ADMIN' ? 'bg-danger' : (sessionScope.userRole == 'STAFF' ? 'bg-primary' : 'bg-success')} rounded-pill">
                                    ${sessionScope.userRole}
                                </span>
                                <span class="fw-bold small text-dark">${sessionScope.userName}</span>
                                <a href="${pageContext.request.contextPath}/logout" class="text-danger ms-2" title="Logout" onclick="return confirmAction('Are you sure you want to log out?');">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                </a>
                            </div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-primary btn-sm px-3 ms-2 rounded-pill fw-semibold" href="${pageContext.request.contextPath}/login.jsp">
                                <i class="fa-solid fa-right-to-bracket me-1"></i> Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary btn-sm px-3 ms-1 rounded-pill fw-semibold" href="${pageContext.request.contextPath}/register.jsp">
                                <i class="fa-solid fa-user-plus me-1"></i> Register
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
