<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Main Navbar (Screenshots 1 & 2) -->
<nav class="main-navbar sticky-top">
    <div class="container">
        <div class="row align-items-center g-3">
            
            <!-- 1. Brand Logo -->
            <div class="col-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/" class="brand-logo">
                    <i class="bi bi-shop-window text-primary"></i>
                    <span>ShopSphere</span>
                </a>
            </div>

            <!-- 2. Centered Search Bar Pill -->
            <div class="col-12 col-lg-6 order-3 order-lg-2">
                <form action="${pageContext.request.contextPath}/products" method="GET" class="search-pill shadow-sm">
                    <div class="dropdown me-2">
                        <button class="btn btn-sm btn-link text-muted text-decoration-none dropdown-toggle px-1 py-0 d-flex align-items-center gap-1" 
                                type="button" data-bs-toggle="dropdown" style="font-size: 0.85rem;">
                            <i class="bi bi-grid-3x3-gap"></i> Categories
                        </button>
                        <ul class="dropdown-menu shadow-sm">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products">All Categories</a></li>
                            <c:forEach var="cat" items="${applicationScope.activeCategories != null ? applicationScope.activeCategories : categories}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=${cat.id}">${cat.name}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="vr my-1 me-2 text-secondary"></div>
                    <input type="text" name="q" placeholder="Searching for products, brands and essentials..." 
                           value="${param.q}" autocomplete="off" aria-label="Search">
                    <button type="submit" class="btn btn-link text-dark p-0 ms-2">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <!-- 3. Right Icons: Wishlist, Cart & Profile -->
            <div class="col-6 col-lg-3 order-2 order-lg-3 text-end d-flex align-items-center justify-content-end gap-2">
                
                <!-- Wishlist Icon -->
                <a href="${pageContext.request.contextPath}/wishlist" class="nav-icon-btn" title="Saved Wishlist">
                    <i class="bi bi-heart"></i>
                    <c:if test="${sessionScope.wishlistCount > 0}">
                        <span class="nav-icon-badge">${sessionScope.wishlistCount}</span>
                    </c:if>
                </a>

                <!-- Cart Icon -->
                <a href="${pageContext.request.contextPath}/cart" class="nav-icon-btn" title="Shopping Cart">
                    <i class="bi bi-bag"></i>
                    <span class="nav-icon-badge" id="cartBadge">${sessionScope.cartCount != null ? sessionScope.cartCount : '0'}</span>
                </a>

                <!-- User Profile / Auth -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="nav-icon-btn border-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" title="Account Menu">
                                <i class="bi bi-person-circle fs-5"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                <li class="px-3 py-2 border-bottom">
                                    <div class="fw-bold text-dark">${sessionScope.user.fullName}</div>
                                    <small class="text-muted">${sessionScope.user.email}</small>
                                    <span class="badge ${sessionScope.user.role eq 'ADMIN' ? 'bg-danger' : 'bg-primary'} d-block mt-1">
                                        ${sessionScope.user.role}
                                    </span>
                                </li>
                                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                    <li>
                                        <a class="dropdown-item py-2 text-danger fw-semibold" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="bi bi-speedometer2 me-2"></i> Admin Panel
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">
                                        <i class="bi bi-person me-2"></i> My Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/orders">
                                        <i class="bi bi-receipt me-2"></i> My Orders
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/wishlist">
                                        <i class="bi bi-heart me-2"></i> My Wishlist
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i> Log Out
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-dark px-3 py-2 rounded-pill fw-semibold ms-2">
                            <i class="bi bi-person me-1"></i> Sign In
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <!-- Sub-navigation Category Bar (Screenshot 2) -->
        <div class="sub-nav-categories d-none d-lg-flex align-items-center gap-4 mt-3 pt-2 border-top">
            <div class="dropdown">
                <button class="btn btn-sm btn-dark rounded-pill px-3 py-1 dropdown-toggle d-flex align-items-center gap-2" 
                        type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-list fs-6"></i> All Categories
                </button>
                <ul class="dropdown-menu shadow">
                    <c:forEach var="cat" items="${applicationScope.activeCategories != null ? applicationScope.activeCategories : categories}">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=${cat.id}"><i class="bi ${cat.icon} me-2 text-primary"></i> ${cat.name}</a></li>
                    </c:forEach>
                </ul>
            </div>
            
            <a href="${pageContext.request.contextPath}/products?category=1" class="sub-nav-link ${param.category eq '1' ? 'active' : ''}">Home & Living</a>
            <a href="${pageContext.request.contextPath}/products?category=2" class="sub-nav-link ${param.category eq '2' ? 'active' : ''}">Accessories</a>
            <a href="${pageContext.request.contextPath}/products?category=3" class="sub-nav-link ${param.category eq '3' ? 'active' : ''}">Healthcare</a>
            <a href="${pageContext.request.contextPath}/products?category=4" class="sub-nav-link ${param.category eq '4' ? 'active' : ''}">Electronic</a>
            <a href="${pageContext.request.contextPath}/products?category=5" class="sub-nav-link ${param.category eq '5' ? 'active' : ''}">Phone & iPads</a>
            <a href="${pageContext.request.contextPath}/products?category=6" class="sub-nav-link ${param.category eq '6' ? 'active' : ''}">Health & Beauty</a>
            <a href="${pageContext.request.contextPath}/products?category=7" class="sub-nav-link ${param.category eq '7' ? 'active' : ''}">Sports & Outdoor</a>
            <a href="${pageContext.request.contextPath}/products?category=8" class="sub-nav-link ${param.category eq '8' ? 'active' : ''}">Toys & Games</a>
        </div>
    </div>
</nav>
