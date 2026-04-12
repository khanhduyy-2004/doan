<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .pay-card {
    border:2px solid #e0e0e0; border-radius:12px;
    padding:16px; cursor:pointer; transition:0.2s;
    margin-bottom:12px;
  }
  .pay-card:hover { border-color:#0077b6; }
  .pay-card.active {
    border-color:#0077b6; background:#f0f8ff;
  }
  .pay-icon {
    width:44px; height:44px; border-radius:10px;
    display:flex; align-items:center;
    justify-content:center; font-size:1.4rem;
    flex-shrink:0;
  }
  .pay-detail {
    display:none; margin-top:14px; padding:14px;
    background:#f8f9fa; border-radius:10px;
    font-size:14px;
  }
  .pay-detail.show { display:block; }
  .check-circle {
    width:20px; height:20px; border-radius:50%;
    border:2px solid #dee2e6; flex-shrink:0;
    display:flex; align-items:center;
    justify-content:center; transition:0.2s;
  }
  .check-circle.checked {
    background:#0077b6; border-color:#0077b6;
  }
  .info-row {
    display:flex; justify-content:space-between;
    align-items:center; padding:6px 0;
    border-bottom:1px solid #f0f0f0;
  }
  .info-row:last-child { border:none; }
  .copy-btn {
    font-size:11px; padding:2px 10px;
    border-radius:20px; border:1px solid #0077b6;
    background:white; color:#0077b6;
    cursor:pointer; transition:0.15s;
  }
  .copy-btn:hover { background:#0077b6; color:white; }
  .copy-btn.copied {
    background:#28a745; border-color:#28a745; color:white;
  }
  .step-bar {
    display:flex; align-items:center;
    margin-bottom:28px;
  }
  .step { display:flex; align-items:center; gap:8px; }
  .step-num {
    width:32px; height:32px; border-radius:50%;
    display:flex; align-items:center;
    justify-content:center; font-weight:700;
    font-size:14px; flex-shrink:0;
  }
  .step-line { flex:1; height:2px; background:#dee2e6; }
  .step-line.done { background:#0077b6; }
</style>

<div class="container mt-4 mb-5">

  <!-- Breadcrumb -->
  <nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/dyleeseafood/home">Trang chủ</a>
      </li>
      <li class="breadcrumb-item">
        <a href="/dyleeseafood/cart">Giỏ hàng</a>
      </li>
      <li class="breadcrumb-item active">Đặt hàng</li>
    </ol>
  </nav>

  <!-- Bước -->
  <div class="step-bar">
    <div class="step">
      <div class="step-num"
           style="background:#6c757d;color:white;">1</div>
      <span class="text-muted" style="font-size:14px;">
        Giỏ hàng
      </span>
    </div>
    <div class="step-line done mx-2"></div>
    <div class="step">
      <div class="step-num"
           style="background:#0077b6;color:white;">2</div>
      <span class="fw-bold"
            style="font-size:14px;color:#0077b6;">
        Đặt hàng
      </span>
    </div>
    <div class="step-line mx-2"></div>
    <div class="step">
      <div class="step-num"
           style="background:#dee2e6;color:#999;">3</div>
      <span class="text-muted" style="font-size:14px;">
        Hoàn thành
      </span>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger mb-3">
      <i class="bi bi-exclamation-circle me-2"></i>
      ${error}
    </div>
  </c:if>

  <form method="post"
        action="/dyleeseafood/order/place"
        id="orderForm">
    <div class="row g-4">

      <!-- CỘT TRÁI -->
      <div class="col-lg-7">

        <!-- THÔNG TIN NGƯỜI NHẬN -->
        <div class="card border-0 shadow-sm mb-3"
             style="border-radius:16px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold">
              <i class="bi bi-person-circle text-primary"></i>
              Thông tin người nhận
            </h6>
          </div>
          <div class="card-body">

            <%-- Hidden: gửi fullName + phone lên server --%>
            <input type="hidden" name="fullName"
                   value="${customer.name}">
            <input type="hidden" name="phone"
                   value="${customer.phone}">

            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-bold">Họ và tên</label>
                <input type="text" class="form-control"
                       value="${customer.name}" readonly
                       style="background:#f8f9fa;">
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold">Số điện thoại</label>
                <input type="text" class="form-control"
                       value="${customer.phone}" readonly
                       style="background:#f8f9fa;">
              </div>
              <div class="col-12">
                <label class="form-label fw-bold">Email</label>
                <input type="text" class="form-control"
                       value="${customer.email}" readonly
                       style="background:#f8f9fa;">
              </div>
              <div class="col-12">
                <label class="form-label fw-bold">
                  Số nhà, tên đường *
                </label>
                <input type="text" name="address"
                       class="form-control"
                       placeholder="VD: 123 Đường Lê Lợi"
                       required>
              </div>
              <div class="col-md-4">
                <label class="form-label fw-bold">Phường/Xã</label>
                <input type="text" name="ward"
                       class="form-control"
                       placeholder="VD: Phường Bến Nghé">
              </div>
              <div class="col-md-4">
                <label class="form-label fw-bold">Quận/Huyện</label>
                <input type="text" name="district"
                       class="form-control"
                       placeholder="VD: Quận 1">
              </div>
              <div class="col-md-4">
                <label class="form-label fw-bold">
                  Tỉnh/Thành phố *
                </label>
                <input type="text" name="city"
                       class="form-control"
                       placeholder="VD: TP. Hồ Chí Minh"
                       required>
              </div>
            </div>
          </div>
        </div>

        <!-- PHƯƠNG THỨC THANH TOÁN -->
        <div class="card border-0 shadow-sm mb-3"
             style="border-radius:16px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold">
              <i class="bi bi-credit-card text-primary"></i>
              Phương thức thanh toán
            </h6>
          </div>
          <div class="card-body">
            <input type="hidden" name="paymentMethod"
                   id="paymentMethod" value="COD">

            <!-- 1. COD -->
            <div class="pay-card active" id="card-cod"
                 onclick="selectPay('cod')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-icon"
                     style="background:#e8f5e9;">💵</div>
                <div style="flex:1;">
                  <div class="fw-bold">Tiền mặt (COD)</div>
                  <small class="text-muted">
                    Thanh toán khi nhận hàng
                  </small>
                </div>
                <div class="check-circle checked" id="chk-cod">
                  <i class="bi bi-check text-white"
                     style="font-size:12px;"></i>
                </div>
              </div>
              <div class="pay-detail show" id="detail-cod">
                <div class="d-flex gap-2 align-items-start">
                  <i class="bi bi-info-circle text-primary mt-1"></i>
                  <div class="text-muted" style="line-height:1.7;">
                    Nhân viên thu tiền mặt khi giao hàng.
                    Chuẩn bị đúng số tiền:
                    <span class="fw-bold text-primary">
                      <fmt:formatNumber value="${total}"
                                        pattern="#,###"/>đ
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <!-- 2. CHUYỂN KHOẢN -->
            <div class="pay-card" id="card-bank"
                 onclick="selectPay('bank')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-icon"
                     style="background:#e3f2fd;">🏦</div>
                <div style="flex:1;">
                  <div class="fw-bold">
                    Chuyển khoản ngân hàng
                  </div>
                  <small class="text-muted">
                    Vietcombank · MB Bank · Techcombank
                  </small>
                </div>
                <div class="check-circle" id="chk-bank"></div>
              </div>
              <div class="pay-detail" id="detail-bank">
                <div class="fw-bold mb-2">
                  <i class="bi bi-bank text-primary"></i>
                  Thông tin chuyển khoản
                </div>
                <div class="info-row">
                  <span class="text-muted">Ngân hàng</span>
                  <span class="fw-bold">Vietcombank</span>
                </div>
                <div class="info-row">
                  <span class="text-muted">Số tài khoản</span>
                  <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold"
                          style="font-family:monospace;">
                      1234 5678 9012
                    </span>
                    <button type="button" class="copy-btn"
                            onclick="copyText(this,'1234567890')">
                      Sao chép
                    </button>
                  </div>
                </div>
                <div class="info-row">
                  <span class="text-muted">Chủ tài khoản</span>
                  <span class="fw-bold">DYLEE SEAFOOD</span>
                </div>
                <div class="info-row">
                  <span class="text-muted">Số tiền</span>
                  <span class="fw-bold text-primary">
                    <fmt:formatNumber value="${total}"
                                      pattern="#,###"/>đ
                  </span>
                </div>
                <div class="alert alert-warning py-2 mt-2 mb-0"
                     style="font-size:12px;">
                  <i class="bi bi-exclamation-triangle"></i>
                  Nội dung CK:
                  <strong>
                    DYLEE ${sessionScope.loggedUser.username}
                  </strong>
                </div>
              </div>
            </div>

            <!-- 3. MOMO -->
            <div class="pay-card" id="card-momo"
                 onclick="selectPay('momo')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-icon"
                     style="background:#fce4ec;">💜</div>
                <div style="flex:1;">
                  <div class="fw-bold">Ví MoMo</div>
                  <small class="text-muted">
                    Thanh toán qua ứng dụng MoMo
                  </small>
                </div>
                <div class="check-circle" id="chk-momo"></div>
              </div>
              <div class="pay-detail" id="detail-momo">
                <div class="info-row">
                  <span class="text-muted">Số điện thoại</span>
                  <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold">0909 999 888</span>
                    <button type="button" class="copy-btn"
                            onclick="copyText(this,'0909999888')">
                      Sao chép
                    </button>
                  </div>
                </div>
                <div class="info-row">
                  <span class="text-muted">Tên tài khoản</span>
                  <span class="fw-bold">DYLEE SEAFOOD</span>
                </div>
                <div class="info-row">
                  <span class="text-muted">Số tiền</span>
                  <span class="fw-bold text-danger">
                    <fmt:formatNumber value="${total}"
                                      pattern="#,###"/>đ
                  </span>
                </div>
              </div>
            </div>

            <!-- 4. VNPAY -->
            <div class="pay-card" id="card-vnpay"
                 onclick="selectPay('vnpay')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-icon"
                     style="background:#e8f4fd;">📱</div>
                <div style="flex:1;">
                  <div class="fw-bold">VNPay</div>
                  <small class="text-muted">
                    Thanh toán qua ứng dụng VNPay
                  </small>
                </div>
                <div class="check-circle" id="chk-vnpay"></div>
              </div>
              <div class="pay-detail" id="detail-vnpay">
                <div class="info-row">
                  <span class="text-muted">Số tiền</span>
                  <span class="fw-bold text-primary">
                    <fmt:formatNumber value="${total}"
                                      pattern="#,###"/>đ
                  </span>
                </div>
                <div class="alert alert-info py-2 mt-2 mb-0"
                     style="font-size:12px;">
                  <i class="bi bi-info-circle"></i>
                  Mở app VNPay → QR Code → Quét mã thanh toán
                </div>
              </div>
            </div>

            <!-- 5. ZALOPAY -->
            <div class="pay-card" id="card-zalopay"
                 onclick="selectPay('zalopay')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-icon"
                     style="background:#e8f5e9;">🟢</div>
                <div style="flex:1;">
                  <div class="fw-bold">ZaloPay</div>
                  <small class="text-muted">
                    Thanh toán qua ứng dụng ZaloPay
                  </small>
                </div>
                <div class="check-circle" id="chk-zalopay"></div>
              </div>
              <div class="pay-detail" id="detail-zalopay">
                <div class="info-row">
                  <span class="text-muted">Số tiền</span>
                  <span class="fw-bold"
                        style="color:#00b14f;">
                    <fmt:formatNumber value="${total}"
                                      pattern="#,###"/>đ
                  </span>
                </div>
                <div class="alert alert-success py-2 mt-2 mb-0"
                     style="font-size:12px;">
                  <i class="bi bi-info-circle"></i>
                  Mở app ZaloPay → Quét QR → Xác nhận
                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- GHI CHÚ -->
        <div class="card border-0 shadow-sm"
             style="border-radius:16px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold">
              <i class="bi bi-chat-text text-primary"></i>
              Ghi chú đơn hàng
            </h6>
          </div>
          <div class="card-body">
            <textarea name="note" class="form-control"
                      rows="3"
                      placeholder="Ghi chú cho người giao hàng...">
            </textarea>
          </div>
        </div>

      </div>

      <!-- CỘT PHẢI: TÓM TẮT -->
      <div class="col-lg-5">
        <div class="card border-0 shadow-sm"
             style="border-radius:16px;
                    position:sticky;top:80px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold">
              <i class="bi bi-receipt text-primary"></i>
              Tóm tắt đơn hàng
            </h6>
          </div>
          <div class="card-body p-0">

            <!-- DANH SÁCH SẢN PHẨM -->
            <div style="max-height:280px;overflow-y:auto;
                        padding:0 16px;">
              <c:forEach var="item" items="${cart}">
                <div class="d-flex align-items-center
                            gap-3 py-2"
                     style="border-bottom:1px solid #f5f5f5;">
                  <div style="position:relative;">
                    <img src="${not empty item.imageUrl
                                ? item.imageUrl
                                : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'}"
                         style="width:54px;height:54px;
                                object-fit:cover;
                                border-radius:8px;"
                         onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'"
                         alt="">
                    <span style="position:absolute;
                                 top:-6px;right:-6px;
                                 background:#0077b6;
                                 color:white;font-size:11px;
                                 border-radius:50%;
                                 width:18px;height:18px;
                                 display:flex;
                                 align-items:center;
                                 justify-content:center;
                                 font-weight:700;">
                      <fmt:formatNumber value="${item.quantity}"
                                        pattern="#.##"/>
                    </span>
                  </div>
                  <div style="flex:1;min-width:0;">
                    <div class="fw-bold"
                         style="font-size:13px;
                                white-space:nowrap;
                                overflow:hidden;
                                text-overflow:ellipsis;">
                      ${item.name}
                    </div>
                    <small class="text-muted">
                      ${item.unit}
                    </small>
                  </div>
                  <div style="color:#0077b6;font-weight:700;
                              font-size:13px;white-space:nowrap;">
                    <fmt:formatNumber value="${item.totalPrice}"
                                      pattern="#,###"/>đ
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- TỔNG TIỀN -->
            <div class="p-3">
              <div class="d-flex justify-content-between mb-2"
                   style="font-size:14px;">
                <span class="text-muted">Tạm tính:</span>
                <span class="fw-bold">
                  <fmt:formatNumber value="${total}"
                                    pattern="#,###"/>đ
                </span>
              </div>
              <div class="d-flex justify-content-between mb-2"
                   style="font-size:14px;">
                <span class="text-muted">Phí vận chuyển:</span>
                <span class="text-success fw-bold">
                  <i class="bi bi-truck"></i> Miễn phí
                </span>
              </div>
              <div class="d-flex justify-content-between mb-2"
                   style="font-size:14px;">
                <span class="text-muted">Phương thức:</span>
                <span class="fw-bold" id="selectedPayLabel">
                  💵 Tiền mặt (COD)
                </span>
              </div>
              <hr class="my-2">
              <div class="d-flex justify-content-between fw-bold"
                   style="font-size:1.15rem;">
                <span>Tổng cộng:</span>
                <span class="text-danger">
                  <fmt:formatNumber value="${total}"
                                    pattern="#,###"/>đ
                </span>
              </div>
            </div>

            <!-- NÚT ĐẶT HÀNG -->
            <div class="px-3 pb-3">
              <button type="submit"
                      class="btn btn-primary w-100 py-3 fw-bold"
                      style="border-radius:12px;font-size:16px;">
                <i class="bi bi-check-circle"></i>
                Xác nhận đặt hàng
              </button>
              <a href="/dyleeseafood/cart"
                 class="btn btn-outline-secondary w-100 mt-2">
                ← Quay lại giỏ hàng
              </a>
            </div>

            <!-- CAM KẾT -->
            <div class="px-3 pb-3">
              <div class="p-3 bg-light rounded-3"
                   style="font-size:12px;">
                <div class="d-flex gap-2 mb-1">
                  <i class="bi bi-shield-check text-success"></i>
                  <span class="text-muted">
                    Thanh toán an toàn & bảo mật
                  </span>
                </div>
                <div class="d-flex gap-2 mb-1">
                  <i class="bi bi-truck text-primary"></i>
                  <span class="text-muted">
                    Giao hàng trong 2 giờ
                  </span>
                </div>
                <div class="d-flex gap-2">
                  <i class="bi bi-arrow-repeat text-warning"></i>
                  <span class="text-muted">
                    Đổi trả trong 24h nếu lỗi
                  </span>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>

    </div>
  </form>
</div>

<script>
var payMethods = {
  'cod':     { label: '💵 Tiền mặt (COD)' },
  'bank':    { label: '🏦 Chuyển khoản' },
  'momo':    { label: '💜 Ví MoMo' },
  'vnpay':   { label: '📱 VNPay' },
  'zalopay': { label: '🟢 ZaloPay' }
};

var methodMap = {
  'cod':     'COD',
  'bank':    'bank_transfer',
  'momo':    'momo',
  'vnpay':   'vnpay',
  'zalopay': 'zalopay'
};

function selectPay(method) {
  Object.keys(payMethods).forEach(function(m) {
    var card   = document.getElementById('card-'   + m);
    var chk    = document.getElementById('chk-'    + m);
    var detail = document.getElementById('detail-' + m);
    if (!card) return;
    if (m === method) {
      card.classList.add('active');
      chk.classList.add('checked');
      chk.innerHTML =
        '<i class="bi bi-check text-white"' +
        ' style="font-size:12px;"></i>';
      detail.classList.add('show');
    } else {
      card.classList.remove('active');
      chk.classList.remove('checked');
      chk.innerHTML = '';
      detail.classList.remove('show');
    }
  });
  document.getElementById('paymentMethod').value =
    methodMap[method];
  document.getElementById('selectedPayLabel')
    .textContent = payMethods[method].label;
}

function copyText(btn, text) {
  navigator.clipboard.writeText(text).then(function() {
    btn.textContent = 'Đã chép!';
    btn.classList.add('copied');
    setTimeout(function() {
      btn.textContent = 'Sao chép';
      btn.classList.remove('copied');
    }, 2000);
  });
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
