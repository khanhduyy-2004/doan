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
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Thanh toán</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-credit-card me-2"></i>Phương thức thanh toán</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:820px;">
  
<div class="card-s">
  <h5 class="fw-bold mb-1" style="color:var(--dark);">Các phương thức thanh toán</h5>
  <div class="divider"></div>
  <div style="display:flex;flex-direction:column;gap:16px;">
    <div style="border:1.5px solid #e8edf5;border-radius:12px;padding:18px;">
      <div class="fw-bold mb-1" style="font-size:14px;"><span style="background:#e8f5e9;color:#2e7d32;padding:2px 10px;border-radius:10px;font-size:12px;margin-right:8px;">COD</span>Thanh toán khi nhận hàng</div>
      <div style="font-size:13px;color:#4a5568;line-height:1.7;">Trả tiền mặt trực tiếp cho nhân viên giao hàng. Không cần tài khoản ngân hàng hay ví điện tử.</div>
    </div>
    <div style="border:1.5px solid #e8edf5;border-radius:12px;padding:18px;">
      <div class="fw-bold mb-1" style="font-size:14px;"><span style="background:#e3f2fd;color:#0077b6;padding:2px 10px;border-radius:10px;font-size:12px;margin-right:8px;">Bank</span>Chuyển khoản ngân hàng</div>
      <div style="font-size:13px;color:#4a5568;line-height:1.7;">Chuyển khoản đến: <strong>STK: 1234567890</strong> — NH: Vietcombank — Chủ TK: Lê Trần Khánh Duy. Nội dung: Mã đơn hàng.</div>
    </div>
    <div style="border:1.5px solid #e8edf5;border-radius:12px;padding:18px;">
      <div class="fw-bold mb-1" style="font-size:14px;"><span style="background:#fce4ec;color:#ae2070;padding:2px 10px;border-radius:10px;font-size:12px;margin-right:8px;">MoMo</span>Ví MoMo</div>
      <div style="font-size:13px;color:#4a5568;line-height:1.7;">Chuyển đến SĐT: <strong>0909 999 888</strong>. Tên: Dylee Seafood. Nội dung: Mã đơn hàng.</div>
    </div>
    <div style="border:1.5px solid #e8edf5;border-radius:12px;padding:18px;">
      <div class="fw-bold mb-1" style="font-size:14px;"><span style="background:#e3f2fd;color:#0066b3;padding:2px 10px;border-radius:10px;font-size:12px;margin-right:8px;">VNPay</span>VNPay QR</div>
      <div style="font-size:13px;color:#4a5568;line-height:1.7;">Quét mã QR VNPay trên trang thanh toán để thanh toán nhanh qua ứng dụng ngân hàng bất kỳ.</div>
    </div>
    <div style="border:1.5px solid #e8edf5;border-radius:12px;padding:18px;">
      <div class="fw-bold mb-1" style="font-size:14px;"><span style="background:#e3f2fd;color:#006af5;padding:2px 10px;border-radius:10px;font-size:12px;margin-right:8px;">ZaloPay</span>Ví ZaloPay</div>
      <div style="font-size:13px;color:#4a5568;line-height:1.7;">Chuyển đến SĐT: <strong>0909 888 777</strong>. Tên: Dylee Seafood. Nội dung: Mã đơn hàng.</div>
    </div>
  </div>
</div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
