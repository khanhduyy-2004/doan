<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:28px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.accordion-button:not(.collapsed){background:#e3f2fd;color:var(--primary);}
.accordion-button:focus{box-shadow:none;}
.accordion-item{border:1px solid #e8edf5;border-radius:12px!important;margin-bottom:8px;overflow:hidden;}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">FAQ</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-question-circle me-2"></i>Câu hỏi thường gặp</h4>
  </div>
</div>
<div class="container mt-4 mb-5" style="max-width:800px;">
  <div class="card-s">
    <h5 class="fw-bold mb-1" style="color:var(--dark);">Đặt hàng &amp; Giao hàng</h5>
    <div class="divider"></div>
    <div class="accordion accordion-flush" id="faq1">
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#q1">Tôi có thể đặt hàng bằng cách nào?</button></h2><div id="q1" class="accordion-collapse collapse show" data-bs-parent="#faq1"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Bạn có thể đặt hàng trực tiếp trên website Dylee Seafood. Chọn sản phẩm → Thêm vào giỏ → Thanh toán. Hoặc gọi hotline <strong>0123 456 789</strong> để được nhân viên hỗ trợ đặt hàng.</div></div></div>
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q2">Thời gian giao hàng là bao lâu?</button></h2><div id="q2" class="accordion-collapse collapse" data-bs-parent="#faq1"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Chúng tôi cam kết giao hàng trong <strong>2 giờ</strong> kể từ khi đặt hàng thành công, trong khu vực Hải Phòng. Đơn hàng đặt sau 19:00 sẽ được giao vào sáng hôm sau.</div></div></div>
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q3">Phí giao hàng là bao nhiêu?</button></h2><div id="q3" class="accordion-collapse collapse" data-bs-parent="#faq1"><div class="accordion-body" style="font-size:13px;color:#4a5568;"><strong>Miễn phí giao hàng</strong> toàn bộ khu vực Hải Phòng. Không giới hạn giá trị đơn hàng.</div></div></div>
    </div>
  </div>
  <div class="card-s">
    <h5 class="fw-bold mb-1" style="color:var(--dark);">Chất lượng &amp; Đổi trả</h5>
    <div class="divider"></div>
    <div class="accordion accordion-flush" id="faq2">
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q4">Hải sản có đảm bảo tươi sống không?</button></h2><div id="q4" class="accordion-collapse collapse" data-bs-parent="#faq2"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Tất cả hải sản được đánh bắt trong ngày, bảo quản lạnh và kiểm tra chất lượng trước khi giao. Chúng tôi cam kết <strong>100% tươi sống</strong> hoặc hoàn tiền.</div></div></div>
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q5">Tôi có thể đổi trả hàng không?</button></h2><div id="q5" class="accordion-collapse collapse" data-bs-parent="#faq2"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Có. Nếu hàng nhận được không đúng chất lượng cam kết, bạn có thể yêu cầu đổi trả trong <strong>24 giờ</strong> kể từ khi nhận hàng. Chúng tôi sẽ đổi lại hoặc hoàn tiền 100%.</div></div></div>
    </div>
  </div>
  <div class="card-s">
    <h5 class="fw-bold mb-1" style="color:var(--dark);">Thanh toán &amp; Tài khoản</h5>
    <div class="divider"></div>
    <div class="accordion accordion-flush" id="faq3">
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q6">Có những phương thức thanh toán nào?</button></h2><div id="q6" class="accordion-collapse collapse" data-bs-parent="#faq3"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Chúng tôi chấp nhận: <strong>COD</strong> (tiền mặt khi nhận), <strong>Chuyển khoản ngân hàng</strong>, <strong>MoMo</strong>, <strong>VNPay</strong> và <strong>ZaloPay</strong>.</div></div></div>
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q7">Quên mật khẩu phải làm gì?</button></h2><div id="q7" class="accordion-collapse collapse" data-bs-parent="#faq3"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Vui lòng liên hệ hotline <strong>0123 456 789</strong> hoặc email <strong>dylee@seafood.vn</strong>. Nhân viên sẽ xác minh danh tính và cấp lại mật khẩu trong vòng 30 phút.</div></div></div>
      <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q8">Hạng VIP/VVIP có lợi ích gì?</button></h2><div id="q8" class="accordion-collapse collapse" data-bs-parent="#faq3"><div class="accordion-body" style="font-size:13px;color:#4a5568;">Khách hàng <strong>VIP</strong> (chi tiêu từ 5 triệu đồng) được giảm <strong>5%</strong> tự động trên mọi đơn hàng. Khách hàng <strong>VVIP</strong> (từ 20 triệu đồng) được giảm <strong>10%</strong>.</div></div></div>
    </div>
  </div>
  <div class="text-center p-4" style="background:#f0f8ff;border-radius:14px;border:1px solid #bee3f8;">
    <i class="bi bi-headset" style="font-size:2rem;color:var(--primary);"></i>
    <h6 class="fw-bold mt-2 mb-1">Vẫn còn thắc mắc?</h6>
    <p class="text-muted mb-3" style="font-size:13px;">Liên hệ ngay với đội hỗ trợ của chúng tôi</p>
    <a href="/dyleeseafood/contact" class="btn btn-primary px-4" style="border-radius:10px;"><i class="bi bi-chat-dots me-2"></i>Liên hệ hỗ trợ</a>
  </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
