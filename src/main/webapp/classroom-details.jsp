<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="find" />
</jsp:include>

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <!-- Breadcrumb & Title -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <a href="${pageContext.request.contextPath}/find-classroom" class="text-decoration-none text-muted small">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Classroom Search
            </a>
            <h2 class="fw-bold mb-0 mt-1">${classroom.roomNumber}: ${classroom.roomName}</h2>
        </div>
        <div class="d-flex align-items-center gap-2">
            <span class="badge-type ${classroom.typeBadgeClass} fs-6">${classroom.roomType}</span>
            <span class="badge bg-primary fs-6">${classroom.block}</span>
        </div>
    </div>

    <div class="row g-4">
        <!-- Left: Classroom Specifications -->
        <div class="col-lg-6">
            <div class="card card-custom h-100">
                <div class="card-header bg-white">
                    <span><i class="fa-solid fa-circle-info me-2 text-primary"></i>Room Specifications</span>
                    <span class="text-muted small">ID: #${classroom.id}</span>
                </div>
                <div class="card-body">
                    <div class="row g-3 mb-4">
                        <div class="col-sm-6">
                            <small class="text-muted d-block text-uppercase fw-semibold" style="font-size: 0.72rem;">Room Number</small>
                            <div class="fw-bold text-dark fs-5 mt-1">${classroom.roomNumber}</div>
                        </div>

                        <div class="col-sm-6">
                            <small class="text-muted d-block text-uppercase fw-semibold" style="font-size: 0.72rem;">Academic Block</small>
                            <div class="fw-bold text-dark fs-5 mt-1">${classroom.block}</div>
                        </div>

                        <div class="col-sm-6">
                            <small class="text-muted d-block text-uppercase fw-semibold" style="font-size: 0.72rem;">Floor Level</small>
                            <div class="text-dark fw-semibold mt-1">${classroom.floor}</div>
                        </div>

                        <div class="col-sm-6">
                            <small class="text-muted d-block text-uppercase fw-semibold" style="font-size: 0.72rem;">Seating Capacity</small>
                            <div class="text-dark fw-semibold mt-1"><i class="fa-solid fa-user-group me-1 text-primary"></i>${classroom.capacity} Students</div>
                        </div>

                        <div class="col-sm-12">
                            <small class="text-muted d-block text-uppercase fw-semibold" style="font-size: 0.72rem;">Department</small>
                            <div class="text-dark fw-semibold mt-1">${classroom.department}</div>
                        </div>
                    </div>

                    <!-- Facilities -->
                    <div class="mb-4">
                        <h6 class="fw-bold text-muted text-uppercase mb-2" style="font-size: 0.75rem;">Room Amenities & Facilities</h6>
                        <div class="d-flex flex-wrap gap-2">
                            <c:forEach var="fac" items="${classroom.facilitiesList}">
                                <span class="facility-pill">
                                    <i class="fa-solid fa-check text-success"></i> ${fac}
                                </span>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Description -->
                    <div>
                        <h6 class="fw-bold text-muted text-uppercase mb-2" style="font-size: 0.75rem;">Room Description</h6>
                        <div class="p-3 bg-light rounded-3 border text-dark">
                            ${classroom.description}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Step-by-Step Navigation Path -->
        <div class="col-lg-6">
            <div class="card card-custom h-100">
                <div class="card-header bg-white">
                    <span><i class="fa-solid fa-route me-2 text-primary"></i>Campus Walking Navigation Path</span>
                    <span class="badge bg-success-subtle text-success border border-success">Est. 2-3 mins</span>
                </div>
                <div class="card-body">
                    <p class="text-muted small mb-3">
                        Follow these waypoint directions from the campus main gate to reach <strong>${classroom.roomNumber}</strong>:
                    </p>

                    <!-- Steps Timeline -->
                    <div class="nav-steps-container">
                        <c:forEach var="step" items="${classroom.navigationSteps}" varStatus="status">
                            <div class="nav-step-item ${status.last ? 'destination border-success' : ''}">
                                <div class="nav-step-badge">
                                    <c:choose>
                                        <c:when test="${status.first}"><i class="fa-solid fa-door-open"></i></c:when>
                                        <c:when test="${status.last}"><i class="fa-solid fa-location-dot"></i></c:when>
                                        <c:otherwise>${status.count}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="nav-step-text">
                                    ${step}
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex gap-2 mt-4 pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/campus-map" class="btn btn-outline-primary w-100">
                            <i class="fa-solid fa-map-location-dot me-1"></i> View on Campus Map
                        </a>
                        <button type="button" class="btn btn-light border px-4" onclick="window.print()">
                            <i class="fa-solid fa-print me-1"></i> Print
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
