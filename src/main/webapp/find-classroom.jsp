<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="find" />
</jsp:include>

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-magnifying-glass-location text-primary me-2"></i>Find My Classroom</h2>
            <p class="text-muted mb-0">Search any classroom, lab, or seminar hall by room number, block, floor, or department.</p>
        </div>
        <a href="${pageContext.request.contextPath}/campus-map" class="btn btn-outline-primary btn-sm">
            <i class="fa-solid fa-map me-1"></i> Open Interactive Campus Map
        </a>
    </div>

    <!-- Search & Filter Card -->
    <div class="card card-custom p-4 mb-4 bg-white shadow-sm">
        <form action="${pageContext.request.contextPath}/find-classroom" method="GET" class="row g-3">
            <div class="col-md-4">
                <label class="form-label small fw-bold text-muted">Room Code or Keyword</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                    <input type="text" name="roomNumber" class="form-control" placeholder="e.g. A204, LAB-A1, B305..." value="${requestScope.selectedRoom}">
                </div>
            </div>

            <div class="col-md-2">
                <label class="form-label small fw-bold text-muted">Campus Block</label>
                <select name="block" class="form-select">
                    <option value="ALL" ${requestScope.selectedBlock == 'ALL' ? 'selected' : ''}>All Blocks</option>
                    <c:forEach var="b" items="${requestScope.blocks}">
                        <option value="${b}" ${requestScope.selectedBlock == b ? 'selected' : ''}>${b}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label small fw-bold text-muted">Floor</label>
                <select name="floor" class="form-select">
                    <option value="ALL" ${requestScope.selectedFloor == 'ALL' ? 'selected' : ''}>All Floors</option>
                    <c:forEach var="f" items="${requestScope.floors}">
                        <option value="${f}" ${requestScope.selectedFloor == f ? 'selected' : ''}>${f}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label small fw-bold text-muted">Department</label>
                <select name="department" class="form-select">
                    <option value="ALL" ${requestScope.selectedDept == 'ALL' ? 'selected' : ''}>All Departments</option>
                    <c:forEach var="d" items="${requestScope.departments}">
                        <option value="${d}" ${requestScope.selectedDept == d ? 'selected' : ''}>${d}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label small fw-bold text-muted">Room Type</label>
                <select name="roomType" class="form-select">
                    <option value="ALL" ${requestScope.selectedType == 'ALL' ? 'selected' : ''}>All Types</option>
                    <option value="Classroom" ${requestScope.selectedType == 'Classroom' ? 'selected' : ''}>Classroom</option>
                    <option value="Laboratory" ${requestScope.selectedType == 'Laboratory' ? 'selected' : ''}>Laboratory</option>
                    <option value="Seminar Hall" ${requestScope.selectedType == 'Seminar Hall' ? 'selected' : ''}>Seminar Hall</option>
                    <option value="Auditorium" ${requestScope.selectedType == 'Auditorium' ? 'selected' : ''}>Auditorium</option>
                    <option value="Faculty Room" ${requestScope.selectedType == 'Faculty Room' ? 'selected' : ''}>Faculty Room</option>
                    <option value="Office" ${requestScope.selectedType == 'Office' ? 'selected' : ''}>Office</option>
                </select>
            </div>

            <div class="col-12 d-flex justify-content-between align-items-center flex-wrap gap-2 pt-2 border-top">
                <div class="small text-muted">
                    Found <strong>${requestScope.classrooms.size()}</strong> matching location(s)
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-light border btn-sm px-3">
                        <i class="fa-solid fa-rotate-left me-1"></i> Reset Filters
                    </a>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">
                        <i class="fa-solid fa-filter me-1"></i> Apply Search
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Live Client Filter Box -->
    <div class="d-flex justify-content-end mb-3">
        <div class="input-group" style="max-width: 320px;">
            <span class="input-group-text bg-white"><i class="fa-solid fa-list-check text-muted"></i></span>
            <input type="text" id="tableSearchInput" class="form-control form-control-sm" placeholder="Quick filter listed results...">
        </div>
    </div>

    <!-- Classrooms Results List -->
    <div class="card card-custom">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty requestScope.classrooms}">
                    <div class="text-center py-5 text-muted">
                        <i class="fa-solid fa-door-closed fs-1 mb-2 d-block opacity-50"></i>
                        <h5>No classrooms found</h5>
                        <p class="small mb-3">No classrooms or laboratories match the specified search parameters.</p>
                        <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-sm btn-outline-primary">View All Classrooms</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-custom table-hover filterable-table">
                            <thead>
                                <tr>
                                    <th>Room Code</th>
                                    <th>Room Name</th>
                                    <th>Building Block</th>
                                    <th>Floor</th>
                                    <th>Department</th>
                                    <th>Room Type</th>
                                    <th>Capacity</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${requestScope.classrooms}">
                                    <tr>
                                        <td><strong class="text-primary fs-6">${c.roomNumber}</strong></td>
                                        <td>
                                            <div class="fw-bold text-dark">${c.roomName}</div>
                                            <small class="text-muted">${c.description}</small>
                                        </td>
                                        <td><span class="badge bg-light text-dark border">${c.block}</span></td>
                                        <td><span class="small fw-semibold text-secondary">${c.floor}</span></td>
                                        <td>${c.department}</td>
                                        <td><span class="badge-type ${c.typeBadgeClass}">${c.roomType}</span></td>
                                        <td><small class="text-muted"><i class="fa-solid fa-user-group me-1"></i>${c.capacity} seats</small></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/classroom-details?id=${c.id}" class="btn btn-sm btn-primary">
                                                <i class="fa-solid fa-location-arrow me-1"></i> View Path
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
