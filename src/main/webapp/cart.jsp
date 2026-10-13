<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Shopping Cart Page -->
<main class="container my-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">Shopping Cart</li>
        </ol>
    </nav>

    <!-- Feedback Alerts -->
    <c:if test="${not empty sessionScope.cartSuccess}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.cartSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartSuccess" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.cartError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.cartError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartError" scope="session" />
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 fw-bold text-dark mb-0">Shopping Cart</h1>
        <span class="text-muted small">${sessionScope.cartCount != null ? sessionScope.cartCount : '0'} items</span>
    </div>

    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="row g-4">
                
                <!-- Left Column: Cart Items List -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr class="small text-uppercase text-muted">
                                        <th style="width: 45%;">Product</th>
                                        <th class="text-center" style="width: 20%;">Quantity</th>
                                        <th class="text-end" style="width: 20%;">Price</th>
                                        <th class="text-center" style="width: 15%;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr>
                                            <!-- Product Info -->
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <img src="${pageContext.request.contextPath}/${item.productImageUrl}" 
                                                         alt="${item.productName}" 
                                                         class="rounded border" 
                                                         style="width: 60px; height: 60px; object-fit: contain; background: #f8fafc;"
                                                         onerror="this.onerror=null; this.src='https://placehold.co/100x100/f1f5f9/0f172a?text=Item';">
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}" 
                                                           class="text-dark fw-bold text-decoration-none small d-block">
                                                            ${item.productName}
                                                        </a>
                                                        <div class="text-primary small fw-semibold">
                                                            ₹${item.getEffectiveUnitPrice()}
                                                            <c:if test="${item.productDiscount > 0}">
                                                                <span class="text-muted text-decoration-line-through ms-1" style="font-size: 0.75rem;">₹${item.productPrice}</span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>

                                            <!-- Quantity Controls -->
                                            <td class="text-center">
                                                <form action="${pageContext.request.contextPath}/cart" method="POST" class="d-inline-flex align-items-center justify-content-center">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="cartId" value="${item.id}">
                                                    
                                                    <div class="input-group input-group-sm" style="width: 100px;">
                                                        <button class="btn btn-outline-secondary" type="submit" name="quantity" value="${item.quantity - 1}">-</button>
                                                        <input type="text" class="form-control text-center bg-white" value="${item.quantity}" readonly>
                                                        <button class="btn btn-outline-secondary" type="submit" name="quantity" value="${item.quantity + 1}">+</button>
                                                    </div>
                                                </form>
                                            </td>

                                            <!-- Line Subtotal -->
                                            <td class="text-end fw-bold text-dark">
                                                ₹${item.getSubtotal()}
                                            </td>

                                            <!-- Remove Action -->
                                            <td class="text-center">
                                                <form action="${pageContext.request.contextPath}/cart" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="cartId" value="${item.id}">
                                                    <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle" title="Remove Item">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Table Footer Buttons -->
                        <div class="card-footer bg-white p-3 d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-sm rounded-pill">
                                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
                            </a>
                            <form action="${pageContext.request.contextPath}/cart" method="POST">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill" onclick="return confirm('Clear your entire cart?')">
                                    <i class="bi bi-trash3 me-1"></i> Clear Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Order Summary Card -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white sticky-top" style="top: 100px;">
                        <h5 class="fw-bold text-dark mb-3 pb-2 border-bottom">Order Summary</h5>

                        <div class="d-flex justify-content-between mb-2 small text-secondary">
                            <span>Subtotal</span>
                            <span class="text-dark fw-semibold">₹${subtotal}</span>
                        </div>

                        <c:if test="${savings > 0}">
                            <div class="d-flex justify-content-between mb-2 small text-success">
                                <span>Estimated Savings</span>
                                <span class="fw-semibold">-₹${savings}</span>
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between mb-2 small text-secondary">
                            <span>Estimated Shipping</span>
                            <span class="text-success fw-semibold">FREE</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3 small text-secondary">
                            <span>Taxes</span>
                            <span class="text-muted">Calculated at checkout</span>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between align-items-baseline mb-4">
                            <span class="h6 fw-bold mb-0">Total</span>
                            <span class="h4 fw-extrabold text-primary mb-0">₹${subtotal}</span>
                        </div>

                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 rounded-pill py-2 fw-semibold shadow-sm mb-3">
                            Proceed to Checkout <i class="bi bi-arrow-right ms-1"></i>
                        </a>

                        <div class="alert alert-light border small text-muted text-center py-2 mb-0">
                            <i class="bi bi-shield-check text-success me-1"></i> 100% Secure Checkout & Guaranteed Safe Payment
                        </div>
                    </div>
                </div>

            </div>
        </c:when>

        <c:otherwise>
            <!-- Empty Cart State -->
            <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4 bg-white">
                <div class="text-muted mb-3">
                    <i class="bi bi-bag-x" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2">Your Shopping Cart is Empty</h3>
                <p class="text-muted small mb-4">Looks like you haven't added anything to your cart yet. Explore our latest electronics and essentials!</p>
                <div>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                        Start Shopping Now
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<%@ include file="/fragments/footer.jsp" %>
