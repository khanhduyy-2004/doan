<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:28px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.contact-item{display:flex;gap:14px;align-items:flex-start;padding:14px 0;border-bottom:1px solid #f5f5f5;}
.contact-item:last-child{border:none;}
.contact-icon{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:1.2rem;}
.form-control,.form-select{border:1.5px solid #e8edf5;border-radius:10px;font-size:14px;padding:10px 14px;}
.form-control:focus,.form-select:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(0,119,182,0.1);}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Liên hệ</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-telephone me-2"></i>Liên hệ với chúng tôi</h4>
  </div>
</div>
<div class="container mt-4 mb-5">
  <div class="row g-4">
    <div class="col-lg-5">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Thông tin liên hệ</h5>
        <div class="divider"></div>
        <div class="contact-item">
          <div class="contact-icon" style="background:#e3f2fd;"><i class="bi bi-telephone-fill" style="color:var(--primary);"></i></div>
          <div><div class="fw-bold" style="font-size:14px;">Hotline</div><div style="font-size:13px;color:#8a9ab0;">0123 456 789</div><div style="font-size:12px;color:#8a9ab0;">7:00 – 21:00 hàng ngày</div></div>
        </div>
        <div class="contact-item">
          <div class="contact-icon" style="background:#e8f5e9;"><i class="bi bi-envelope-fill" style="color:#28a745;"></i></div>
          <div><div class="fw-bold" style="font-size:14px;">Email</div><div style="font-size:13px;color:#8a9ab0;">dylee@seafood.vn</div><div style="font-size:12px;color:#8a9ab0;">Phản hồi trong vòng 2 giờ</div></div>
        </div>
        <div class="contact-item">
          <div class="contact-icon" style="background:#fff8e6;"><i class="bi bi-geo-alt-fill" style="color:#ff9800;"></i></div>
          <div><div class="fw-bold" style="font-size:14px;">Địa chỉ</div><div style="font-size:13px;color:#8a9ab0;">Hải Phòng, Việt Nam</div></div>
        </div>
        <div class="contact-item">
          <div class="contact-icon" style="background:#fce4ec;"><i class="bi bi-chat-dots-fill" style="color:#e91e63;"></i></div>
          <div><div class="fw-bold" style="font-size:14px;">Zalo</div><div style="font-size:13px;color:#8a9ab0;">0123 456 789</div><div style="font-size:12px;color:#8a9ab0;">Nhắn tin trực tiếp qua Zalo</div></div>
        </div>
        <div style="background:#f0f8ff;border-radius:12px;padding:16px;margin-top:8px;border:1px solid #bee3f8;">
          <div class="fw-bold mb-1" style="font-size:13px;color:var(--primary);"><i class="bi bi-clock me-1"></i>Giờ làm việc</div>
          <div style="font-size:13px;color:#4a5568;">Thứ 2 – Chủ nhật: <strong>7:00 – 21:00</strong></div>
          <div style="font-size:12px;color:#8a9ab0;">Không nghỉ lễ — Luôn sẵn sàng phục vụ!</div>
        </div>
      </div>
    </div>
    <div class="col-lg-7">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Gửi tin nhắn cho chúng tôi</h5>
        <div class="divider"></div>
        <c:choose>
          <c:when test="${not empty sessionScope.loggedUser}">
            <form>
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label fw-bold" style="font-size:13px;">Họ và tên</label>
                  <input type="text" class="form-control" value="${sessionScope.loggedCustomer.name}" readonly style="background:#f7f9fc;">
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-bold" style="font-size:13px;">Số điện thoại</label>
                  <input type="text" class="form-control" placeholder="0912 345 678">
                </div>
                <div class="col-12">
                  <label class="form-label fw-bold" style="font-size:13px;">Chủ đề</label>
                  <select class="form-select">
                    <option>Tư vấn sản phẩm</option>
                    <option>Đặt hàng số lượng lớn</option>
                    <option>Khiếu nại / Phản hồi</option>
                    <option>Hợp tác kinh doanh</option>
                    <option>Khác</option>
                  </select>
                </div>
                <div class="col-12">
                  <label class="form-label fw-bold" style="font-size:13px;">Nội dung</label>
                  <textarea class="form-control" rows="4" placeholder="Nhập nội dung tin nhắn..."></textarea>
                </div>
                <div class="col-12">
                  <button type="button" class="btn btn-primary px-5" style="border-radius:10px;"
                          onclick="this.innerHTML='<i class=&quot;bi bi-check-circle me-2&quot;></i>Đã gửi!';this.disabled=true;this.style.background='#28a745';">
                    <i class="bi bi-send me-2"></i>Gửi tin nhắn
                  </button>
                </div>
              </div>
            </form>
          </c:when>
          <c:otherwise>
            <div class="text-center py-4">
              <i class="bi bi-lock" style="font-size:3rem;color:#dde3ed;"></i>
              <p class="text-muted mt-2 mb-3">Đăng nhập để gửi tin nhắn trực tiếp cho chúng tôi</p>
              <a href="/dyleeseafood/login" class="btn btn-primary px-4" style="border-radius:10px;">
                <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
              </a>
              <div class="mt-3 text-muted" style="font-size:13px;">Hoặc gọi trực tiếp: <strong>0123 456 789</strong></div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
