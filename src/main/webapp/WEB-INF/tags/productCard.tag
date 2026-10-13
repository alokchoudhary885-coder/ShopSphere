<%@ tag description="Reusable Modern Product Card" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ attribute name="product" required="true" type="com.shopsphere.model.Product" %>

<div class="col">
    <div class="product-card h-100 shadow-sm">
        
        <!-- Wishlist Heart Button (Top-Right) -->
        <button type="button" class="btn-wishlist-toggle" onclick="toggleWishlist(${product.id}, this)" title="Add to Wishlist">
            <i class="bi bi-heart"></i>
        </button>

        <!-- Product Image Container -->
        <div class="product-img-wrap">
            <a href="${pageContext.request.contextPath}/product-details?id=${product.id}">
                <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                     alt="${product.name}" 
                     class="product-thumb"
                     onerror="this.onerror=null; this.src='https://placehold.co/300x300/f1f5f9/0f172a?text=${product.brand}';">
            </a>
            
            <c:if test="${product.hasDiscount()}">
                <span class="badge-discount-float">
                    ${product.discountPercent}% OFF
                </span>
            </c:if>
        </div>

        <!-- Product Details Body -->
        <div class="product-body">
            
            <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="product-brand-tag">${product.brand}</span>
                <c:choose>
                    <c:when test="${product.isInStock()}">
                        <span class="badge bg-success-subtle text-success small" style="font-size: 0.65rem;">In Stock</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger-subtle text-danger small" style="font-size: 0.65rem;">Out of Stock</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <h3 class="product-title">
                <a href="${pageContext.request.contextPath}/product-details?id=${product.id}" title="${product.name}">
                    ${product.name}
                </a>
            </h3>

            <!-- Price & Discounts -->
            <div class="product-price-row mb-2">
                <span class="price-current">₹${product.getDiscountedPrice()}</span>
                <c:if test="${product.hasDiscount()}">
                    <span class="price-original">₹${product.price}</span>
                </c:if>
            </div>

            <!-- Star Rating & Review Count -->
            <div class="mb-3">
                <tags:ratingStars score="${product.rating}" count="${product.reviewCount}" />
            </div>

            <!-- Dual Action Buttons (Screenshot 4) -->
            <div class="product-actions mt-auto">
                <button type="button" class="btn-add-cart" 
                        onclick="addToCart(${product.id}, 1)" 
                        ${!product.isInStock() ? 'disabled' : ''}>
                    <i class="bi bi-cart-plus me-1"></i> Add To Cart
                </button>
                <a href="${pageContext.request.contextPath}/checkout?buyNowId=${product.id}&qty=1" 
                   class="btn-buy-now ${!product.isInStock() ? 'disabled' : ''}">
                    Buy Now
                </a>
            </div>

        </div>
    </div>
</div>
