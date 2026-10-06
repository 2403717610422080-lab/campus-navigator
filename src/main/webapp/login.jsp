<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <jsp:include page="/includes/alerts.jsp" />

            <c:if test="${param.logout == 'true'}">
                <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> You have successfully logged out.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card card-custom p-4 shadow">
                <div class="text-center mb-4">
                    <div class="bg-primary-subtle text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.5rem;">
                        <i class="fa-solid fa-compass"></i>
                    </div>
                    <h3 class="fw-bold mb-1">Campus Portal Login</h3>
                    <p class="text-muted small">Sign in to find classrooms, labs, and navigation routes</p>
                </div>

                <!-- Quick Fill Demo Accounts -->
                <div class="bg-light p-3 rounded-3 border mb-4">
                    <small class="fw-bold text-muted d-block mb-2 text-uppercase" style="font-size: 0.72rem;">One-Click Demo Credentials:</small>
                    <div class="d-flex flex-wrap gap-2">
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="fillDemoCredentials('admin')">
                            <i class="fa-solid fa-user-shield me-1"></i> Admin
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="fillDemoCredentials('staff')">
                            <i class="fa-solid fa-chalkboard-user me-1"></i> Faculty / Staff
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-success" onclick="fillDemoCredentials('student')">
                            <i class="fa-solid fa-graduation-cap me-1"></i> Student
                        </button>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Username or Email</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-regular fa-user text-muted"></i></span>
                            <input type="text" class="form-control" id="username" name="username" value="${requestScope.username}" placeholder="e.g. student or student@campus.edu" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-lock text-muted"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                        <i class="fa-solid fa-right-to-bracket me-2"></i> Log In
                    </button>
                </form>

                <div class="text-center mt-4 pt-3 border-top">
                    <span class="text-muted small">New to Campus Navigator?</span>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="fw-semibold text-primary ms-1 small">Create Student Account</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
