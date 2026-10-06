<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <!-- Admin Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <span class="badge bg-danger mb-1">Administrator Workspace</span>
            <h2 class="fw-bold mb-0">Campus Facilities & Classroom Control</h2>
            <p class="text-muted mb-0">Add, update, or remove classrooms, laboratories, and campus landmark points.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/add-classroom" class="btn btn-primary btn-sm fw-bold">
                <i class="fa-solid fa-plus me-1"></i> Add New Room
            </a>
            <a href="${pageContext.request.contextPath}/admin/locations" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-map-pin me-1"></i> Manage Landmarks
            </a>
        </div>
    </div>

    <!-- Admin Statistics Metrics -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md">
            <div class="stat-pill">
                <div class="card-icon-box icon-blue mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-chalkboard-user"></i>
                </div>
                <div>
                    <div class="number">${requestScope.totalRooms}</div>
                    <div class="label">Total Rooms</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md">
            <div class="stat-pill">
                <div class="card-icon-box icon-emerald mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-laptop-code"></i>
                </div>
                <div>
                    <div class="number text-success">${requestScope.totalLabs}</div>
                    <div class="label">Laboratories</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md">
            <div class="stat-pill">
                <div class="card-icon-box icon-amber mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-users-rectangle"></i>
                </div>
                <div>
                    <div class="number text-warning">${requestScope.totalHalls}</div>
                    <div class="label">Auditoriums / Halls</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md">
            <div class="stat-pill">
                <div class="card-icon-box icon-indigo mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-map-location-dot"></i>
                </div>
                <div>
                    <div class="number text-indigo">${requestScope.totalLocations}</div>
                    <div class="label">Campus Blocks</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md">
            <div class="stat-pill">
                <div class="card-icon-box icon-purple mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>
                <div>
                    <div class="number text-purple">${requestScope.totalStudents}</div>
                    <div class="label">Registered Users</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Management Table -->
    <div class="card card-custom">
        <div class="card-header bg-white">
            <span><i class="fa-solid fa-list-check me-2 text-primary"></i>Classroom Inventory Overview</span>
            <a href="${pageContext.request.contextPath}/admin/classrooms" class="btn btn-sm btn-outline-primary">Manage Full Inventory</a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>Room No.</th>
                            <th>Room Name</th>
                            <th>Block</th>
                            <th>Floor</th>
                            <th>Department</th>
                            <th>Type</th>
                            <th>Capacity</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${requestScope.recentClassrooms}">
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
                                <td class="text-end">
                                    <div class="d-flex gap-1 justify-content-end">
                                        <a href="${pageContext.request.contextPath}/admin/edit-classroom?id=${c.id}" class="btn btn-sm btn-outline-secondary" title="Edit">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/delete-classroom?id=${c.id}" class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirmAction('Delete classroom ${c.roomNumber}?');">
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
