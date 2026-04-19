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
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Đổi trả</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-arrow-repeat me-2"></i>Đổi trả &amp; Hoàn tiền</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:820px;">
  
<div class="card-s">
  <h5 class="fw-bold mb-1" style="color:var(--dark);">Chính sách đổi trả &amp; hoàn tiền</h5>
  <div class="divider"></div>
  <div style="background:#e3f2fd;border-radius:12px;padding:16px;margin-bottom:20px;">
    <div class="fw-bold mb-1" style="color:var(--primary);font-size:14px;"><i class="bi bi-shield-check me-2"></i>Cam kết hoàn tiền 100%</div>
    <div style="font-size:13px;color:#4a5568;">Nếu sản phẩm không đúng chất lượng như cam kết, chúng tôi đổi lại hoặc hoàn tiền đầy đủ, không điều kiện.</div>
  </div>
  <div style="font-size:14px;font-weight:700;margin-bottom:12px;color:var(--dark);">Các trường hợp được đổi trả</div>
  <div style="display:flex;flex-direction:column;gap:10px;font-size:13px;color:#4a5568;margin-bottom:20px;">
    <div style="display:flex;gap:10px;"><i class="bi bi-check-circle-fill text-success mt-1;"></i><span>Hải sản không tươi, có mùi lạ khi nhận hàng</span></div>
    <div style="display:flex;gap:10px;"><i class="bi bi-check-circle-fill text-success mt-1;"></i><span>Sản phẩm giao không đúng loại, không đúng số lượng</span></div>
    <div style="display:flex;gap:10px;"><i class="bi bi-check-circle-fill text-success mt-1;"></i><span>Đóng gói bị hư hỏng trong quá trình vận chuyển</span></div>
  </div>
  <div style="font-size:14px;font-weight:700;margin-bottom:12px;color:var(--dark);">Quy trình đổi trả</div>
  <div class="step-item"><div class="step-num">1</div><div><div class="fw-bold" style="font-size:13px;">Liên hệ hotline 0123 456 789</div><div style="font-size:12px;color:#8a9ab0;">Trong vòng 24h sau khi nhận hàng. Mô tả vấn đề và gửi hình ảnh nếu có.</div></div></div>
  <div class="step-item"><div class="step-num">2</div><div><div class="fw-bold" style="font-size:13px;">Xác nhận đổi trả</div><div style="font-size:12px;color:#8a9ab0;">Nhân viên sẽ xác nhận và thông báo thời gian thu hồi/giao đổi trong 30 phút.</div></div></div>
  <div class="step-item"><div class="step-num">3</div><div><div class="fw-bold" style="font-size:13px;">Nhận hàng đổi hoặc hoàn tiền</div><div style="font-size:12px;color:#8a9ab0;">Hàng đổi giao trong 2h. Hoàn tiền trong 24h qua hình thức thanh toán ban đầu.</div></div></div>
</div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
