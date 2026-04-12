<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-7">
      <div class="card border-0 shadow-sm text-center p-5"
           style="border-radius:20px;">

        <!-- Icon thành công -->
        <div style="width:80px;height:80px;
                    background:#e8f5e9;border-radius:50%;
                    margin:0 auto 20px;display:flex;
                    align-items:center;justify-content:center;">
          <i class="bi bi-check-circle-fill text-success"
             style="font-size:2.5rem;"></i>
        </div>

        <h3 class="fw-bold text-success mb-2">
          Đặt hàng thành công!
        </h3>
        <p class="text-muted mb-4">
          Cảm ơn bạn đã mua hàng tại Dylee Seafood.
          Chúng tôi sẽ liên hệ xác nhận sớm nhất!
        </p>

        <!-- Thông tin đơn hàng -->
        <div class="p-4 bg-light rounded-3 mb-4 text-start">
          <div class="d-flex justify-content-between mb-2">
            <span class="text-muted">Mã đơn hàng:</span>
            <span class="fw-bold text-primary">
              #DL${order.id}
            </span>
          </div>
          <div class="d-flex justify-content-between mb-2">
            <span class="text-muted">Tổng tiền:</span>
            <span class="fw-bold text-danger">
              <fmt:formatNumber value="${order.total}"
                                pattern="#,###"/>đ
            </span>
          </div>
          <div class="d-flex justify-content-between mb-2">
            <span class="text-muted">Thanh toán:</span>
            <span class="fw-bold">
              <c:choose>
                <c:when test="${order.paymentMethod == 'COD'}">
                  <i class="bi bi-cash text-success"></i>
                  Tiền mặt (COD)
                </c:when>
                <c:when test="${order.paymentMethod == 'bank_transfer'}">
                  <i class="bi bi-bank text-primary"></i>
                  Chuyển khoản
                </c:when>
                <c:when test="${order.paymentMethod == 'momo'}">
                  <i class="bi bi-phone text-danger"></i>
                  MoMo
                </c:when>
                <c:when test="${order.paymentMethod == 'vnpay'}">
                  <i class="bi bi-qr-code text-primary"></i>
                  VNPay
                </c:when>
                <c:when test="${order.paymentMethod == 'zalopay'}">
                  <i class="bi bi-wallet2"
                     style="color:#00b14f;"></i>
                  ZaloPay
                </c:when>
                <c:otherwise>
                  ${order.paymentMethod}
                </c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="d-flex justify-content-between mb-2">
            <span class="text-muted">Ngày đặt:</span>
            <span class="fw-bold">${order.orderDate}</span>
          </div>
          <div class="d-flex justify-content-between">
            <span class="text-muted">Trạng thái:</span>
            <span class="badge bg-warning text-dark">
              ⏳ Chờ xác nhận
            </span>
          </div>
        </div>

        <!-- Sản phẩm đã đặt -->
        <c:if test="${not empty items}">
          <div class="text-start mb-4">
            <h6 class="fw-bold mb-3">
              <i class="bi bi-box-seam text-primary me-2"></i>
              Sản phẩm đã đặt
            </h6>
            <c:forEach var="item" items="${items}">
              <div class="d-flex align-items-center
                          gap-3 py-2"
                   style="border-bottom:1px solid #f0f0f0;">
                <div>
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
                <div class="ms-auto fw-bold"
                     style="color:#0077b6;
                            white-space:nowrap;">
                  <fmt:formatNumber value="${item.totalPrice}"
                                    pattern="#,###"/>đ
                </div>
              </div>
            </c:forEach>
            <div class="d-flex justify-content-between
                        fw-bold mt-2 pt-2"
                 style="font-size:15px;">
              <span>Tổng cộng:</span>
              <span class="text-danger">
                <fmt:formatNumber value="${order.total}"
                                  pattern="#,###"/>đ
              </span>
            </div>
          </div>
        </c:if>

        <!-- Thông tin giao hàng -->
        <div class="p-3 border rounded-3 mb-4 text-start"
             style="border-color:#0077b6 !important;">
          <h6 class="fw-bold mb-2 text-primary">
            <i class="bi bi-truck"></i>
            Thông tin giao hàng
          </h6>
          <small class="text-muted">
            <i class="bi bi-clock me-1"></i>
            Dự kiến giao trong
            <strong>2 giờ</strong>
            kể từ khi xác nhận đơn<br>
            <i class="bi bi-telephone me-1"></i>
            Chúng tôi sẽ gọi điện xác nhận trước khi giao
          </small>
        </div>

        <!-- Nút -->
        <div class="d-flex gap-3 flex-wrap">
          <a href="/dyleeseafood/order/tracking/${order.id}"
             class="btn btn-outline-primary flex-fill py-2">
            <i class="bi bi-geo-alt"></i>
            Theo dõi đơn hàng
          </a>
          <a href="/dyleeseafood/order/history"
             class="btn btn-outline-secondary flex-fill py-2">
            <i class="bi bi-clock-history"></i>
            Lịch sử đơn hàng
          </a>
        </div>
        <div class="d-flex gap-3 flex-wrap mt-2">
          <a href="/dyleeseafood/home"
             class="btn btn-primary flex-fill py-2">
            <i class="bi bi-house"></i> Về trang chủ
          </a>
          <a href="/dyleeseafood/products"
             class="btn btn-outline-primary flex-fill py-2">
            <i class="bi bi-shop"></i> Mua tiếp
          </a>
        </div>

      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
