<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:28px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.step-item{display:flex;gap:16px;align-items:flex-start;padding:16px 0;border-bottom:1px solid #f5f5f5;}
.step-item:last-child{border:none;}
.step-num{width:36px;height:36px;border-radius:50%;background:var(--primary);color:white;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:14px;flex-shrink:0;}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Đặt hàng</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-cart-check me-2"></i>Hướng dẫn đặt hàng</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:820px;">
  
<div class="card-s">
  <h5 class="fw-bold mb-1" style="color:var(--dark);">Quy trình đặt hàng</h5>
  <div class="divider"></div>
  <div class="step-item"><div class="step-num">1</div><div><div class="fw-bold" style="font-size:14px;">Chọn sản phẩm</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Duyệt qua danh mục sản phẩm, chọn hải sản bạn muốn mua. Nhấn vào sản phẩm để xem chi tiết về nguồn gốc, giá cả và tình trạng tồn kho.</div></div></div>
  <div class="step-item"><div class="step-num">2</div><div><div class="fw-bold" style="font-size:14px;">Chọn số lượng &amp; Thêm vào giỏ</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Chọn số lượng phù hợp rồi nhấn "Thêm vào giỏ hàng". Tiếp tục chọn thêm sản phẩm hoặc tiến hành thanh toán.</div></div></div>
  <div class="step-item"><div class="step-num">3</div><div><div class="fw-bold" style="font-size:14px;">Kiểm tra giỏ hàng</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Xem lại các sản phẩm trong giỏ, điều chỉnh số lượng nếu cần, rồi nhấn "Tiến hành thanh toán".</div></div></div>
  <div class="step-item"><div class="step-num">4</div><div><div class="fw-bold" style="font-size:14px;">Điền thông tin giao hàng</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Nhập địa chỉ nhận hàng chính xác, số điện thoại liên lạc và ghi chú (nếu có) để chúng tôi giao đúng nơi, đúng yêu cầu.</div></div></div>
  <div class="step-item"><div class="step-num">5</div><div><div class="fw-bold" style="font-size:14px;">Chọn phương thức thanh toán</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Chọn COD, chuyển khoản, MoMo, VNPay hoặc ZaloPay. Xác nhận đơn hàng và chờ xác nhận từ chúng tôi.</div></div></div>
  <div class="step-item"><div class="step-num">6</div><div><div class="fw-bold" style="font-size:14px;">Nhận hàng</div><div style="font-size:13px;color:#8a9ab0;line-height:1.7;">Đơn hàng sẽ được giao trong 2 giờ. Kiểm tra hàng trước khi nhận. Nếu không đạt chất lượng, từ chối nhận và liên hệ hotline.</div></div></div>
</div>
<div class="text-center p-4" style="background:#e8f5e9;border-radius:14px;border:1px solid #c8e6c9;">
  <i class="bi bi-telephone-fill" style="font-size:1.8rem;color:#28a745;"></i>
  <h6 class="fw-bold mt-2 mb-1">Cần hỗ trợ đặt hàng?</h6>
  <p class="text-muted mb-2" style="font-size:13px;">Gọi ngay hotline <strong>0123 456 789</strong> — hỗ trợ 7:00–21:00 hàng ngày</p>
  <a href="/dyleeseafood/products" class="btn btn-success px-4" style="border-radius:10px;"><i class="bi bi-shop me-2"></i>Bắt đầu mua sắm</a>
</div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
