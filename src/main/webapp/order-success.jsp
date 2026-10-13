<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Order Success Confirmation Page -->
<main class="container my-5">

    <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white text-center mx-auto" style="max-width: 760px;">
        
        <!-- Celebratory Check Icon -->
        <div class="mb-4">
            <div class="d-inline-flex align-items-center justify-content-center bg-success bg-opacity-10 text-success rounded-circle" style="width: 90px; height: 90px;">
                <i class="bi bi-check-circle-fill" style="font-size: 3.5rem;"></i>
            </div>
        </div>

        <h1 class="h2 fw-extrabold text-dark mb-2" style="font-weight: 800;">Thank You for Your Order!</h1>
        <p class="text-muted mb-4">
            Your payment was simulated successfully and your order has been placed into our fulfillment pipeline.
        </p>

        <!-- Order Meta Card -->
        <div class="card bg-light border-0 rounded-4 p-4 text-start mb-4">
            <div class="row g-3">
                <div class="col-sm-6">
                    <small class="text-muted d-block">Order Reference</small>
                    <span class="fw-bold text-dark fs-6">${lastPlacedOrder != null ? lastPlacedOrder.orderNumber : 'ORD-20261013-CONFIRMED'}</span>
                </div>
                <div class="col-sm-6">
                    <small class="text-muted d-block">Payment Status</small>
                    <span class="badge ${lastPlacedOrder != null && lastPlacedOrder.paymentStatus eq 'PAID' ? 'bg-success' : 'bg-warning text-dark'} px-3 py-1">
                        ${lastPlacedOrder != null ? lastPlacedOrder.paymentStatus : 'PAID (Simulated)'}
                    </span>
                </div>
                <div class="col-sm-6">
                    <small class="text-muted d-block">Order Status</small>
                    <span class="badge bg-primary px-3 py-1">
                        ${lastPlacedOrder != null ? lastPlacedOrder.status : 'PROCESSING'}
                    </span>
                </div>
                <div class="col-sm-6">
                    <small class="text-muted d-block">Total Amount</small>
                    <span class="fw-bold text-primary fs-5">
                        ₹${lastPlacedOrder != null ? lastPlacedOrder.finalAmount : '0.00'}
                    </span>
                </div>
            </div>
        </div>

        <!-- Ordered Items Quick Preview if available -->
        <c:if test="${not empty lastPlacedOrder && not empty lastPlacedOrder.orderItems}">
            <div class="text-start mb-4">
                <h6 class="fw-bold text-dark mb-3">Items in This Order</h6>
                <div class="d-flex flex-column gap-2">
                    <c:forEach var="oi" items="${lastPlacedOrder.orderItems}">
                        <div class="d-flex justify-content-between align-items-center p-2 bg-light rounded-2 border">
                            <span class="small fw-semibold text-dark">${oi.productName} &times; ${oi.quantity}</span>
                            <span class="small fw-bold text-dark">₹${oi.subtotal}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <div class="d-flex flex-column flex-sm-row justify-content-center gap-3 mt-2">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                <i class="bi bi-receipt me-1"></i> View Order History
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark rounded-pill px-4 py-2 fw-semibold">
                Continue Shopping <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

    </div>

</main>

<%@ include file="/fragments/footer.jsp" %>
