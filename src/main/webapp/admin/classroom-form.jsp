<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <jsp:include page="/includes/alerts.jsp" />

            <div class="card card-custom shadow">
                <div class="card-header bg-white">
                    <span>
                        <i class="fa-solid ${formMode == 'EDIT' ? 'fa-pen-to-square text-warning' : 'fa-plus text-primary'} me-2"></i>
                        ${formMode == 'EDIT' ? 'Edit Classroom / Lab: ' : 'Add New Classroom / Laboratory'}
                        <c:if test="${formMode == 'EDIT'}"><span class="text-primary">${classroom.roomNumber}</span></c:if>
                    </span>
                    <a href="${pageContext.request.contextPath}/admin/classrooms" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left me-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/${formMode == 'EDIT' ? 'edit-classroom' : 'add-classroom'}" method="POST">
                        <c:if test="${formMode == 'EDIT'}">
                            <input type="hidden" name="id" value="${classroom.id}">
                        </c:if>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="roomNumber" class="form-label fw-semibold">Room Code / Number <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="roomNumber" name="roomNumber" value="${classroom.roomNumber}" placeholder="e.g. A204 or LAB-A1" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="roomName" class="form-label fw-semibold">Room Name / Title <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="roomName" name="roomName" value="${classroom.roomName}" placeholder="e.g. Web Technology & Cloud Class" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="block" class="form-label fw-semibold">Campus Block <span class="text-danger">*</span></label>
                                <select class="form-select" id="block" name="block" required>
                                    <option value="A Block" ${classroom.block == 'A Block' ? 'selected' : ''}>A Block</option>
                                    <option value="B Block" ${classroom.block == 'B Block' ? 'selected' : ''}>B Block</option>
                                    <option value="C Block" ${classroom.block == 'C Block' ? 'selected' : ''}>C Block</option>
                                    <option value="Administrative Block" ${classroom.block == 'Administrative Block' ? 'selected' : ''}>Administrative Block</option>
                                    <option value="Central Building" ${classroom.block == 'Central Building' ? 'selected' : ''}>Central Building (Library)</option>
                                </select>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label for="floor" class="form-label fw-semibold">Floor <span class="text-danger">*</span></label>
                                <select class="form-select" id="floor" name="floor" required>
                                    <option value="Ground Floor" ${classroom.floor == 'Ground Floor' ? 'selected' : ''}>Ground Floor</option>
                                    <option value="1st Floor" ${classroom.floor == '1st Floor' ? 'selected' : ''}>1st Floor</option>
                                    <option value="2nd Floor" ${classroom.floor == '2nd Floor' ? 'selected' : ''}>2nd Floor</option>
                                    <option value="3rd Floor" ${classroom.floor == '3rd Floor' ? 'selected' : ''}>3rd Floor</option>
                                </select>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label for="capacity" class="form-label fw-semibold">Seating Capacity</label>
                                <input type="number" class="form-control" id="capacity" name="capacity" value="${classroom != null ? classroom.capacity : 60}" min="1" max="1000">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="department" class="form-label fw-semibold">Assigned Department <span class="text-danger">*</span></label>
                                <select class="form-select" id="department" name="department" required>
                                    <option value="Computer Science" ${classroom.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                    <option value="Information Technology" ${classroom.department == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                                    <option value="Electronics" ${classroom.department == 'Electronics' ? 'selected' : ''}>Electronics</option>
                                    <option value="Mechanical" ${classroom.department == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
                                    <option value="Civil" ${classroom.department == 'Civil' ? 'selected' : ''}>Civil</option>
                                    <option value="General" ${classroom.department == 'General' ? 'selected' : ''}>General / Cross-Department</option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="roomType" class="form-label fw-semibold">Room Type <span class="text-danger">*</span></label>
                                <select class="form-select" id="roomType" name="roomType" required>
                                    <option value="Classroom" ${classroom.roomType == 'Classroom' ? 'selected' : ''}>Classroom</option>
                                    <option value="Laboratory" ${classroom.roomType == 'Laboratory' ? 'selected' : ''}>Laboratory</option>
                                    <option value="Seminar Hall" ${classroom.roomType == 'Seminar Hall' ? 'selected' : ''}>Seminar Hall</option>
                                    <option value="Auditorium" ${classroom.roomType == 'Auditorium' ? 'selected' : ''}>Auditorium</option>
                                    <option value="Faculty Room" ${classroom.roomType == 'Faculty Room' ? 'selected' : ''}>Faculty Room</option>
                                    <option value="Office" ${classroom.roomType == 'Office' ? 'selected' : ''}>Office</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="facilities" class="form-label fw-semibold">Facilities & Amenities</label>
                            <input type="text" class="form-control" id="facilities" name="facilities" value="${classroom.facilities}" placeholder="Projector, Wi-Fi, Smart Board, Air Conditioning">
                            <small class="text-muted">Separate multiple amenities with commas.</small>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label fw-semibold">Detailed Description</label>
                            <textarea class="form-control" id="description" name="description" rows="2" placeholder="Briefly explain what courses or practicals take place here...">${classroom.description}</textarea>
                        </div>

                        <div class="mb-4">
                            <label for="navigationPath" class="form-label fw-semibold">Step-by-Step Navigation Path <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="navigationPath" name="navigationPath" value="${classroom.navigationPath}" placeholder="Main Gate → A Block → 2nd Floor → Room A204" required>
                            <small class="text-muted">Use arrow symbols (<code>→</code> or <code>-&gt;</code>) to separate each navigation waypoint.</small>
                        </div>

                        <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/classrooms" class="btn btn-light border px-4">Cancel</a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="fa-solid fa-floppy-disk me-1"></i> ${formMode == 'EDIT' ? 'Save Changes' : 'Create Room'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
