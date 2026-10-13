<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- 4-Pillar Trust / Value Proposition Strip (Screenshot 2) -->
<section class="trust-badges-section py-4 my-5 border-top border-bottom bg-white">
    <div class="container">
        <div class="row g-4 text-center text-md-start">
            
            <div class="col-6 col-lg-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="trust-icon-box bg-primary-subtle text-primary">
                        <i class="bi bi-arrow-repeat fs-3"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Free & flexible return</h6>
                        <small class="text-muted">Easy Returns, No Hassle</small>
                    </div>
                </div>
            </div>

            <div class="col-6 col-lg-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="trust-icon-box bg-warning-subtle text-warning">
                        <i class="bi bi-star-fill fs-3"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Our Google Reviews</h6>
                        <small class="text-muted">See What Customers Say</small>
                    </div>
                </div>
            </div>

            <div class="col-6 col-lg-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="trust-icon-box bg-success-subtle text-success">
                        <i class="bi bi-patch-check-fill fs-3"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Free Express Shipping</h6>
                        <small class="text-muted">Enjoy Fast, Free Delivery!</small>
                    </div>
                </div>
            </div>

            <div class="col-6 col-lg-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="trust-icon-box bg-danger-subtle text-danger">
                        <i class="bi bi-truck fs-3"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Same Day Dispatch</h6>
                        <small class="text-muted">Prompt Shipping, Quick Arrival</small>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer-section bg-white pt-5 pb-4">
    <div class="container">
        <div class="row g-4 mb-4">
            
            <!-- Col 1: Brand Info -->
            <div class="col-lg-4 col-md-6">
                <a href="${pageContext.request.contextPath}/" class="brand-logo mb-3">
                    <i class="bi bi-shop-window text-primary"></i>
                    <span>ShopSphere</span>
                </a>
                <p class="text-muted small mt-2">
                    Advanced Java Enterprise E-Commerce Management System built for the RTU syllabus. Demonstrates Jakarta Servlets, JSP, JDBC, MVC, Swing, Sockets, and RMI.
                </p>
                <div class="d-flex gap-3 text-muted">
                    <a href="#" class="text-secondary"><i class="bi bi-facebook fs-5"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-twitter-x fs-5"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-instagram fs-5"></i></a>
                    <a href="https://github.com/alokchoudhary885-coder/ShopSphere" target="_blank" class="text-secondary"><i class="bi bi-github fs-5"></i></a>
                </div>
            </div>

            <!-- Col 2: Categories -->
            <div class="col-lg-2 col-md-6 col-6">
                <h6 class="fw-bold mb-3">Shop Categories</h6>
                <ul class="list-unstyled small mb-0 d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/products?category=4" class="text-muted text-decoration-none">Electronics</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=5" class="text-muted text-decoration-none">Phones & iPads</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=1" class="text-muted text-decoration-none">Home & Living</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2" class="text-muted text-decoration-none">Accessories</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3" class="text-muted text-decoration-none">Healthcare</a></li>
                </ul>
            </div>

            <!-- Col 3: Customer Care -->
            <div class="col-lg-2 col-md-6 col-6">
                <h6 class="fw-bold mb-3">Customer Support</h6>
                <ul class="list-unstyled small mb-0 d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/orders" class="text-muted text-decoration-none">Track Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="text-muted text-decoration-none">Shipping Rates</a></li>
                    <li><a href="${pageContext.request.contextPath}/wishlist" class="text-muted text-decoration-none">Saved Wishlist</a></li>
                    <li><a href="${pageContext.request.contextPath}/login" class="text-muted text-decoration-none">My Account</a></li>
                </ul>
            </div>

            <!-- Col 4: RTU Educational Demonstrations -->
            <div class="col-lg-4 col-md-6">
                <h6 class="fw-bold mb-3">RTU Syllabus Demonstrations</h6>
                <ul class="list-unstyled small mb-0 d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/edu/jsp-syntax-demo.jsp" class="text-muted text-decoration-none"><i class="bi bi-code-slash me-1"></i> JSP Declarations & Scriptlets</a></li>
                    <li><a href="${pageContext.request.contextPath}/edu/jstl-core-demo.jsp" class="text-muted text-decoration-none"><i class="bi bi-tags me-1"></i> JSTL Core Tags & EL</a></li>
                    <li><a href="${pageContext.request.contextPath}/edu/jstl-xml-demo.jsp" class="text-muted text-decoration-none"><i class="bi bi-filetype-xml me-1"></i> JSTL XML Feed Parser</a></li>
                    <li><a href="${pageContext.request.contextPath}/edu/jstl-sql-demo.jsp" class="text-muted text-decoration-none"><i class="bi bi-database me-1"></i> JSTL SQL vs DAO Comparison</a></li>
                </ul>
            </div>

        </div>

        <hr class="text-secondary my-4">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center small text-muted">
            <div>&copy; 2026 ShopSphere E-Commerce System. All rights reserved.</div>
            <div class="d-flex gap-3 mt-2 mt-md-0">
                <a href="#" class="text-muted text-decoration-none">Privacy Policy</a>
                <a href="#" class="text-muted text-decoration-none">Terms of Service</a>
                <a href="#" class="text-muted text-decoration-none">Security Standards</a>
            </div>
        </div>
    </div>
</footer>

<!-- Toast Container for Notifications -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1090;">
    <div id="actionToast" class="toast align-items-center text-white bg-dark border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">Item added to cart!</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
