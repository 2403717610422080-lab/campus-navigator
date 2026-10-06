<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="profile" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <jsp:include page="/includes/alerts.jsp" />

            <div class="card card-custom shadow">
                <div class="card-header bg-white">
                    <span><i class="fa-regular fa-id-card me-2 text-primary"></i>My Student Profile</span>
                    <span class="badge ${profileUser.admin ? 'bg-danger' : (profileUser.staff ? 'bg-primary' : 'bg-success')}">
                        ${profileUser.role} Account
                    </span>
                </div>
                <div class="card-body p-4">
                    <!-- Profile Avatar & Details Header -->
                    <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                        <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 64px; height: 64px; font-size: 1.75rem; font-weight: 700;">
                            ${profileUser.name.substring(0, 1).toUpperCase()}
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${profileUser.name}</h4>
                            <div class="text-muted small">${profileUser.email} &bull; @${profileUser.username}</div>
                            <small class="text-secondary"><i class="fa-solid fa-id-badge me-1"></i>ID: ${profileUser.studentId != null ? profileUser.studentId : 'N/A'}</small>
                        </div>
                    </div>

                    <!-- Profile Edit Form -->
                    <form action="${pageContext.request.contextPath}/profile" method="POST">
                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" value="${profileUser.name}" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="department" class="form-label fw-semibold">Department</label>
                                <select class="form-select" id="department" name="department">
                                    <option value="Computer Science" ${profileUser.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                    <option value="Information Technology" ${profileUser.department == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                                    <option value="Electronics" ${profileUser.department == 'Electronics' ? 'selected' : ''}>Electronics</option>
                                    <option value="Mechanical" ${profileUser.department == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
                                    <option value="Civil" ${profileUser.department == 'Civil' ? 'selected' : ''}>Civil</option>
                                    <option value="General" ${profileUser.department == 'General' ? 'selected' : ''}>General / Other</option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="year" class="form-label fw-semibold">Academic Year</label>
                                <select class="form-select" id="year" name="year">
                                    <option value="1st Year" ${profileUser.year == '1st Year' ? 'selected' : ''}>1st Year</option>
                                    <option value="2nd Year" ${profileUser.year == '2nd Year' ? 'selected' : ''}>2nd Year</option>
                                    <option value="3rd Year" ${profileUser.year == '3rd Year' ? 'selected' : ''}>3rd Year</option>
                                    <option value="4th Year" ${profileUser.year == '4th Year' ? 'selected' : ''}>4th Year</option>
                                    <option value="Faculty" ${profileUser.year == 'Faculty' ? 'selected' : ''}>Faculty / Staff</option>
                                </select>
                            </div>
                        </div>

                        <div class="row bg-light p-3 rounded-3 border mb-4">
                            <div class="col-sm-6 mb-2 mb-sm-0">
                                <small class="text-muted d-block text-uppercase fw-bold" style="font-size: 0.7rem;">Username</small>
                                <span class="fw-semibold text-dark">${profileUser.username}</span>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted d-block text-uppercase fw-bold" style="font-size: 0.7rem;">Account Created</small>
                                <span class="text-muted small">${profileUser.createdAt}</span>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light border px-4">Cancel</a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="fa-solid fa-floppy-disk me-1"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
