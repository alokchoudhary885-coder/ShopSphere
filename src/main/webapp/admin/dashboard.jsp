<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — ShopSphere</title>
    <!-- Admin Styling -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

    <!-- Dark Navigation Sidebar (Screenshot 5 Faithful) -->
    <jsp:include page="/fragments/admin-sidebar.jsp" />

    <!-- Main Content Canvas -->
    <div class="admin-main-wrapper">
        <!-- Top Sticky Header -->
        <jsp:include page="/fragments/admin-header.jsp" />

        <!-- Dashboard Content Area -->
        <main class="admin-content">
            <!-- Page Title & Time Controls -->
            <div class="admin-page-header">
                <div class="admin-title-area">
                    <h1>Dashboard</h1>
                    <div class="admin-breadcrumb">
                        <span>dashboard</span> / <a href="${pageContext.request.contextPath}/admin/dashboard">dashboard</a>
                    </div>
                </div>

                <div class="admin-header-controls">
                    <button class="admin-date-picker-btn">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="16" y1="2" x2="16" y2="6"></line>
                            <line x1="8" y1="2" x2="8" y2="6"></line>
                            <line x1="3" y1="10" x2="21" y2="10"></line>
                        </svg>
                        <span>Dec 29, 2023 - Jan 4, 2024</span>
                    </button>

                    <select class="admin-select-btn">
                        <option>Monthly</option>
                        <option>Weekly</option>
                        <option>Daily</option>
                        <option>Yearly</option>
                    </select>
                </div>
            </div>

            <!-- KPI Cards Row 1 (Financial & Inventory) -->
            <div class="kpi-grid">
                <!-- 1. Total Earning -->
                <div class="kpi-card kpi-earnings">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #15803d;">💰</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value">$ <fmt:formatNumber value="${totalEarnings}" pattern="#,##0.00" /></div>
                        <div class="kpi-label">Total Earning</div>
                    </div>
                </div>

                <!-- 2. Commission Given -->
                <div class="kpi-card kpi-commission">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #0284c7;">🪙</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value">$ <fmt:formatNumber value="${commissionGiven}" pattern="#,##0.00" /></div>
                        <div class="kpi-label">Commission Given</div>
                    </div>
                </div>

                <!-- 3. Total Item -->
                <div class="kpi-card kpi-totalitem">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #ea580c;">🧺</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${totalItems}" /></div>
                        <div class="kpi-label">Total Item</div>
                    </div>
                </div>

                <!-- 4. In Stock -->
                <div class="kpi-card kpi-instock">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #16a34a;">📦</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${inStock}" /></div>
                        <div class="kpi-label">In Stock</div>
                    </div>
                </div>

                <!-- 5. Out Of Stock -->
                <div class="kpi-card kpi-outofstock">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #dc2626;">🚫</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${outOfStock}" /></div>
                        <div class="kpi-label">Out Of Stock</div>
                    </div>
                </div>
            </div>

            <!-- KPI Cards Row 2 (Fulfillment Counters) -->
            <div class="kpi-grid">
                <!-- 6. Waiting For Confirmation -->
                <div class="kpi-card kpi-waiting">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #d97706;">📋</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${waitingConfirmation}" /></div>
                        <div class="kpi-label">Waiting For Confirmation</div>
                    </div>
                </div>

                <!-- 7. Processing Order -->
                <div class="kpi-card kpi-processing">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #0284c7;">🔄</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${processingOrders}" /></div>
                        <div class="kpi-label">Processing Order</div>
                    </div>
                </div>

                <!-- 8. Ready For Delivery -->
                <div class="kpi-card kpi-ready">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #ca8a04;">📦</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${readyForDelivery}" /></div>
                        <div class="kpi-label">Ready For Delivery</div>
                    </div>
                </div>

                <!-- 9. Delivered Order -->
                <div class="kpi-card kpi-delivered">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #2563eb;">🚚</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value"><c:out value="${deliveredOrders}" /></div>
                        <div class="kpi-label">Delivered Order</div>
                    </div>
                </div>

                <!-- 10. Refunded -->
                <div class="kpi-card kpi-refunded">
                    <div class="kpi-top-row">
                        <span class="kpi-icon-wrap" style="color: #dc2626;">↩️</span>
                        <span class="kpi-badge">↑ 18%</span>
                    </div>
                    <div>
                        <div class="kpi-value">$ <c:out value="${refundedAmount}" /></div>
                        <div class="kpi-label">Refunded</div>
                    </div>
                </div>
            </div>

            <!-- Analytics Chart: Earning and Commission -->
            <div class="admin-chart-card">
                <div class="chart-card-header">
                    <h2 class="chart-card-title">Earning and Commission</h2>
                    <div class="chart-legend">
                        <div class="legend-item">
                            <span class="legend-dot earning"></span>
                            <span>Total earning: $ <fmt:formatNumber value="${totalEarnings}" pattern="#,##0.00" /></span>
                        </div>
                        <div class="legend-item">
                            <span class="legend-dot commission"></span>
                            <span>Commission given: $ <fmt:formatNumber value="${commissionGiven}" pattern="#,##0.00" /></span>
                        </div>
                    </div>
                </div>

                <div class="chart-canvas-container">
                    <canvas id="salesChartCanvas"></canvas>
                </div>
            </div>

            <!-- Split Tables: Top Selling Product & Top Rated Items -->
            <div class="admin-split-grid">
                <!-- Table 1: Top Selling Product -->
                <div class="admin-table-card">
                    <h2 class="table-card-title">Top Selling Product</h2>
                    <table class="admin-data-table">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Sold</th>
                                <th>Profit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${topSellingProducts}" var="prod">
                                <tr>
                                    <td>
                                        <div class="table-product-cell">
                                            <img src="${prod.image}" alt="${prod.name}" class="table-product-thumb" />
                                            <span class="table-product-title"><c:out value="${prod.name}" /></span>
                                        </div>
                                    </td>
                                    <td><c:out value="${prod.category}" /></td>
                                    <td><c:out value="${prod.price}" /></td>
                                    <td><c:out value="${prod.sold}" /></td>
                                    <td><span class="profit-badge"><c:out value="${prod.profit}" /></span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Table 2: Top rated items -->
                <div class="admin-table-card">
                    <h2 class="table-card-title">Top rated items</h2>
                    <table class="admin-data-table">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Rating</th>
                                <th>Profit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${topRatedProducts}" var="prod">
                                <tr>
                                    <td>
                                        <div class="table-product-cell">
                                            <img src="${prod.image}" alt="${prod.name}" class="table-product-thumb" />
                                            <span class="table-product-title"><c:out value="${prod.name}" /></span>
                                        </div>
                                    </td>
                                    <td><c:out value="${prod.category}" /></td>
                                    <td><c:out value="${prod.price}" /></td>
                                    <td>
                                        <span class="rating-badge">★ <c:out value="${prod.rating}" /> (Reviews)</span>
                                    </td>
                                    <td><span class="profit-badge"><c:out value="${prod.profit}" /></span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Admin Script -->
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
