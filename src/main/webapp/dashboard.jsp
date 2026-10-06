<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <!-- Welcome Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1">Welcome back, ${sessionScope.userName}!</h2>
            <p class="text-muted mb-0">
                <i class="fa-solid fa-graduation-cap me-1 text-primary"></i>
                <span>${sessionScope.userDepartment}</span> &bull; 
                <span class="badge ${sessionScope.userRole == 'ADMIN' ? 'bg-danger' : (sessionScope.userRole == 'STAFF' ? 'bg-primary' : 'bg-success')}">${sessionScope.userRole}</span>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-primary px-3 py-2 fw-bold shadow-sm">
            <i class="fa-solid fa-magnifying-glass-location me-2"></i> Find a Room
        </a>
    </div>

    <!-- Quick Search Widget -->
    <div class="card card-custom p-4 mb-4 bg-white border shadow-sm">
        <form action="${pageContext.request.contextPath}/find-classroom" method="GET" class="row g-2 align-items-center">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="fa-solid fa-door-open text-primary"></i></span>
                    <input type="text" name="roomNumber" class="form-control form-control-lg" placeholder="Enter Room (e.g. A204, LAB-A1, B305)...">
                </div>
            </div>
            <div class="col-md-3">
                <select name="block" class="form-select form-select-lg">
                    <option value="ALL">All Blocks</option>
                    <c:forEach var="b" items="${requestScope.blocks}">
                        <option value="${b}">${b}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <select name="roomType" class="form-select form-select-lg">
                    <option value="ALL">All Types</option>
                    <option value="Classroom">Classrooms</option>
                    <option value="Laboratory">Laboratories</option>
                    <option value="Seminar Hall">Seminar Halls</option>
                    <option value="Auditorium">Auditoriums</option>
                    <option value="Faculty Room">Faculty Rooms</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> Search
                </button>
            </div>
        </form>
    </div>

    <!-- 5 Core Dashboard Feature Cards -->
    <div class="row g-3 mb-4">
        <!-- 1. Find Classroom -->
        <div class="col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/find-classroom?roomType=Classroom" class="dashboard-card">
                <div>
                    <div class="card-icon-box icon-blue">
                        <i class="fa-solid fa-chalkboard-user"></i>
                    </div>
                    <h5 class="fw-bold mb-1">Find Classroom</h5>
                    <p class="text-muted small mb-0">Search lecture rooms by floor, block, and capacity.</p>
                </div>
                <div class="mt-3 text-primary fw-bold small">
                    Explore Rooms <i class="fa-solid fa-arrow-right ms-1"></i>
                </div>
            </a>
        </div>

        <!-- 2. Find Laboratory -->
        <div class="col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/find-classroom?roomType=Laboratory" class="dashboard-card">
                <div>
                    <div class="card-icon-box icon-emerald">
                        <i class="fa-solid fa-laptop-code"></i>
                    </div>
                    <h5 class="fw-bold mb-1">Find Laboratory</h5>
                    <p class="text-muted small mb-0">Locate Computer, Electronics, and Web Tech Labs.</p>
                </div>
                <div class="mt-3 text-success fw-bold small">
                    Explore Labs <i class="fa-solid fa-arrow-right ms-1"></i>
                </div>
            </a>
        </div>

        <!-- 3. Campus Blocks -->
        <div class="col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/campus-map" class="dashboard-card">
                <div>
                    <div class="card-icon-box icon-indigo">
                        <i class="fa-solid fa-building"></i>
                    </div>
                    <h5 class="fw-bold mb-1">Campus Blocks</h5>
                    <p class="text-muted small mb-0">View A Block, B Block, C Block layout and details.</p>
                </div>
                <div class="mt-3 text-indigo fw-bold small">
                    View Blocks <i class="fa-solid fa-arrow-right ms-1"></i>
                </div>
            </a>
        </div>

        <!-- 4. Departments -->
        <div class="col-md-6 col-lg">
            <a href="${pageContext.request.contextPath}/find-classroom" class="dashboard-card">
                <div>
                    <div class="card-icon-box icon-purple">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>
                    <h5 class="fw-bold mb-1">Departments</h5>
                    <p class="text-muted small mb-0">Browse rooms filtered by engineering departments.</p>
                </div>
                <div class="mt-3 text-purple fw-bold small">
                    Department View <i class="fa-solid fa-arrow-right ms-1"></i>
                </div>
            </a>
        </div>

        <!-- 5. Important Locations -->
        <div class="col-md-6 col-lg">
            <a href="${pageContext.request.contextPath}/campus-map" class="dashboard-card">
                <div>
                    <div class="card-icon-box icon-amber">
                        <i class="fa-solid fa-map-pin"></i>
                    </div>
                    <h5 class="fw-bold mb-1">Key Locations</h5>
                    <p class="text-muted small mb-0">Library, Auditorium, Cafeteria, and Admin Office.</p>
                </div>
                <div class="mt-3 text-warning fw-bold small">
                    See Landmarks <i class="fa-solid fa-arrow-right ms-1"></i>
                </div>
            </a>
        </div>
    </div>

    <!-- Metrics Row -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="stat-pill">
                <div class="card-icon-box icon-blue mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-chalkboard"></i>
                </div>
                <div>
                    <div class="number">${requestScope.totalClassrooms}</div>
                    <div class="label">Classrooms</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="stat-pill">
                <div class="card-icon-box icon-emerald mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-flask"></i>
                </div>
                <div>
                    <div class="number text-success">${requestScope.totalLabs}</div>
                    <div class="label">Laboratories</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="stat-pill">
                <div class="card-icon-box icon-amber mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div>
                    <div class="number text-warning">${requestScope.totalSeminarHalls}</div>
                    <div class="label">Halls & Auditoriums</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="stat-pill">
                <div class="card-icon-box icon-indigo mb-0" style="width: 44px; height: 44px; font-size: 1.2rem;">
                    <i class="fa-solid fa-map-location"></i>
                </div>
                <div>
                    <div class="number text-indigo">${requestScope.totalLocations}</div>
                    <div class="label">Campus Landmarks</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Access Classrooms Table -->
    <div class="card card-custom">
        <div class="card-header bg-white">
            <span><i class="fa-solid fa-star me-2 text-warning"></i>Popular & Featured Campus Rooms</span>
            <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-sm btn-outline-primary">View All Rooms</a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>Room No.</th>
                            <th>Room Name</th>
                            <th>Block & Floor</th>
                            <th>Department</th>
                            <th>Room Type</th>
                            <th>Capacity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${requestScope.featuredClassrooms}">
                            <tr>
                                <td><strong class="text-primary fs-6">${c.roomNumber}</strong></td>
                                <td>
                                    <div class="fw-bold text-dark">${c.roomName}</div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border me-1">${c.block}</span>
                                    <small class="text-muted">${c.floor}</small>
                                </td>
                                <td>${c.department}</td>
                                <td><span class="badge-type ${c.typeBadgeClass}">${c.roomType}</span></td>
                                <td><i class="fa-solid fa-user-group me-1 text-muted small"></i>${c.capacity} seats</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/classroom-details?id=${c.id}" class="btn btn-sm btn-primary">
                                        <i class="fa-solid fa-route me-1"></i> Navigate
                                    </a>
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
