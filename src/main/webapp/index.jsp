<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Main Storefront Content -->
<main class="container my-4">

    <!-- 1. Bento Grid Hero Section (Screenshot 1) -->
    <section class="hero-bento-section">
        <div class="bento-grid-container">
            
            <!-- Bento Card 1: Large Left (Smart Home Essentials) -->
            <div class="bento-card bento-card-large shadow-sm">
                <div>
                    <span class="bento-badge">Starting At Only ₹699</span>
                    <h1 class="bento-title">Smart Home<br>Essentials Bundle</h1>
                    <p class="bento-desc">Enjoy seamless connectivity, premium ambient sound, and effortless wireless charging.</p>
                </div>
                <a href="${pageContext.request.contextPath}/products?category=4" class="btn-bento-cta">
                    Explore Now <i class="bi bi-arrow-right"></i>
                </a>
            </div>

            <!-- Bento Card 2: Top Right (JBL Wireless Headphones) -->
            <div class="bento-card bento-card-navy shadow-sm">
                <div>
                    <span class="bento-badge">Starting At Only ₹699</span>
                    <h2 class="bento-title">JBL Wireless<br>Headphones</h2>
                    <p class="bento-desc">Stay connected with Bluetooth 5.3 technology and enjoy signature pure bass sound.</p>
                </div>
                <a href="${pageContext.request.contextPath}/products?category=4" class="btn-bento-cta">
                    Explore Now <i class="bi bi-arrow-right"></i>
                </a>
            </div>

        </div>

        <!-- Bento Secondary Row (Bottom 3 Cards - Screenshot 1) -->
        <div class="bento-row-bottom">
            
            <!-- Bottom Card 1: Apple Sleek Laptop -->
            <div class="bento-card-sm shadow-sm" style="background: linear-gradient(135deg, #020617 0%, #1e293b 100%);">
                <div>
                    <span class="badge bg-primary text-uppercase px-2 py-1 mb-2">Best Deals</span>
                    <h3 class="fw-bold mb-1" style="font-size: 1.25rem;">Apple Sleek Ultra<br>Thin Laptop</h3>
                </div>
                <a href="${pageContext.request.contextPath}/products?category=4" class="btn btn-sm btn-outline-light rounded-pill align-self-start mt-3">
                    View Specs
                </a>
            </div>

            <!-- Bottom Card 2: JBL Live Over Ear -->
            <div class="bento-card-sm shadow-sm" style="background: linear-gradient(135deg, #0c4a6e 0%, #0369a1 100%);">
                <div>
                    <span class="badge bg-warning text-dark text-uppercase px-2 py-1 mb-2">Grab 50% Off</span>
                    <h3 class="fw-bold mb-1" style="font-size: 1.25rem;">JBL Live Over Ear<br>Headphone</h3>
                    <small class="text-light opacity-75">Wireless high-res studio audio</small>
                </div>
                <a href="${pageContext.request.contextPath}/products?category=4" class="btn btn-sm btn-light rounded-pill align-self-start mt-3">
                    Explore Now
                </a>
            </div>

            <!-- Bottom Card 3: Apple Smartwatch Series 8 -->
            <div class="bento-card-sm shadow-sm" style="background: linear-gradient(135deg, #18181b 0%, #3f3f46 100%);">
                <div>
                    <span class="badge bg-danger text-uppercase px-2 py-1 mb-2">New Arrival</span>
                    <h3 class="fw-bold mb-1" style="font-size: 1.25rem;">Apple Smartwatch<br>Series 8</h3>
                </div>
                <a href="${pageContext.request.contextPath}/products?category=5" class="btn btn-sm btn-outline-light rounded-pill align-self-start mt-3">
                    Shop Now
                </a>
            </div>

        </div>
    </section>

    <!-- 2. Split Promo Banners (Screenshot 2) -->
    <section class="split-promo-section my-5">
        <div class="row g-4">
            
            <!-- Left Banner: Redefine Comfort -->
            <div class="col-lg-7">
                <div class="p-4 p-md-5 rounded-4 d-flex flex-column justify-content-between h-100 shadow-sm" 
                     style="background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%); min-height: 280px; border: 1px solid var(--border-color);">
                    <div>
                        <span class="text-uppercase fw-bold text-muted small">Living Room Collections</span>
                        <h2 class="display-6 fw-extrabold text-dark mt-2 mb-3" style="font-weight: 800;">
                            Redefine Comfort<br>with <span class="fst-italic text-secondary">Timeless Elegance</span>
                        </h2>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/products?category=1" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                            Shop the Collection
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right Banner: iPhone 17 Pro -->
            <div class="col-lg-5">
                <div class="p-4 p-md-5 rounded-4 d-flex flex-column justify-content-between h-100 shadow-sm text-white" 
                     style="background: linear-gradient(135deg, #09090b 0%, #18181b 60%, #ea580c 120%); min-height: 280px;">
                    <div>
                        <span class="text-uppercase fw-semibold text-warning small">iOS and Apple Intelligence</span>
                        <h2 class="display-6 fw-bold mt-2 mb-3" style="font-weight: 800;">iPhone 17 Pro</h2>
                        <p class="text-light opacity-75 small">Engineered with aerospace-grade titanium and periscope camera system.</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/products?category=5" class="btn btn-light rounded-pill px-4 py-2 fw-semibold">
                            Shop Now
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- 3. Product Category Pills (Screenshot 2) -->
    <section class="my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="h4 fw-bold text-dark mb-0">Product Category</h2>
            <a href="${pageContext.request.contextPath}/products" class="text-primary text-decoration-none fw-semibold small">
                Browse All <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="pastel-category-grid">
            <a href="${pageContext.request.contextPath}/products?category=1" class="pastel-cat-card cat-theme-1">
                <i class="bi bi-house-heart"></i>
                <span>Home & Living</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=2" class="pastel-cat-card cat-theme-2">
                <i class="bi bi-watch"></i>
                <span>Accessories</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=3" class="pastel-cat-card cat-theme-3">
                <i class="bi bi-heart-pulse"></i>
                <span>Healthcare</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=4" class="pastel-cat-card cat-theme-4">
                <i class="bi bi-laptop"></i>
                <span>Electronic</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=5" class="pastel-cat-card cat-theme-5">
                <i class="bi bi-phone"></i>
                <span>Phone & iPads</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=6" class="pastel-cat-card cat-theme-6">
                <i class="bi bi-brush"></i>
                <span>Health & Beauty</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=7" class="pastel-cat-card cat-theme-7">
                <i class="bi bi-trophy"></i>
                <span>Sports & Outdoor</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=8" class="pastel-cat-card cat-theme-8">
                <i class="bi bi-controller"></i>
                <span>Toys & Games</span>
            </a>
        </div>
    </section>

    <!-- 4. Featured Products (Screenshot 1 & 4 Style) -->
    <section class="my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="h4 fw-bold text-dark mb-1">Featured Products</h2>
                <p class="text-muted small mb-0">Top-rated items handpicked for quality and customer satisfaction</p>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-dark rounded-pill px-3">
                Browse Products <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach var="product" items="${featuredProducts}">
                <tags:productCard product="${product}" />
            </c:forEach>
        </div>
    </section>

</main>

<%@ include file="/fragments/footer.jsp" %>
