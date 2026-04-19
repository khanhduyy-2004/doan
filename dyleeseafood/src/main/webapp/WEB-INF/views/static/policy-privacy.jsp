<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:32px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.policy-section{margin-bottom:24px;}
.policy-section h6{font-weight:700;color:var(--dark);font-size:14px;margin-bottom:8px;}
.policy-section p{font-size:13px;color:#4a5568;line-height:1.8;margin:0;}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Chính sách bảo mật</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-shield-lock me-2"></i>Chính sách bảo mật</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:820px;">
  <div class="card-s">
    <div style="background:#e3f2fd;border-radius:10px;padding:14px;margin-bottom:24px;font-size:13px;color:#4a5568;">
      <i class="bi bi-info-circle-fill me-2" style="color:var(--primary);"></i>
      Cập nhật lần cuối: <strong>18/04/2026</strong> — Dylee Seafood cam kết bảo vệ thông tin cá nhân của bạn.
    </div>
    <div class="policy-section">
      <h6>1. Thông tin chúng tôi thu thập</h6>
      <p>Khi bạn đăng ký tài khoản hoặc đặt hàng, chúng tôi thu thập: họ tên, số điện thoại, địa chỉ email, địa chỉ giao hàng và lịch sử đặt hàng. Các thông tin này được thu thập nhằm phục vụ quá trình giao dịch và cải thiện trải nghiệm mua sắm của bạn.</p>
    </div>
    <div class="policy-section">
      <h6>2. Mục đích sử dụng thông tin</h6>
      <p>Thông tin của bạn được sử dụng để: xử lý đơn hàng, giao hàng đúng địa chỉ, gửi thông báo về đơn hàng, hỗ trợ khách hàng và (nếu bạn đồng ý) gửi thông tin khuyến mãi.</p>
    </div>
    <div class="policy-section">
      <h6>3. Bảo vệ thông tin</h6>
      <p>Mật khẩu được mã hóa bằng BCrypt. Chúng tôi không lưu trữ thông tin thẻ ngân hàng. Dữ liệu được bảo vệ bởi tường lửa và hệ thống bảo mật nhiều lớp.</p>
    </div>
    <div class="policy-section">
      <h6>4. Chia sẻ thông tin với bên thứ ba</h6>
      <p>Chúng tôi không bán, trao đổi hay chuyển giao thông tin cá nhân của bạn cho bên thứ ba, ngoại trừ đối tác giao hàng (chỉ nhận địa chỉ và số điện thoại) và khi pháp luật yêu cầu.</p>
    </div>
    <div class="policy-section">
      <h6>5. Quyền của bạn</h6>
      <p>Bạn có quyền: xem, chỉnh sửa hoặc xóa thông tin cá nhân của mình bất kỳ lúc nào qua trang Tài khoản; từ chối nhận email marketing; yêu cầu xóa tài khoản bằng cách liên hệ hotline.</p>
    </div>
    <div class="policy-section">
      <h6>6. Liên hệ</h6>
      <p>Mọi thắc mắc về chính sách bảo mật, vui lòng liên hệ: <strong>0123 456 789</strong> hoặc email <strong>dylee@seafood.vn</strong></p>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
