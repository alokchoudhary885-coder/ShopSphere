<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Customer Orders History Page -->
<main class="container my-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">My Orders</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h3 fw-bold text-dark mb-1">My Orders</h1>
            <p class="text-muted small mb-0">Track shipments, view invoices and delivery timelines</p>
        </div>
        <span class="badge bg-light text-muted border px-3 py-2 rounded-pill">
            ${orders != null ? orders.size() : '0'} Total Orders
        </span>
    </div>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="d-flex flex-column gap-3">
                <c:forEach var="order" items="${orders}">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 pb-3 border-bottom">
                            
                            <div>
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <span class="fw-bold text-dark fs-6">${order.orderNumber}</span>
                                    
                                    <!-- Order Status Badge -->
                                    <c:choose>
                                        <c:when test="${order.status eq 'DELIVERED'}">
                                            <span class="badge bg-success-subtle text-success">Delivered</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'SHIPPED'}">
                                            <span class="badge bg-info-subtle text-info">Shipped</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'PROCESSING'}">
                                            <span class="badge bg-primary-subtle text-primary">Processing</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'CANCELLED'}">
                                            <span class="badge bg-danger-subtle text-danger">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning-subtle text-warning">Pending</span>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Payment Status Badge -->
                                    <span class="badge ${order.paymentStatus eq 'PAID' ? 'bg-success' : 'bg-secondary'} small">
                                        ${order.paymentStatus}
                                    </span>
                                </div>
                                <small class="text-muted">
                                    Placed on ${order.createdAt}
                                </small>
                            </div>

                            <div class="text-md-end">
                                <div class="text-muted small">Total Amount</div>
                                <div class="h5 fw-bold text-primary mb-0">₹${order.finalAmount}</div>
                            </div>

                        </div>

                        <!-- Card Footer Action -->
                        <div class="pt-3 d-flex justify-content-between align-items-center">
                            <span class="small text-muted">
                                <i class="bi bi-box-seam me-1 text-primary"></i> Standard Express Fulfillment
                            </span>
                            <a href="${pageContext.request.contextPath}/order-details?id=${order.id}" class="btn btn-outline-dark btn-sm rounded-pill px-3 fw-semibold">
                                View Details & Invoice <i class="bi bi-chevron-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Empty Orders State -->
            <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4 bg-white">
                <div class="text-muted mb-3">
                    <i class="bi bi-receipt" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2">No Orders Placed Yet</h3>
                <p class="text-muted small mb-4">You have not placed any orders yet. Discover high quality products in our catalog!</p>
                <div>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                        Explore Shop Catalog
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<%@ include file="/fragments/footer.jsp" %>
