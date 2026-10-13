<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'ShopSphere — Modern Enterprise E-Commerce'}" /></title>
    
    <!-- Bootstrap 5.3 & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom ShopSphere CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Top Announcement Bar (Screenshots 1 & 2) -->
    <div class="top-bar">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <span class="badge bg-danger text-uppercase px-2 py-1" style="font-size: 0.7rem; font-weight: 700;">Hot</span>
                <span>Get 50% Off on Selected Items | <a href="${pageContext.request.contextPath}/products">Shop Now</a></span>
            </div>
            <div class="d-flex align-items-center gap-4">
                <span class="d-none d-md-inline"><i class="bi bi-telephone me-1"></i> +00115586890</span>
                <span class="d-none d-sm-inline"><i class="bi bi-truck me-1"></i> Free Express Shipping</span>
                <div class="dropdown">
                    <a class="text-white text-decoration-none dropdown-toggle small" href="#" role="button" data-bs-dismiss="dropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-globe me-1"></i> EN (₹)
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                        <li><a class="dropdown-item active" href="#">English (INR ₹)</a></li>
                        <li><a class="dropdown-item" href="#">हिन्दी (INR ₹)</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
