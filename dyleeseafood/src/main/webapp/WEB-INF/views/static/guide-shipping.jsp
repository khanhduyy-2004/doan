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
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Vận chuyển</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-truck me-2"></i>Chính sách vận chuyển</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:820px;">
  
<div class="card-s">
  <h5 class="fw-bold mb-1" style="color:var(--dark);">Chính sách vận chuyển</h5>
  <div class="divider"></div>
  <div style="background:#e8f5e9;border-radius:12px;padding:18px;margin-bottom:20px;border:1px solid #c8e6c9;">
    <div class="fw-bold mb-1" style="color:#2e7d32;font-size:14px;"><i class="bi bi-truck me-2"></i>Miễn phí vận chuyển toàn khu vực Hải Phòng</div>
    <div style="font-size:13px;color:#4a5568;">Không giới hạn giá trị đơn hàng. Áp dụng 7:00–21:00 hàng ngày.</div>
  </div>
  <div style="font-size:14px;font-weight:700;margin-bottom:12px;color:var(--dark);">Thời gian giao hàng</div>
  <div style="display:flex;flex-direction:column;gap:10px;font-size:13px;color:#4a5568;">
    <div style="display:flex;gap:10px;"><i class="bi bi-check-circle-fill text-success mt-1;flex-shrink:0;"></i><span><strong>Giao trong 2 giờ</strong> với đơn hàng đặt từ 7:00–19:00</span></div>
    <div style="display:flex;gap:10px;"><i class="bi bi-check-circle-fill text-success mt-1;flex-shrink:0;"></i><span>Đơn đặt sau 19:00 sẽ <strong>giao sáng hôm sau</strong> từ 7:00</span></div>
    <div style="display:flex;gap:10px;"><i class="bi bi-info-circle text-primary mt-1;flex-shrink:0;"></i><span>Thời gian có thể thay đổi vào dịp lễ hoặc thời tiết xấu</span></div>
  </div>
</div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
