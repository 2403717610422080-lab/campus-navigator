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
            <h2 class="fw-bold mb-0 mt-1"><i class="fa-solid fa-map-pin text-primary me-2"></i>Campus Landmarks & Buildings Registry</h2>
        </div>
        <button type="button" class="btn btn-primary fw-bold" data-bs-toggle="modal" data-bs-target="#addLocationModal">
            <i class="fa-solid fa-plus me-1"></i> Add Campus Landmark
        </button>
    </div>

    <!-- Locations Table -->
    <div class="card card-custom">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Location Name</th>
                            <th>Category / Type</th>
                            <th>Block</th>
                            <th>Floor Level</th>
                            <th>Description</th>
                            <th>Key Features</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loc" items="${requestScope.locations}">
                            <tr>
                                <td><strong>#${loc.id}</strong></td>
                                <td><strong class="text-dark">${loc.locationName}</strong></td>
                                <td><span class="badge bg-light text-dark border">${loc.locationType}</span></td>
                                <td>${loc.block}</td>
                                <td><small class="text-muted">${loc.floor}</small></td>
                                <td><small class="text-muted">${loc.description}</small></td>
                                <td><small class="text-secondary">${loc.keyFeatures}</small></td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/admin/delete-location?id=${loc.id}" class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirmAction('Delete location ${loc.locationName}?');">
                                        <i class="fa-solid fa-trash"></i>
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

<!-- Modal: Add Location -->
<div class="modal fade" id="addLocationModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/add-location" method="POST">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-plus me-2"></i>Add Campus Location / Landmark</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="locationName" class="form-label fw-semibold">Location Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="locationName" name="locationName" placeholder="e.g. Student Activity Center" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="locationType" class="form-label fw-semibold">Location Type</label>
                            <select class="form-select" id="locationType" name="locationType">
                                <option value="Academic Block">Academic Block</option>
                                <option value="Facility">Facility / Utility</option>
                                <option value="Administrative">Administrative Office</option>
                                <option value="Recreation">Recreation & Sports</option>
                                <option value="Entrance">Entrance / Gate</option>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="locBlock" class="form-label fw-semibold">Campus Block</label>
                            <input type="text" class="form-control" id="locBlock" name="block" placeholder="e.g. Central Area">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="locFloor" class="form-label fw-semibold">Floor / Elevation</label>
                        <input type="text" class="form-control" id="locFloor" name="floor" placeholder="e.g. Ground Floor">
                    </div>

                    <div class="mb-3">
                        <label for="locDesc" class="form-label fw-semibold">Description</label>
                        <textarea class="form-control" id="locDesc" name="description" rows="2" placeholder="Brief function or purpose of this location..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="keyFeatures" class="form-label fw-semibold">Key Features / Amenities</label>
                        <input type="text" class="form-control" id="keyFeatures" name="keyFeatures" placeholder="e.g. Wi-Fi, Discussion rooms, Locker facility">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary fw-bold">Save Location</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
