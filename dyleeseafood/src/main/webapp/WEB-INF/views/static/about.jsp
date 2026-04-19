<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:28px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.stat-box{text-align:center;padding:20px;background:#f0f8ff;border-radius:14px;border:1px solid #bee3f8;}
.team-card{text-align:center;background:white;border-radius:14px;padding:24px;box-shadow:0 2px 12px rgba(0,0,0,0.07);}
.team-avatar{width:72px;height:72px;border-radius:50%;margin:0 auto 12px;display:flex;align-items:center;justify-content:center;font-size:1.6rem;font-weight:700;}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Giới thiệu</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-info-circle me-2"></i>Giới thiệu về Dylee Seafood</h4>
  </div>
</div>
<div class="container mt-4 mb-5">
  <div class="row g-4">
    <div class="col-lg-8">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Chúng tôi là ai?</h5>
        <div class="divider"></div>
        <p style="font-size:14px;color:#4a5568;line-height:1.85;">Dylee Seafood là thương hiệu hải sản tươi sống hàng đầu tại Hải Phòng, được thành lập với sứ mệnh mang đến những sản phẩm hải sản chất lượng cao, tươi ngon trực tiếp từ biển đến bàn ăn của mỗi gia đình Việt Nam.</p>
        <p style="font-size:14px;color:#4a5568;line-height:1.85;">Với hơn 5 năm hoạt động trong lĩnh vực cung cấp hải sản, chúng tôi đã xây dựng được mạng lưới đối tác ngư dân tin cậy tại các vùng biển Hải Phòng, Quảng Ninh và Nghệ An, đảm bảo nguồn cung ổn định, tươi sống quanh năm.</p>
        <div class="row g-3 mt-2">
          <div class="col-6 col-md-3"><div class="stat-box"><div style="font-size:1.8rem;font-weight:800;color:var(--primary);">5+</div><div style="font-size:12px;color:#8a9ab0;">Năm kinh nghiệm</div></div></div>
          <div class="col-6 col-md-3"><div class="stat-box"><div style="font-size:1.8rem;font-weight:800;color:var(--primary);">500+</div><div style="font-size:12px;color:#8a9ab0;">Khách hàng tin dùng</div></div></div>
          <div class="col-6 col-md-3"><div class="stat-box"><div style="font-size:1.8rem;font-weight:800;color:var(--primary);">50+</div><div style="font-size:12px;color:#8a9ab0;">Loại hải sản</div></div></div>
          <div class="col-6 col-md-3"><div class="stat-box"><div style="font-size:1.8rem;font-weight:800;color:var(--primary);">2h</div><div style="font-size:12px;color:#8a9ab0;">Giao hàng nhanh</div></div></div>
        </div>
      </div>
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Sứ mệnh &amp; Tầm nhìn</h5>
        <div class="divider"></div>
        <div class="row g-3">
          <div class="col-md-6">
            <div style="background:#e3f2fd;border-radius:12px;padding:18px;">
              <div class="fw-bold mb-2" style="color:var(--primary);font-size:14px;"><i class="bi bi-bullseye me-2"></i>Sứ mệnh</div>
              <p style="font-size:13px;color:#4a5568;margin:0;line-height:1.7;">Mang đến hải sản tươi sống, an toàn và giá cả hợp lý cho mọi gia đình Việt Nam, góp phần bảo tồn nghề đánh bắt truyền thống của ngư dân địa phương.</p>
            </div>
          </div>
          <div class="col-md-6">
            <div style="background:#e8f5e9;border-radius:12px;padding:18px;">
              <div class="fw-bold mb-2" style="color:#28a745;font-size:14px;"><i class="bi bi-eye me-2"></i>Tầm nhìn</div>
              <p style="font-size:13px;color:#4a5568;margin:0;line-height:1.7;">Trở thành nền tảng thương mại điện tử hải sản uy tín nhất Việt Nam, kết nối trực tiếp ngư dân và người tiêu dùng một cách minh bạch.</p>
            </div>
          </div>
        </div>
      </div>
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Cam kết của chúng tôi</h5>
        <div class="divider"></div>
        <div style="display:flex;flex-direction:column;gap:12px;">
          <div style="display:flex;gap:14px;align-items:flex-start;">
            <div style="width:40px;height:40px;border-radius:10px;background:#e3f2fd;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="bi bi-fish" style="color:var(--primary);"></i></div>
            <div><div class="fw-bold" style="font-size:14px;">Tươi sống 100%</div><div style="font-size:13px;color:#8a9ab0;line-height:1.6;">Tất cả hải sản được đánh bắt trong ngày, kiểm tra chất lượng nghiêm ngặt trước khi giao đến tay khách hàng.</div></div>
          </div>
          <div style="display:flex;gap:14px;align-items:flex-start;">
            <div style="width:40px;height:40px;border-radius:10px;background:#e8f5e9;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="bi bi-truck" style="color:#28a745;"></i></div>
            <div><div class="fw-bold" style="font-size:14px;">Giao hàng nhanh trong 2 giờ</div><div style="font-size:13px;color:#8a9ab0;line-height:1.6;">Đội ngũ giao hàng chuyên nghiệp với xe lạnh chuyên dụng, đảm bảo hải sản đến tay bạn còn tươi như mới đánh bắt.</div></div>
          </div>
          <div style="display:flex;gap:14px;align-items:flex-start;">
            <div style="width:40px;height:40px;border-radius:10px;background:#fff8e6;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="bi bi-shield-check" style="color:#ff9800;"></i></div>
            <div><div class="fw-bold" style="font-size:14px;">An toàn vệ sinh thực phẩm</div><div style="font-size:13px;color:#8a9ab0;line-height:1.6;">Đạt tiêu chuẩn VSATTP, được cấp phép kinh doanh thực phẩm bởi Sở Y tế Hải Phòng.</div></div>
          </div>
          <div style="display:flex;gap:14px;align-items:flex-start;">
            <div style="width:40px;height:40px;border-radius:10px;background:#fce4ec;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="bi bi-arrow-repeat" style="color:#e91e63;"></i></div>
            <div><div class="fw-bold" style="font-size:14px;">Đổi trả trong 24h</div><div style="font-size:13px;color:#8a9ab0;line-height:1.6;">Nếu hàng không đúng chất lượng như cam kết, chúng tôi đổi lại hoặc hoàn tiền 100% không điều kiện.</div></div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Thông tin liên hệ</h5>
        <div class="divider"></div>
        <div style="font-size:13px;color:#4a5568;line-height:2.3;">
          <div><i class="bi bi-geo-alt-fill me-2" style="color:var(--primary);"></i>Hải Phòng, Việt Nam</div>
          <div><i class="bi bi-telephone-fill me-2" style="color:var(--primary);"></i>0123 456 789</div>
          <div><i class="bi bi-envelope-fill me-2" style="color:var(--primary);"></i>dylee@seafood.vn</div>
          <div><i class="bi bi-clock-fill me-2" style="color:var(--primary);"></i>7:00 – 21:00 hàng ngày</div>
        </div>
        <a href="/dyleeseafood/contact" class="btn btn-primary w-100 mt-3" style="border-radius:10px;">
          <i class="bi bi-chat-dots me-2"></i>Liên hệ ngay
        </a>
      </div>
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Sinh viên thực hiện</h5>
        <div class="divider"></div>
        <div class="team-card p-0 shadow-none">
          <div class="team-avatar" style="background:linear-gradient(135deg,var(--dark),var(--primary));color:white;">D</div>
          <div class="fw-bold" style="font-size:14px;">Lê Trần Khánh Duy</div>
          <div class="text-muted" style="font-size:12px;">MSSV: 2210900020</div>
          <div class="text-muted" style="font-size:12px;">Lập trình Web - Java Spring MVC</div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
