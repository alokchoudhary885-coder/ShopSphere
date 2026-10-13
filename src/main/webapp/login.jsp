<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account - Log In / Register | ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Minimalist Brand Header -->
    <header class="border-bottom bg-white py-3">
        <div class="container d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/" class="brand-logo text-decoration-none">
                <i class="bi bi-bag-check-fill"></i> ShopSphere
            </a>
            <nav class="d-none d-md-flex gap-4">
                <a href="${pageContext.request.contextPath}/products" class="text-secondary text-decoration-none fw-medium">All Products</a>
                <a href="${pageContext.request.contextPath}/products?category=4" class="text-secondary text-decoration-none fw-medium">Electronics</a>
                <a href="${pageContext.request.contextPath}/products?category=1" class="text-secondary text-decoration-none fw-medium">Home & Living</a>
                <a href="${pageContext.request.contextPath}/products?category=2" class="text-secondary text-decoration-none fw-medium">Accessories</a>
            </nav>
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/wishlist" class="text-dark"><i class="bi bi-heart fs-5"></i></a>
                <a href="${pageContext.request.contextPath}/cart" class="text-dark"><i class="bi bi-bag fs-5"></i></a>
            </div>
        </div>
    </header>

    <!-- Main Auth Portal (Screenshot 3 - 3-Column Layout) -->
    <main class="container my-5">

        <!-- Notification Alerts -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-shield-lock-fill me-2"></i> ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.loginNotice}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="bi bi-info-circle-fill me-2"></i> ${sessionScope.loginNotice}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="loginNotice" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session" />
        </c:if>

        <div class="auth-columns">

            <!-- Column 1: Log In Form -->
            <div class="auth-col">
                <h2 class="auth-col-title">Log In</h2>
                <form action="${pageContext.request.contextPath}/login" method="POST" class="auth-form">
                    <div class="form-group mb-3">
                        <label for="loginEmail">Email address</label>
                        <input type="email" class="form-control" id="loginEmail" name="email" 
                               value="${email}" required autofocus autocomplete="email">
                    </div>
                    <div class="form-group mb-3">
                        <label for="loginPassword">Password</label>
                        <input type="password" class="form-control" id="loginPassword" name="password" 
                               required autocomplete="current-password">
                        <div class="text-end mt-1">
                            <a href="#" class="text-muted small text-decoration-none">Forgot your password?</a>
                        </div>
                    </div>
                    <button type="submit" class="btn-auth-dark mt-2">Sign In</button>
                    
                    <div class="mt-3 p-2 bg-light border rounded small text-muted">
                        <strong>Demo Credentials:</strong><br>
                        Admin: <code>admin@shopsphere.com</code> / <code>admin123</code><br>
                        Customer: <code>customer@shopsphere.com</code> / <code>customer123</code>
                    </div>
                </form>
            </div>

            <!-- Column 2: Register Form -->
            <div class="auth-col">
                <h2 class="auth-col-title">Register</h2>
                <form action="${pageContext.request.contextPath}/register" method="POST" class="auth-form">
                    <div class="form-group mb-3">
                        <label for="regFullName">Full Name</label>
                        <input type="text" class="form-control" id="regFullName" name="fullName" 
                               value="${fullName}" required autocomplete="name">
                    </div>
                    <div class="form-group mb-3">
                        <label for="regEmail">Email address</label>
                        <input type="email" class="form-control" id="regEmail" name="email" 
                               value="${email}" required autocomplete="email">
                    </div>
                    <div class="form-group mb-3">
                        <label for="regPhone">Mobile Number (Optional)</label>
                        <input type="tel" class="form-control" id="regPhone" name="phone" 
                               value="${phone}" autocomplete="tel">
                    </div>
                    <div class="form-group mb-3">
                        <label for="regPassword">Password (Min. 6 characters)</label>
                        <input type="password" class="form-control" id="regPassword" name="password" 
                               required autocomplete="new-password">
                    </div>
                    <div class="form-group mb-3">
                        <label for="regConfirmPassword">Confirm Password</label>
                        <input type="password" class="form-control" id="regConfirmPassword" name="confirmPassword" 
                               required autocomplete="new-password">
                    </div>
                    <button type="submit" class="btn-auth-dark mt-2">Create Account</button>
                </form>
            </div>

            <!-- Column 3: Wishlist Teaser Panel -->
            <div class="auth-col">
                <h2 class="auth-col-title">Wishlist</h2>
                <p class="text-muted small mb-3">Register or sign in to share and save your personal wishlist across devices.</p>

                <!-- Preview sample wishlist item matching Screenshot 3 -->
                <div class="wishlist-preview-item">
                    <div class="bg-dark text-white rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <i class="bi bi-wallet2 fs-4"></i>
                    </div>
                    <div class="flex-grow-1">
                        <div class="fw-bold small">Oscar Wallet</div>
                        <div class="text-muted small">Black</div>
                        <div class="fw-semibold text-primary">₹2,499.00</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-dark">View</a>
                </div>

                <div class="wishlist-preview-item">
                    <div class="bg-primary text-white rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                        <i class="bi bi-headphones fs-4"></i>
                    </div>
                    <div class="flex-grow-1">
                        <div class="fw-bold small">JBL Live Over Ear</div>
                        <div class="text-muted small">Wireless</div>
                        <div class="fw-semibold text-primary">₹6,499.00</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-dark">View</a>
                </div>

                <div class="alert alert-secondary text-center small mt-4 mb-0 py-2">
                    Please log in or create an account to manage your active wishlist.
                </div>
            </div>

        </div>

        <!-- Value Guarantees Strip (Screenshot 3 Footer) -->
        <div class="guarantees-strip row g-4 mt-5">
            <div class="col-md-4 guarantee-item">
                <i class="bi bi-truck"></i>
                <div><span>Free & Express Shipping</span></div>
                <small class="text-muted">On all domestic orders over ₹499</small>
            </div>
            <div class="col-md-4 guarantee-item">
                <i class="bi bi-shield-check"></i>
                <div><span>Genuine Warranty</span></div>
                <small class="text-muted">100% verified original products</small>
            </div>
            <div class="col-md-4 guarantee-item">
                <i class="bi bi-arrow-repeat"></i>
                <div><span>Hassle-Free Returns</span></div>
                <small class="text-muted">7-day replacement guarantee</small>
            </div>
        </div>

    </main>

    <footer class="bg-white border-top py-3 text-center text-muted small">
        <div class="container">
            &copy; 2026 ShopSphere — RTU Advanced Java E-Commerce Project. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
