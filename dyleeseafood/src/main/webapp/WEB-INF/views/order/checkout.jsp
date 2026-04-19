<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .pay-card {
    border:2px solid #e8edf5; border-radius:14px;
    padding:16px 18px; cursor:pointer;
    transition:all 0.2s; margin-bottom:10px;
    background:white;
  }
  .pay-card:hover { border-color:#0077b6; box-shadow:0 2px 12px rgba(0,119,182,0.1); }
  .pay-card.active { border-color:#0077b6; background:#f0f8ff; }

  .pay-logo {
    width:48px; height:48px; border-radius:12px;
    display:flex; align-items:center;
    justify-content:center; flex-shrink:0;
    font-weight:800; font-size:13px; letter-spacing:-0.5px;
  }
  .pay-detail { display:none; margin-top:16px; }
  .pay-detail.show { display:block; }

  .check-circle {
    width:22px; height:22px; border-radius:50%;
    border:2px solid #dee2e6; flex-shrink:0;
    display:flex; align-items:center;
    justify-content:center; transition:0.2s;
  }
  .check-circle.checked { background:#0077b6; border-color:#0077b6; }

  .bank-card {
    border:1px solid #e8edf5; border-radius:10px;
    padding:14px; margin-bottom:8px;
    background:white; cursor:pointer; transition:0.15s;
  }
  .bank-card:hover { border-color:#0077b6; }
  .bank-card.selected { border-color:#0077b6; background:#f0f8ff; }

  .copy-btn {
    font-size:11px; padding:3px 12px; border-radius:20px;
    border:1px solid #0077b6; background:white;
    color:#0077b6; cursor:pointer; transition:0.15s;
  }
  .copy-btn:hover { background:#0077b6; color:white; }
  .copy-btn.copied { background:#28a745; border-color:#28a745; color:white; }

  /* ── ADDRESS SELECTION ── */
  .addr-mode-btn {
    border:1.5px solid #e8edf5; border-radius:10px;
    padding:7px 16px; font-size:13px; font-weight:600;
    color:#64748b; background:white; cursor:pointer;
    transition:.15s; display:flex; align-items:center; gap:5px;
  }
  .addr-mode-btn:hover { border-color:#0077b6; color:#0077b6; }
  .addr-mode-btn.active { background:#0077b6; border-color:#0077b6; color:white; }

  .addr-choice-card {
    display:block; border:2px solid #e8edf5; border-radius:12px;
    padding:14px 16px; margin-bottom:10px; cursor:pointer;
    transition:.15s; background:white;
  }
  .addr-choice-card:hover { border-color:#93c5fd; background:#f8fbff; }
  .addr-choice-card.selected { border-color:#0077b6; background:#f0f8ff; }

  .addr-radio {
    width:20px; height:20px; border-radius:50%;
    border:2.5px solid #cbd5e1; flex-shrink:0; margin-top:2px;
    display:flex; align-items:center; justify-content:center;
    transition:.15s;
  }
  .addr-radio.checked { border-color:#0077b6; background:#0077b6; }
  .addr-radio-dot {
    width:8px; height:8px; border-radius:50%;
    background:white; display:none;
  }
  .addr-radio.checked .addr-radio-dot { display:block; }

  .info-row {
    display:flex; justify-content:space-between;
    align-items:center; padding:8px 0;
    border-bottom:1px solid #f0f2f5; font-size:13px;
  }
  .info-row:last-child { border:none; }

  .step-guide {
    display:flex; flex-direction:column; gap:8px;
    background:#f7f9fc; border-radius:10px;
    padding:14px; margin-top:12px;
  }
  .step-guide-item {
    display:flex; align-items:flex-start; gap:10px;
    font-size:13px;
  }
  .step-num-small {
    width:22px; height:22px; border-radius:50%;
    background:#0077b6; color:white;
    display:flex; align-items:center;
    justify-content:center; font-size:11px;
    font-weight:700; flex-shrink:0; margin-top:1px;
  }

  .qr-box {
    width:130px; height:130px; border:2px solid #e8edf5;
    border-radius:12px; display:flex; flex-direction:column;
    align-items:center; justify-content:center;
    background:#fafafa; flex-shrink:0;
  }

  .step-bar { display:flex; align-items:center; margin-bottom:28px; }
  .step { display:flex; align-items:center; gap:8px; }
  .step-num { width:32px; height:32px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:14px; flex-shrink:0; }
  .step-line { flex:1; height:2px; background:#dee2e6; }
  .step-line.done { background:#0077b6; }

  .info-row-label { color:#8a9ab0; font-size:13px; }
  .info-row-value { font-weight:600; font-size:13px; }
  .monospace { font-family:'Courier New',monospace; letter-spacing:1px; }
</style>

<div class="container mt-4 mb-5">
  <nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/dyleeseafood/home">Trang chủ</a></li>
      <li class="breadcrumb-item"><a href="/dyleeseafood/cart">Giỏ hàng</a></li>
      <li class="breadcrumb-item active">Đặt hàng</li>
    </ol>
  </nav>

  <!-- Bước -->
  <div class="step-bar">
    <div class="step">
      <div class="step-num" style="background:#6c757d;color:white;">1</div>
      <span class="text-muted" style="font-size:14px;">Giỏ hàng</span>
    </div>
    <div class="step-line done mx-2"></div>
    <div class="step">
      <div class="step-num" style="background:#0077b6;color:white;">2</div>
      <span class="fw-bold" style="font-size:14px;color:#0077b6;">Đặt hàng</span>
    </div>
    <div class="step-line mx-2"></div>
    <div class="step">
      <div class="step-num" style="background:#dee2e6;color:#999;">3</div>
      <span class="text-muted" style="font-size:14px;">Hoàn thành</span>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger mb-3">
      <i class="bi bi-exclamation-circle me-2"></i>${error}
    </div>
  </c:if>

  <form method="post" action="/dyleeseafood/order/place" id="orderForm">
    <div class="row g-4">

      <!-- CỘT TRÁI -->
      <div class="col-lg-7">

        <!-- THÔNG TIN NGƯỜI NHẬN -->
        <div class="card border-0 shadow-sm mb-3" style="border-radius:16px;overflow:hidden;">
          <div class="card-header bg-white border-0 pt-3 pb-2"
               style="border-bottom:1px solid #f1f5f9;">
            <h6 class="fw-bold mb-0">
              <i class="bi bi-geo-alt-fill me-2" style="color:#0077b6;"></i>Địa chỉ giao hàng
            </h6>
          </div>
          <div class="card-body">

            <!-- ══ CÓ ĐỊA CHỈ ĐÃ LƯU ══ -->
            <c:if test="${not empty savedAddresses}">

              <!-- Toggle buttons -->
              <div class="d-flex gap-2 mb-3">
                <button type="button" id="btnSaved" class="addr-mode-btn active"
                        onclick="useMode('saved')">
                  <i class="bi bi-bookmark-check me-1"></i>Địa chỉ đã lưu
                </button>
                <button type="button" id="btnNew" class="addr-mode-btn"
                        onclick="useMode('new')">
                  <i class="bi bi-plus-circle me-1"></i>Nhập địa chỉ mới
                </button>
              </div>

              <!-- PANEL: chọn địa chỉ đã lưu -->
              <div id="panelSaved">
                <c:forEach var="addr" items="${savedAddresses}">
                  <label class="addr-choice-card ${addr.defaultAddr ? 'selected' : ''}"
                         onclick="selectSavedAddr(${addr.id}, this)">
                    <div class="d-flex align-items-start gap-3">
                      <div class="addr-radio ${addr.defaultAddr ? 'checked' : ''}"
                           id="radio_${addr.id}">
                        <div class="addr-radio-dot"></div>
                      </div>
                      <div style="flex:1;">
                        <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                          <span style="font-weight:700;font-size:14px;">${addr.fullName}</span>
                          <span style="color:#94a3b8;">|</span>
                          <span style="font-size:13px;color:#475569;">${addr.phone}</span>
                          <c:if test="${addr.defaultAddr}">
                            <span style="background:#e0f2fe;color:#0077b6;border-radius:20px;
                                         padding:1px 9px;font-size:11px;font-weight:700;">
                              Mặc định
                            </span>
                          </c:if>
                        </div>
                        <div style="font-size:13px;color:#64748b;">${addr.fullAddress}</div>
                      </div>
                    </div>
                    <input type="radio" name="savedAddressId" value="${addr.id}"
                           ${addr.defaultAddr ? 'checked' : ''} style="display:none;">
                  </label>
                </c:forEach>
                <a href="/dyleeseafood/profile#tab-address" target="_blank"
                   style="font-size:12px;color:#0077b6;text-decoration:none;">
                  <i class="bi bi-pencil me-1"></i>Quản lý địa chỉ
                </a>
              </div>

              <!-- PANEL: nhập địa chỉ mới (savedAddressId=0) -->
              <div id="panelNew" style="display:none;">
                <input type="radio" name="savedAddressId" value="0"
                       id="radioNew" style="display:none;">
                <div class="row g-3">
                  <div class="col-md-6">
                    <label class="form-label fw-semibold">
                      Họ tên người nhận <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="fullName" id="inFullName"
                           class="form-control" value="${customer.name}">
                  </div>
                  <div class="col-md-6">
                    <label class="form-label fw-semibold">
                      Số điện thoại <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="phone" id="inPhone"
                           class="form-control" value="${customer.phone}">
                  </div>
                  <div class="col-12">
                    <label class="form-label fw-semibold">
                      Số nhà, tên đường <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="address" id="inAddress"
                           class="form-control" placeholder="VD: 123 Đường Lê Lợi">
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-semibold">Phường/Xã</label>
                    <input type="text" name="ward"
                           class="form-control" placeholder="Phường Bến Nghé">
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-semibold">Quận/Huyện</label>
                    <input type="text" name="district"
                           class="form-control" placeholder="Quận 1">
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-semibold">
                      Tỉnh/Thành phố <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="city" id="inCity"
                           class="form-control" placeholder="TP. Hồ Chí Minh">
                  </div>
                </div>
              </div>

            </c:if>

            <!-- ══ CHƯA CÓ ĐỊA CHỈ LƯU → nhập trực tiếp ══ -->
            <c:if test="${empty savedAddresses}">
              <input type="hidden" name="savedAddressId" value="0">
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label fw-semibold">
                    Họ tên người nhận <span class="text-danger">*</span>
                  </label>
                  <input type="text" name="fullName" class="form-control"
                         value="${customer.name}" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-semibold">
                    Số điện thoại <span class="text-danger">*</span>
                  </label>
                  <input type="text" name="phone" class="form-control"
                         value="${customer.phone}" required>
                </div>
                <div class="col-12">
                  <label class="form-label fw-semibold">
                    Số nhà, tên đường <span class="text-danger">*</span>
                  </label>
                  <input type="text" name="address" class="form-control"
                         placeholder="VD: 123 Đường Lê Lợi" required>
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-semibold">Phường/Xã</label>
                  <input type="text" name="ward" class="form-control" placeholder="Phường Bến Nghé">
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-semibold">Quận/Huyện</label>
                  <input type="text" name="district" class="form-control" placeholder="Quận 1">
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-semibold">
                    Tỉnh/Thành phố <span class="text-danger">*</span>
                  </label>
                  <input type="text" name="city" class="form-control"
                         placeholder="TP. Hồ Chí Minh" required>
                </div>
              </div>
              <div class="mt-3">
                <a href="/dyleeseafood/profile#tab-address"
                   style="font-size:13px;color:#0077b6;">
                  <i class="bi bi-bookmark-plus me-1"></i>Lưu địa chỉ để dùng lại lần sau
                </a>
              </div>
            </c:if>

          </div>
        </div>

        <!-- PHƯƠNG THỨC THANH TOÁN -->
        <div class="card border-0 shadow-sm mb-3" style="border-radius:16px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold"><i class="bi bi-credit-card text-primary me-2"></i>Phương thức thanh toán</h6>
          </div>
          <div class="card-body">
            <input type="hidden" name="paymentMethod" id="paymentMethod" value="COD">

            <!-- ===== 1. COD ===== -->
            <div class="pay-card active" id="card-cod" onclick="selectPay('cod')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-logo" style="background:#e8f5e9;">
                  <i class="bi bi-cash-coin" style="font-size:1.4rem;color:#2e7d32;"></i>
                </div>
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:14px;">Thanh toán khi nhận hàng (COD)</div>
                  <small class="text-muted">Trả tiền mặt cho nhân viên giao hàng</small>
                </div>
                <div class="check-circle checked" id="chk-cod">
                  <i class="bi bi-check text-white" style="font-size:13px;"></i>
                </div>
              </div>

              <div class="pay-detail show" id="detail-cod">
                <div style="background:#e8f5e9;border-radius:10px;padding:14px;">
                  <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-info-circle-fill" style="color:#2e7d32;"></i>
                    <span class="fw-bold" style="font-size:13px;color:#2e7d32;">Hướng dẫn thanh toán COD</span>
                  </div>
                  <div class="step-guide" style="background:white;">
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#2e7d32;">1</div>
                      <span>Đặt hàng thành công — chờ nhân viên gọi xác nhận</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#2e7d32;">2</div>
                      <span>Chuẩn bị đúng số tiền:
                        <strong class="text-danger ms-1">
                          <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                        </strong>
                      </span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#2e7d32;">3</div>
                      <span>Thanh toán trực tiếp khi nhận hàng</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#2e7d32;">4</div>
                      <span>Kiểm tra hàng trước khi ký nhận</span>
                    </div>
                  </div>
                  <div class="mt-2" style="font-size:12px;color:#388e3c;">
                    <i class="bi bi-check-circle-fill me-1"></i>
                    Không mất phí — Thanh toán sau khi nhận hàng
                  </div>
                </div>
              </div>
            </div>

            <!-- ===== 2. CHUYỂN KHOẢN ===== -->
            <div class="pay-card" id="card-bank" onclick="selectPay('bank')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-logo" style="background:#e3f2fd;">
                  <i class="bi bi-bank" style="font-size:1.4rem;color:#0077b6;"></i>
                </div>
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:14px;">Chuyển khoản ngân hàng</div>
                  <small class="text-muted">Vietcombank · Techcombank · MB Bank</small>
                </div>
                <div class="check-circle" id="chk-bank"></div>
              </div>

              <div class="pay-detail" id="detail-bank">
                <!-- Chọn ngân hàng -->
                <div class="mb-3">
                  <small class="fw-bold text-muted">Chọn ngân hàng:</small>
                  <div class="row g-2 mt-1">
                    <div class="col-4">
                      <div class="bank-card selected" id="bank-vcb" onclick="selectBank('vcb',event)">
                        <div style="font-size:11px;font-weight:800;color:#007b40;">Vietcom<br>bank</div>
                        <div style="font-size:10px;color:#8a9ab0;">VCB</div>
                      </div>
                    </div>
                    <div class="col-4">
                      <div class="bank-card" id="bank-tcb" onclick="selectBank('tcb',event)">
                        <div style="font-size:11px;font-weight:800;color:#e31837;">Techcom<br>bank</div>
                        <div style="font-size:10px;color:#8a9ab0;">TCB</div>
                      </div>
                    </div>
                    <div class="col-4">
                      <div class="bank-card" id="bank-mb" onclick="selectBank('mb',event)">
                        <div style="font-size:11px;font-weight:800;color:#6734c7;">MB<br>Bank</div>
                        <div style="font-size:10px;color:#8a9ab0;">MBB</div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Chi tiết tài khoản -->
                <div style="background:#f7f9fc;border-radius:10px;padding:14px;border:1px solid #e8edf5;">
                  <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-bank text-primary"></i>
                    <span class="fw-bold" style="font-size:13px;" id="bankName">Vietcombank (VCB)</span>
                  </div>
                  <div class="info-row">
                    <span class="info-row-label">Số tài khoản</span>
                    <div class="d-flex align-items-center gap-2">
                      <span class="info-row-value monospace" id="bankNumber">1234 5678 9012</span>
                      <button type="button" class="copy-btn" onclick="copyText(this,'1234567890')">Sao chép</button>
                    </div>
                  </div>
                  <div class="info-row">
                    <span class="info-row-label">Chủ tài khoản</span>
                    <span class="info-row-value">DYLEE SEAFOOD</span>
                  </div>
                  <div class="info-row">
                    <span class="info-row-label">Số tiền</span>
                    <span class="info-row-value" style="color:#0077b6;">
                      <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                    </span>
                  </div>
                  <div class="info-row">
                    <span class="info-row-label">Nội dung CK</span>
                    <div class="d-flex align-items-center gap-2">
                      <span class="info-row-value monospace" id="transferNote">
                        DYLEE ${sessionScope.loggedUser.username}
                      </span>
                      <button type="button" class="copy-btn"
                              onclick="copyText(this,'DYLEE ${sessionScope.loggedUser.username}')">
                        Sao chép
                      </button>
                    </div>
                  </div>
                </div>

                <div class="step-guide mt-3">
                  <div class="step-guide-item">
                    <div class="step-num-small">1</div>
                    <span>Mở app ngân hàng → Chuyển tiền → Nhập số TK</span>
                  </div>
                  <div class="step-guide-item">
                    <div class="step-num-small">2</div>
                    <span>Nhập số tiền: <strong><fmt:formatNumber value="${total}" pattern="#,###"/>đ</strong></span>
                  </div>
                  <div class="step-guide-item">
                    <div class="step-num-small">3</div>
                    <span>Nội dung: <strong>DYLEE ${sessionScope.loggedUser.username}</strong> — bắt buộc đúng</span>
                  </div>
                  <div class="step-guide-item">
                    <div class="step-num-small">4</div>
                    <span>Xác nhận chuyển khoản → Đơn hàng được duyệt trong 30 phút</span>
                  </div>
                </div>

                <div class="mt-2 p-2" style="background:#fff8e6;border-radius:8px;border:1px solid #ffe0b2;font-size:12px;color:#e65100;">
                  <i class="bi bi-exclamation-triangle-fill me-1"></i>
                  <strong>Lưu ý:</strong> Nhập sai nội dung chuyển khoản sẽ không xác nhận được đơn hàng!
                </div>
              </div>
            </div>

            <!-- ===== 3. MOMO ===== -->
            <div class="pay-card" id="card-momo" onclick="selectPay('momo')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-logo" style="background:#fce4ec;">
                  <span style="color:#ae2070;font-size:15px;font-weight:900;">Mo<br style="line-height:0.5;">Mo</span>
                </div>
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:14px;">Ví MoMo</div>
                  <small class="text-muted">Chuyển tiền qua số điện thoại hoặc QR</small>
                </div>
                <div class="check-circle" id="chk-momo"></div>
              </div>

              <div class="pay-detail" id="detail-momo">
                <div style="background:#fce4ec;border-radius:10px;padding:14px;">
                  <div class="d-flex gap-3">
                    <!-- QR placeholder -->
                    <div class="qr-box" style="border-color:#ae2070;">
                      <svg width="90" height="90" viewBox="0 0 210 210">
                        <rect width="210" height="210" fill="white"/>
                        <rect x="10" y="10" width="60" height="60" fill="#ae2070"/>
                        <rect x="18" y="18" width="44" height="44" fill="white"/>
                        <rect x="26" y="26" width="28" height="28" fill="#ae2070"/>
                        <rect x="140" y="10" width="60" height="60" fill="#ae2070"/>
                        <rect x="148" y="18" width="44" height="44" fill="white"/>
                        <rect x="156" y="26" width="28" height="28" fill="#ae2070"/>
                        <rect x="10" y="140" width="60" height="60" fill="#ae2070"/>
                        <rect x="18" y="148" width="44" height="44" fill="white"/>
                        <rect x="26" y="156" width="28" height="28" fill="#ae2070"/>
                        <rect x="82" y="10" width="9" height="9" fill="#ae2070"/>
                        <rect x="100" y="10" width="9" height="9" fill="#ae2070"/>
                        <rect x="118" y="10" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="28" width="9" height="9" fill="#ae2070"/>
                        <rect x="109" y="28" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="46" width="9" height="9" fill="#ae2070"/>
                        <rect x="91" y="46" width="9" height="9" fill="#ae2070"/>
                        <rect x="118" y="46" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="64" width="9" height="9" fill="#ae2070"/>
                        <rect x="100" y="64" width="9" height="9" fill="#ae2070"/>
                        <rect x="109" y="64" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="100" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="118" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="130" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="91" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="118" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="109" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="130" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="91" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="118" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="82" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="100" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="130" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="91" y="172" width="9" height="9" fill="#ae2070"/>
                        <rect x="109" y="172" width="9" height="9" fill="#ae2070"/>
                        <rect x="10" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="28" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="46" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="64" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="19" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="46" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="10" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="37" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="55" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="19" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="46" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="140" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="158" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="176" y="82" width="9" height="9" fill="#ae2070"/>
                        <rect x="149" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="167" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="185" y="100" width="9" height="9" fill="#ae2070"/>
                        <rect x="140" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="167" y="118" width="9" height="9" fill="#ae2070"/>
                        <rect x="149" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="176" y="136" width="9" height="9" fill="#ae2070"/>
                        <rect x="140" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="158" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="176" y="154" width="9" height="9" fill="#ae2070"/>
                        <rect x="149" y="172" width="9" height="9" fill="#ae2070"/>
                        <rect x="167" y="172" width="9" height="9" fill="#ae2070"/>
                        <rect x="140" y="190" width="9" height="9" fill="#ae2070"/>
                        <rect x="176" y="190" width="9" height="9" fill="#ae2070"/>
                      </svg>
                      <small style="font-size:10px;color:#ae2070;font-weight:600;">QR MoMo</small>
                    </div>

                    <div style="flex:1;">
                      <div class="info-row">
                        <span class="info-row-label">SĐT nhận</span>
                        <div class="d-flex align-items-center gap-2">
                          <span class="info-row-value">0909 999 888</span>
                          <button type="button" class="copy-btn" onclick="copyText(this,'0909999888')" style="border-color:#ae2070;color:#ae2070;">Sao chép</button>
                        </div>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Tên TK</span>
                        <span class="info-row-value">DYLEE SEAFOOD</span>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Số tiền</span>
                        <span class="info-row-value" style="color:#ae2070;">
                          <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                        </span>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Ghi chú</span>
                        <span class="info-row-value" style="font-size:12px;">
                          DL ${sessionScope.loggedUser.username}
                        </span>
                      </div>
                    </div>
                  </div>

                  <div class="step-guide mt-3" style="background:white;">
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#ae2070;">1</div>
                      <span>Mở app MoMo → Chọn <strong>Chuyển tiền</strong></span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#ae2070;">2</div>
                      <span>Nhập SĐT: <strong>0909 999 888</strong> hoặc quét QR</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#ae2070;">3</div>
                      <span>Nhập số tiền và nội dung: <strong>DL ${sessionScope.loggedUser.username}</strong></span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#ae2070;">4</div>
                      <span>Xác nhận bằng mã PIN / Face ID</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- ===== 4. VNPAY ===== -->
            <div class="pay-card" id="card-vnpay" onclick="selectPay('vnpay')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-logo" style="background:#e8f0fe;">
                  <span style="color:#0066b3;font-size:13px;font-weight:900;letter-spacing:-1px;">VN<br style="line-height:0.4;">Pay</span>
                </div>
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:14px;">VNPay</div>
                  <small class="text-muted">Ví VNPay · ATM nội địa · Thẻ tín dụng</small>
                </div>
                <div class="check-circle" id="chk-vnpay"></div>
              </div>

              <div class="pay-detail" id="detail-vnpay">
                <div style="background:#e8f0fe;border-radius:10px;padding:14px;">
                  <div class="d-flex gap-3">
                    <div class="qr-box" style="border-color:#0066b3;">
                      <svg width="90" height="90" viewBox="0 0 210 210">
                        <rect width="210" height="210" fill="white"/>
                        <rect x="10" y="10" width="60" height="60" fill="#0066b3"/>
                        <rect x="18" y="18" width="44" height="44" fill="white"/>
                        <rect x="26" y="26" width="28" height="28" fill="#0066b3"/>
                        <rect x="140" y="10" width="60" height="60" fill="#0066b3"/>
                        <rect x="148" y="18" width="44" height="44" fill="white"/>
                        <rect x="156" y="26" width="28" height="28" fill="#0066b3"/>
                        <rect x="10" y="140" width="60" height="60" fill="#0066b3"/>
                        <rect x="18" y="148" width="44" height="44" fill="white"/>
                        <rect x="26" y="156" width="28" height="28" fill="#0066b3"/>
                        <rect x="82" y="10" width="9" height="9" fill="#0066b3"/>
                        <rect x="109" y="10" width="9" height="9" fill="#0066b3"/>
                        <rect x="127" y="10" width="9" height="9" fill="#0066b3"/>
                        <rect x="91" y="28" width="9" height="9" fill="#0066b3"/>
                        <rect x="118" y="28" width="9" height="9" fill="#0066b3"/>
                        <rect x="82" y="46" width="9" height="9" fill="#0066b3"/>
                        <rect x="100" y="46" width="9" height="9" fill="#0066b3"/>
                        <rect x="127" y="46" width="9" height="9" fill="#0066b3"/>
                        <rect x="91" y="64" width="9" height="9" fill="#0066b3"/>
                        <rect x="109" y="64" width="9" height="9" fill="#0066b3"/>
                        <rect x="82" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="109" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="127" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="91" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="118" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="100" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="127" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="82" y="136" width="9" height="9" fill="#0066b3"/>
                        <rect x="109" y="136" width="9" height="9" fill="#0066b3"/>
                        <rect x="91" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="127" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="10" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="37" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="55" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="19" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="46" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="10" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="28" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="55" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="37" y="136" width="9" height="9" fill="#0066b3"/>
                        <rect x="19" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="55" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="140" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="167" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="185" y="82" width="9" height="9" fill="#0066b3"/>
                        <rect x="149" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="176" y="100" width="9" height="9" fill="#0066b3"/>
                        <rect x="158" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="185" y="118" width="9" height="9" fill="#0066b3"/>
                        <rect x="140" y="136" width="9" height="9" fill="#0066b3"/>
                        <rect x="167" y="136" width="9" height="9" fill="#0066b3"/>
                        <rect x="149" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="176" y="154" width="9" height="9" fill="#0066b3"/>
                        <rect x="140" y="172" width="9" height="9" fill="#0066b3"/>
                        <rect x="158" y="172" width="9" height="9" fill="#0066b3"/>
                        <rect x="185" y="172" width="9" height="9" fill="#0066b3"/>
                        <rect x="149" y="190" width="9" height="9" fill="#0066b3"/>
                        <rect x="176" y="190" width="9" height="9" fill="#0066b3"/>
                      </svg>
                      <small style="font-size:10px;color:#0066b3;font-weight:600;">QR VNPay</small>
                    </div>

                    <div style="flex:1;">
                      <div class="info-row">
                        <span class="info-row-label">Số tiền</span>
                        <span class="info-row-value" style="color:#0066b3;">
                          <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                        </span>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Người nhận</span>
                        <span class="info-row-value">DYLEE SEAFOOD</span>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Hỗ trợ</span>
                        <span style="font-size:11px;color:#8a9ab0;">ATM · Visa · QR</span>
                      </div>
                    </div>
                  </div>

                  <div class="step-guide mt-3" style="background:white;">
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#0066b3;">1</div>
                      <span>Mở app VNPay → Quét mã QR ở trên</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#0066b3;">2</div>
                      <span>Hoặc: Chọn <strong>Nạp tiền & Thanh toán</strong> → tìm cửa hàng</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#0066b3;">3</div>
                      <span>Xác nhận số tiền và hoàn tất giao dịch</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- ===== 5. ZALOPAY ===== -->
            <div class="pay-card" id="card-zalopay" onclick="selectPay('zalopay')">
              <div class="d-flex align-items-center gap-3">
                <div class="pay-logo" style="background:#e3f6ff;">
                  <span style="color:#006af5;font-size:13px;font-weight:900;letter-spacing:-1px;">Zalo<br style="line-height:0.4;">Pay</span>
                </div>
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:14px;">ZaloPay</div>
                  <small class="text-muted">Thanh toán qua ứng dụng ZaloPay</small>
                </div>
                <div class="check-circle" id="chk-zalopay"></div>
              </div>

              <div class="pay-detail" id="detail-zalopay">
                <div style="background:#e3f6ff;border-radius:10px;padding:14px;">
                  <div class="d-flex gap-3">
                    <div class="qr-box" style="border-color:#006af5;">
                      <svg width="90" height="90" viewBox="0 0 210 210">
                        <rect width="210" height="210" fill="white"/>
                        <rect x="10" y="10" width="60" height="60" fill="#006af5"/>
                        <rect x="18" y="18" width="44" height="44" fill="white"/>
                        <rect x="26" y="26" width="28" height="28" fill="#006af5"/>
                        <rect x="140" y="10" width="60" height="60" fill="#006af5"/>
                        <rect x="148" y="18" width="44" height="44" fill="white"/>
                        <rect x="156" y="26" width="28" height="28" fill="#006af5"/>
                        <rect x="10" y="140" width="60" height="60" fill="#006af5"/>
                        <rect x="18" y="148" width="44" height="44" fill="white"/>
                        <rect x="26" y="156" width="28" height="28" fill="#006af5"/>
                        <rect x="82" y="10" width="9" height="9" fill="#006af5"/>
                        <rect x="100" y="10" width="9" height="9" fill="#006af5"/>
                        <rect x="127" y="10" width="9" height="9" fill="#006af5"/>
                        <rect x="91" y="28" width="9" height="9" fill="#006af5"/>
                        <rect x="109" y="28" width="9" height="9" fill="#006af5"/>
                        <rect x="82" y="46" width="9" height="9" fill="#006af5"/>
                        <rect x="118" y="46" width="9" height="9" fill="#006af5"/>
                        <rect x="100" y="64" width="9" height="9" fill="#006af5"/>
                        <rect x="127" y="64" width="9" height="9" fill="#006af5"/>
                        <rect x="82" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="100" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="118" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="91" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="127" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="82" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="109" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="100" y="136" width="9" height="9" fill="#006af5"/>
                        <rect x="118" y="136" width="9" height="9" fill="#006af5"/>
                        <rect x="82" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="127" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="91" y="172" width="9" height="9" fill="#006af5"/>
                        <rect x="118" y="172" width="9" height="9" fill="#006af5"/>
                        <rect x="10" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="28" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="55" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="64" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="19" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="37" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="55" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="10" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="46" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="28" y="136" width="9" height="9" fill="#006af5"/>
                        <rect x="55" y="136" width="9" height="9" fill="#006af5"/>
                        <rect x="10" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="37" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="64" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="140" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="158" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="185" y="82" width="9" height="9" fill="#006af5"/>
                        <rect x="149" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="176" y="100" width="9" height="9" fill="#006af5"/>
                        <rect x="140" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="167" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="185" y="118" width="9" height="9" fill="#006af5"/>
                        <rect x="158" y="136" width="9" height="9" fill="#006af5"/>
                        <rect x="140" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="176" y="154" width="9" height="9" fill="#006af5"/>
                        <rect x="149" y="172" width="9" height="9" fill="#006af5"/>
                        <rect x="167" y="172" width="9" height="9" fill="#006af5"/>
                        <rect x="185" y="172" width="9" height="9" fill="#006af5"/>
                        <rect x="140" y="190" width="9" height="9" fill="#006af5"/>
                        <rect x="158" y="190" width="9" height="9" fill="#006af5"/>
                        <rect x="176" y="190" width="9" height="9" fill="#006af5"/>
                      </svg>
                      <small style="font-size:10px;color:#006af5;font-weight:600;">QR ZaloPay</small>
                    </div>

                    <div style="flex:1;">
                      <div class="info-row">
                        <span class="info-row-label">SĐT nhận</span>
                        <div class="d-flex align-items-center gap-2">
                          <span class="info-row-value">0909 888 777</span>
                          <button type="button" class="copy-btn" onclick="copyText(this,'0909888777')" style="border-color:#006af5;color:#006af5;">Sao chép</button>
                        </div>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Tên TK</span>
                        <span class="info-row-value">DYLEE SEAFOOD</span>
                      </div>
                      <div class="info-row">
                        <span class="info-row-label">Số tiền</span>
                        <span class="info-row-value" style="color:#006af5;">
                          <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                        </span>
                      </div>
                    </div>
                  </div>

                  <div class="step-guide mt-3" style="background:white;">
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#006af5;">1</div>
                      <span>Mở app ZaloPay → Quét QR hoặc chọn <strong>Chuyển tiền</strong></span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#006af5;">2</div>
                      <span>Nhập SĐT: <strong>0909 888 777</strong></span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#006af5;">3</div>
                      <span>Nhập số tiền và nội dung đơn hàng</span>
                    </div>
                    <div class="step-guide-item">
                      <div class="step-num-small" style="background:#006af5;">4</div>
                      <span>Xác nhận thanh toán</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- GHI CHÚ -->
        <div class="card border-0 shadow-sm" style="border-radius:16px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold"><i class="bi bi-chat-text text-primary me-2"></i>Ghi chú đơn hàng</h6>
          </div>
          <div class="card-body">
            <textarea name="note" class="form-control" rows="3" placeholder="Ghi chú cho người giao hàng..."></textarea>
          </div>
        </div>

      </div>

      <!-- CỘT PHẢI: TÓM TẮT -->
      <div class="col-lg-5">
        <div class="card border-0 shadow-sm" style="border-radius:16px;position:sticky;top:80px;">
          <div class="card-header bg-white border-0 pt-3 pb-0">
            <h6 class="fw-bold"><i class="bi bi-receipt text-primary me-2"></i>Tóm tắt đơn hàng</h6>
          </div>
          <div class="card-body p-0">
            <!-- Sản phẩm -->
            <div style="max-height:280px;overflow-y:auto;padding:0 16px;">
              <c:forEach var="item" items="${cart}">
                <div class="d-flex align-items-center gap-3 py-2" style="border-bottom:1px solid #f5f5f5;">
                  <div style="position:relative;">
                    <img src="${not empty item.imageUrl ? item.imageUrl : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'}"
                         style="width:54px;height:54px;object-fit:cover;border-radius:8px;"
                         onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'" alt="">
                    <span style="position:absolute;top:-6px;right:-6px;background:#0077b6;color:white;font-size:11px;border-radius:50%;width:18px;height:18px;display:flex;align-items:center;justify-content:center;font-weight:700;">
                      <fmt:formatNumber value="${item.quantity}" pattern="#.##"/>
                    </span>
                  </div>
                  <div style="flex:1;min-width:0;">
                    <div class="fw-bold" style="font-size:13px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${item.name}</div>
                    <small class="text-muted">${item.unit}</small>
                  </div>
                  <div style="color:#0077b6;font-weight:700;font-size:13px;white-space:nowrap;">
                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>đ
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- Tổng -->
            <div class="p-3">
              <div class="d-flex justify-content-between mb-2" style="font-size:14px;">
                <span class="text-muted">Tạm tính:</span>
                <c:if test="${discountPct > 0}">
                  <div class="d-flex justify-content-between mb-1" style="font-size:13px;color:#16a34a;">
                    <span>Chiết khấu thành viên (${discountPct}%)</span>
                    <span>- <fmt:formatNumber value="${discount}" pattern="#,###"/>đ</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1" style="font-size:13px;color:#64748b;">
                    <span>Tạm tính</span>
                    <span><fmt:formatNumber value="${subtotal}" pattern="#,###"/>đ</span>
                  </div>
                  <hr style="margin:8px 0;">
                </c:if>
                <span class="fw-bold"><fmt:formatNumber value="${total}" pattern="#,###"/>đ</span>
              </div>
              <div class="d-flex justify-content-between mb-2" style="font-size:14px;">
                <span class="text-muted">Phí vận chuyển:</span>
                <span class="text-success fw-bold"><i class="bi bi-truck me-1"></i>Miễn phí</span>
              </div>
              <div class="d-flex justify-content-between mb-2" style="font-size:14px;">
                <span class="text-muted">Thanh toán:</span>
                <span class="fw-bold" id="selectedPayLabel">💵 Tiền mặt (COD)</span>
              </div>
              <hr class="my-2">
              <div class="d-flex justify-content-between fw-bold" style="font-size:1.15rem;">
                <span>Tổng cộng:</span>
                <span class="text-danger"><fmt:formatNumber value="${total}" pattern="#,###"/>đ</span>
              </div>
            </div>

            <div class="px-3 pb-3">
              <button type="submit" class="btn btn-primary w-100 py-3 fw-bold" style="border-radius:12px;font-size:16px;">
                <i class="bi bi-check-circle me-2"></i>Xác nhận đặt hàng
              </button>
              <a href="/dyleeseafood/cart" class="btn btn-outline-secondary w-100 mt-2">← Quay lại giỏ hàng</a>
            </div>

            <div class="px-3 pb-3">
              <div class="p-3 bg-light rounded-3" style="font-size:12px;">
                <div class="d-flex gap-2 mb-1"><i class="bi bi-shield-check text-success"></i><span class="text-muted">Thanh toán an toàn &amp; bảo mật</span></div>
                <div class="d-flex gap-2 mb-1"><i class="bi bi-truck text-primary"></i><span class="text-muted">Giao hàng trong 2 giờ</span></div>
                <div class="d-flex gap-2"><i class="bi bi-arrow-repeat text-warning"></i><span class="text-muted">Đổi trả trong 24h nếu lỗi</span></div>
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
  'cod':     { label: '💵 Tiền mặt (COD)',       value: 'COD' },
  'bank':    { label: '🏦 Chuyển khoản',          value: 'bank_transfer' },
  'momo':    { label: '💜 Ví MoMo',               value: 'momo' },
  'vnpay':   { label: '🔵 VNPay',                 value: 'vnpay' },
  'zalopay': { label: '🔷 ZaloPay',               value: 'zalopay' }
};

var bankData = {
  'vcb': { name:'Vietcombank (VCB)', number:'1234 5678 9012', raw:'1234567890' },
  'tcb': { name:'Techcombank (TCB)', number:'9876 5432 1098', raw:'9876543210' },
  'mb':  { name:'MB Bank (MBB)',     number:'5555 7777 9999', raw:'5555777799' }
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
      chk.innerHTML = '<i class="bi bi-check text-white" style="font-size:13px;"></i>';
      detail.classList.add('show');
    } else {
      card.classList.remove('active');
      chk.classList.remove('checked');
      chk.innerHTML = '';
      detail.classList.remove('show');
    }
  });
  document.getElementById('paymentMethod').value = payMethods[method].value;
  document.getElementById('selectedPayLabel').textContent = payMethods[method].label;
}

function selectBank(bankKey, e) {
  e.stopPropagation();
  var data = bankData[bankKey];
  document.querySelectorAll('.bank-card').forEach(function(b){ b.classList.remove('selected'); });
  document.getElementById('bank-' + bankKey).classList.add('selected');
  document.getElementById('bankName').textContent   = data.name;
  document.getElementById('bankNumber').textContent = data.number;
  document.querySelector('#detail-bank .copy-btn').onclick = function(){ copyText(this, data.raw); };
}

function copyText(btn, text) {
  navigator.clipboard.writeText(text).then(function() {
    var orig = btn.textContent;
    btn.textContent = '✓ Đã chép';
    btn.classList.add('copied');
    setTimeout(function() {
      btn.textContent = 'Sao chép';
      btn.classList.remove('copied');
    }, 2000);
  }).catch(function() {
    var ta = document.createElement('textarea');
    ta.value = text;
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
    btn.textContent = '✓ Đã chép';
    btn.classList.add('copied');
    setTimeout(function() {
      btn.textContent = 'Sao chép';
      btn.classList.remove('copied');
    }, 2000);
  });
}
</script>

<script>
/* ══ ADDRESS: CHUYỂN MODE ══ */
function useMode(mode) {
  var panelSaved = document.getElementById('panelSaved');
  var panelNew   = document.getElementById('panelNew');
  var btnSaved   = document.getElementById('btnSaved');
  var btnNew     = document.getElementById('btnNew');
  var radioNew   = document.getElementById('radioNew');
  var inAddr     = document.getElementById('inAddress');
  var inCity     = document.getElementById('inCity');
  var inFull     = document.getElementById('inFullName');
  var inPhone    = document.getElementById('inPhone');

  if (mode === 'saved') {
    if(panelSaved) panelSaved.style.display = 'block';
    if(panelNew)   panelNew.style.display   = 'none';
    if(btnSaved)   { btnSaved.classList.add('active'); }
    if(btnNew)     { btnNew.classList.remove('active'); }
    // Bỏ check radioNew
    if(radioNew) radioNew.checked = false;
    // Bỏ required khỏi input mới
    [inAddr, inCity, inFull, inPhone].forEach(function(el){
      if(el) el.removeAttribute('required');
    });
    // Đảm bảo có 1 địa chỉ được chọn
    var checked = document.querySelector(
      'input[name=savedAddressId]:not(#radioNew):checked');
    if (!checked) {
      var first = document.querySelector(
        'input[name=savedAddressId]:not(#radioNew)');
      if (first) {
        first.checked = true;
        var card = first.closest('.addr-choice-card');
        if (card) highlightCard(card, first.value);
      }
    }
  } else {
    if(panelSaved) panelSaved.style.display = 'none';
    if(panelNew)   panelNew.style.display   = 'block';
    if(btnSaved)   { btnSaved.classList.remove('active'); }
    if(btnNew)     { btnNew.classList.add('active'); }
    // Check radioNew
    if(radioNew) radioNew.checked = true;
    // Bỏ check tất cả saved
    document.querySelectorAll(
      'input[name=savedAddressId]:not(#radioNew)').forEach(function(r){
      r.checked = false;
    });
    // Bỏ selected khỏi tất cả card
    document.querySelectorAll('.addr-choice-card').forEach(function(c){
      c.classList.remove('selected');
    });
    document.querySelectorAll('.addr-radio').forEach(function(r){
      r.classList.remove('checked');
    });
    // Thêm required cho input mới
    if(inAddr)  inAddr.setAttribute('required','required');
    if(inCity)  inCity.setAttribute('required','required');
    if(inFull)  inFull.setAttribute('required','required');
    if(inPhone) inPhone.setAttribute('required','required');
    // Focus vào ô họ tên
    if(inFull) setTimeout(function(){ inFull.focus(); }, 100);
  }
}

/* ══ ADDRESS: CHỌN 1 ĐỊA CHỈ ĐÃ LƯU ══ */
function selectSavedAddr(id, card) {
  // Bỏ chọn tất cả
  document.querySelectorAll('.addr-choice-card').forEach(function(c){
    c.classList.remove('selected');
  });
  document.querySelectorAll('.addr-radio').forEach(function(r){
    r.classList.remove('checked');
  });
  document.querySelectorAll(
    'input[name=savedAddressId]:not(#radioNew)').forEach(function(r){
    r.checked = false;
  });
  // Chọn card này
  card.classList.add('selected');
  var radioDiv = document.getElementById('radio_' + id);
  if (radioDiv) radioDiv.classList.add('checked');
  var input = card.querySelector('input[type=radio]');
  if (input) input.checked = true;
}

function highlightCard(card, id) {
  document.querySelectorAll('.addr-choice-card').forEach(function(c){
    c.classList.remove('selected');
  });
  document.querySelectorAll('.addr-radio').forEach(function(r){
    r.classList.remove('checked');
  });
  card.classList.add('selected');
  var radioDiv = document.getElementById('radio_' + id);
  if (radioDiv) radioDiv.classList.add('checked');
}

/* ══ VALIDATE TRƯỚC KHI SUBMIT ══ */
document.getElementById('orderForm').addEventListener('submit', function(e) {
  var panelNew = document.getElementById('panelNew');
  var isSaved  = !panelNew || panelNew.style.display === 'none';

  if (isSaved) {
    // Kiểm tra đã chọn địa chỉ chưa
    var checked = document.querySelector(
      'input[name=savedAddressId]:not(#radioNew):checked');
    if (!checked) {
      e.preventDefault();
      alert('Vui lòng chọn địa chỉ giao hàng!');
      return;
    }
  } else {
    // Kiểm tra các field bắt buộc
    var inFull  = document.getElementById('inFullName');
    var inPhone = document.getElementById('inPhone');
    var inAddr  = document.getElementById('inAddress');
    var inCity  = document.getElementById('inCity');

    var missing = [];
    if (inFull  && !inFull.value.trim())  missing.push('Họ tên người nhận');
    if (inPhone && !inPhone.value.trim()) missing.push('Số điện thoại');
    if (inAddr  && !inAddr.value.trim())  missing.push('Địa chỉ');
    if (inCity  && !inCity.value.trim())  missing.push('Tỉnh/Thành phố');

    if (missing.length > 0) {
      e.preventDefault();
      alert('Vui lòng điền: ' + missing.join(', '));
      return;
    }
  }
});
</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
