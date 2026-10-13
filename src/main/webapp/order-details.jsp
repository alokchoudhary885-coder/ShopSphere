<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Order Receipt & Details Page -->
<main class="container my-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4 d-print-none">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/orders" class="text-decoration-none text-muted">My Orders</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">${order.orderNumber}</li>
        </ol>
    </nav>

    <!-- Header Actions -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <div class="d-flex align-items-center gap-2 mb-1">
                <h1 class="h3 fw-bold text-dark mb-0">${order.orderNumber}</h1>
                <span class="badge ${order.status eq 'DELIVERED' ? 'bg-success' : 'bg-primary'} px-3 py-1">
                    ${order.status}
                </span>
            </div>
            <p class="text-muted small mb-0">Placed on ${order.createdAt}</p>
        </div>
        <div class="d-print-none d-flex gap-2">
            <button type="button" class="btn btn-outline-dark btn-sm rounded-pill" onclick="window.print()">
                <i class="bi bi-printer me-1"></i> Print Invoice
            </button>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-light btn-sm rounded-pill border">
                <i class="bi bi-arrow-left me-1"></i> Back to Orders
            </a>
        </div>
    </div>

    <div class="row g-4">
        
        <!-- Left: Ordered Items List -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
                <div class="card-header bg-white p-3 border-bottom">
                    <h6 class="fw-bold text-dark mb-0">Ordered Items (${order.orderItems.size()})</h6>
                </div>
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-light small text-uppercase text-muted">
                            <tr>
                                <th>Item</th>
                                <th class="text-center">Quantity</th>
                                <th class="text-end">Unit Price</th>
                                <th class="text-end">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${pageContext.request.contextPath}/${item.productImageUrl}" 
                                                 alt="${item.productName}" 
                                                 class="rounded border" 
                                                 style="width: 50px; height: 50px; object-fit: contain; background: #f8fafc;"
                                                 onerror="this.onerror=null; this.src='https://placehold.co/80x80/f1f5f9/0f172a?text=Item';">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}" class="text-dark fw-bold text-decoration-none small">
                                                    ${item.productName}
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center fw-semibold text-secondary">
                                        ${item.quantity}
                                    </td>
                                    <td class="text-end small text-muted">
                                        ₹${item.unitPrice}
                                    </td>
                                    <td class="text-end fw-bold text-dark">
                                        ₹${item.subtotal}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Right: Shipping Address, Payment & Financial Summary -->
        <div class="col-lg-4">
            
            <!-- Shipping Address Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h6 class="fw-bold text-dark mb-3 pb-2 border-bottom">
                    <i class="bi bi-geo-alt me-1 text-primary"></i> Shipping Address
                </h6>
                <c:choose>
                    <c:when test="${not empty order.shippingAddress}">
                        <div class="small text-secondary">
                            <div class="fw-bold text-dark mb-1">${sessionScope.user.fullName}</div>
                            <div>${order.shippingAddress.street}</div>
                            <div>${order.shippingAddress.city}, ${order.shippingAddress.state} — <strong>${order.shippingAddress.postalCode}</strong></div>
                            <div>${order.shippingAddress.country}</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted small">Standard registered delivery address.</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Payment Details Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h6 class="fw-bold text-dark mb-3 pb-2 border-bottom">
                    <i class="bi bi-credit-card me-1 text-primary"></i> Payment Details
                </h6>
                <div class="small text-secondary">
                    <div class="d-flex justify-content-between mb-1">
                        <span>Payment Status:</span>
                        <span class="badge ${order.paymentStatus eq 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">${order.paymentStatus}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-1">
                        <span>Gateway:</span>
                        <span class="text-dark fw-semibold">Mock Payment Gateway</span>
                    </div>
                </div>
            </div>

            <!-- Invoice Summary Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <h6 class="fw-bold text-dark mb-3 pb-2 border-bottom">Payment Summary</h6>
                
                <div class="d-flex justify-content-between mb-2 small text-secondary">
                    <span>Items Subtotal</span>
                    <span class="text-dark fw-semibold">₹${order.totalAmount}</span>
                </div>

                <c:if test="${order.discountAmount > 0}">
                    <div class="d-flex justify-content-between mb-2 small text-success">
                        <span>Coupon Discount</span>
                        <span class="fw-bold">-₹${order.discountAmount}</span>
                    </div>
                </c:if>

                <div class="d-flex justify-content-between mb-2 small text-secondary">
                    <span>Delivery Charges</span>
                    <span class="text-success fw-semibold">FREE</span>
                </div>

                <hr>

                <div class="d-flex justify-content-between align-items-baseline">
                    <span class="h6 fw-bold mb-0">Total Paid</span>
                    <span class="h4 fw-extrabold text-primary mb-0">₹${order.finalAmount}</span>
                </div>
            </div>

        </div>

    </div>

</main>

<%@ include file="/fragments/footer.jsp" %>
