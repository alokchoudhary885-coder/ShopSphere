<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Saved Wishlist Page -->
<main class="container my-4">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
            <li class="breadcrumb-item active text-dark" aria-current="page">My Wishlist</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h3 fw-bold text-dark mb-1">My Wishlist</h1>
            <p class="text-muted small mb-0">Saved products you love across devices</p>
        </div>
        <span class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-semibold">
            <i class="bi bi-heart-fill me-1"></i> ${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : '0'} items
        </span>
    </div>

    <c:choose>
        <c:when test="${not empty wishlistItems}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <c:forEach var="item" items="${wishlistItems}">
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden position-relative product-card">
                            
                            <!-- Delete Button -->
                            <form action="${pageContext.request.contextPath}/wishlist" method="POST" class="position-absolute top-0 end-0 m-3" style="z-index: 10;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="wishlistId" value="${item.id}">
                                <button type="submit" class="btn btn-sm btn-light rounded-circle shadow-sm text-danger" title="Remove from wishlist">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </form>

                            <!-- Product Thumbnail -->
                            <div class="product-img-wrap">
                                <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}">
                                    <img src="${pageContext.request.contextPath}/${item.productImageUrl}" 
                                         alt="${item.productName}" 
                                         class="product-thumb"
                                         onerror="this.onerror=null; this.src='https://placehold.co/300x300/f1f5f9/0f172a?text=Saved+Item';">
                                </a>
                            </div>

                            <!-- Body -->
                            <div class="product-body">
                                <h3 class="product-title">
                                    <a href="${pageContext.request.contextPath}/product-details?id=${item.productId}">
                                        ${item.productName}
                                    </a>
                                </h3>

                                <div class="product-price-row mb-3">
                                    <span class="price-current">₹${item.productPrice}</span>
                                </div>

                                <!-- Move to Cart Button -->
                                <form action="${pageContext.request.contextPath}/wishlist" method="POST" class="mt-auto">
                                    <input type="hidden" name="action" value="moveToCart">
                                    <input type="hidden" name="wishlistId" value="${item.id}">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <button type="submit" class="btn btn-dark btn-sm w-100 rounded-pill fw-semibold py-2">
                                        <i class="bi bi-cart-plus me-1"></i> Move to Cart
                                    </button>
                                </form>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Empty Wishlist State -->
            <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4 bg-white">
                <div class="text-muted mb-3">
                    <i class="bi bi-heart" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2">Your Wishlist is Empty</h3>
                <p class="text-muted small mb-4">Explore our catalog and click the heart icon on any product to save it for later.</p>
                <div>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                        Explore Products
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<%@ include file="/fragments/footer.jsp" %>
