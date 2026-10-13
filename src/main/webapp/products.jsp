<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ include file="/fragments/header.jsp" %>
<%@ include file="/fragments/navbar.jsp" %>

<!-- Main Catalog Container (Screenshot 4 - "Shop") -->
<main class="container my-4">

    <!-- Top Breadcrumb & Page Title -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb small mb-1">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Shop</li>
                </ol>
            </nav>
            <h1 class="h3 fw-bold text-dark mb-0">Shop Catalog</h1>
        </div>
        <div class="d-none d-md-flex align-items-center gap-2">
            <span class="badge bg-light text-muted border px-3 py-2">
                <i class="bi bi-clock-history me-1"></i> Live Catalog
            </span>
        </div>
    </div>

    <div class="row g-4">

        <!-- ===================================================================
             1. LEFT SIDEBAR FILTERS (Screenshot 4)
             =================================================================== -->
        <aside class="col-lg-3">
            <form id="filterForm" action="${pageContext.request.contextPath}/products" method="GET" class="card border-0 shadow-sm rounded-4 p-4">
                
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                    <h5 class="fw-bold mb-0" style="font-size: 1.1rem;">
                        <i class="bi bi-sliders me-2 text-primary"></i> Filters
                    </h5>
                    <a href="${pageContext.request.contextPath}/products" class="text-muted small text-decoration-none">Reset</a>
                </div>

                <!-- A. Price Range Filter -->
                <div class="filter-group mb-4">
                    <label class="fw-bold small text-dark mb-2 d-block">Price Range (₹)</label>
                    <div class="row g-2 align-items-center">
                        <div class="col-5">
                            <input type="number" name="minPrice" class="form-control form-control-sm" 
                                   placeholder="Min (0)" value="${selectedMinPrice}" min="0">
                        </div>
                        <div class="col-2 text-center text-muted">-</div>
                        <div class="col-5">
                            <input type="number" name="maxPrice" class="form-control form-control-sm" 
                                   placeholder="Max (150000)" value="${selectedMaxPrice}" min="0">
                        </div>
                    </div>
                </div>

                <!-- B. Categories Checklist with Counts -->
                <div class="filter-group mb-4">
                    <label class="fw-bold small text-dark mb-2 d-block">Category</label>
                    <div class="d-flex flex-column gap-2" style="max-height: 220px; overflow-y: auto;">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="category" id="cat_all" value="" 
                                   ${empty selectedCategory ? 'checked' : ''} onchange="this.form.submit()">
                            <label class="form-check-label small d-flex justify-content-between" for="cat_all">
                                <span>All Categories</span>
                            </label>
                        </div>
                        <c:forEach var="cat" items="${allCategories}">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="category" id="cat_${cat.id}" value="${cat.id}" 
                                       ${selectedCategory == cat.id ? 'checked' : ''} onchange="this.form.submit()">
                                <label class="form-check-label small d-flex justify-content-between" for="cat_${cat.id}">
                                    <span>${cat.name}</span>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- C. Brands Checklist -->
                <div class="filter-group mb-4">
                    <label class="fw-bold small text-dark mb-2 d-block">Brands</label>
                    <div class="d-flex flex-column gap-2" style="max-height: 180px; overflow-y: auto;">
                        <c:forEach var="b" items="${allBrands}">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="brand" id="brand_${b}" value="${b}" 
                                       ${selectedBrand eq b ? 'checked' : ''} onchange="this.form.submit()">
                                <label class="form-check-label small" for="brand_${b}">${b}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- D. Ratings Filter (Screenshot 4) -->
                <div class="filter-group mb-4">
                    <label class="fw-bold small text-dark mb-2 d-block">Customer Rating</label>
                    <div class="d-flex flex-column gap-2">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="minRating" id="rate_5" value="5" 
                                   ${selectedMinRating == 5 ? 'checked' : ''} onchange="this.form.submit()">
                            <label class="form-check-label small text-warning" for="rate_5">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                <span class="text-dark ms-1">5 Stars</span>
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="minRating" id="rate_4" value="4" 
                                   ${selectedMinRating == 4 ? 'checked' : ''} onchange="this.form.submit()">
                            <label class="form-check-label small text-warning" for="rate_4">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                                <span class="text-dark ms-1">4 Stars & above</span>
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="minRating" id="rate_3" value="3" 
                                   ${selectedMinRating == 3 ? 'checked' : ''} onchange="this.form.submit()">
                            <label class="form-check-label small text-warning" for="rate_3">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                                <span class="text-dark ms-1">3 Stars & above</span>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Hidden Search & Sort Inputs -->
                <c:if test="${not empty searchKeyword}">
                    <input type="hidden" name="q" value="${searchKeyword}">
                </c:if>

                <button type="submit" class="btn btn-dark w-100 rounded-pill fw-semibold mt-2">
                    Apply Filters
                </button>
            </form>
        </aside>

        <!-- ===================================================================
             2. RIGHT PRODUCT GRID & TOOLBAR (Screenshot 4)
             =================================================================== -->
        <section class="col-lg-9">
            
            <!-- Top Toolbar -->
            <div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                    
                    <!-- Search Input & Result Count -->
                    <div class="d-flex align-items-center gap-3">
                        <div class="text-muted small">
                            Showing <strong class="text-dark">${startIndex}-${endIndex}</strong> of <strong class="text-dark">${totalResults}</strong> results
                        </div>
                        <c:if test="${not empty searchKeyword}">
                            <span class="badge bg-primary-subtle text-primary">
                                "${searchKeyword}" <a href="${pageContext.request.contextPath}/products" class="text-primary text-decoration-none ms-1">&times;</a>
                            </span>
                        </c:if>
                    </div>

                    <!-- Sort Dropdown Pills (Screenshot 4) -->
                    <div class="d-flex align-items-center gap-2">
                        <label for="sortSelect" class="text-muted small text-nowrap">Sort by:</label>
                        <select id="sortSelect" name="sort" class="form-select form-select-sm rounded-pill border-secondary-subtle" 
                                style="width: auto;" onchange="updateSort(this.value)">
                            <option value="top_rated" ${selectedSort eq 'top_rated' ? 'selected' : ''}>Top Rated</option>
                            <option value="popular" ${selectedSort eq 'popular' ? 'selected' : ''}>Popular</option>
                            <option value="newest" ${selectedSort eq 'newest' ? 'selected' : ''}>Newest</option>
                            <option value="price_asc" ${selectedSort eq 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc" ${selectedSort eq 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                        </select>
                    </div>

                </div>
            </div>

            <!-- Product Cards Grid (4 Columns - Screenshot 4) -->
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3">
                        <c:forEach var="product" items="${products}">
                            <tags:productCard product="${product}" />
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-5">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}&category=${selectedCategory}&brand=${selectedBrand}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}&minRating=${selectedMinRating}&sort=${selectedSort}&q=${searchKeyword}">
                                        Previous
                                    </a>
                                </li>
                                <c:forEach var="p" begin="1" end="${totalPages}">
                                    <li class="page-item ${currentPage == p ? 'active' : ''}">
                                        <a class="page-link" href="?page=${p}&category=${selectedCategory}&brand=${selectedBrand}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}&minRating=${selectedMinRating}&sort=${selectedSort}&q=${searchKeyword}">
                                            ${p}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}&category=${selectedCategory}&brand=${selectedBrand}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}&minRating=${selectedMinRating}&sort=${selectedSort}&q=${searchKeyword}">
                                        Next
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4">
                        <div class="text-muted mb-3"><i class="bi bi-search" style="font-size: 3rem;"></i></div>
                        <h4 class="fw-bold">No Products Found</h4>
                        <p class="text-muted small">No items matched your filter criteria. Try adjusting your price range or category.</p>
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark rounded-pill px-4">Clear All Filters</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </section>

    </div>
</main>

<%@ include file="/fragments/footer.jsp" %>

<script>
function updateSort(sortValue) {
    const url = new URL(window.location.href);
    url.searchParams.set('sort', sortValue);
    url.searchParams.set('page', '1');
    window.location.href = url.toString();
}
</script>
