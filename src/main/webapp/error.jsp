<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<jsp:include page="/includes/header.jsp" />

<div class="container my-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card card-custom p-5 shadow">
                <div class="text-warning mb-3">
                    <i class="fa-solid fa-triangle-exclamation text-warning" style="font-size: 3.5rem;"></i>
                </div>
                <h2 class="fw-bold mb-2">Notice / Error</h2>
                <p class="text-muted mb-4">
                    The requested page or classroom was not found, or a temporary system condition occurred.
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary px-4">
                        <i class="fa-solid fa-house me-1"></i> Go to Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/find-classroom" class="btn btn-outline-secondary px-4">
                        <i class="fa-solid fa-magnifying-glass me-1"></i> Search Classrooms
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
