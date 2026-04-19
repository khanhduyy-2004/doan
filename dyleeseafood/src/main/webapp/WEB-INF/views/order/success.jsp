<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .success-icon {
    width:88px; height:88px; background:#e8f5e9;
    border-radius:50%; margin:0 auto 20px;
    display:flex; align-items:center;
    justify-content:center;
    animation:popIn 0.5s cubic-bezier(0.175,0.885,0.32,1.275);
  }
  @keyframes popIn {
    from { transform:scale(0); opacity:0; }
    to   { transform:scale(1); opacity:1; }
  }
  .info-row {
    display:flex; justify-content:space-between;
    align-items:center; padding:9px 0;
    border-bottom:1px solid #f0f2f5; font-size:13.5px;
  }
  .info-row:last-child { border:none; }
  .pay-reminder {
    border-radius:14px; padding:20px;
    margin-bottom:20px;
  }
  .step-guide-item {
    display:flex; align-items:flex-start;
    gap:10px; font-size:13px; margin-bottom:8px;
  }
  .step-num {
    width:22px; height:22px; border-radius:50%;
    display:flex; align-items:center;
    justify-content:center; font-size:11px;
    font-weight:700; color:white; flex-shrink:0;
  }
  .copy-btn {
    font-size:11px; padding:2px 10px;
    border-radius:20px; border:1px solid;
    background:white; cursor:pointer; transition:0.15s;
  }
  .copy-btn.copied { color:white!important; }
  .monospace { font-family:'Courier New',monospace; letter-spacing:1px; }
  .progress-track {
    display:flex; align-items:center; gap:0;
    margin:20px 0;
  }
  .prog-step {
    display:flex; flex-direction:column;
    align-items:center; gap:4px; flex:1;
  }
  .prog-dot {
    width:28px; height:28px; border-radius:50%;
    display:flex; align-items:center;
    justify-content:center; font-size:12px;
    font-weight:700; z-index:1;
  }
  .prog-line { flex:1; height:3px; margin-top:-14px; }
  .prog-label { font-size:10px; text-align:center; }
