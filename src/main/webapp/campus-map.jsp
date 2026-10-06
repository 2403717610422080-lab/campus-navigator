<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp">
    <jsp:param name="active" value="map" />
</jsp:include>

<div class="container my-4">
    <jsp:include page="/includes/alerts.jsp" />

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-map-location-dot text-primary me-2"></i>Campus Map & Navigation Guide</h2>
            <p class="text-muted mb-0">Interactive schematic campus layout and point-to-point walking directions.</p>
        </div>
    </div>

    <!-- Point-to-Point Route Search Form -->
    <div class="card card-custom p-4 mb-4 bg-white shadow-sm">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-diamond-turn-right text-primary me-2"></i>Get Walking Directions</h5>
        <form action="${pageContext.request.contextPath}/get-directions" method="GET" class="row g-2 align-items-end">
            <div class="col-md-5">
                <label class="form-label small fw-bold text-muted">Starting Point (Source)</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-circle-dot text-success"></i></span>
                    <select name="source" class="form-select">
                        <option value="Main Gate" ${requestScope.source == 'Main Gate' ? 'selected' : ''}>Main Gate & Security Post</option>
                        <option value="A Block" ${requestScope.source == 'A Block' ? 'selected' : ''}>A Block (Computing & IT)</option>
                        <option value="B Block" ${requestScope.source == 'B Block' ? 'selected' : ''}>B Block (Electronics)</option>
                        <option value="C Block" ${requestScope.source == 'C Block' ? 'selected' : ''}>C Block (Mechanical)</option>
                        <option value="Central Library" ${requestScope.source == 'Central Library' ? 'selected' : ''}>Central Library</option>
                        <option value="Campus Cafeteria" ${requestScope.source == 'Campus Cafeteria' ? 'selected' : ''}>Campus Cafeteria</option>
                    </select>
                </div>
            </div>

            <div class="col-md-5">
                <label class="form-label small fw-bold text-muted">Destination (Classroom, Lab, or Landmark)</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-location-dot text-danger"></i></span>
                    <input type="text" name="destination" class="form-control" placeholder="e.g. A204, Central Library, B305..." value="${requestScope.destination}" required>
                </div>
            </div>

            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100 fw-bold">
                    <i class="fa-solid fa-route me-1"></i> Show Route
                </button>
            </div>
        </form>

        <!-- Display Computed Route if Available -->
        <c:if test="${not empty requestScope.matchedRoute}">
            <div class="alert alert-primary mt-4 mb-0 border-primary" role="alert">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h6 class="fw-bold mb-0">
                        <i class="fa-solid fa-route me-2"></i> Route: ${requestScope.matchedRoute.source} &rarr; ${requestScope.matchedRoute.destination}
                    </h6>
                    <span class="badge bg-primary">${requestScope.matchedRoute.estimatedTime}</span>
                </div>
                <p class="small text-dark mb-2">${requestScope.matchedRoute.routeDescription}</p>
                <div class="p-3 bg-white rounded-3 border">
                    <strong class="small text-muted d-block mb-1 text-uppercase">Walking Steps:</strong>
                    <div class="nav-steps-container">
                        <c:forEach var="step" items="${requestScope.matchedRoute.stepsList}" varStatus="st">
                            <div class="nav-step-item ${st.last ? 'destination' : ''} p-2">
                                <div class="nav-step-badge" style="width: 28px; height: 28px; font-size: 0.8rem;">${st.count}</div>
                                <div class="nav-step-text small">${step}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Interactive Campus Schematic Grid -->
    <div class="card card-custom p-4 mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-compass me-2 text-primary"></i>Interactive Campus Grid Layout</h5>
                <small class="text-muted">Click on any block to inspect departments, facilities, and classrooms.</small>
            </div>
            <span class="badge bg-light text-dark border">Ground Plan Schematic</span>
        </div>

        <div class="campus-map-grid">
            <!-- Row 1 -->
            <div class="map-block-card" onclick="showBlockDetails('A Block (Computing & IT)', 'Computer Science, Information Technology, Software Engg', 'Web Tech Lab, Database Lab, Alan Turing Hall, Room A101 to A205')">
                <i class="fa-solid fa-desktop fs-2 text-primary"></i>
                <div class="block-title">A BLOCK</div>
                <div class="block-subtitle">Computing & IT (4 Floors)</div>
            </div>

            <div class="map-block-card" onclick="showBlockDetails('Central Library', 'Digital Library, Book Bank, Periodicals, Reading Rooms', 'Over 50,000 resources, Quiet study pods, Wi-Fi 6')">
                <i class="fa-solid fa-book-bookmark fs-2 text-success"></i>
                <div class="block-title">CENTRAL LIBRARY</div>
                <div class="block-subtitle">Knowledge Center (3 Floors)</div>
            </div>

            <div class="map-block-card" onclick="showBlockDetails('B Block (Electronics & EEE)', 'Electronics & Comm, Electrical Engg, VLSI Center', 'DSP Lab, Embedded Lab, Signal Hall, Room B101 to B306')">
                <i class="fa-solid fa-microchip fs-2 text-warning"></i>
                <div class="block-title">B BLOCK</div>
                <div class="block-subtitle">Electronics & EEE (4 Floors)</div>
            </div>

            <!-- Row 2 -->
            <div class="map-block-card" onclick="showBlockDetails('Administrative Block', 'Principal Office, Registrar, Accounts, Exam Cell', 'Sir C.V. Raman Auditorium (500 seats), Central Foyer')">
                <i class="fa-solid fa-landmark fs-2 text-secondary"></i>
                <div class="block-title">ADMIN BLOCK</div>
                <div class="block-subtitle">Auditorium & Offices (2 Floors)</div>
            </div>

            <div class="map-block-card bg-light border-primary" style="cursor: default;">
                <i class="fa-solid fa-tree fs-2 text-success"></i>
                <div class="block-title">CENTRAL COURTYARD</div>
                <div class="block-subtitle">Fountain Plaza & Walkways</div>
            </div>

            <div class="map-block-card" onclick="showBlockDetails('C Block (Mechanical & Civil)', 'Mechanical Engg, Civil Engg, Robotics Lab', 'CAD/CAM Lab, Machine Workshop, Room C101 to C301')">
                <i class="fa-solid fa-gears fs-2 text-danger"></i>
                <div class="block-title">C BLOCK</div>
                <div class="block-subtitle">Mechanical & Civil (4 Floors)</div>
            </div>

            <!-- Row 3 -->
            <div class="map-block-card" onclick="showBlockDetails('Campus Cafeteria & Food Court', 'Multi-cuisine catering, Refreshment kiosks', 'Food Court, Coffee Lounge, Outdoor terrace seating')">
                <i class="fa-solid fa-utensils fs-2 text-warning"></i>
                <div class="block-title">CAFETERIA</div>
                <div class="block-subtitle">Dining & Student Lounge</div>
            </div>

            <div class="map-block-card" onclick="showBlockDetails('Main Gate & Security Station', 'Visitor Check-in, Bus Drop-off, Security Office', 'Pedestrian Turnstiles, Emergency Post, Information Desk')">
                <i class="fa-solid fa-archway fs-2 text-primary"></i>
                <div class="block-title">MAIN GATE</div>
                <div class="block-subtitle">Campus Entrance & Security</div>
            </div>

            <div class="map-block-card" onclick="showBlockDetails('Sports Complex & Parking', 'Indoor Courts, Gymnasium, 2-Wheeler/4-Wheeler Parking', 'Badminton Courts, Gym, EV Charging Bay')">
                <i class="fa-solid fa-person-running fs-2 text-info"></i>
                <div class="block-title">SPORTS & PARKING</div>
                <div class="block-subtitle">Athletics & Vehicle Bay</div>
            </div>
        </div>
    </div>

    <!-- Campus Directory Table -->
    <div class="card card-custom">
        <div class="card-header bg-white">
            <span><i class="fa-solid fa-list-ul me-2 text-primary"></i>Campus Directory & Landmark Registry</span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>Location Name</th>
                            <th>Type</th>
                            <th>Block</th>
                            <th>Floor</th>
                            <th>Description</th>
                            <th>Key Features</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loc" items="${requestScope.locations}">
                            <tr>
                                <td><strong class="text-dark">${loc.locationName}</strong></td>
                                <td><span class="badge bg-light text-dark border">${loc.locationType}</span></td>
                                <td>${loc.block}</td>
                                <td><small class="text-muted">${loc.floor}</small></td>
                                <td><small class="text-muted">${loc.description}</small></td>
                                <td><small class="text-secondary">${loc.keyFeatures}</small></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Block Details -->
<div class="modal fade" id="blockDetailsModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="blockModalTitle">Block Details</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <small class="text-muted d-block text-uppercase fw-bold" style="font-size: 0.72rem;">Departments & Centers</small>
                    <div class="fw-semibold text-dark mt-1" id="blockModalDepts"></div>
                </div>
                <div class="mb-3">
                    <small class="text-muted d-block text-uppercase fw-bold" style="font-size: 0.72rem;">Facilities & Key Rooms</small>
                    <div class="text-secondary mt-1" id="blockModalFeatures"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <a href="#" id="blockModalSearchLink" class="btn btn-primary fw-bold">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> View Rooms in this Block
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
