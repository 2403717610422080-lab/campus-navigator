<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <!-- Hero Banner -->
    <div class="hero-banner">
        <div class="container">
            <span class="badge bg-white text-primary fw-bold px-3 py-2 rounded-pill text-uppercase mb-3 shadow-sm">
                <i class="fa-solid fa-location-arrow me-1"></i> Interactive Campus Wayfinding System
            </span>
            <h1 class="hero-title">FIND MY CLASSROOM<br>CAMPUS NAVIGATOR</h1>
            <p class="hero-subtitle">Instantly locate classrooms, computer laboratories, lecture halls, faculty offices, and key campus buildings with step-by-step navigation directions.</p>
            
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light btn-lg px-4 py-2 fw-bold text-primary shadow">
                            <i class="fa-solid fa-right-to-bracket me-2"></i> Student / Staff Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline-light btn-lg px-4 py-2 fw-bold">
                            <i class="fa-solid fa-user-plus me-2"></i> Register Account
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-warning btn-lg px-4 py-2 fw-bold text-dark shadow">
                            <i class="fa-solid fa-magnifying-glass-location me-2"></i> Search Classrooms
                        </a>
                        <a href="${pageContext.request.contextPath}/campus-map" class="btn btn-light btn-lg px-4 py-2 fw-bold text-primary shadow ms-2">
                            <i class="fa-solid fa-map-location-dot me-2"></i> View Campus Map
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- 4 Feature Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-6 col-lg-3">
            <div class="dashboard-card text-center">
                <div>
                    <div class="card-icon-box icon-blue mx-auto">
                        <i class="fa-solid fa-chalkboard-user"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Classroom Finder</h5>
                    <p class="text-muted small">Search rooms by code (e.g. A204), block, floor, and department with real-time results.</p>
                </div>
                <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-sm btn-outline-primary mt-3">Search Classrooms</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="dashboard-card text-center">
                <div>
                    <div class="card-icon-box icon-emerald mx-auto">
                        <i class="fa-solid fa-laptop-code"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Laboratories</h5>
                    <p class="text-muted small">Find specialized computer, electronics, networking, and engineering laboratory locations.</p>
                </div>
                <a href="${pageContext.request.contextPath}/find-classroom?roomType=Laboratory" class="btn btn-sm btn-outline-success mt-3">Browse Labs</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="dashboard-card text-center">
                <div>
                    <div class="card-icon-box icon-indigo mx-auto">
                        <i class="fa-solid fa-route"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Step-by-Step Routes</h5>
                    <p class="text-muted small">Follow clear walking paths from the campus main gate directly to your room doorway.</p>
                </div>
                <a href="${pageContext.request.contextPath}/campus-map" class="btn btn-sm btn-outline-indigo mt-3 text-indigo">Get Directions</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="dashboard-card text-center">
                <div>
                    <div class="card-icon-box icon-amber mx-auto">
                        <i class="fa-solid fa-building-columns"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Campus Blocks</h5>
                    <p class="text-muted small">Explore A Block, B Block, C Block, Library, and Administrative centers interactively.</p>
                </div>
                <a href="${pageContext.request.contextPath}/campus-map" class="btn btn-sm btn-outline-warning text-dark mt-3">Explore Blocks</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
