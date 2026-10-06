<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-decoration-none text-muted small">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Admin Dashboard
            </a>
            <h2 class="fw-bold mb-0 mt-1"><i class="fa-solid fa-chalkboard-user text-primary me-2"></i>Classroom & Lab Registry</h2>
        </div>
        <a href="${pageContext.request.contextPath}/admin/add-classroom" class="btn btn-primary fw-bold">
            <i class="fa-solid fa-plus me-1"></i> Add New Classroom
        </a>
    </div>

    <!-- Search / Filter Bar -->
    <div class="card card-custom p-3 mb-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <form action="${pageContext.request.contextPath}/admin/classrooms" method="GET" class="d-flex gap-2" style="max-width: 400px;">
                <input type="text" name="search" class="form-control form-control-sm" placeholder="Search room number, name, block..." value="${requestScope.searchQuery}">
                <button type="submit" class="btn btn-primary btn-sm px-3">Search</button>
                <c:if test="${not empty requestScope.searchQuery}">
                    <a href="${pageContext.request.contextPath}/admin/classrooms" class="btn btn-light btn-sm border">Reset</a>
                </c:if>
            </form>

            <div class="input-group" style="max-width: 250px;">
                <span class="input-group-text bg-white"><i class="fa-solid fa-filter text-muted"></i></span>
                <input type="text" id="tableSearchInput" class="form-control form-control-sm" placeholder="Live table filter...">
            </div>
        </div>
    </div>

    <!-- Table -->
    <div class="card card-custom">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-custom table-hover filterable-table">
                    <thead>
                        <tr>
                            <th>Room No.</th>
                            <th>Room Name</th>
                            <th>Block</th>
                            <th>Floor</th>
                            <th>Department</th>
                            <th>Type</th>
                            <th>Capacity</th>
                            <th>Navigation Path</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${requestScope.classrooms}">
                            <tr>
                                <td><strong class="text-primary">${c.roomNumber}</strong></td>
                                <td>
                                    <div class="fw-bold text-dark">${c.roomName}</div>
                                </td>
                                <td><span class="badge bg-light text-dark border">${c.block}</span></td>
                                <td>${c.floor}</td>
                                <td>${c.department}</td>
                                <td><span class="badge-type ${c.typeBadgeClass}">${c.roomType}</span></td>
                                <td>${c.capacity}</td>
                                <td><small class="text-muted d-inline-block text-truncate" style="max-width: 200px;">${c.navigationPath}</small></td>
                                <td class="text-end">
                                    <div class="d-flex gap-1 justify-content-end">
                                        <a href="${pageContext.request.contextPath}/classroom-details?id=${c.id}" class="btn btn-sm btn-light border" title="Preview Details">
                                            <i class="fa-solid fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/edit-classroom?id=${c.id}" class="btn btn-sm btn-outline-primary" title="Edit">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/delete-classroom?id=${c.id}" class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirmAction('Are you sure you want to delete classroom ${c.roomNumber}?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
