<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .history-hero {
    background:linear-gradient(135deg,#023e8a 0%,#0077b6 100%);
    padding:40px 0 60px;
    margin-bottom:-40px;
  }
  .order-card {
    background:white; border-radius:16px;
    border:1px solid #edf0f5; overflow:hidden;
    transition:transform 0.2s, box-shadow 0.2s;
    margin-bottom:16px;
  }
  .order-card:hover {
    transform:translateY(-2px);
    box-shadow:0 8px 24px rgba(0,0,0,0.08);
  }
  .order-header {
    padding:16px 20px;
    border-bottom:1px solid #f0f2f5;
    display:flex; align-items:center;
    justify-content:space-between;
    flex-wrap:wrap; gap:10px;
  }
  .order-id { font-weight:700; color:#0077b6; font-size:15px; }
  .order-date { color:#8a9ab0; font-size:13px; }
  .order-body { padding:16px 20px; }
  .order-item {
    display:flex; align-items:center; gap:12px;
    padding:8px 0; border-bottom:1px solid #f7f9fc;
  }
  .order-item:last-child { border:none; }
  .order-item img {
    width:48px; height:48px; object-fit:cover;
    border-radius:8px; border:1px solid #edf0f5;
  }
  .order-footer {
    padding:14px 20px; background:#f7f9fc;
    border-top:1px solid #f0f2f5;
    display:flex; align-items:center;
    justify-content:space-between;
    flex-wrap:wrap; gap:10px;
  }
  .status-badge {
    display:inline-flex; align-items:center; gap:6px;
    padding:5px 12px; border-radius:20px;
    font-size:12px; font-weight:600;
  }
  .status-dot { width:7px; height:7px; border-radius:50%; }
  .empty-state {
    text-align:center; padding:60px 20px; color:#8a9ab0;
  }
  .filter-tab {
    padding:7px 16px; border-radius:20px;
    border:1px solid #dde3ed; background:white;
    font-size:13px; cursor:pointer; color:#4a5568;
    text-decoration:none; transition:0.15s; font-weight:500;
  }
  .filter-tab:hover, .filter-tab.active {
    background:#023e8a; color:white; border-color:#023e8a;
  }
  @keyframes pulse {
    0%, 100% { opacity:1; }
    50% { opacity:0.4; }
  }
</style>

<!-- HERO -->
<div class="history-hero">
  <div class="container">
    <div class="d-flex align-items-center gap-3">
      <a href="/dyleeseafood/home"
         class="text-white-50 text-decoration-none">
        <i class="bi bi-house"></i>
      </a>
      <span class="text-white-50">/</span>
      <span class="text-white fw-bold">Lịch sử mua hàng</span>
    </div>
    <h2 class="text-white fw-bold mt-3 mb-1">
      📋 Lịch sử đơn hàng
    </h2>
    <p style="color:rgba(255,255,255,0.7);font-size:14px;">
      Xem lại tất cả đơn hàng đã đặt
    </p>
  </div>
</div>

<div class="container pb-5">
  <div class="row g-4">

    <!-- CỘT TRÁI -->
    <div class="col-md-3">
      <div style="position:sticky;top:80px;">

        <!-- Thẻ thành viên -->
        <div class="card border-0 shadow-sm mb-3"
             style="border-radius:16px;overflow:hidden;">
          <div style="background:linear-gradient(
                        135deg,#023e8a,#0077b6);
                      padding:20px;">
            <div style="width:52px;height:52px;
                        border-radius:50%;
                        background:rgba(255,255,255,0.2);
                        display:flex;align-items:center;
                        justify-content:center;
                        font-size:22px;font-weight:700;
                        color:white;margin-bottom:12px;">
              ${sessionScope.loggedCustomer.name.substring(0,1)}
            </div>
            <div class="text-white fw-bold"
                 style="font-size:15px;">
              ${sessionScope.loggedCustomer.name}
            </div>
            <small style="color:rgba(255,255,255,0.7);">
              @${sessionScope.loggedUser.username}
            </small>
          </div>
          <div class="p-3">
            <c:choose>
              <c:when test="${sessionScope.loggedCustomer.tierId==3}">
                <span class="badge px-3 py-2 w-100 text-center"
                      style="background:#fef0f0;
                             color:#c62828;font-size:13px;">
                  👑 Khách hàng VVIP
                </span>
              </c:when>
              <c:when test="${sessionScope.loggedCustomer.tierId==2}">
                <span class="badge px-3 py-2 w-100 text-center"
                      style="background:#fff8e6;
                             color:#e65100;font-size:13px;">
                  ⭐ Khách hàng VIP
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge px-3 py-2 w-100 text-center"
                      style="background:#f5f5f5;
                             color:#616161;font-size:13px;">
                  🎫 Thành viên thường
                </span>
              </c:otherwise>
            </c:choose>
            <div class="mt-3 pt-3"
                 style="border-top:1px solid #f0f2f5;">
              <div class="d-flex justify-content-between mb-1">
                <small class="text-muted">Tổng đơn hàng</small>
                <small class="fw-bold">${orders.size()}</small>
              </div>
              <div class="d-flex justify-content-between">
                <small class="text-muted">Tổng chi tiêu</small>
                <small class="fw-bold"
                       style="color:#0077b6;">
                  <fmt:formatNumber
                     value="${sessionScope.loggedCustomer.totalSpent}"
                     pattern="#,###"/>đ
                </small>
              </div>
            </div>
          </div>
        </div>

        <!-- Menu -->
        <div class="card border-0 shadow-sm"
             style="border-radius:16px;">
          <div class="list-group list-group-flush"
               style="border-radius:16px;overflow:hidden;">
            <a href="/dyleeseafood/order/history"
               class="list-group-item list-group-item-action
                      py-3 px-4 active"
               style="font-size:13px;font-weight:500;">
              <i class="bi bi-clock-history me-2"></i>
              Lịch sử đơn hàng
            </a>
            <a href="/dyleeseafood/home"
               class="list-group-item list-group-item-action
                      py-3 px-4"
               style="font-size:13px;">
              <i class="bi bi-shop me-2"></i>
              Tiếp tục mua sắm
            </a>
          </div>
        </div>

      </div>
    </div>

    <!-- CỘT PHẢI: Danh sách đơn hàng -->
    <div class="col-md-9">

      <!-- Filter tabs -->
      <div class="d-flex gap-2 flex-wrap mb-4">
        <a href="/dyleeseafood/order/history"
           class="filter-tab
             ${empty statusFilter ? 'active' : ''}">
          Tất cả
        </a>
        <a href="/dyleeseafood/order/history?status=Pending"
           class="filter-tab
             ${statusFilter=='Pending'?'active':''}">
          ⏳ Chờ xác nhận
        </a>
        <a href="/dyleeseafood/order/history?status=Confirmed"
           class="filter-tab
             ${statusFilter=='Confirmed'?'active':''}">
          ✅ Đã xác nhận
        </a>
        <a href="/dyleeseafood/order/history?status=Processing"
           class="filter-tab
             ${statusFilter=='Processing'?'active':''}">
          ⚙️ Đang xử lý
        </a>
        <a href="/dyleeseafood/order/history?status=Shipping"
           class="filter-tab
             ${statusFilter=='Shipping'?'active':''}">
          🚚 Đang giao
        </a>
        <a href="/dyleeseafood/order/history?status=Delivered"
           class="filter-tab
             ${statusFilter=='Delivered'?'active':''}">
          📦 Đã giao
        </a>
        <a href="/dyleeseafood/order/history?status=Cancelled"
           class="filter-tab
             ${statusFilter=='Cancelled'?'active':''}">
          ❌ Đã hủy
        </a>
      </div>

      <!-- Danh sách đơn hàng -->
      <c:choose>
        <c:when test="${empty orders}">
          <div class="empty-state card border-0 shadow-sm"
               style="border-radius:16px;">
            <i class="bi bi-bag-x"
               style="font-size:4rem;color:#dde3ed;"></i>
            <h5 class="mt-3 fw-bold" style="color:#4a5568;">
              Chưa có đơn hàng nào
            </h5>
            <p style="color:#8a9ab0;font-size:14px;">
              Hãy mua sắm để tạo đơn hàng đầu tiên!
            </p>
            <a href="/dyleeseafood/products"
               class="btn btn-primary px-4 mt-2">
              <i class="bi bi-bag-plus"></i> Mua ngay
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="order" items="${orders}">
            <div class="order-card">

              <!-- Header -->
              <div class="order-header">
                <div>
                  <div class="order-id">
                    #DL${order.id}
                  </div>
                  <div class="order-date">
                    <i class="bi bi-calendar3 me-1"></i>
                    ${order.orderDate}
                  </div>
                </div>
                <div class="d-flex align-items-center gap-2">
                  <c:choose>
                    <c:when test="${order.status=='Pending'}">
                      <span class="status-badge"
                            style="background:#fff8e6;
                                   color:#e65100;">
                        <span class="status-dot"
                              style="background:#e65100;">
                        </span>Chờ xác nhận
                      </span>
                    </c:when>
                    <c:when test="${order.status=='Confirmed'}">
                      <span class="status-badge"
                            style="background:#e8f4fd;
                                   color:#0077b6;">
                        <span class="status-dot"
                              style="background:#0077b6;">
                        </span>Đã xác nhận
                      </span>
                    </c:when>
                    <c:when test="${order.status=='Processing'}">
                      <span class="status-badge"
                            style="background:#e3f2fd;
                                   color:#1565c0;">
                        <span class="status-dot"
                              style="background:#1565c0;">
                        </span>Đang xử lý
                      </span>
                    </c:when>
                    <c:when test="${order.status=='Shipping'}">
                      <span class="status-badge"
                            style="background:#e8f5e9;
                                   color:#2e7d32;">
                        <span class="status-dot"
                              style="background:#2e7d32;
                                     animation:pulse 1s infinite;">
                        </span>Đang giao hàng
                      </span>
                    </c:when>
                    <c:when test="${order.status=='Delivered'}">
                      <span class="status-badge"
                            style="background:#e8f5e9;
                                   color:#1b5e20;">
                        <span class="status-dot"
                              style="background:#1b5e20;">
                        </span>Đã giao thành công
                      </span>
                    </c:when>
                    <c:when test="${order.status=='Cancelled'}">
                      <span class="status-badge"
                            style="background:#fef0f0;
                                   color:#c62828;">
                        <span class="status-dot"
                              style="background:#c62828;">
                        </span>Đã hủy
                      </span>
                    </c:when>
                  </c:choose>
                  <a href="/dyleeseafood/order/tracking/${order.id}"
                     class="btn btn-sm btn-outline-primary"
                     style="font-size:12px;border-radius:8px;">
                    <i class="bi bi-geo-alt"></i> Theo dõi
                  </a>
                </div>
              </div>

              <!-- Sản phẩm -->
              <div class="order-body">
                <c:forEach var="item" items="${order.items}">
                  <div class="order-item">
                    <img src="${not empty item.imageUrl
                                ? item.imageUrl
                                : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80'}"
                         onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80'"
                         alt="${item.productName}">
                    <div style="flex:1;">
                      <div class="fw-bold"
                           style="font-size:13.5px;">
                        ${item.productName}
                      </div>
                      <small class="text-muted">
                        <fmt:formatNumber value="${item.quantity}"
                                          pattern="#.##"/>
                        ${item.productUnit} ×
                        <fmt:formatNumber value="${item.price}"
                                          pattern="#,###"/>đ
                      </small>
                    </div>
                    <div class="fw-bold"
                         style="color:#0077b6;font-size:13.5px;">
                      <fmt:formatNumber value="${item.totalPrice}"
                                        pattern="#,###"/>đ
                    </div>
                  </div>
                </c:forEach>
              </div>

              <!-- Footer -->
              <div class="order-footer">
                <div style="font-size:13px;color:#8a9ab0;">
                  <i class="bi bi-credit-card me-1"></i>
                  <c:choose>
                    <c:when test="${order.paymentMethod=='COD'}">
                      Tiền mặt (COD)
                    </c:when>
                    <c:when test="${order.paymentMethod=='bank_transfer'}">
                      Chuyển khoản
                    </c:when>
                    <c:when test="${order.paymentMethod=='momo'}">
                      Ví MoMo
                    </c:when>
                    <c:when test="${order.paymentMethod=='vnpay'}">
                      VNPay
                    </c:when>
                    <c:when test="${order.paymentMethod=='zalopay'}">
                      ZaloPay
                    </c:when>
                    <c:otherwise>
                      ${order.paymentMethod}
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="d-flex align-items-center gap-3">
                  <span style="font-size:13px;color:#4a5568;">
                    Tổng cộng:
                  </span>
                  <span class="fw-bold"
                        style="color:#e63946;font-size:17px;">
                    <fmt:formatNumber value="${order.total}"
                                      pattern="#,###"/>đ
                  </span>
                </div>
              </div>

            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
