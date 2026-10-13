<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Product Details Page Container -->
<main class="container my-4">

    <!-- Breadcrumbs -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products" class="text-decoration-none text-muted">Shop</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?category=${product.categoryId}" class="text-decoration-none text-muted">${product.categoryName}</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">${product.name}</li>
        </ol>
    </nav>

    <!-- Feedback Alerts -->
    <c:if test="${not empty sessionScope.reviewSuccess}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.reviewSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="reviewSuccess" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.reviewError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.reviewError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="reviewError" scope="session" />
    </c:if>

    <!-- Main Product Presentation Card -->
    <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 mb-5 bg-white">
        <div class="row g-5 align-items-center">
            
            <!-- Left: Product Image Preview -->
            <div class="col-lg-5 text-center position-relative">
                <div class="p-4 bg-light rounded-4 d-flex align-items-center justify-content-center" style="min-height: 380px;">
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                         alt="${product.name}" 
                         class="img-fluid" 
                         style="max-height: 320px; object-fit: contain;"
                         onerror="this.onerror=null; this.src='https://placehold.co/400x400/f1f5f9/0f172a?text=${product.brand}';">
                </div>
                <c:if test="${product.hasDiscount()}">
                    <span class="badge bg-danger position-absolute top-0 start-0 m-3 px-3 py-2 fs-6 rounded-pill">
                        ${product.discountPercent}% OFF
                    </span>
                </c:if>
            </div>

            <!-- Right: Product Info & Actions -->
            <div class="col-lg-7">
                
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <span class="text-uppercase fw-bold text-muted small letter-spacing-1">${product.brand}</span>
                    <button type="button" class="btn btn-outline-danger btn-sm rounded-pill" onclick="toggleWishlist(${product.id}, this)">
                        <i class="bi bi-heart me-1"></i> Save to Wishlist
                    </button>
                </div>

                <h1 class="h2 fw-extrabold text-dark mb-2" style="font-weight: 800;">${product.name}</h1>

                <!-- Rating & Stock Badge -->
                <div class="d-flex align-items-center gap-3 mb-3">
                    <tags:ratingStars score="${product.rating}" count="${product.reviewCount}" />
                    <div class="vr"></div>
                    <c:choose>
                        <c:when test="${product.isInStock()}">
                            <span class="badge bg-success-subtle text-success px-3 py-1">In Stock (${product.stockQuantity} available)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger-subtle text-danger px-3 py-1">Out of Stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Price Row -->
                <div class="d-flex align-items-baseline gap-3 my-3 p-3 bg-light rounded-3">
                    <span class="display-6 fw-bold text-primary">₹${product.getDiscountedPrice()}</span>
                    <c:if test="${product.hasDiscount()}">
                        <span class="fs-5 text-muted text-decoration-line-through">₹${product.price}</span>
                        <span class="badge bg-danger-subtle text-danger fw-semibold">Save ₹${product.getSavingsAmount()}</span>
                    </c:if>
                </div>

                <!-- Description -->
                <p class="text-secondary my-3 leading-relaxed">
                    ${product.description}
                </p>

                <!-- Quantity & Action Buttons -->
                <div class="my-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <label class="fw-semibold small text-dark">Quantity:</label>
                        <div class="input-group" style="width: 140px;">
                            <button class="btn btn-outline-secondary" type="button" onclick="decrementQty()">-</button>
                            <input type="number" id="detailQty" class="form-control text-center" value="1" min="1" max="${product.stockQuantity}">
                            <button class="btn btn-outline-secondary" type="button" onclick="incrementQty(${product.stockQuantity})">+</button>
                        </div>
                    </div>

                    <div class="d-flex flex-wrap gap-3">
                        <button type="button" class="btn btn-dark px-4 py-2 rounded-pill fw-semibold flex-grow-1" 
                                onclick="addToCart(${product.id}, document.getElementById('detailQty').value)"
                                ${!product.isInStock() ? 'disabled' : ''}>
                            <i class="bi bi-cart-plus me-2"></i> Add to Cart
                        </button>
                        <a href="${pageContext.request.contextPath}/checkout?buyNowId=${product.id}&qty=1" 
                           id="buyNowBtn"
                           class="btn btn-primary px-4 py-2 rounded-pill fw-semibold flex-grow-1 ${!product.isInStock() ? 'disabled' : ''}">
                            Buy Now
                        </a>
                    </div>
                </div>

                <!-- Trust Guarantees Mini Strip -->
                <div class="row g-3 border-top pt-3 text-muted small">
                    <div class="col-sm-4 d-flex align-items-center gap-2">
                        <i class="bi bi-truck fs-5 text-dark"></i>
                        <span>Free express shipping</span>
                    </div>
                    <div class="col-sm-4 d-flex align-items-center gap-2">
                        <i class="bi bi-shield-check fs-5 text-dark"></i>
                        <span>1 Year Brand Warranty</span>
                    </div>
                    <div class="col-sm-4 d-flex align-items-center gap-2">
                        <i class="bi bi-arrow-repeat fs-5 text-dark"></i>
                        <span>7 Days Return Policy</span>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Customer Reviews & Submission Section -->
    <section class="card border-0 shadow-sm rounded-4 p-4 p-md-5 mb-5 bg-white">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="h4 fw-bold text-dark mb-1">Customer Reviews & Ratings</h3>
                <p class="text-muted small mb-0">Real feedback from verified purchasers</p>
            </div>
            <div>
                <tags:ratingStars score="${product.rating}" count="${product.reviewCount}" />
            </div>
        </div>

        <div class="row g-4">
            
            <!-- Left: Reviews List -->
            <div class="col-lg-7">
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <div class="d-flex flex-column gap-3">
                            <c:forEach var="rev" items="${reviews}">
                                <div class="p-3 bg-light rounded-3 border">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <div class="fw-bold text-dark">
                                            <i class="bi bi-person-circle me-1 text-secondary"></i> ${rev.userName != null ? rev.userName : 'Verified Buyer'}
                                        </div>
                                        <tags:ratingStars score="${rev.rating}" />
                                    </div>
                                    <p class="text-secondary small mb-1">${rev.comment}</p>
                                    <small class="text-muted" style="font-size: 0.75rem;">${rev.createdAt}</small>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-light border text-muted small p-4 text-center">
                            No reviews yet for this product. Be the first to share your experience!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Right: Write a Review Form -->
            <div class="col-lg-5">
                <div class="card bg-light border-0 rounded-4 p-4">
                    <h5 class="fw-bold mb-3">Write a Review</h5>
                    <form action="${pageContext.request.contextPath}/reviews" method="POST">
                        <input type="hidden" name="productId" value="${product.id}">
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Your Rating:</label>
                            <select name="rating" class="form-select form-select-sm" required>
                                <option value="5">★★★★★ 5 Stars (Excellent)</option>
                                <option value="4">★★★★☆ 4 Stars (Very Good)</option>
                                <option value="3">★★★☆☆ 3 Stars (Average)</option>
                                <option value="2">★★☆☆☆ 2 Stars (Poor)</option>
                                <option value="1">★☆☆☆☆ 1 Star (Terrible)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Review Comment:</label>
                            <textarea name="comment" class="form-control form-control-sm" rows="3" 
                                      placeholder="What did you like or dislike about this product?" required></textarea>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <button type="submit" class="btn btn-dark btn-sm w-100 rounded-pill fw-semibold">
                                    Submit Review
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-dark btn-sm w-100 rounded-pill">
                                    Sign In to Review
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>

        </div>
    </section>

    <!-- Related Products in Same Category -->
    <c:if test="${not empty relatedProducts}">
        <section class="my-5">
            <h3 class="h4 fw-bold text-dark mb-4">Related Products You May Like</h3>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                <c:forEach var="rel" items="${relatedProducts}">
                    <tags:productCard product="${rel}" />
                </c:forEach>
            </div>
        </section>
    </c:if>

</main>

<%@ include file="/fragments/footer.jsp" %>

<script>
function incrementQty(max) {
    const input = document.getElementById('detailQty');
    let val = parseInt(input.value) || 1;
    if (val < max) {
        input.value = val + 1;
        updateBuyNowHref(val + 1);
    }
}

function decrementQty() {
    const input = document.getElementById('detailQty');
    let val = parseInt(input.value) || 1;
    if (val > 1) {
        input.value = val - 1;
        updateBuyNowHref(val - 1);
    }
}

function updateBuyNowHref(qty) {
    const btn = document.getElementById('buyNowBtn');
    if (btn) {
        btn.href = '${pageContext.request.contextPath}/checkout?buyNowId=${product.id}&qty=' + qty;
    }
}

document.getElementById('detailQty').addEventListener('change', function() {
    let val = parseInt(this.value) || 1;
    updateBuyNowHref(val);
});
</script>
