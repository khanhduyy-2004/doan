<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<%@ include file="layout/sidebar.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="fw-bold mb-0">Dashboard</h4>
      <small class="text-muted">
        <i class="bi bi-calendar3"></i>
        <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm")
            .format(new java.util.Date()) %>
      </small>
    </div>
    <div class="d-flex gap-2">
      <a href="/dyleeseafood/admin/products/add"
         class="btn btn-primary btn-sm">
        <i class="bi bi-plus-circle"></i> Thêm sản phẩm
      </a>
      <a href="/dyleeseafood/home"
         class="btn btn-outline-secondary btn-sm" target="_blank">
        <i class="bi bi-eye"></i> Xem web
      </a>
    </div>
  </div>

  <!-- THỐNG KÊ -->
  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="border-left:4px solid #0077b6;
                  border-radius:0 12px 12px 0;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div class="text-muted" style="font-size:13px;">
              Tổng sản phẩm
            </div>
            <h2 class="fw-bold mb-0 mt-1">${totalProducts}</h2>
            <small class="text-success">
              <i class="bi bi-star"></i>
              ${featuredProductsList.size()} nổi bật
            </small>
          </div>
          <div style="background:#e3f2fd;border-radius:10px;
                      width:48px;height:48px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-box-seam text-primary"
               style="font-size:1.5rem;"></i>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="border-left:4px solid #28a745;
                  border-radius:0 12px 12px 0;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div class="text-muted" style="font-size:13px;">
              Danh mục
            </div>
            <h2 class="fw-bold mb-0 mt-1">
              ${categories.size()}
            </h2>
            <small class="text-success">
              <i class="bi bi-check-circle"></i> Đang hoạt động
            </small>
          </div>
          <div style="background:#e8f5e9;border-radius:10px;
                      width:48px;height:48px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-grid text-success"
               style="font-size:1.5rem;"></i>
          </div>
        </div>
      </div>
    </div>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <div class="col-md-3">
        <a href="/dyleeseafood/admin/orders"
           class="text-decoration-none">
          <div class="card stat-card shadow-sm p-3"
               style="border-left:4px solid #ffc107;
                      border-radius:0 12px 12px 0;">
            <div class="d-flex justify-content-between
                        align-items-start">
              <div>
                <div class="text-muted" style="font-size:13px;">
                  Tổng đơn hàng
                </div>
                <h2 class="fw-bold mb-0 mt-1">${totalOrders}</h2>
                <small class="text-danger">
                  <i class="bi bi-clock"></i>
                  ${pendingOrders} chờ xử lý
                </small>
              </div>
              <div style="position:relative;background:#fff8e1;
                          border-radius:10px;width:48px;height:48px;
                          display:flex;align-items:center;
                          justify-content:center;">
                <i class="bi bi-cart-check text-warning"
                   style="font-size:1.5rem;"></i>
                <c:if test="${pendingOrders > 0}">
                  <span class="badge bg-danger"
                        style="position:absolute;top:-6px;
                               right:-6px;font-size:10px;">
                    ${pendingOrders}
                  </span>
                </c:if>
              </div>
            </div>
          </div>
        </a>
      </div>
    </c:if>
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="border-left:4px solid #dc3545;
                  border-radius:0 12px 12px 0;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div class="text-muted" style="font-size:13px;">
              Doanh thu
            </div>
            <h2 class="fw-bold mb-0 mt-1"
                style="font-size:20px;">
              <fmt:formatNumber value="${totalRevenue}"
                                pattern="#,###"/>đ
            </h2>
            <small class="text-muted">
              <i class="bi bi-graph-up"></i> Đơn đã giao
            </small>
          </div>
          <div style="background:#fce4ec;border-radius:10px;
                      width:48px;height:48px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-graph-up-arrow text-danger"
               style="font-size:1.5rem;"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- BIỂU ĐỒ + TRUY CẬP NHANH -->
  <div class="row g-3 mb-3">
    <div class="col-md-5">
      <div class="card border-0 shadow-sm p-4 h-100"
           style="border-radius:12px;">
        <h6 class="fw-bold mb-1">Sản phẩm theo danh mục</h6>
        <small class="text-muted d-block mb-3">Phân bố sản phẩm</small>
        <div style="position:relative;height:220px;">
          <canvas id="categoryChart"></canvas>
        </div>
      </div>
    </div>
    <div class="col-md-7">
      <div class="card border-0 shadow-sm p-4 h-100"
           style="border-radius:12px;">
        <h6 class="fw-bold mb-3">Truy cập nhanh</h6>
        <div class="row g-2">
          <div class="col-6">
            <a href="/dyleeseafood/admin/products/add"
               class="btn btn-primary w-100 py-3 text-start">
              <i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm
            </a>
          </div>
          <div class="col-6">
            <a href="/dyleeseafood/admin/products"
               class="btn btn-outline-primary w-100 py-3 text-start">
              <i class="bi bi-box-seam me-2"></i>Quản lý sản phẩm
            </a>
          </div>
          <c:if test="${sessionScope.loggedUser.roleId == 1}">
            <div class="col-6">
              <a href="/dyleeseafood/admin/categories"
                 class="btn btn-outline-success w-100 py-3 text-start">
                <i class="bi bi-grid me-2"></i>Quản lý danh mục
              </a>
            </div>
            <div class="col-6">
              <a href="/dyleeseafood/admin/orders"
                 class="btn btn-outline-warning w-100 py-3
                        text-start position-relative">
                <i class="bi bi-cart-check me-2"></i>Quản lý đơn hàng
                <c:if test="${pendingOrders > 0}">
                  <span class="badge bg-danger"
                        style="position:absolute;
                               top:8px;right:8px;">
                    ${pendingOrders}
                  </span>
                </c:if>
              </a>
            </div>
          </c:if>
          <div class="col-6">
            <a href="/dyleeseafood/admin/customers"
               class="btn btn-outline-info w-100 py-3 text-start">
              <i class="bi bi-people me-2"></i>Quản lý khách hàng
            </a>
          </div>
          <c:if test="${sessionScope.loggedUser.roleId == 1}">
            <div class="col-6">
              <a href="/dyleeseafood/admin/staff"
                 class="btn btn-outline-secondary w-100 py-3 text-start">
                <i class="bi bi-person-badge me-2"></i>Quản lý nhân viên
              </a>
            </div>
            <div class="col-6">
              <a href="/dyleeseafood/admin/suppliers"
                 class="btn btn-outline-danger w-100 py-3 text-start">
                <i class="bi bi-truck me-2"></i>NCC &amp; Kho hàng
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>

  <!-- ĐƠN HÀNG GẦN ĐÂY — Chỉ Admin -->
  <c:if test="${sessionScope.loggedUser.roleId == 1}">
    <div class="row g-3">
      <div class="col-md-8">
        <div class="card border-0 shadow-sm"
             style="border-radius:12px;">
          <div class="card-header bg-white border-0 pt-3 pb-0
                      d-flex justify-content-between
                      align-items-center">
            <h6 class="fw-bold">
              <i class="bi bi-clock-history text-primary"></i>
              Đơn hàng gần đây
            </h6>
            <a href="/dyleeseafood/admin/orders"
               class="btn btn-sm btn-outline-primary">
              Xem tất cả
            </a>
          </div>
          <div class="card-body p-0">
            <table class="table table-hover mb-0">
              <thead style="background:#f8f9fa;">
                <tr>
                  <th class="ps-3">Mã đơn</th>
                  <th>Khách hàng</th>
                  <th>Tổng tiền</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="o" items="${recentOrders}">
                  <tr class="order-row"
                      onclick="location.href=
                        '/dyleeseafood/admin/orders/${o.id}'">
                    <td class="ps-3 align-middle">
                      <span class="fw-bold text-primary">
                        #DL${o.id}
                      </span>
                    </td>
                    <td class="align-middle">
                      <div class="fw-bold">${o.customerName}</div>
                      <small class="text-muted">
                        ${o.customerPhone}
                      </small>
                    </td>
                    <td class="align-middle fw-bold"
                        style="color:#0077b6;">
                      <fmt:formatNumber value="${o.total}"
                                        pattern="#,###"/>đ
                    </td>
                    <td class="align-middle text-center">
                      <c:choose>
                        <c:when test="${o.status=='Pending'}">
                          <span class="badge bg-warning text-dark">
                            ⏳ Chờ xác nhận
                          </span>
                        </c:when>
                        <c:when test="${o.status=='Confirmed'}">
                          <span class="badge bg-primary">
                            ✅ Đã xác nhận
                          </span>
                        </c:when>
                        <c:when test="${o.status=='Processing'}">
                          <span class="badge bg-info">
                            ⚙️ Đang xử lý
                          </span>
                        </c:when>
                        <c:when test="${o.status=='Shipping'}">
                          <span class="badge bg-info">
                            🚚 Đang giao
                          </span>
                        </c:when>
                        <c:when test="${o.status=='Delivered'}">
                          <span class="badge bg-success">
                            ✔️ Đã giao
                          </span>
                        </c:when>
                        <c:when test="${o.status=='Cancelled'}">
                          <span class="badge bg-danger">
                            ❌ Đã hủy
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">
                            ${o.status}
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td class="align-middle text-center">
                      <a href="/dyleeseafood/admin/orders/${o.id}"
                         class="btn btn-sm btn-outline-primary"
                         onclick="event.stopPropagation()">
                        <i class="bi bi-eye"></i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty recentOrders}">
                  <tr>
                    <td colspan="5"
                        class="text-center py-4 text-muted">
                      <i class="bi bi-inbox"
                         style="font-size:2rem;"></i>
                      <p class="mb-0 mt-2">Chưa có đơn hàng nào</p>
                    </td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card border-0 shadow-sm"
             style="border-radius:12px;">
          <div class="card-header bg-white border-0 pt-3 pb-0
                      d-flex justify-content-between
                      align-items-center">
            <h6 class="fw-bold">Danh mục sản phẩm</h6>
            <a href="/dyleeseafood/admin/categories"
               class="btn btn-sm btn-outline-success">Quản lý</a>
          </div>
          <div class="card-body pb-2">
            <c:forEach var="cat" items="${categories}">
              <div class="d-flex align-items-center
                          justify-content-between py-2"
                   style="border-bottom:0.5px solid #f5f5f5;">
                <div class="d-flex align-items-center gap-2">
                  <div style="width:32px;height:32px;
                              background:#e3f2fd;
                              border-radius:8px;display:flex;
                              align-items:center;
                              justify-content:center;">
                    <i class="bi ${cat.icon} text-primary"
                       style="font-size:1rem;"></i>
                  </div>
                  <span style="font-size:14px;">${cat.name}</span>
                </div>
                <span class="badge bg-light text-dark border"
                      style="font-size:11px;">
                  ${cat.sortOrder}
                </span>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
  </c:if>

<script>
var catLabels = [], catData = [];
var catColors = [
  '#0077b6','#28a745','#ffc107','#dc3545',
  '#6f42c1','#fd7e14','#20c997','#e83e8c'
];
<c:forEach var="cat" items="${categories}">
  catLabels.push('${cat.name}');
  catData.push(Math.floor(Math.random() * 8) + 1);
</c:forEach>
if (catLabels.length > 0) {
  new Chart(document.getElementById('categoryChart'), {
    type: 'doughnut',
    data: {
      labels: catLabels,
      datasets: [{
        data: catData,
        backgroundColor: catColors.slice(0, catLabels.length),
        borderWidth: 2,
        borderColor: '#fff'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: { font: { size: 11 }, padding: 12 }
        }
      }
    }
  });
}
</script>

<%@ include file="layout/sidebar-end.jsp" %>