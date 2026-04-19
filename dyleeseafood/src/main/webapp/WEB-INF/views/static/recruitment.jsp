<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>:root{--primary:#0077b6;--dark:#023e8a;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
.card-s{background:white;border-radius:16px;box-shadow:0 2px 14px rgba(0,0,0,0.07);padding:28px;margin-bottom:20px;}
.divider{height:3px;width:44px;background:var(--primary);border-radius:2px;margin:6px 0 18px;}
.job-card{background:white;border-radius:14px;border:1.5px solid #e8edf5;padding:20px;transition:all 0.2s;}
.job-card:hover{border-color:var(--primary);box-shadow:0 4px 16px rgba(0,119,182,0.12);}
.job-tag{display:inline-block;padding:3px 10px;border-radius:10px;font-size:11px;font-weight:600;}
</style>
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb"><ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);"><li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li><li class="breadcrumb-item active" style="color:white;">Tuyển dụng</li></ol></nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-briefcase me-2"></i>Tuyển dụng</h4>
  </div>
</div>
<div class="container mt-4 mb-5">
  <div class="row g-4">
    <div class="col-lg-8">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Vị trí đang tuyển</h5>
        <div class="divider"></div>
        <div class="d-flex flex-column gap-3">
          <div class="job-card">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <h6 class="fw-bold mb-0" style="font-size:15px;">Nhân viên giao hàng</h6>
              <span class="job-tag" style="background:#e3f2fd;color:var(--primary);">Full-time</span>
            </div>
            <div class="d-flex gap-3 mb-2" style="font-size:12px;color:#8a9ab0;">
              <span><i class="bi bi-geo-alt me-1"></i>Hải Phòng</span>
              <span><i class="bi bi-cash me-1"></i>6–8 triệu/tháng</span>
            </div>
            <p style="font-size:13px;color:#4a5568;margin-bottom:12px;">Giao hàng hải sản tươi sống trong nội thành Hải Phòng. Có xe máy, bằng lái A1 trở lên.</p>
            <button class="btn btn-outline-primary btn-sm" style="border-radius:8px;" onclick="alert('Vui lòng gọi 0123 456 789 để ứng tuyển!')">Ứng tuyển ngay</button>
          </div>
          <div class="job-card">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <h6 class="fw-bold mb-0" style="font-size:15px;">Nhân viên bán hàng online</h6>
              <span class="job-tag" style="background:#e8f5e9;color:#28a745;">Part-time</span>
            </div>
            <div class="d-flex gap-3 mb-2" style="font-size:12px;color:#8a9ab0;">
              <span><i class="bi bi-geo-alt me-1"></i>Làm việc tại nhà</span>
              <span><i class="bi bi-cash me-1"></i>4–6 triệu/tháng</span>
            </div>
            <p style="font-size:13px;color:#4a5568;margin-bottom:12px;">Tư vấn, chốt đơn qua Zalo/Facebook. Thành thạo tin học văn phòng, giao tiếp tốt.</p>
            <button class="btn btn-outline-primary btn-sm" style="border-radius:8px;" onclick="alert('Vui lòng gọi 0123 456 789 để ứng tuyển!')">Ứng tuyển ngay</button>
          </div>
          <div class="job-card">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <h6 class="fw-bold mb-0" style="font-size:15px;">Nhân viên kho &amp; phân loại hải sản</h6>
              <span class="job-tag" style="background:#e3f2fd;color:var(--primary);">Full-time</span>
            </div>
            <div class="d-flex gap-3 mb-2" style="font-size:12px;color:#8a9ab0;">
              <span><i class="bi bi-geo-alt me-1"></i>Hải Phòng</span>
              <span><i class="bi bi-cash me-1"></i>5–7 triệu/tháng</span>
            </div>
            <p style="font-size:13px;color:#4a5568;margin-bottom:12px;">Phân loại, kiểm tra chất lượng hải sản. Sức khỏe tốt, chịu được môi trường lạnh.</p>
            <button class="btn btn-outline-primary btn-sm" style="border-radius:8px;" onclick="alert('Vui lòng gọi 0123 456 789 để ứng tuyển!')">Ứng tuyển ngay</button>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="card-s">
        <h5 class="fw-bold mb-1" style="color:var(--dark);">Tại sao chọn Dylee?</h5>
        <div class="divider"></div>
        <div style="font-size:13px;color:#4a5568;display:flex;flex-direction:column;gap:12px;">
          <div class="d-flex gap-2"><i class="bi bi-check-circle-fill text-success mt-1"></i>Môi trường làm việc thân thiện, năng động</div>
          <div class="d-flex gap-2"><i class="bi bi-check-circle-fill text-success mt-1"></i>Lương thưởng cạnh tranh + thưởng hiệu suất</div>
          <div class="d-flex gap-2"><i class="bi bi-check-circle-fill text-success mt-1"></i>Được đào tạo chuyên môn bài bản</div>
          <div class="d-flex gap-2"><i class="bi bi-check-circle-fill text-success mt-1"></i>Đóng BHXH, BHYT đầy đủ</div>
        </div>
      </div>
      <div class="card-s">
        <div class="fw-bold mb-2" style="font-size:14px;color:var(--dark);">Liên hệ ứng tuyển</div>
        <div style="font-size:13px;color:#4a5568;line-height:2.2;">
          <div><i class="bi bi-telephone me-2 text-primary"></i>0123 456 789</div>
          <div><i class="bi bi-envelope me-2 text-primary"></i>hr@dylee.vn</div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
