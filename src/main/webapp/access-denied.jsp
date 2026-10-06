<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/includes/header.jsp" />

<div class="container my-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card card-custom p-5 shadow">
                <div class="text-danger mb-3">
                    <i class="fa-solid fa-lock text-danger" style="font-size: 3.5rem;"></i>
                </div>
                <h2 class="fw-bold text-danger mb-2">Access Denied</h2>
                <p class="text-muted mb-4">
                    ${not empty requestScope.errorMessage ? requestScope.errorMessage : "You do not have permission to view this administrative page."}
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary px-4">
                        <i class="fa-solid fa-house me-1"></i> Return to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
