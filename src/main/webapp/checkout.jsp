<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Checkout Page -->
<main class="container my-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none text-muted">Cart</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">Checkout</li>
        </ol>
    </nav>

    <!-- Error Alerts -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 fw-bold text-dark mb-0">Complete Your Order</h1>
        <span class="badge bg-light text-muted border px-3 py-2">
            <i class="bi bi-shield-lock-fill text-success me-1"></i> 256-Bit SSL Encrypted
        </span>
    </div>

    <form action="${pageContext.request.contextPath}/checkout" method="POST" id="checkoutForm">
        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

        <div class="row g-4">

            <!-- ===================================================================
                 1. LEFT COLUMN: Address, Payment & Coupon
                 =================================================================== -->
            <div class="col-lg-8">
                
                <!-- STEP 1: Delivery Address -->
                <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
                    <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                        <span class="badge bg-primary rounded-circle px-2 py-1">1</span>
                        <h5 class="fw-bold text-dark mb-0">Delivery Address</h5>
                    </div>

                    <c:choose>
                        <c:when test="${not empty addresses}">
                            <div class="d-flex flex-column gap-3 mb-3">
                                <c:forEach var="addr" items="${addresses}" varStatus="loop">
                                    <div class="p-3 border rounded-3 position-relative address-radio-card ${addr.isDefault ? 'border-primary bg-primary-subtle bg-opacity-10' : ''}">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="addressId" id="addr_${addr.id}" 
                                                   value="${addr.id}" ${addr.isDefault || loop.first ? 'checked' : ''} 
                                                   onchange="toggleNewAddressForm(false)">
                                            <label class="form-check-label w-100" for="addr_${addr.id}">
                                                <div class="fw-bold text-dark mb-1">
                                                    ${sessionScope.user.fullName}
                                                    <c:if test="${addr.isDefault}">
                                                        <span class="badge bg-primary ms-2" style="font-size: 0.7rem;">Default</span>
                                                    </c:if>
                                                </div>
                                                <div class="text-secondary small">
                                                    ${addr.street}, ${addr.city}, ${addr.state} — <strong>${addr.postalCode}</strong>, ${addr.country}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info small mb-3">
                                <i class="bi bi-info-circle me-1"></i> Please enter your delivery address below.
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Option to add new address -->
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="addressId" id="addr_new" value="new" 
                               ${empty addresses ? 'checked' : ''} onchange="toggleNewAddressForm(true)">
                        <label class="form-check-label fw-semibold small text-dark" for="addr_new">
                            + Add a new delivery address
                        </label>
                    </div>

                    <!-- New Address Input Fields -->
                    <div id="newAddressFields" class="p-3 bg-light rounded-3 border ${not empty addresses ? 'd-none' : ''}">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label small fw-bold">Street Address / House No.</label>
                                <input type="text" name="newStreet" class="form-control form-control-sm" placeholder="e.g. Flat 402, Royal Palms, Malviya Nagar">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">City</label>
                                <input type="text" name="newCity" class="form-control form-control-sm" placeholder="e.g. Jaipur">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">State</label>
                                <input type="text" name="newState" class="form-control form-control-sm" placeholder="e.g. Rajasthan">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">PIN / Postal Code</label>
                                <input type="text" name="newPostalCode" class="form-control form-control-sm" placeholder="e.g. 302017">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Country</label>
                                <input type="text" name="newCountry" class="form-control form-control-sm" value="India">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- STEP 2: Payment Method -->
                <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
                    <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                        <span class="badge bg-primary rounded-circle px-2 py-1">2</span>
                        <h5 class="fw-bold text-dark mb-0">Payment Method</h5>
                    </div>

                    <div class="d-flex flex-column gap-3">
                        
                        <!-- UPI -->
                        <div class="p-3 border rounded-3 payment-method-card border-primary bg-primary-subtle bg-opacity-10">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="pay_upi" value="UPI" checked>
                                <label class="form-check-label w-100" for="pay_upi">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold text-dark"><i class="bi bi-qr-code-scan me-2 text-primary"></i> UPI / Instant QR Payment</span>
                                        <span class="badge bg-success-subtle text-success small">Fast & Zero Fee</span>
                                    </div>
                                    <small class="text-muted d-block mt-1">Google Pay, PhonePe, Paytm, BHIM</small>
                                </label>
                            </div>
                        </div>

                        <!-- Card -->
                        <div class="p-3 border rounded-3 payment-method-card">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="pay_card" value="CARD">
                                <label class="form-check-label w-100" for="pay_card">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold text-dark"><i class="bi bi-credit-card-2-front me-2 text-primary"></i> Credit / Debit Card</span>
                                        <span class="text-muted small">Visa, Mastercard, RuPay</span>
                                    </div>
                                    <small class="text-muted d-block mt-1">Simulated test payment gateway</small>
                                </label>
                            </div>
                        </div>

                        <!-- Net Banking -->
                        <div class="p-3 border rounded-3 payment-method-card">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="pay_net" value="NET_BANKING">
                                <label class="form-check-label w-100" for="pay_net">
                                    <span class="fw-bold text-dark"><i class="bi bi-bank me-2 text-primary"></i> Net Banking</span>
                                    <small class="text-muted d-block mt-1">All major Indian banks supported</small>
                                </label>
                            </div>
                        </div>

                        <!-- Cash on Delivery -->
                        <div class="p-3 border rounded-3 payment-method-card">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="pay_cod" value="COD">
                                <label class="form-check-label w-100" for="pay_cod">
                                    <span class="fw-bold text-dark"><i class="bi bi-cash-stack me-2 text-primary"></i> Cash on Delivery (COD)</span>
                                    <small class="text-muted d-block mt-1">Pay with cash or UPI at the time of doorstep delivery</small>
                                </label>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- STEP 3: Coupon Code Promotion -->
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                        <span class="badge bg-primary rounded-circle px-2 py-1">3</span>
                        <h5 class="fw-bold text-dark mb-0">Apply Coupon Code</h5>
                    </div>

                    <div class="input-group mb-2">
                        <input type="text" id="couponInput" name="couponCode" class="form-control" 
                               placeholder="Enter coupon code" value="${couponCode}" style="text-transform: uppercase;">
                        <button type="button" class="btn btn-dark" onclick="applyCoupon()">Apply</button>
                    </div>

                    <c:if test="${not empty couponMessage}">
                        <div class="small ${discountAmount > 0 ? 'text-success' : 'text-danger'} mb-2">
                            <i class="bi ${discountAmount > 0 ? 'bi-check-circle-fill' : 'bi-x-circle-fill'} me-1"></i> ${couponMessage}
                        </div>
                    </c:if>

                    <div class="d-flex flex-wrap gap-2 mt-2">
                        <span class="text-muted small">Try:</span>
                        <button type="button" class="badge bg-light text-dark border py-1 px-2" onclick="fillCoupon('WELCOME50')">WELCOME50 (50% Off)</button>
                        <button type="button" class="badge bg-light text-dark border py-1 px-2" onclick="fillCoupon('SAVE20')">SAVE20 (20% Off)</button>
                        <button type="button" class="badge bg-light text-dark border py-1 px-2" onclick="fillCoupon('FESTIVE100')">FESTIVE100 (30% Off)</button>
                    </div>
                </div>

            </div>

            <!-- ===================================================================
                 2. RIGHT COLUMN: Order Summary & Placement
                 =================================================================== -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white sticky-top" style="top: 100px;">
                    
                    <h5 class="fw-bold text-dark mb-3 pb-2 border-bottom">Review Items (${cartItems.size()})</h5>

                    <!-- Items Preview Mini List -->
                    <div class="d-flex flex-column gap-3 mb-4" style="max-height: 240px; overflow-y: auto;">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex align-items-center gap-3">
                                <img src="${pageContext.request.contextPath}/${item.productImageUrl}" 
                                     alt="${item.productName}" 
                                     class="rounded border" 
                                     style="width: 48px; height: 48px; object-fit: contain; background: #f8fafc;"
                                     onerror="this.onerror=null; this.src='https://placehold.co/80x80/f1f5f9/0f172a?text=Item';">
                                <div class="flex-grow-1 small">
                                    <div class="fw-bold text-dark text-truncate" style="max-width: 160px;">${item.productName}</div>
                                    <div class="text-muted">Qty: ${item.quantity} &times; ₹${item.getEffectiveUnitPrice()}</div>
                                </div>
                                <div class="fw-bold text-dark small text-end">
                                    ₹${item.getSubtotal()}
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-2 small text-secondary">
                        <span>Items Subtotal</span>
                        <span class="text-dark fw-semibold">₹${subtotal}</span>
                    </div>

                    <c:if test="${discountAmount > 0}">
                        <div class="d-flex justify-content-between mb-2 small text-success">
                            <span>Coupon Discount (${couponCode})</span>
                            <span class="fw-bold">-₹${discountAmount}</span>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-between mb-2 small text-secondary">
                        <span>Delivery Fee</span>
                        <span class="text-success fw-semibold">FREE</span>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between align-items-baseline mb-4">
                        <span class="h6 fw-bold mb-0">Total Payable</span>
                        <span class="h4 fw-extrabold text-primary mb-0">₹${finalAmount}</span>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-3 fw-bold shadow-sm mb-3" style="font-size: 1.05rem;">
                        <i class="bi bi-lock-fill me-1"></i> Place Order & Pay ₹${finalAmount}
                    </button>

                    <div class="text-center text-muted small">
                        By placing your order, you agree to ShopSphere's conditions of sale and mock payment terms.
                    </div>

                </div>
            </div>

        </div>
    </form>

</main>

<%@ include file="/fragments/footer.jsp" %>

<script>
function toggleNewAddressForm(show) {
    const el = document.getElementById('newAddressFields');
    if (show) {
        el.classList.remove('d-none');
    } else {
        el.classList.add('d-none');
    }
}

function fillCoupon(code) {
    document.getElementById('couponInput').value = code;
    applyCoupon();
}

function applyCoupon() {
    const code = document.getElementById('couponInput').value.trim();
    const url = new URL(window.location.href);
    if (code) {
        url.searchParams.set('coupon', code);
    } else {
        url.searchParams.delete('coupon');
    }
    window.location.href = url.toString();
}
</script>
