<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .tracking-hero {
    background: linear-gradient(135deg, #023e8a 0%, #0077b6 100%);
    padding: 40px 0 70px;
    margin-bottom: -50px;
  }
  .tracking-card {
    background: white;
    border-radius: 20px;
    border: 1px solid #edf0f5;
    box-shadow: 0 4px 24px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 20px;
  }
  .tracking-card .card-header-custom {
    padding: 20px 24px;
    border-bottom: 1px solid #f0f2f5;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .timeline-wrap { padding: 32px 24px; }
  .timeline {
    position: relative;
    padding: 0; margin: 0; list-style: none;
  }
  .timeline::before {
    content: '';
    position: absolute;
    left: 19px; top: 0; bottom: 0;
    width: 2px; background: #edf0f5; z-index: 0;
  }
  .tl-item {
    display: flex; align-items: flex-start;
    gap: 16px; margin-bottom: 28px;
    position: relative; z-index: 1;
  }
  .tl-item:last-child { margin-bottom: 0; }
  .tl-dot {
    width: 40px; height: 40px; border-radius: 50%;
    display: flex; align-items: center;
    justify-content: center;
    font-size: 16px; flex-shrink: 0;
    position: relative; z-index: 2; transition: all 0.3s;
  }
  .tl-dot.done {
    background: #023e8a; color: white;
    box-shadow: 0 0 0 4px rgba(2,62,138,0.15);
  }
  .tl-dot.current {
    background: #0077b6; color: white;
    box-shadow: 0 0 0 4px rgba(0,119,182,0.2);
    animation: glow 2s ease-in-out infinite;
  }
  .tl-dot.todo {
    background: #f0f2f5; color: #adb5bd;
    border: 2px dashed #dde3ed;
  }
  .tl-content { flex: 1; padding-top: 8px; }
  .tl-title { font-weight: 600; font-size: 14px; margin-bottom: 3px; }
  .tl-title.done    { color: #023e8a; }
  .tl-title.current { color: #0077b6; }
  .tl-title.todo    { color: #adb5bd; }
  .tl-desc { font-size: 12px; color: #8a9ab0; line-height: 1.5; }
  .tl-time { font-size: 11px; color: #0077b6; font-weight: 500; margin-top: 3px; }
  @keyframes glow {
    0%,100% { box-shadow: 0 0 0 4px rgba(0,119,182,0.15); }
    50%      { box-shadow: 0 0 0 8px rgba(0,119,182,0.1); }
  }
  .product-row {
    display: flex; align-items: center; gap: 14px;
    padding: 12px 0; border-bottom: 1px solid #f7f9fc;
  }
  .product-row:last-child { border: none; }
  .product-row img {
    width: 52px; height: 52px; object-fit: cover;
    border-radius: 10px; border: 1px solid #edf0f5;
  }
  .info-box {
    background: #f7f9fc; border-radius: 12px;
    padding: 14px 16px; margin-bottom: 12px;
  }
  .info-label {
    font-size: 11px; font-weight: 600; color: #8a9ab0;
    text-transform: uppercase; letter-spacing: 0.06em;
    margin-bottom: 4px;
  }
  .info-value { font-size: 13.5px; font-weight: 500; color: #1a2035; }
</style>

<!-- HERO -->
<div class="tracking-hero">
  <div class="container">
    <div class="mb-3">
      <a href="/dyleeseafood/order/history"
         class="text-white-50 text-decoration-none"
         style="font-size:13px;">
        <i class="bi bi-arrow-left me-1"></i>
        Lịch sử đơn hàng
      </a>
    </div>
    <h2 class="text-white fw-bold mb-1">
      🚚 Theo dõi đơn hàng
    </h2>
    <p style="color:rgba(255,255,255,0.7);font-size:14px;">
      Mã đơn hàng:
      <strong class="text-white">#DL${order.id}</strong>
    </p>
  </div>
</div>

<div class="container pb-5">
  <div class="row g-4">

    <!-- CỘT TRÁI: Timeline -->
    <div class="col-md-7">
      <div class="tracking-card">
        <div class="card-header-custom">
          <div>
            <h6 class="fw-bold mb-0">Trạng thái đơn hàng</h6>
            <small class="text-muted">Cập nhật realtime</small>
          </div>
          <c:choose>
            <c:when test="${order.status == 'Delivered'}">
              <span class="badge px-3 py-2"
                    style="background:#e8f5e9;color:#1b5e20;
                           font-size:13px;border-radius:20px;">
                ✅ Đã giao thành công
              </span>
            </c:when>
            <c:when test="${order.status == 'Shipping'}">
              <span class="badge px-3 py-2"
                    style="background:#e3f2fd;color:#1565c0;
                           font-size:13px;border-radius:20px;">
                🚚 Đang giao hàng
              </span>
            </c:when>
            <c:when test="${order.status == 'Processing'}">
              <span class="badge px-3 py-2"
                    style="background:#e8f4fd;color:#0077b6;
                           font-size:13px;border-radius:20px;">
                ⚙️ Đang xử lý
              </span>
            </c:when>
            <c:when test="${order.status == 'Confirmed'}">
              <span class="badge px-3 py-2"
                    style="background:#e8f4fd;color:#0077b6;
                           font-size:13px;border-radius:20px;">
                ✔️ Đã xác nhận
              </span>
            </c:when>
            <c:when test="${order.status == 'Cancelled'}">
              <span class="badge px-3 py-2"
                    style="background:#fef0f0;color:#c62828;
                           font-size:13px;border-radius:20px;">
                ❌ Đã hủy
              </span>
            </c:when>
            <c:otherwise>
              <span class="badge px-3 py-2"
                    style="background:#fff8e6;color:#e65100;
                           font-size:13px;border-radius:20px;">
                ⏳ Chờ xác nhận
              </span>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="timeline-wrap">
          <ul class="timeline">

            <!-- Bước 1: Đặt hàng — luôn done -->
            <li class="tl-item">
              <div class="tl-dot done">
                <i class="bi bi-receipt"></i>
              </div>
              <div class="tl-content">
                <div class="tl-title done">
                  Đặt hàng thành công
                </div>
                <div class="tl-desc">
                  Đơn hàng #DL${order.id} đã được tạo
                </div>
                <div class="tl-time">${order.orderDate}</div>
              </div>
            </li>

            <!-- Bước 2: Xác nhận -->
            <li class="tl-item">
              <c:choose>
                <c:when test="${order.status == 'Confirmed'
                             || order.status == 'Processing'
                             || order.status == 'Shipping'
                             || order.status == 'Delivered'}">
                  <div class="tl-dot done">
                    <i class="bi bi-check-lg"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title done">Đã xác nhận</div>
                    <div class="tl-desc">
                      Cửa hàng đã xác nhận đơn hàng
                    </div>
                  </div>
                </c:when>
                <c:when test="${order.status == 'Pending'}">
                  <div class="tl-dot current">
                    <i class="bi bi-hourglass-split"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title current">
                      Đang chờ xác nhận
                    </div>
                    <div class="tl-desc">
                      Cửa hàng đang xem xét đơn hàng
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="tl-dot todo">
                    <i class="bi bi-check-lg"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title todo">
                      Xác nhận đơn hàng
                    </div>
                    <div class="tl-desc">
                      Chờ cửa hàng xác nhận
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </li>

            <!-- Bước 3: Xử lý -->
            <li class="tl-item">
              <c:choose>
                <c:when test="${order.status == 'Processing'
                             || order.status == 'Shipping'
                             || order.status == 'Delivered'}">
                  <div class="tl-dot done">
                    <i class="bi bi-gear-fill"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title done">Đã xử lý xong</div>
                    <div class="tl-desc">
                      Sản phẩm đã được đóng gói
                    </div>
                  </div>
                </c:when>
                <c:when test="${order.status == 'Confirmed'}">
                  <div class="tl-dot current">
                    <i class="bi bi-gear-fill"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title current">
                      Đang xử lý và đóng gói
                    </div>
                    <div class="tl-desc">
                      Sản phẩm đang được chuẩn bị
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="tl-dot todo">
                    <i class="bi bi-gear"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title todo">
                      Xử lý và đóng gói
                    </div>
                    <div class="tl-desc">
                      Chuẩn bị hàng hóa
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </li>

            <!-- Bước 4: Giao hàng -->
            <li class="tl-item">
              <c:choose>
                <c:when test="${order.status == 'Delivered'}">
                  <div class="tl-dot done">
                    <i class="bi bi-truck"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title done">
                      Đã giao cho shipper
                    </div>
                    <div class="tl-desc">
                      Đơn hàng đã được giao thành công
                    </div>
                  </div>
                </c:when>
                <c:when test="${order.status == 'Shipping'}">
                  <div class="tl-dot current">
                    <i class="bi bi-truck"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title current">
                      Đang trên đường giao
                    </div>
                    <div class="tl-desc">
                      Shipper đang giao hàng đến bạn
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="tl-dot todo">
                    <i class="bi bi-truck"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title todo">Giao hàng</div>
                    <div class="tl-desc">
                      Đang chờ bàn giao cho shipper
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </li>

            <!-- Bước 5: Hoàn thành -->
            <li class="tl-item">
              <c:choose>
                <c:when test="${order.status == 'Delivered'}">
                  <div class="tl-dot done"
                       style="background:#1b5e20;">
                    <i class="bi bi-bag-check-fill"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title done">
                      Giao hàng thành công 🎉
                    </div>
                    <div class="tl-desc">
                      Cảm ơn bạn đã mua hàng tại Dylee!
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="tl-dot todo">
                    <i class="bi bi-bag-check"></i>
                  </div>
                  <div class="tl-content">
                    <div class="tl-title todo">
                      Giao hàng thành công
                    </div>
                    <div class="tl-desc">
                      Nhận hàng và hoàn tất
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </li>

          </ul>
        </div>
      </div>
    </div>

    <!-- CỘT PHẢI -->
    <div class="col-md-5">

      <!-- Sản phẩm -->
      <div class="tracking-card">
        <div class="card-header-custom">
          <h6 class="fw-bold mb-0">
            <i class="bi bi-box-seam text-primary me-2"></i>
            Sản phẩm đặt hàng
          </h6>
        </div>
        <div class="p-4">
          <c:forEach var="item" items="${items}">
            <div class="product-row">
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
                  SL:
                  <fmt:formatNumber value="${item.quantity}"
                                    pattern="#.##"/>
                  ${item.productUnit}
                </small>
              </div>
              <div class="fw-bold"
                   style="color:#0077b6;font-size:13.5px;">
                <fmt:formatNumber value="${item.totalPrice}"
                                  pattern="#,###"/>đ
              </div>
            </div>
          </c:forEach>

          <div class="d-flex justify-content-between
                      mt-3 pt-3"
               style="border-top:1px solid #f0f2f5;">
            <span class="text-muted">Phí vận chuyển</span>
            <span class="text-success fw-bold">Miễn phí</span>
          </div>
          <div class="d-flex justify-content-between mt-2">
            <span class="fw-bold">Tổng cộng</span>
            <span class="fw-bold"
                  style="color:#e63946;font-size:17px;">
              <fmt:formatNumber value="${order.total}"
                                pattern="#,###"/>đ
            </span>
          </div>
        </div>
      </div>

      <!-- Thông tin giao hàng -->
      <div class="tracking-card">
        <div class="card-header-custom">
          <h6 class="fw-bold mb-0">
            <i class="bi bi-geo-alt text-primary me-2"></i>
            Thông tin giao hàng
          </h6>
        </div>
        <div class="p-4">
          <div class="info-box">
            <div class="info-label">Người nhận</div>
            <div class="info-value">
              ${order.customerName}
            </div>
          </div>
          <div class="info-box">
            <div class="info-label">Số điện thoại</div>
            <div class="info-value">
              ${order.customerPhone}
            </div>
          </div>
          <div class="info-box">
            <div class="info-label">
              Phương thức thanh toán
            </div>
            <div class="info-value">
              <c:choose>
                <c:when test="${order.paymentMethod == 'COD'}">
                  💵 Thanh toán khi nhận hàng
                </c:when>
                <c:when test="${order.paymentMethod == 'bank_transfer'}">
                  🏦 Chuyển khoản ngân hàng
                </c:when>
                <c:when test="${order.paymentMethod == 'momo'}">
                  💜 Ví MoMo
                </c:when>
                <c:when test="${order.paymentMethod == 'vnpay'}">
                  📱 VNPay
                </c:when>
                <c:when test="${order.paymentMethod == 'zalopay'}">
                  🟢 ZaloPay
                </c:when>
                <c:otherwise>
                  ${order.paymentMethod}
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:if test="${not empty order.note}">
            <div class="info-box">
              <div class="info-label">Ghi chú</div>
              <div class="info-value">${order.note}</div>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Nút -->
      <div class="d-flex gap-2 flex-wrap">
        <a href="/dyleeseafood/order/history"
           class="btn btn-outline-secondary flex-fill">
          <i class="bi bi-arrow-left"></i> Quay lại
        </a>
        <a href="/dyleeseafood/products"
           class="btn btn-primary flex-fill">
          <i class="bi bi-bag-plus"></i> Mua thêm
        </a>
        <c:if test="${order.status=='Pending'}">
          <button type="button"
                  onclick="document.getElementById('cancelBox').style.display='flex'"
                  class="btn flex-fill"
                  style="background:#fff0f0;color:#dc2626;border:1.5px solid #fca5a5;font-weight:600;">
            <i class="bi bi-x-circle me-1"></i>Hủy đơn
          </button>
        </c:if>
      </div>

    </div>
  </div>
</div>


<!-- TOAST -->
<c:if test="${not empty cancelError}">
<div style="position:fixed;bottom:24px;right:24px;background:#fef2f2;
            color:#dc2626;border:1px solid #fecaca;border-radius:12px;
            padding:14px 20px;font-size:13px;font-weight:600;
            display:flex;align-items:center;gap:10px;min-width:260px;
            z-index:9999;box-shadow:0 8px 24px rgba(0,0,0,.1);"
     id="errToast">
  <i class="bi bi-exclamation-circle-fill"></i>${cancelError}
</div>
<script>setTimeout(function(){var t=document.getElementById('errToast');if(t){t.style.opacity='0';t.style.transition='opacity .5s';}},4000);</script>
</c:if>

<!-- MODAL XÁC NHẬN HỦY -->
<div id="cancelBox" style="
    display:none; position:fixed; inset:0;
    background:rgba(0,0,0,.45); backdrop-filter:blur(2px);
    z-index:9998; align-items:center; justify-content:center;">
  <div style="background:white; border-radius:16px; width:100%;
              max-width:380px; padding:28px 24px;
              box-shadow:0 20px 60px rgba(0,0,0,.2); text-align:center;">
    <i class="bi bi-x-circle-fill" style="font-size:3rem;color:#fca5a5;"></i>
    <h5 class="fw-bold mt-3 mb-2" style="color:#0f172a;">Xác nhận hủy đơn?</h5>
    <p style="font-size:13px;color:#64748b;margin-bottom:4px;">
      Đơn hàng <strong style="color:#0077b6;">#DL${order.id}</strong>
    </p>
    <p style="font-size:12px;color:#94a3b8;margin-bottom:20px;">
      Hành động này không thể hoàn tác.
    </p>
    <form method="post" action="/dyleeseafood/order/cancel/${order.id}">
      <div style="display:flex;gap:10px;justify-content:center;">
        <button type="button"
                onclick="document.getElementById('cancelBox').style.display='none'"
                style="background:#f1f5f9;color:#475569;border:1px solid #e5eaf2;
                       border-radius:9px;padding:10px 22px;font-size:13px;
                       font-weight:600;cursor:pointer;">
          Giữ đơn
        </button>
        <button type="submit"
                style="background:#dc2626;color:white;border:none;
                       border-radius:9px;padding:10px 22px;font-size:13px;
                       font-weight:600;cursor:pointer;">
          <i class="bi bi-x-circle me-1"></i>Xác nhận hủy
        </button>
      </div>
    </form>
  </div>
</div>
<script>
document.getElementById('cancelBox').addEventListener('click', function(e){
  if(e.target===this) this.style.display='none';
});
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