</style>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-8">

      <!-- CARD CHÍNH -->
      <div class="card border-0 shadow-sm text-center p-4 p-md-5 mb-4"
           style="border-radius:20px;">

        <div class="success-icon">
          <i class="bi bi-check-circle-fill text-success" style="font-size:2.8rem;"></i>
        </div>
        <h3 class="fw-bold text-success mb-1">Đặt hàng thành công!</h3>
        <p class="text-muted mb-4" style="font-size:15px;">
          Cảm ơn bạn đã mua hàng tại
          <strong style="color:#0077b6;">🐟 Dylee Seafood</strong>.
          Chúng tôi sẽ liên hệ xác nhận sớm nhất!
        </p>

        <!-- TIẾN TRÌNH ĐƠN HÀNG -->
        <div class="progress-track mb-4">
          <div class="prog-step">
            <div class="prog-dot" style="background:#0077b6;color:white;">
              <i class="bi bi-check" style="font-size:14px;"></i>
            </div>
            <span class="prog-label fw-bold" style="color:#0077b6;">Đặt hàng</span>
          </div>
          <div class="prog-line" style="background:#0077b6;flex:1;height:3px;margin-top:-14px;"></div>
          <div class="prog-step">
            <div class="prog-dot" style="background:#ffc107;color:white;">⏳</div>
            <span class="prog-label fw-bold" style="color:#ffc107;font-size:10px;">Xác nhận</span>
          </div>
          <div class="prog-line" style="background:#e8edf5;flex:1;height:3px;margin-top:-14px;"></div>
          <div class="prog-step">
            <div class="prog-dot" style="background:#e8edf5;color:#aaa;">🚚</div>
            <span class="prog-label" style="color:#aaa;font-size:10px;">Giao hàng</span>
          </div>
          <div class="prog-line" style="background:#e8edf5;flex:1;height:3px;margin-top:-14px;"></div>
          <div class="prog-step">
            <div class="prog-dot" style="background:#e8edf5;color:#aaa;">✅</div>
            <span class="prog-label" style="color:#aaa;font-size:10px;">Hoàn thành</span>
          </div>
        </div>

        <!-- THÔNG TIN ĐƠN HÀNG -->
        <div class="text-start mb-4 p-4 bg-light rounded-3">
          <div class="info-row">
            <span class="text-muted">Mã đơn hàng</span>
            <span class="fw-bold text-primary" style="font-size:16px;">#DL${order.id}</span>
          </div>
          <div class="info-row">
            <span class="text-muted">Tổng tiền</span>
            <span class="fw-bold text-danger" style="font-size:15px;">
              <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
            </span>
          </div>
          <div class="info-row">
            <span class="text-muted">Phương thức</span>
            <span class="fw-bold">
              <c:choose>
                <c:when test="${order.paymentMethod=='COD'}">
                  <span style="color:#2e7d32;"><i class="bi bi-cash-coin me-1"></i>Tiền mặt (COD)</span>
                </c:when>
                <c:when test="${order.paymentMethod=='bank_transfer'}">
                  <span style="color:#0077b6;"><i class="bi bi-bank me-1"></i>Chuyển khoản</span>
                </c:when>
                <c:when test="${order.paymentMethod=='momo'}">
                  <span style="color:#ae2070;"><i class="bi bi-phone-fill me-1"></i>Ví MoMo</span>
                </c:when>
                <c:when test="${order.paymentMethod=='vnpay'}">
                  <span style="color:#0066b3;"><i class="bi bi-qr-code me-1"></i>VNPay</span>
                </c:when>
                <c:when test="${order.paymentMethod=='zalopay'}">
                  <span style="color:#006af5;"><i class="bi bi-wallet2 me-1"></i>ZaloPay</span>
                </c:when>
              </c:choose>
            </span>
          </div>
          <div class="info-row">
            <span class="text-muted">Trạng thái TT</span>
            <c:choose>
              <c:when test="${order.paymentMethod=='COD'}">
                <span class="badge" style="background:#fff8e6;color:#e65100;font-size:12px;">⏳ Thanh toán khi nhận</span>
              </c:when>
              <c:otherwise>
                <span class="badge" style="background:#fef0f0;color:#c62828;font-size:12px;">❗ Chưa thanh toán</span>
              </c:otherwise>
            </c:choose>
          </div>
          <div class="info-row">
            <span class="text-muted">Ngày đặt</span>
            <span class="fw-bold">${order.orderDate}</span>
          </div>
          <div class="info-row">
            <span class="text-muted">Trạng thái</span>
            <span class="badge bg-warning text-dark" style="font-size:12px;">⏳ Chờ xác nhận</span>
          </div>
        </div>

        <!-- ===== PHẦN THANH TOÁN THEO PHƯƠNG THỨC ===== -->

        <%-- COD --%>
        <c:if test="${order.paymentMethod=='COD'}">
          <div class="pay-reminder text-start" style="background:#e8f5e9;border:1px solid #c8e6c9;">
            <div class="d-flex align-items-center gap-2 mb-3">
              <div style="width:36px;height:36px;background:#2e7d32;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <i class="bi bi-cash-coin text-white" style="font-size:1rem;"></i>
              </div>
              <div>
                <div class="fw-bold" style="color:#2e7d32;">Thanh toán khi nhận hàng (COD)</div>
                <small class="text-muted">Chuẩn bị sẵn tiền mặt</small>
              </div>
            </div>
            <div style="background:white;border-radius:10px;padding:12px 16px;margin-bottom:12px;">
              <div class="d-flex justify-content-between">
                <span class="text-muted" style="font-size:13px;">Số tiền cần chuẩn bị:</span>
                <span class="fw-bold text-danger" style="font-size:18px;">
                  <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
                </span>
              </div>
            </div>
            <div style="display:flex;flex-direction:column;gap:6px;">
              <div class="step-guide-item">
                <div class="step-num" style="background:#2e7d32;">1</div>
                <span>Chờ nhân viên gọi điện xác nhận đơn hàng</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#2e7d32;">2</div>
                <span>Chuẩn bị đúng <strong><fmt:formatNumber value="${order.total}" pattern="#,###"/>đ</strong> — ưu tiên tiền lẻ</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#2e7d32;">3</div>
                <span>Kiểm tra hàng kỹ trước khi ký nhận và thanh toán</span>
              </div>
            </div>
          </div>
        </c:if>

        <%-- BANK TRANSFER --%>
        <c:if test="${order.paymentMethod=='bank_transfer'}">
          <div class="pay-reminder text-start" style="background:#e3f2fd;border:1px solid #bbdefb;">
            <div class="d-flex align-items-center gap-2 mb-3">
              <div style="width:36px;height:36px;background:#0077b6;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <i class="bi bi-bank text-white" style="font-size:1rem;"></i>
              </div>
              <div>
                <div class="fw-bold" style="color:#0077b6;">Chuyển khoản ngân hàng</div>
                <small class="text-danger fw-bold">❗ Vui lòng chuyển khoản trong vòng 30 phút</small>
              </div>
            </div>
            <div style="background:white;border-radius:10px;padding:14px;margin-bottom:12px;">
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Ngân hàng</span>
                <span class="fw-bold" style="color:#007b40;">Vietcombank (VCB)</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Số tài khoản</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold monospace">1234 5678 9012</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'1234567890')" style="border-color:#0077b6;color:#0077b6;">Sao chép</button>
                </div>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Chủ tài khoản</span>
                <span class="fw-bold">DYLEE SEAFOOD</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Số tiền</span>
                <span class="fw-bold" style="color:#0077b6;font-size:16px;">
                  <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
                </span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Nội dung CK</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold monospace" style="font-size:12px;">DYLEE DL${order.id}</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'DYLEE DL${order.id}')" style="border-color:#0077b6;color:#0077b6;">Sao chép</button>
                </div>
              </div>
            </div>
            <div style="display:flex;flex-direction:column;gap:6px;">
              <div class="step-guide-item">
                <div class="step-num" style="background:#0077b6;">1</div>
                <span>Mở app ngân hàng → Chuyển tiền</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#0077b6;">2</div>
                <span>Nhập STK: <strong>1234 5678 9012</strong> — Vietcombank</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#0077b6;">3</div>
                <span>Nội dung: <strong>DYLEE DL${order.id}</strong> — bắt buộc đúng</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#0077b6;">4</div>
                <span>Đơn hàng được duyệt tự động sau khi nhận chuyển khoản</span>
              </div>
            </div>
            <div class="mt-2 p-2" style="background:#fff8e6;border-radius:8px;border:1px solid #ffe0b2;font-size:12px;color:#e65100;">
              <i class="bi bi-exclamation-triangle-fill me-1"></i>
              <strong>Lưu ý:</strong> Sai nội dung chuyển khoản sẽ không xác nhận được đơn!
            </div>
          </div>
        </c:if>

        <%-- MOMO --%>
        <c:if test="${order.paymentMethod=='momo'}">
          <div class="pay-reminder text-start" style="background:#fce4ec;border:1px solid #f8bbd9;">
            <div class="d-flex align-items-center gap-2 mb-3">
              <div style="width:36px;height:36px;background:#ae2070;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <span style="color:white;font-size:11px;font-weight:900;">Mo</span>
              </div>
              <div>
                <div class="fw-bold" style="color:#ae2070;">Thanh toán qua MoMo</div>
                <small class="text-danger fw-bold">❗ Vui lòng chuyển tiền trong vòng 15 phút</small>
              </div>
            </div>
            <div style="background:white;border-radius:10px;padding:14px;margin-bottom:12px;">
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">SĐT nhận tiền</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold">0909 999 888</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'0909999888')" style="border-color:#ae2070;color:#ae2070;">Sao chép</button>
                </div>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Tên tài khoản</span>
                <span class="fw-bold">DYLEE SEAFOOD</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Số tiền</span>
                <span class="fw-bold" style="color:#ae2070;font-size:16px;">
                  <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
                </span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Nội dung</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold monospace" style="font-size:12px;">DYLEE DL${order.id}</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'DYLEE DL${order.id}')" style="border-color:#ae2070;color:#ae2070;">Sao chép</button>
                </div>
              </div>
            </div>
            <div style="display:flex;flex-direction:column;gap:6px;">
              <div class="step-guide-item">
                <div class="step-num" style="background:#ae2070;">1</div>
                <span>Mở app <strong>MoMo</strong> → Chọn <strong>Chuyển tiền</strong></span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#ae2070;">2</div>
                <span>Nhập số điện thoại: <strong>0909 999 888</strong></span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#ae2070;">3</div>
                <span>Nhập số tiền và nội dung: <strong>DYLEE DL${order.id}</strong></span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#ae2070;">4</div>
                <span>Xác nhận bằng mã PIN hoặc Face ID</span>
              </div>
            </div>
          </div>
        </c:if>

        <%-- VNPAY --%>
        <c:if test="${order.paymentMethod=='vnpay'}">
          <div class="pay-reminder text-start" style="background:#e8f0fe;border:1px solid #c5d8fa;">
            <div class="d-flex align-items-center gap-2 mb-3">
              <div style="width:36px;height:36px;background:#0066b3;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <span style="color:white;font-size:11px;font-weight:900;">VN</span>
              </div>
              <div>
                <div class="fw-bold" style="color:#0066b3;">Thanh toán qua VNPay</div>
                <small class="text-danger fw-bold">❗ Vui lòng thanh toán trong vòng 15 phút</small>
              </div>
            </div>
            <div style="background:white;border-radius:10px;padding:14px;margin-bottom:12px;">
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Đơn hàng</span>
                <span class="fw-bold" style="color:#0066b3;">#DL${order.id}</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Số tiền</span>
                <span class="fw-bold" style="color:#0066b3;font-size:16px;">
                  <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
                </span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Người nhận</span>
                <span class="fw-bold">DYLEE SEAFOOD</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Phương thức</span>
                <span style="font-size:12px;color:#8a9ab0;">QR Code · ATM · Thẻ tín dụng</span>
              </div>
            </div>
            <div style="display:flex;flex-direction:column;gap:6px;">
              <div class="step-guide-item">
                <div class="step-num" style="background:#0066b3;">1</div>
                <span>Mở app <strong>VNPay</strong> → Quét QR code đã hiển thị lúc đặt hàng</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#0066b3;">2</div>
                <span>Hoặc: <strong>Thanh toán hóa đơn</strong> → tìm Dylee Seafood</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#0066b3;">3</div>
                <span>Nhập mã đơn hàng: <strong>DL${order.id}</strong> → xác nhận</span>
              </div>
            </div>
          </div>
        </c:if>

        <%-- ZALOPAY --%>
        <c:if test="${order.paymentMethod=='zalopay'}">
          <div class="pay-reminder text-start" style="background:#e3f6ff;border:1px solid #b3e5fc;">
            <div class="d-flex align-items-center gap-2 mb-3">
              <div style="width:36px;height:36px;background:#006af5;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <span style="color:white;font-size:11px;font-weight:900;">Z</span>
              </div>
              <div>
                <div class="fw-bold" style="color:#006af5;">Thanh toán qua ZaloPay</div>
                <small class="text-danger fw-bold">❗ Vui lòng chuyển tiền trong vòng 15 phút</small>
              </div>
            </div>
            <div style="background:white;border-radius:10px;padding:14px;margin-bottom:12px;">
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">SĐT nhận tiền</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold">0909 888 777</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'0909888777')" style="border-color:#006af5;color:#006af5;">Sao chép</button>
                </div>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Tên tài khoản</span>
                <span class="fw-bold">DYLEE SEAFOOD</span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Số tiền</span>
                <span class="fw-bold" style="color:#006af5;font-size:16px;">
                  <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
                </span>
              </div>
              <div class="info-row">
                <span class="text-muted" style="font-size:13px;">Nội dung</span>
                <div class="d-flex align-items-center gap-2">
                  <span class="fw-bold monospace" style="font-size:12px;">DYLEE DL${order.id}</span>
                  <button type="button" class="copy-btn" onclick="copyText(this,'DYLEE DL${order.id}')" style="border-color:#006af5;color:#006af5;">Sao chép</button>
                </div>
              </div>
            </div>
            <div style="display:flex;flex-direction:column;gap:6px;">
              <div class="step-guide-item">
                <div class="step-num" style="background:#006af5;">1</div>
                <span>Mở app <strong>ZaloPay</strong> → Chọn <strong>Chuyển tiền</strong></span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#006af5;">2</div>
                <span>Nhập SĐT: <strong>0909 888 777</strong> hoặc quét QR</span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#006af5;">3</div>
                <span>Nhập số tiền và nội dung: <strong>DYLEE DL${order.id}</strong></span>
              </div>
              <div class="step-guide-item">
                <div class="step-num" style="background:#006af5;">4</div>
                <span>Xác nhận bằng mã PIN hoặc vân tay</span>
              </div>
            </div>
          </div>
        </c:if>

        <!-- SẢN PHẨM ĐÃ ĐẶT -->
        <c:if test="${not empty items}">
          <div class="text-start mb-4">
            <h6 class="fw-bold mb-3">
              <i class="bi bi-box-seam text-primary me-2"></i>Sản phẩm đã đặt
            </h6>
            <c:forEach var="item" items="${items}">
              <div class="d-flex align-items-center gap-3 py-2" style="border-bottom:1px solid #f0f0f0;">
                <div style="flex:1;">
                  <div class="fw-bold" style="font-size:13.5px;">${item.productName}</div>
                  <small class="text-muted">
                    <fmt:formatNumber value="${item.quantity}" pattern="#.##"/>
                    ${item.productUnit} ×
                    <fmt:formatNumber value="${item.price}" pattern="#,###"/>đ
                  </small>
                </div>
                <div class="fw-bold" style="color:#0077b6;white-space:nowrap;">
                  <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>đ
                </div>
              </div>
            </c:forEach>
            <div class="d-flex justify-content-between fw-bold mt-2 pt-2" style="font-size:15px;">
              <span>Tổng cộng:</span>
              <span class="text-danger"><fmt:formatNumber value="${order.total}" pattern="#,###"/>đ</span>
            </div>
          </div>
        </c:if>

        <!-- THÔNG TIN GIAO HÀNG -->
        <div class="p-3 mb-4 text-start" style="border:1.5px solid #0077b6;border-radius:12px;">
          <h6 class="fw-bold mb-2 text-primary">
            <i class="bi bi-truck me-2"></i>Thông tin giao hàng
          </h6>
          <div style="font-size:13px;color:#4a5568;line-height:1.8;">
            <div><i class="bi bi-clock me-2 text-primary"></i>Dự kiến giao trong <strong>2 giờ</strong> kể từ khi xác nhận</div>
            <div><i class="bi bi-telephone me-2 text-primary"></i>Nhân viên sẽ gọi điện xác nhận trước khi giao</div>
            <div><i class="bi bi-arrow-repeat me-2 text-warning"></i>Đổi trả trong 24h nếu hàng lỗi hoặc không đúng</div>
          </div>
        </div>

        <!-- NÚT ĐIỀU HƯỚNG -->
        <div class="d-flex gap-2 flex-wrap mb-2">
          <a href="/dyleeseafood/order/history" class="btn btn-outline-primary flex-fill py-2">
            <i class="bi bi-clock-history me-1"></i>Lịch sử đơn hàng
          </a>
          <a href="/dyleeseafood/profile" class="btn btn-outline-secondary flex-fill py-2">
            <i class="bi bi-person-circle me-1"></i>Tài khoản
          </a>
        </div>
        <div class="d-flex gap-2 flex-wrap">
          <a href="/dyleeseafood/home" class="btn btn-primary flex-fill py-2">
            <i class="bi bi-house me-1"></i>Về trang chủ
          </a>
          <a href="/dyleeseafood/products" class="btn btn-outline-primary flex-fill py-2">
            <i class="bi bi-shop me-1"></i>Mua thêm
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
function copyText(btn, text) {
  navigator.clipboard.writeText(text).then(function() {
    var orig = btn.textContent;
    btn.textContent = '✓ Đã chép';
    btn.classList.add('copied');
    btn.style.backgroundColor = '#28a745';
    btn.style.borderColor = '#28a745';
    setTimeout(function() {
      btn.textContent = 'Sao chép';
      btn.classList.remove('copied');
      btn.style.backgroundColor = '';
      btn.style.borderColor = '';
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
    btn.style.backgroundColor = '#28a745';
    btn.style.borderColor = '#28a745';
    setTimeout(function() {
      btn.textContent = 'Sao chép';
      btn.classList.remove('copied');
      btn.style.backgroundColor = '';
      btn.style.borderColor = '';
    }, 2000);
  });
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
