<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chi tiết đơn hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background:#f0f2f5; }
    .sidebar { background:#023e8a; min-height:100vh; width:240px; position:fixed; top:0; left:0; z-index:100; }
    .sidebar .nav-link { color:rgba(255,255,255,0.8); padding:12px 20px; border-radius:8px; margin:2px 8px; transition:0.2s; }
    .sidebar .nav-link:hover, .sidebar .nav-link.active { background:rgba(255,255,255,0.15); color:white; }
    .main-content { margin-left:240px; padding:24px; }
    .step-node {
      width:36px; height:36px; border-radius:50%;
      display:flex; align-items:center;
      justify-content:center; font-size:14px;
      font-weight:700; flex-shrink:0;
    }
    .step-node.done { background:#0077b6; color:white; }
    .step-node.current { background:#ffc107; color:#333; }
    .step-node.todo { background:#dee2e6; color:#999; }
    .step-line { flex:1; height:3px; }
    .step-line.done { background:#0077b6; }
    .step-line.todo { background:#dee2e6; }
  </style>
</head>
<body>

<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <span style="font-size:2rem;">🐟</span>
    <h5 class="text-white fw-bold mb-0 mt-1">Dylee Admin</h5>
    <small style="color:rgba(255,255,255,0.5);">
      ${sessionScope.loggedUser.roleId == 1
        ? 'Quản trị viên' : 'Nhân viên'}
    </small>
  </div>
  <nav class="nav flex-column px-2">
    <a href="/dyleeseafood/admin/dashboard" class="nav-link">
      <i class="bi bi-speedometer2 me-2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products" class="nav-link">
      <i class="bi bi-box-seam me-2"></i> Sản phẩm
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/categories" class="nav-link">
        <i class="bi bi-grid me-2"></i> Danh mục
      </a>
      <a href="/dyleeseafood/admin/orders"
         class="nav-link active">
        <i class="bi bi-cart-check me-2"></i> Đơn hàng
      </a>
    </c:if>
    <a href="/dyleeseafood/admin/customers" class="nav-link">
      <i class="bi bi-people me-2"></i> Khách hàng
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/staff" class="nav-link">
        <i class="bi bi-person-badge me-2"></i> Nhân viên
      </a>
    </c:if>
    <a href="/dyleeseafood/home" class="nav-link">
      <i class="bi bi-shop me-2"></i> Xem web
    </a>
    <hr style="border-color:rgba(255,255,255,0.15);" class="mx-2">
    <a href="/dyleeseafood/logout" class="nav-link"
       style="color:rgba(255,100,100,0.9)!important;">
      <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
    </a>
  </nav>
</div>

<div class="main-content">

  <div class="d-flex align-items-center gap-3 mb-4">
    <a href="/dyleeseafood/admin/orders"
       class="btn btn-outline-secondary btn-sm">
      ← Quay lại
    </a>
    <div>
      <h4 class="fw-bold mb-0">
        Chi tiết đơn hàng #DL${order.id}
      </h4>
      <small class="text-muted">${order.orderDate}</small>
    </div>
  </div>

  <!-- Timeline trạng thái -->
  <div class="card border-0 shadow-sm p-4 mb-3"
       style="border-radius:16px;">
    <h6 class="fw-bold mb-3">Trạng thái đơn hàng</h6>

    <div class="d-flex align-items-center mb-3">
      <div class="text-center" style="min-width:80px;">
        <div class="step-node done mx-auto mb-1">
          <i class="bi bi-receipt"></i>
        </div>
        <small style="font-size:11px;">Đặt hàng</small>
      </div>
      <div class="step-line ${order.status == 'Confirmed'
           || order.status == 'Processing'
           || order.status == 'Shipping'
           || order.status == 'Delivered'
           ? 'done' : 'todo'}"></div>
      <div class="text-center" style="min-width:80px;">
        <div class="step-node ${order.status == 'Confirmed'
             || order.status == 'Processing'
             || order.status == 'Shipping'
             || order.status == 'Delivered'
             ? 'done' : order.status == 'Pending'
             ? 'current' : 'todo'} mx-auto mb-1">
          <i class="bi bi-check"></i>
        </div>
        <small style="font-size:11px;">Xác nhận</small>
      </div>
      <div class="step-line ${order.status == 'Processing'
           || order.status == 'Shipping'
           || order.status == 'Delivered'
           ? 'done' : 'todo'}"></div>
      <div class="text-center" style="min-width:80px;">
        <div class="step-node ${order.status == 'Processing'
             || order.status == 'Shipping'
             || order.status == 'Delivered'
             ? 'done' : order.status == 'Confirmed'
             ? 'current' : 'todo'} mx-auto mb-1">
          <i class="bi bi-gear"></i>
        </div>
        <small style="font-size:11px;">Xử lý</small>
      </div>
      <div class="step-line ${order.status == 'Shipping'
           || order.status == 'Delivered'
           ? 'done' : 'todo'}"></div>
      <div class="text-center" style="min-width:80px;">
        <div class="step-node ${order.status == 'Shipping'
             || order.status == 'Delivered'
             ? 'done' : order.status == 'Processing'
             ? 'current' : 'todo'} mx-auto mb-1">
          <i class="bi bi-truck"></i>
        </div>
        <small style="font-size:11px;">Đang giao</small>
      </div>
      <div class="step-line ${order.status == 'Delivered'
           ? 'done' : 'todo'}"></div>
      <div class="text-center" style="min-width:80px;">
        <div class="step-node ${order.status == 'Delivered'
             ? 'done' : order.status == 'Shipping'
             ? 'current' : 'todo'} mx-auto mb-1">
          <i class="bi bi-bag-check"></i>
        </div>
        <small style="font-size:11px;">Hoàn thành</small>
      </div>
    </div>

    <!-- Nút cập nhật -->
    <div class="d-flex gap-2 flex-wrap">
      <c:if test="${order.status == 'Pending'}">
        <form method="post"
              action="/dyleeseafood/admin/orders/${order.id}/status">
          <input type="hidden" name="status" value="Confirmed">
          <button type="submit" class="btn btn-primary btn-sm">
            <i class="bi bi-check-circle"></i> Xác nhận đơn
          </button>
        </form>
        <form method="post"
              action="/dyleeseafood/admin/orders/${order.id}/status">
          <input type="hidden" name="status" value="Cancelled">
          <button type="submit" class="btn btn-danger btn-sm"
                  onclick="return confirm('Hủy đơn hàng này?')">
            <i class="bi bi-x-circle"></i> Hủy đơn
          </button>
        </form>
      </c:if>
      <c:if test="${order.status == 'Confirmed'}">
        <form method="post"
              action="/dyleeseafood/admin/orders/${order.id}/status">
          <input type="hidden" name="status" value="Processing">
          <button type="submit" class="btn btn-info btn-sm">
            <i class="bi bi-gear"></i> Chuyển xử lý
          </button>
        </form>
      </c:if>
      <c:if test="${order.status == 'Processing'}">
        <form method="post"
              action="/dyleeseafood/admin/orders/${order.id}/status">
          <input type="hidden" name="status" value="Shipping">
          <button type="submit" class="btn btn-info btn-sm">
            <i class="bi bi-truck"></i> Bắt đầu giao
          </button>
        </form>
      </c:if>
      <c:if test="${order.status == 'Shipping'}">
        <form method="post"
              action="/dyleeseafood/admin/orders/${order.id}/status">
          <input type="hidden" name="status" value="Delivered">
          <button type="submit" class="btn btn-success btn-sm">
            <i class="bi bi-bag-check"></i> Đã giao xong
          </button>
        </form>
      </c:if>
    </div>
  </div>

  <div class="row g-3">

    <!-- Sản phẩm trong đơn -->
    <div class="col-md-8">
      <div class="card border-0 shadow-sm"
           style="border-radius:16px;">
        <div class="card-header bg-white border-0 pt-3">
          <h6 class="fw-bold">
            <i class="bi bi-box-seam text-primary"></i>
            Sản phẩm đặt hàng
          </h6>
        </div>
        <div class="card-body p-0">
          <c:forEach var="item" items="${items}">
            <div class="d-flex align-items-center gap-3 p-3"
                 style="border-bottom:1px solid #f5f5f5;">
              <img src="${not empty item.imageUrl
                          ? item.imageUrl
                          : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'}"
                   style="width:60px;height:60px;
                          object-fit:cover;border-radius:10px;"
                   onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'"
                   alt="">
              <div style="flex:1;">
                <div class="fw-bold">${item.productName}</div>
                <small class="text-muted">
                  ${item.quantity} ${item.productUnit} ×
                  <fmt:formatNumber value="${item.price}"
                                    pattern="#,###"/>đ
                </small>
              </div>
              <div class="fw-bold" style="color:#0077b6;">
                <fmt:formatNumber value="${item.totalPrice}"
                                  pattern="#,###"/>đ
              </div>
            </div>
          </c:forEach>
        </div>
        <div class="card-footer bg-white border-0">
          <div class="d-flex justify-content-between mb-2">
            <span class="text-muted">Phí vận chuyển</span>
            <span class="text-success fw-bold">Miễn phí</span>
          </div>
          <div class="d-flex justify-content-between"
               style="font-size:1.1rem;">
            <span class="fw-bold">Tổng cộng</span>
            <span class="fw-bold text-danger"
                  style="font-size:1.2rem;">
              <fmt:formatNumber value="${order.total}"
                                pattern="#,###"/>đ
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- Thông tin khách hàng -->
    <div class="col-md-4">
      <div class="card border-0 shadow-sm mb-3"
           style="border-radius:16px;">
        <div class="card-header bg-white border-0 pt-3">
          <h6 class="fw-bold">
            <i class="bi bi-person-circle text-primary"></i>
            Thông tin khách hàng
          </h6>
        </div>
        <div class="card-body">
          <div class="mb-2">
            <small class="text-muted">Họ tên</small>
            <div class="fw-bold">${order.customerName}</div>
          </div>
          <div class="mb-2">
            <small class="text-muted">Điện thoại</small>
            <div class="fw-bold">${order.customerPhone}</div>
          </div>
          <div class="mb-2">
            <small class="text-muted">Phương thức TT</small>
            <div class="fw-bold">
              <c:choose>
                <c:when test="${order.paymentMethod == 'COD'}">
                  💵 Tiền mặt (COD)
                </c:when>
                <c:when test="${order.paymentMethod == 'bank_transfer'}">
                  🏦 Chuyển khoản
                </c:when>
                <c:when test="${order.paymentMethod == 'momo'}">
                  💜 MoMo
                </c:when>
                <c:when test="${order.paymentMethod == 'vnpay'}">
                  📱 VNPay
                </c:when>
                <c:otherwise>
                  ${order.paymentMethod}
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:if test="${not empty order.note}">
            <div>
              <small class="text-muted">Ghi chú</small>
              <div class="p-2 bg-light rounded-3 mt-1"
                   style="font-size:13px;">
                ${order.note}
              </div>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Trạng thái hiện tại -->
      <div class="card border-0 shadow-sm"
           style="border-radius:16px;">
        <div class="card-body text-center py-4">
          <c:choose>
            <c:when test="${order.status == 'Pending'}">
              <i class="bi bi-clock text-warning"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-warning">
                Chờ xác nhận
              </h6>
            </c:when>
            <c:when test="${order.status == 'Confirmed'}">
              <i class="bi bi-check-circle text-primary"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-primary">
                Đã xác nhận
              </h6>
            </c:when>
            <c:when test="${order.status == 'Processing'}">
              <i class="bi bi-gear text-info"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-info">
                Đang xử lý
              </h6>
            </c:when>
            <c:when test="${order.status == 'Shipping'}">
              <i class="bi bi-truck text-info"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-info">
                Đang giao hàng
              </h6>
            </c:when>
            <c:when test="${order.status == 'Delivered'}">
              <i class="bi bi-bag-check text-success"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-success">
                Đã giao thành công
              </h6>
            </c:when>
            <c:when test="${order.status == 'Cancelled'}">
              <i class="bi bi-x-circle text-danger"
                 style="font-size:2.5rem;"></i>
              <h6 class="fw-bold mt-2 text-danger">
                Đã hủy
              </h6>
            </c:when>
          </c:choose>
          <small class="text-muted">#DL${order.id}</small>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>