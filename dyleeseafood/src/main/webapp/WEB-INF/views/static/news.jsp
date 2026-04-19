<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<style>
  :root{--primary:#0077b6;--dark:#023e8a;}
  .page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:28px 0;}
  .news-card{background:white;border-radius:14px;box-shadow:0 2px 12px rgba(0,0,0,0.07);overflow:hidden;transition:all 0.2s;height:100%;}
  .news-card:hover{transform:translateY(-4px);box-shadow:0 8px 24px rgba(0,0,0,0.12);}
  .news-img{width:100%;height:200px;object-fit:cover;}
  .news-body{padding:18px;}
  .news-tag{display:inline-block;padding:2px 10px;border-radius:10px;font-size:11px;font-weight:600;background:#e3f2fd;color:var(--primary);}
  .news-title{font-size:14px;font-weight:700;color:#1a2035;line-height:1.45;margin:8px 0 6px;}
  .news-desc{font-size:12px;color:#8a9ab0;line-height:1.65;overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;margin-bottom:12px;}
</style>

<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);">
        <li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li>
        <li class="breadcrumb-item active" style="color:white;">Kiến thức hải sản</li>
      </ol>
    </nav>
    <h4 class="text-white fw-bold mb-0"><i class="bi bi-newspaper me-2"></i>Kiến thức hải sản</h4>
  </div>
</div>

<div class="container mt-4 mb-5">
  <div class="row g-4">

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://vcdn1-kinhdoanh.vnecdn.net/2023/11/14/tom-jpeg-1699940158-5302-1699940343.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=taQZag8kkZjTKFHSMJkrFQ" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag">Mẹo hay</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>18/04/2026</small>
          </div>
          <div class="news-title">Cách chọn tôm tươi ngon — 5 bí quyết từ chuyên gia</div>
          <div class="news-desc">Chia sẻ từ các chuyên gia hải sản về cách nhận biết tôm tươi sống, tôm đông lạnh chất lượng tốt và những điều cần tránh khi mua tôm.</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://giangghe.com/upload/filemanager/images/kinh-nghiem-chon-hai-san.jpg" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag" style="background:#e8f5e9;color:#28a745;">Kiến thức</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>15/04/2026</small>
          </div>
          <div class="news-title">Hướng dẫn bảo quản hải sản tại nhà đúng cách</div>
          <div class="news-desc">Biết cách bảo quản hải sản đúng cách giúp giữ được độ tươi ngon lâu hơn, tiết kiệm chi phí và đảm bảo an toàn thực phẩm cho gia đình.</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag" style="background:#fff8e6;color:#e65100;">Công thức</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>12/04/2026</small>
          </div>
          <div class="news-title">Top 5 món cua biển ngon nhất miền Bắc</div>
          <div class="news-desc">Cua biển là nguyên liệu quen thuộc nhưng không phải ai cũng biết cách chế biến để giữ được vị ngọt tự nhiên của cua. Khám phá 5 món ngon nhất!</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://i.pinimg.com/1200x/6d/ef/ca/6defca0bbda72b74aad27228f51b2202.jpg" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag" style="background:#fce4ec;color:#c2185b;">Sức khỏe</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>10/04/2026</small>
          </div>
          <div class="news-title">Lợi ích sức khỏe của việc ăn hải sản thường xuyên</div>
          <div class="news-desc">Hải sản là nguồn protein chất lượng cao, giàu omega-3, vitamin D và các khoáng chất thiết yếu tốt cho tim mạch và não bộ của bạn.</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://images.unsplash.com/photo-1565281936478-3c48cff2d19c?w=400&q=80" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag">Kiến thức</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>08/04/2026</small>
          </div>
          <div class="news-title">Mùa nào ăn hải sản gì ngon nhất trong năm?</div>
          <div class="news-desc">Mỗi loại hải sản có mùa cao điểm riêng khi chất lượng đạt đỉnh. Hiểu đúng sẽ giúp bạn chọn được hải sản tươi nhất và tiết kiệm nhất.</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="news-card">
        <img class="news-img" src="https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=400&q=80" alt="">
        <div class="news-body">
          <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="news-tag" style="background:#fef0f0;color:#c62828;">Cảnh báo</span>
            <small class="text-muted" style="font-size:11px;"><i class="bi bi-calendar3 me-1"></i>05/04/2026</small>
          </div>
          <div class="news-title">Phân biệt hải sản tươi và hải sản ướp hóa chất</div>
          <div class="news-desc">Một số hải sản trên thị trường được ngâm hóa chất để tươi lâu hơn. Bài viết giúp bạn nhận biết và tránh xa những sản phẩm kém chất lượng.</div>
          <a href="#" style="font-size:13px;color:var(--primary);text-decoration:none;font-weight:600;">Đọc thêm <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
      </div>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
