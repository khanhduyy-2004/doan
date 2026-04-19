<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<style>
  :root { --primary:#0077b6; --dark:#023e8a; }
  .page-header { background:linear-gradient(135deg,var(--dark),var(--primary)); padding:14px 0; }
  .gallery-main { width:100%; height:400px; object-fit:cover; border-radius:14px; border:2px solid #e8edf5; transition:opacity 0.25s; cursor:zoom-in; }
  .thumb-strip { display:flex; gap:8px; flex-wrap:wrap; margin-top:10px; }
  .thumb-item { width:72px; height:72px; object-fit:cover; border-radius:10px; border:2px solid #e8edf5; cursor:pointer; transition:all 0.18s; }
  .thumb-item:hover, .thumb-item.active { border-color:var(--primary); transform:scale(1.06); }
  .price-box { background:linear-gradient(135deg,#e8f4fd,#f0f8ff); border-radius:14px; padding:18px 20px; border:1px solid #bee3f8; margin-bottom:16px; }
  .price-main { font-size:2.2rem; font-weight:800; color:var(--primary); line-height:1; }
  .price-unit { font-size:14px; color:#8a9ab0; font-weight:400; }
  .stat-mini { text-align:center; background:#f7f9fc; border-radius:12px; padding:14px 8px; border:1px solid #e8edf5; }
  .stat-mini i { font-size:1.4rem; }
  .stat-mini p { font-size:12px; font-weight:700; margin:6px 0 2px; }
  .stat-mini small { font-size:10px; color:#8a9ab0; }
  .info-table td { padding:10px 14px; font-size:13.5px; vertical-align:middle; }
  .info-table td:first-child { font-weight:700; background:#f7f9fc; color:#4a5568; width:35%; white-space:nowrap; }
  .related-card { border:none; border-radius:12px; overflow:hidden; transition:all 0.2s; background:white; box-shadow:0 2px 10px rgba(0,0,0,0.07); }
  .related-card:hover { transform:translateY(-4px); box-shadow:0 8px 20px rgba(0,0,0,0.12); }
  .related-card img { width:100%; height:130px; object-fit:cover; transition:transform 0.3s; }
  .related-card:hover img { transform:scale(1.05); }
  .zoom-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.88); z-index:9999; align-items:center; justify-content:center; cursor:zoom-out; }
  .zoom-overlay.show { display:flex; }
  .zoom-overlay img { max-width:90vw; max-height:90vh; border-radius:10px; }
</style>

<div class="page-header mb-4">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mb-0" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);">
        <li class="breadcrumb-item"><a href="/dyleeseafood/home"     style="color:rgba(255,255,255,0.75);">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="/dyleeseafood/products" style="color:rgba(255,255,255,0.75);">Sản phẩm</a></li>
        <li class="breadcrumb-item active" style="color:white;">${product.name}</li>
      </ol>
    </nav>
  </div>
</div>

<c:set var="defaultImg" value="https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=600&q=80"/>

<div class="container mb-5">

  <!-- PHẦN CHÍNH -->
  <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius:18px;">
    <div class="row g-4">

      <!-- CỘT ẢNH -->
      <div class="col-md-5">
        <img id="mainImg"
             src="${not empty product.imageUrl ? product.imageUrl : defaultImg}"
             class="gallery-main" alt="${product.name}"
             onerror="this.src='${defaultImg}'"
             onclick="openZoom(this.src)">

        <c:if test="${not empty productImages && productImages.size() > 1}">
          <div class="thumb-strip">
            <c:forEach var="img" items="${productImages}" varStatus="s">
              <img src="${img}" class="thumb-item ${s.first ? 'active' : ''}"
                   alt="${product.name} ${s.count}"
                   onerror="this.src='${defaultImg}'"
                   onclick="switchImg(this,'${img}')">
            </c:forEach>
          </div>
        </c:if>

        <div class="d-flex gap-2 mt-3">
          <span class="text-muted" style="font-size:12px;line-height:2;">Chia sẻ:</span>
          <a href="#" class="btn btn-sm" style="background:#1877f2;color:white;border-radius:8px;font-size:12px;padding:4px 12px;">
            <i class="bi bi-facebook me-1"></i>Facebook
          </a>
          <a href="#" class="btn btn-sm" style="background:#0088cc;color:white;border-radius:8px;font-size:12px;padding:4px 12px;">
            <i class="bi bi-chat-dots-fill me-1"></i>Zalo
          </a>
        </div>
      </div>

      <!-- CỘT THÔNG TIN -->
      <div class="col-md-7">
        <div class="d-flex flex-wrap gap-2 mb-2">
          <span class="badge" style="background:#e3f2fd;color:var(--primary);font-size:12px;padding:5px 12px;">
            <i class="bi bi-grid me-1"></i>${product.categoryName}
          </span>
          <c:if test="${product.featured}">
            <span class="badge bg-warning text-dark" style="font-size:12px;padding:5px 12px;">⭐ Nổi bật</span>
          </c:if>
          <c:if test="${not empty product.supplierName}">
            <span class="badge" style="background:#f0f0f0;color:#555;font-size:12px;padding:5px 12px;">
              <i class="bi bi-building me-1"></i>${product.supplierName}
            </span>
          </c:if>
        </div>

        <h2 class="fw-bold mb-3" style="font-size:1.7rem;color:#1a2035;">${product.name}</h2>

        <div class="price-box">
          <div class="d-flex align-items-baseline gap-2">
            <div class="price-main"><fmt:formatNumber value="${product.price}" pattern="#,###"/>đ</div>
            <div class="price-unit">/ ${product.unit}</div>
          </div>
          <div class="mt-2">
            <c:choose>
              <c:when test="${product.stock > 10}">
                <span class="badge bg-success" style="font-size:12px;padding:5px 12px;">
                  <i class="bi bi-check-circle me-1"></i>Còn hàng (${product.stock} ${product.unit})
                </span>
              </c:when>
              <c:when test="${product.stock > 0}">
                <span class="badge bg-warning text-dark" style="font-size:12px;padding:5px 12px;">
                  <i class="bi bi-exclamation-circle me-1"></i>Sắp hết (còn ${product.stock} ${product.unit})
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-danger" style="font-size:12px;padding:5px 12px;">
                  <i class="bi bi-x-circle me-1"></i>Hết hàng
                </span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <p class="text-muted mb-4" style="font-size:14px;line-height:1.8;">${product.description}</p>

        <div class="row g-2 mb-4">
          <div class="col-3"><div class="stat-mini"><i class="bi bi-box-seam text-primary"></i><p>${product.stock} ${product.unit}</p><small>Tồn kho</small></div></div>
          <div class="col-3"><div class="stat-mini"><i class="bi bi-truck text-success"></i><p>Miễn phí</p><small>Giao hàng</small></div></div>
          <div class="col-3"><div class="stat-mini"><i class="bi bi-shield-check text-info"></i><p>100%</p><small>Tươi sống</small></div></div>
          <div class="col-3"><div class="stat-mini"><i class="bi bi-arrow-repeat text-warning"></i><p>24h</p><small>Đổi trả</small></div></div>
        </div>

        <hr class="my-3">

        <!-- ✅ NÚT MUA — chuyển đến trang select -->
        <c:choose>
          <c:when test="${product.stock > 0}">
            <div class="d-flex gap-3 flex-wrap">
              <a href="/dyleeseafood/cart/select/${product.id}"
                 class="btn btn-primary btn-lg px-5 fw-bold"
                 style="border-radius:12px;text-decoration:none;">
                <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ hàng
              </a>
              <a href="/dyleeseafood/products" class="btn btn-outline-secondary btn-lg" style="border-radius:12px;">
                ← Quay lại
              </a>
            </div>
            <div class="mt-3 p-3" style="background:#e8f5e9;border-radius:10px;font-size:13px;color:#2e7d32;">
              <i class="bi bi-truck me-2"></i>
              <strong>Giao hàng nhanh 2 giờ</strong> — Miễn phí trong khu vực Hải Phòng
            </div>
          </c:when>
          <c:otherwise>
            <div class="d-flex gap-3 flex-wrap">
              <button class="btn btn-secondary btn-lg px-5" style="border-radius:12px;" disabled>
                <i class="bi bi-x-circle me-2"></i>Hết hàng
              </button>
              <a href="/dyleeseafood/products" class="btn btn-outline-secondary btn-lg" style="border-radius:12px;">← Quay lại</a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

  <!-- TABS -->
  <div class="card border-0 shadow-sm mb-4" style="border-radius:18px;overflow:hidden;">
    <div style="display:flex;border-bottom:2px solid #f0f2f5;background:white;">
      <button class="tab-btn active" onclick="switchTab('info',this)"
              style="padding:14px 24px;border:none;background:transparent;font-weight:600;font-size:14px;color:var(--primary);border-bottom:2px solid var(--primary);margin-bottom:-2px;cursor:pointer;">
        <i class="bi bi-file-text me-2"></i>Thông tin sản phẩm
      </button>
      <button class="tab-btn" onclick="switchTab('commit',this)"
              style="padding:14px 24px;border:none;background:transparent;font-weight:600;font-size:14px;color:#8a9ab0;border-bottom:2px solid transparent;margin-bottom:-2px;cursor:pointer;">
        <i class="bi bi-award me-2"></i>Cam kết chất lượng
      </button>
    </div>
    <div id="tab-info" class="p-4">
      <table class="table info-table table-bordered mb-0">
        <tbody>
          <tr><td>Tên sản phẩm</td><td>${product.name}</td></tr>
          <tr><td>Danh mục</td><td>${product.categoryName}</td></tr>
          <c:if test="${not empty product.supplierName}">
            <tr><td>Nhà cung cấp</td><td>${product.supplierName}</td></tr>
          </c:if>
          <tr><td>Đơn giá</td>
              <td style="color:var(--primary);font-weight:700;">
                <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ / ${product.unit}
              </td></tr>
          <tr><td>Tồn kho</td><td>${product.stock} ${product.unit}</td></tr>
          <tr><td>Trạng thái</td>
              <td><c:choose>
                <c:when test="${product.stock > 0}"><span class="text-success fw-bold">✅ Còn hàng</span></c:when>
                <c:otherwise><span class="text-danger fw-bold">❌ Hết hàng</span></c:otherwise>
              </c:choose></td></tr>
          <tr><td>Mô tả</td><td style="line-height:1.7;">${product.description}</td></tr>
        </tbody>
      </table>
    </div>
    <div id="tab-commit" class="p-4" style="display:none;">
      <div class="row g-3 text-center">
        <div class="col-md-3 col-6"><div style="background:#e3f2fd;border-radius:14px;padding:24px 16px;"><i class="bi bi-fish" style="font-size:2.2rem;color:var(--primary);"></i><p class="fw-bold mt-2 mb-1" style="font-size:14px;">Tươi sống 100%</p><small class="text-muted">Đánh bắt trong ngày</small></div></div>
        <div class="col-md-3 col-6"><div style="background:#e8f5e9;border-radius:14px;padding:24px 16px;"><i class="bi bi-truck" style="font-size:2.2rem;color:#28a745;"></i><p class="fw-bold mt-2 mb-1" style="font-size:14px;">Giao hàng 2 giờ</p><small class="text-muted">Miễn phí vận chuyển</small></div></div>
        <div class="col-md-3 col-6"><div style="background:#e0f7fa;border-radius:14px;padding:24px 16px;"><i class="bi bi-shield-check" style="font-size:2.2rem;color:#0097a7;"></i><p class="fw-bold mt-2 mb-1" style="font-size:14px;">An toàn vệ sinh</p><small class="text-muted">Đạt chuẩn VSATTP</small></div></div>
        <div class="col-md-3 col-6"><div style="background:#fff8e6;border-radius:14px;padding:24px 16px;"><i class="bi bi-arrow-repeat" style="font-size:2.2rem;color:#ff9800;"></i><p class="fw-bold mt-2 mb-1" style="font-size:14px;">Đổi trả dễ dàng</p><small class="text-muted">24h nếu hàng lỗi</small></div></div>
      </div>
    </div>
  </div>

  <!-- ✅ SẢN PHẨM GỢI Ý — dùng link thay vì addToCart() -->
  <c:if test="${not empty related}">
    <div class="mb-2">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0" style="color:var(--dark);">🐟 Sản phẩm cùng danh mục</h5>
        <a href="/dyleeseafood/products?category=${product.categoryId}"
           class="btn btn-outline-primary btn-sm" style="border-radius:8px;">Xem thêm →</a>
      </div>
      <div class="row g-3">
        <c:forEach var="r" items="${related}">
          <div class="col-6 col-md-3 col-lg-2">
            <div class="related-card">
              <div style="overflow:hidden;">
                <a href="/dyleeseafood/products/${r.id}">
                  <img src="${not empty r.imageUrl ? r.imageUrl : defaultImg}"
                       onerror="this.src='${defaultImg}'" alt="${r.name}">
                </a>
              </div>
              <div style="padding:10px;">
                <div style="font-size:12px;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;color:#1a2035;" title="${r.name}">${r.name}</div>
                <div style="color:var(--primary);font-size:13px;font-weight:700;margin-top:3px;">
                  <fmt:formatNumber value="${r.price}" pattern="#,###"/>đ
                </div>
                <c:if test="${r.stock > 0}">
                  <a href="/dyleeseafood/cart/select/${r.id}"
                     class="btn btn-outline-primary btn-sm w-100 mt-2"
                     style="border-radius:7px;font-size:11px;text-decoration:none;">
                    <i class="bi bi-cart-plus me-1"></i>Thêm giỏ
                  </a>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

</div>

<!-- ZOOM OVERLAY -->
<div class="zoom-overlay" id="zoomOverlay" onclick="closeZoom()">
  <img id="zoomImg" src="" alt="">
</div>

<script>
function switchImg(el, src) {
  var main = document.getElementById('mainImg');
  main.style.opacity = '0.6';
  main.src = src;
  main.onload = function(){ main.style.opacity = '1'; };
  document.querySelectorAll('.thumb-item').forEach(function(t){ t.classList.remove('active'); });
  el.classList.add('active');
}
function openZoom(src) {
  document.getElementById('zoomImg').src = src;
  document.getElementById('zoomOverlay').classList.add('show');
  document.body.style.overflow = 'hidden';
}
function closeZoom() {
  document.getElementById('zoomOverlay').classList.remove('show');
  document.body.style.overflow = '';
}
document.addEventListener('keydown', function(e){ if(e.key==='Escape') closeZoom(); });
function switchTab(name, btn) {
  document.getElementById('tab-info').style.display   = name==='info'   ? 'block' : 'none';
  document.getElementById('tab-commit').style.display = name==='commit' ? 'block' : 'none';
  document.querySelectorAll('.tab-btn').forEach(function(b){
    b.style.color = '#8a9ab0';
    b.style.borderBottomColor = 'transparent';
  });
  btn.style.color = 'var(--primary)';
  btn.style.borderBottomColor = 'var(--primary)';
}
</script>

<%@ include file="../layout/footer.jsp" %>
