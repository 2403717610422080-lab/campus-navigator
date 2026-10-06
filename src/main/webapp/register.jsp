<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <jsp:include page="/includes/alerts.jsp" />

            <div id="clientValidationMsg" class="alert alert-danger d-none shadow-sm" role="alert"></div>

            <div class="card card-custom p-4 shadow">
                <div class="text-center mb-4">
                    <div class="bg-success-subtle text-success rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px; font-size: 1.5rem;">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <h3 class="fw-bold mb-1">Student Registration</h3>
                    <p class="text-muted small">Create an account to access campus maps and directions</p>
                </div>

                <form id="registerForm" action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" value="${requestScope.name}" placeholder="e.g. John Doe" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="studentId" class="form-label fw-semibold">Student / Roll ID</label>
                            <input type="text" class="form-control" id="studentId" name="studentId" value="${requestScope.studentId}" placeholder="e.g. STU-2024-001">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Institutional Email <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-regular fa-envelope text-muted"></i></span>
                            <input type="email" class="form-control" id="email" name="email" value="${requestScope.email}" placeholder="student@campus.edu" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="department" class="form-label fw-semibold">Department</label>
                            <select class="form-select" id="department" name="department">
                                <option value="Computer Science">Computer Science</option>
                                <option value="Information Technology">Information Technology</option>
                                <option value="Electronics">Electronics & Comm.</option>
                                <option value="Mechanical">Mechanical Engineering</option>
                                <option value="Civil">Civil Engineering</option>
                                <option value="General">General / Other</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="year" class="form-label fw-semibold">Academic Year</label>
                            <select class="form-select" id="year" name="year">
                                <option value="1st Year">1st Year</option>
                                <option value="2nd Year">2nd Year</option>
                                <option value="3rd Year" selected>3rd Year</option>
                                <option value="4th Year">4th Year</option>
                                <option value="Postgraduate">Postgraduate</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="regUsername" class="form-label fw-semibold">Username <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-regular fa-user text-muted"></i></span>
                            <input type="text" class="form-control" id="regUsername" name="username" value="${requestScope.username}" placeholder="choose a unique username" required minlength="3">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Min. 6 chars" required minlength="6">
                        </div>

                        <div class="col-md-6 mb-4">
                            <label for="confirmPassword" class="form-label fw-semibold">Confirm Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                        <i class="fa-solid fa-user-check me-2"></i> Register Account
                    </button>
                </form>

                <div class="text-center mt-4 pt-3 border-top">
                    <span class="text-muted small">Already registered?</span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="fw-semibold text-primary ms-1 small">Sign In</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
