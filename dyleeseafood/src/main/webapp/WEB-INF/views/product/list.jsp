<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<style>
  :root { --primary:#0077b6; --dark:#023e8a; }

  .page-header {
    background:linear-gradient(135deg,var(--dark),var(--primary));
    padding:18px 0;
  }

  /* CATEGORY TABS */
  .cat-tabs {
    background:white;
    border-bottom:2px solid #e8edf5;
    overflow-x:auto; white-space:nowrap;
    -webkit-overflow-scrolling:touch;
  }
  .cat-tabs::-webkit-scrollbar { height:0; }
  .cat-tab {
    display:inline-flex; align-items:center; gap:7px;
    padding:11px 18px; font-size:13px; font-weight:500;
    color:#4a5568; text-decoration:none;
    border-bottom:2px solid transparent;
    transition:all 0.18s; white-space:nowrap;
    margin-bottom:-2px;
  }
  .cat-tab:hover { color:var(--primary); background:#f7f9fc; }
  .cat-tab.active {
    color:var(--primary); font-weight:700;
    border-bottom-color:var(--primary);
    background:#f0f8ff;
  }
  .cat-tab .cat-count {
    background:#e8edf5; color:#8a9ab0;
    font-size:10px; font-weight:700;
    padding:1px 6px; border-radius:10px;
  }
  .cat-tab.active .cat-count {
    background:var(--primary); color:white;
  }

  /* SIDEBAR */
  .filter-card {
    background:white; border-radius:14px;
    box-shadow:0 2px 12px rgba(0,0,0,0.07);
    overflow:hidden; margin-bottom:14px;
  }
  .filter-head {
    background:var(--dark); color:white;
    padding:10px 16px; font-size:13px;
    font-weight:700; display:flex; align-items:center; gap:8px;
  }
  .cat-link {
    display:flex; align-items:center; gap:10px;
    padding:9px 16px; color:#333; text-decoration:none;
    font-size:13px; border-bottom:1px solid #f5f5f5;
    transition:all 0.15s;
  }
  .cat-link:hover { background:#e3f2fd; color:var(--primary); padding-left:20px; }
  .cat-link.active { background:#e3f2fd; color:var(--primary); font-weight:600; border-left:3px solid var(--primary); }
  .cat-link:last-child { border:none; }

  /* TOOLBAR */
  .toolbar {
    background:white; border-radius:12px;
    padding:10px 14px; margin-bottom:14px;
    box-shadow:0 2px 8px rgba(0,0,0,0.06);
    display:flex; align-items:center; gap:10px; flex-wrap:wrap;
  }
  .sort-sel {
    font-size:13px; padding:6px 10px;
    border:1.5px solid #e8edf5; border-radius:8px;
    background:white; cursor:pointer; outline:none;
  }
  .sort-sel:focus { border-color:var(--primary); }
  .vbtn {
    width:32px; height:32px; border:1.5px solid #e8edf5;
    border-radius:8px; background:white;
    display:flex; align-items:center; justify-content:center;
    cursor:pointer; color:#8a9ab0; transition:0.15s; font-size:14px;
  }
  .vbtn.active, .vbtn:hover { border-color:var(--primary); background:#e3f2fd; color:var(--primary); }

  /* PRODUCT CARD */
  .pcard {
    border:none; border-radius:14px; overflow:hidden;
    background:white; box-shadow:0 2px 10px rgba(0,0,0,0.06);
    transition:all 0.22s; height:100%;
    display:flex; flex-direction:column;
  }
  .pcard:hover { transform:translateY(-5px); box-shadow:0 10px 26px rgba(0,0,0,0.12); }
  .pcard-img { position:relative; overflow:hidden; flex-shrink:0; }
  .pcard-img img { width:100%; height:190px; object-fit:cover; transition:transform 0.4s; }
  .pcard:hover .pcard-img img { transform:scale(1.06); }
  .hover-btns {
    position:absolute; bottom:-56px; left:0; right:0;
    display:flex; gap:6px; padding:8px;
    background:rgba(0,0,0,0.55); transition:bottom 0.25s;
  }
  .pcard:hover .hover-btns { bottom:0; }
  .pcard-body { padding:10px; flex:1; display:flex; flex-direction:column; }
  .pcat { display:inline-block; font-size:10px; padding:2px 8px; border-radius:10px; background:#e3f2fd; color:var(--primary); font-weight:600; margin-bottom:5px; }
  .pname { font-size:13.5px; font-weight:700; color:#1a2035; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; margin-bottom:4px; }
  .pdesc { font-size:11.5px; color:#8a9ab0; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; margin-bottom:8px; line-height:1.5; }
  .pprice { font-size:15px; font-weight:800; color:var(--primary); }
  .pprice small { font-size:11px; font-weight:400; color:#8a9ab0; }
  .pstock { font-size:11px; margin-top:2px; }
  .btn-addcart { width:100%; margin-top:8px; font-size:12px; border-radius:8px; padding:7px; font-weight:600; }
  /* Nút chỉ hiện ở list view */
  .lv-only { display:none; }

  /* LIST VIEW */
  #pgrid.lv .pcard { flex-direction:row; }
  #pgrid.lv .pcard-img { width:180px; flex-shrink:0; }
  #pgrid.lv .pcard-img img { height:100%; }
  #pgrid.lv .hover-btns { display:none; }
  #pgrid.lv .pcard-body { padding:16px; }
  #pgrid.lv .pname { font-size:15px; -webkit-line-clamp:1; }
  #pgrid.lv .pdesc { -webkit-line-clamp:3; }
  #pgrid.lv .btn-addcart { width:auto; padding:7px 20px; }
  #pgrid.lv .pcol { width:100%; }
  /* Hiện nút khi ở list view */
  #pgrid.lv .lv-only { display:inline-flex; align-items:center; gap:6px; }

  /* PAGINATION */
  .pag { display:flex; justify-content:center; align-items:center; gap:6px; margin-top:28px; flex-wrap:wrap; }
  .pag-btn {
    min-width:36px; height:36px; padding:0 10px;
    border-radius:9px; font-size:13px; font-weight:600;
    text-decoration:none; border:1.5px solid #e8edf5;
    color:#4a5568; background:white; display:flex;
    align-items:center; justify-content:center;
    transition:all 0.15s;
  }
  .pag-btn:hover { border-color:var(--primary); color:var(--primary); background:#e3f2fd; }
  .pag-btn.active { background:var(--primary); border-color:var(--primary); color:white; }
  .pag-btn.disabled { opacity:0.38; pointer-events:none; }
  .pag-dots { color:#8a9ab0; font-size:13px; padding:0 4px; }

  .empty-box { text-align:center; padding:60px 20px; background:white; border-radius:14px; box-shadow:0 2px 10px rgba(0,0,0,0.06); }
</style>

<!-- PAGE HEADER -->
<div class="page-header">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center gap-3">
      <div>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider-color:rgba(255,255,255,0.5);">
            <li class="breadcrumb-item"><a href="/dyleeseafood/home" style="color:rgba(255,255,255,0.75);">Trang chủ</a></li>
            <li class="breadcrumb-item active" style="color:white;">Sản phẩm</li>
          </ol>
        </nav>
        <h5 class="text-white fw-bold mb-0">
          <c:choose>
            <c:when test="${not empty keyword}">🔍 Kết quả: "${keyword}"</c:when>
            <c:otherwise>🐟 Tất cả hải sản tươi</c:otherwise>
          </c:choose>
        </h5>
      </div>
      <form action="/dyleeseafood/products" method="get"
            class="d-none d-md-flex"
            style="border-radius:10px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.2);">
        <input type="text" name="keyword" value="${keyword}"
               placeholder="Tìm tôm, cua, cá, mực..."
               style="border:none;padding:9px 16px;font-size:13px;width:240px;outline:none;">
        <button type="submit" style="background:#ffc107;border:none;padding:9px 16px;color:#333;cursor:pointer;">
          <i class="bi bi-search"></i>
        </button>
      </form>
    </div>
  </div>
</div>

<!-- ===== TAB DANH MỤC ===== -->
<div class="cat-tabs shadow-sm">
  <div class="container" style="padding-top:0;padding-bottom:0;">

    <%-- URL base giữ sort --%>
    <c:set var="sortParam" value="${not empty sort ? '&sort='.concat(sort) : ''}"/>

    <a href="/dyleeseafood/products${sortParam}"
       class="cat-tab ${empty selectedCategory && empty keyword ? 'active' : ''}">
      <i class="bi bi-grid-fill" style="font-size:13px;"></i>
      Tất cả
    </a>

    <c:forEach var="cat" items="${categories}">
      <a href="/dyleeseafood/products?category=${cat.id}${sortParam}"
         class="cat-tab ${selectedCategory == cat.id ? 'active' : ''}">
        <i class="bi ${cat.icon}" style="font-size:13px;"></i>
        ${cat.name}
      </a>
    </c:forEach>

  </div>
</div>

<div class="container mt-3 mb-5">
  <div class="row g-3">

    <!-- ===== SIDEBAR ===== -->
    <div class="col-md-3 d-none d-md-block">

      <!-- DANH MỤC -->
      <div class="filter-card">
        <div class="filter-head">
          <i class="bi bi-grid-fill"></i>Danh mục
        </div>
        <a href="/dyleeseafood/products${sortParam}"
           class="cat-link ${empty selectedCategory && empty keyword ? 'active' : ''}">
          <i class="bi bi-grid-fill" style="color:var(--primary);font-size:13px;"></i>
          Tất cả sản phẩm
          <span class="ms-auto text-muted" style="font-size:11px;">${totalProducts}</span>
        </a>
        <c:forEach var="cat" items="${categories}">
          <a href="/dyleeseafood/products?category=${cat.id}${sortParam}"
             class="cat-link ${selectedCategory == cat.id ? 'active' : ''}">
            <i class="bi ${cat.icon}" style="color:var(--primary);font-size:13px;"></i>
            ${cat.name}
          </a>
        </c:forEach>
      </div>

      <!-- CAM KẾT -->
      <div class="filter-card p-3">
        <div class="fw-bold mb-3" style="font-size:13px;color:var(--dark);">
          <i class="bi bi-shield-check-fill text-success me-1"></i>Cam kết chất lượng
        </div>
        <div style="font-size:13px;color:#4a5568;display:flex;flex-direction:column;gap:10px;">
          <div class="d-flex align-items-center gap-2">
            <div style="width:32px;height:32px;border-radius:8px;background:#e8f5e9;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
              <i class="bi bi-fish" style="color:#28a745;"></i>
            </div>
            <div><div class="fw-bold" style="font-size:12px;">Tươi sống 100%</div><div style="font-size:11px;color:#8a9ab0;">Đánh bắt trong ngày</div></div>
          </div>
          <div class="d-flex align-items-center gap-2">
            <div style="width:32px;height:32px;border-radius:8px;background:#e3f2fd;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
              <i class="bi bi-truck" style="color:var(--primary);"></i>
            </div>
            <div><div class="fw-bold" style="font-size:12px;">Giao hàng 2 giờ</div><div style="font-size:11px;color:#8a9ab0;">Miễn phí vận chuyển</div></div>
          </div>
          <div class="d-flex align-items-center gap-2">
            <div style="width:32px;height:32px;border-radius:8px;background:#fff8e6;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
              <i class="bi bi-arrow-repeat" style="color:#ff9800;"></i>
            </div>
            <div><div class="fw-bold" style="font-size:12px;">Đổi trả 24h</div><div style="font-size:11px;color:#8a9ab0;">Hoàn tiền 100%</div></div>
          </div>
        </div>
      </div>

      <!-- HOTLINE -->
      <div class="filter-card p-3 text-center">
        <i class="bi bi-headset" style="font-size:2rem;color:var(--primary);"></i>
        <div class="fw-bold mt-2" style="font-size:13px;">Cần tư vấn?</div>
        <div class="text-muted" style="font-size:12px;">Gọi ngay hotline</div>
        <a href="tel:0123456789" class="btn btn-primary btn-sm w-100 mt-2" style="border-radius:8px;">
          <i class="bi bi-telephone-fill me-1"></i>0123 456 789
        </a>
      </div>

    </div>

    <!-- ===== MAIN ===== -->
    <div class="col-md-9">

      <!-- TOOLBAR -->
      <div class="toolbar">
        <div style="font-size:13px;color:#8a9ab0;flex:1;">
          <c:if test="${not empty keyword}">Tìm "<strong style="color:#1a2035;">${keyword}</strong>" — </c:if>
          <strong style="color:#1a2035;">${totalProducts}</strong> sản phẩm
          <c:if test="${totalPages > 1}">
            — Trang <strong style="color:#1a2035;">${currentPage}</strong>/${totalPages}
          </c:if>
        </div>

        <%-- URL base cho sort --%>
        <c:set var="sortBase" value="/dyleeseafood/products?"/>
        <c:if test="${not empty selectedCategory}"><c:set var="sortBase" value="${sortBase}category=${selectedCategory}&"/></c:if>
        <c:if test="${not empty keyword}"><c:set var="sortBase" value="${sortBase}keyword=${keyword}&"/></c:if>

        <select class="sort-sel" onchange="window.location='${sortBase}sort='+this.value">
          <option value="default"    ${sort=='default'    || empty sort ? 'selected':''}>Mặc định</option>
          <option value="price-asc"  ${sort=='price-asc'  ? 'selected':''}>Giá tăng dần</option>
          <option value="price-desc" ${sort=='price-desc' ? 'selected':''}>Giá giảm dần</option>
          <option value="name-asc"   ${sort=='name-asc'   ? 'selected':''}>Tên A → Z</option>
          <option value="stock-desc" ${sort=='stock-desc' ? 'selected':''}>Còn hàng trước</option>
        </select>

        <div class="d-flex gap-1">
          <button class="vbtn active" id="gvBtn" onclick="setView('grid')" title="Dạng lưới">
            <i class="bi bi-grid-3x3-gap-fill"></i>
          </button>
          <button class="vbtn" id="lvBtn" onclick="setView('list')" title="Dạng danh sách">
            <i class="bi bi-list-ul"></i>
          </button>
        </div>
      </div>

      <!-- TAG TÌM KIẾM -->
      <c:if test="${not empty keyword}">
        <div class="d-flex flex-wrap gap-2 mb-3">
          <a href="/dyleeseafood/products${not empty selectedCategory ? '?category='.concat(selectedCategory) : ''}"
             class="badge d-flex align-items-center gap-1"
             style="background:#e3f2fd;color:var(--primary);text-decoration:none;padding:6px 10px;border-radius:20px;font-size:12px;">
            🔍 "${keyword}" <i class="bi bi-x ms-1"></i>
          </a>
        </div>
      </c:if>

      <!-- PRODUCTS -->
      <c:choose>
        <c:when test="${empty products}">
          <div class="empty-box">
            <i class="bi bi-search" style="font-size:4rem;color:#dde3ed;"></i>
            <h5 class="fw-bold mt-3 mb-1">Không tìm thấy sản phẩm</h5>
            <p class="text-muted mb-3">Thử tìm kiếm từ khóa khác hoặc xem danh mục khác.</p>
            <a href="/dyleeseafood/products" class="btn btn-primary px-4" style="border-radius:10px;">
              <i class="bi bi-grid me-2"></i>Xem tất cả sản phẩm
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="row g-3" id="pgrid">
            <c:forEach var="p" items="${products}">
              <div class="col-6 col-lg-4 pcol">
                <div class="pcard">
                  <div class="pcard-img">
                    <img src="${not empty p.imageUrl ? p.imageUrl : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'}"
                         onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'"
                         alt="${p.name}" loading="lazy">
                    <div style="position:absolute;top:8px;left:8px;z-index:2;display:flex;flex-direction:column;gap:4px;">
                      <c:if test="${p.featured}">
                        <span class="badge bg-warning text-dark" style="font-size:10px;">⭐ Nổi bật</span>
                      </c:if>
                      <c:if test="${p.stock == 0}">
                        <span class="badge bg-secondary" style="font-size:10px;">Hết hàng</span>
                      </c:if>
                    </div>
                    <c:if test="${p.stock > 0 && p.stock < 10}">
                      <span class="badge bg-danger" style="position:absolute;top:8px;right:8px;z-index:2;font-size:10px;">Sắp hết</span>
                    </c:if>
                    <div class="hover-btns">
                      <a href="/dyleeseafood/products/${p.id}"
                         class="btn btn-light btn-sm flex-fill" style="font-size:11px;">
                        <i class="bi bi-eye"></i> Xem
                      </a>
                      <c:if test="${p.stock > 0}">
                        <a href="/dyleeseafood/cart/select/${p.id}"
                           class="btn btn-primary btn-sm flex-fill" style="font-size:11px;">
                          <i class="bi bi-cart-plus"></i> Giỏ
                        </a>
                      </c:if>
                    </div>
                  </div>
                  <div class="pcard-body">
                    <span class="pcat">${p.categoryName}</span>
                    <div class="pname">${p.name}</div>
                    <div class="pdesc">${p.description}</div>
                    <div class="mt-auto">
                      <div class="pprice">
                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                        <small>/ ${p.unit}</small>
                      </div>
                      <div class="pstock">
                        <c:choose>
                          <c:when test="${p.stock > 10}">
                            <i class="bi bi-check-circle-fill text-success"></i>
                            <span class="text-success">Còn hàng (${p.stock} ${p.unit})</span>
                          </c:when>
                          <c:when test="${p.stock > 0}">
                            <i class="bi bi-exclamation-circle-fill" style="color:#e65100;"></i>
                            <span style="color:#e65100;">Sắp hết (${p.stock} ${p.unit})</span>
                          </c:when>
                          <c:otherwise>
                            <i class="bi bi-x-circle-fill text-danger"></i>
                            <span class="text-danger">Hết hàng</span>
                          </c:otherwise>
                        </c:choose>
                      </div>
                      <%-- Nút chỉ hiện trong list view (hover ẩn) --%>
                      <c:if test="${p.stock > 0}">
                        <a href="/dyleeseafood/cart/select/${p.id}"
                           class="btn btn-primary btn-addcart lv-only">
                          <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                        </a>
                      </c:if>
                      <c:if test="${p.stock == 0}">
                        <button class="btn btn-secondary btn-addcart lv-only" disabled>
                          <i class="bi bi-x-circle me-1"></i>Hết hàng
                        </button>
                      </c:if>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>

          <!-- ===== PHÂN TRANG ===== -->
          <c:if test="${totalPages > 1}">
            <%-- Build URL base giữ filter + sort --%>
            <c:set var="pagBase" value="/dyleeseafood/products?"/>
            <c:if test="${not empty selectedCategory}">
              <c:set var="pagBase" value="${pagBase}category=${selectedCategory}&"/>
            </c:if>
            <c:if test="${not empty keyword}">
              <c:set var="pagBase" value="${pagBase}keyword=${keyword}&"/>
            </c:if>
            <c:if test="${not empty sort}">
              <c:set var="pagBase" value="${pagBase}sort=${sort}&"/>
            </c:if>

            <div class="pag">
              <%-- Nút Prev --%>
              <a href="${pagBase}page=${currentPage-1}"
                 class="pag-btn ${currentPage <= 1 ? 'disabled' : ''}">
                <i class="bi bi-chevron-left" style="font-size:11px;"></i>
              </a>

              <%-- Trang đầu --%>
              <c:if test="${currentPage > 3}">
                <a href="${pagBase}page=1" class="pag-btn">1</a>
                <c:if test="${currentPage > 4}">
                  <span class="pag-dots">•••</span>
                </c:if>
              </c:if>

              <%-- Các trang gần currentPage --%>
              <c:forEach begin="1" end="${totalPages}" var="pg">
                <c:if test="${pg >= currentPage-2 && pg <= currentPage+2}">
                  <a href="${pagBase}page=${pg}"
                     class="pag-btn ${pg == currentPage ? 'active' : ''}">
                    ${pg}
                  </a>
                </c:if>
              </c:forEach>

              <%-- Trang cuối --%>
              <c:if test="${currentPage < totalPages - 2}">
                <c:if test="${currentPage < totalPages - 3}">
                  <span class="pag-dots">•••</span>
                </c:if>
                <a href="${pagBase}page=${totalPages}" class="pag-btn">${totalPages}</a>
              </c:if>

              <%-- Nút Next --%>
              <a href="${pagBase}page=${currentPage+1}"
                 class="pag-btn ${currentPage >= totalPages ? 'disabled' : ''}">
                <i class="bi bi-chevron-right" style="font-size:11px;"></i>
              </a>
            </div>

            <div class="text-center mt-2" style="font-size:12px;color:#8a9ab0;">
              Hiển thị ${products.size()} / ${totalProducts} sản phẩm
            </div>
          </c:if>

        </c:otherwise>
      </c:choose>

    </div>
  </div>
</div>

<script>
function setView(v) {
  var grid = document.getElementById('pgrid');
  var gBtn = document.getElementById('gvBtn');
  var lBtn = document.getElementById('lvBtn');
  if (v === 'list') {
    grid.classList.add('lv');
    document.querySelectorAll('.pcol')
      .forEach(function(c){ c.className='pcol'; });
    gBtn.classList.remove('active');
    lBtn.classList.add('active');
    localStorage.setItem('pView','list');
  } else {
    grid.classList.remove('lv');
    document.querySelectorAll('.pcol')
      .forEach(function(c){ c.className='col-6 col-lg-4 pcol'; });
    gBtn.classList.add('active');
    lBtn.classList.remove('active');
    localStorage.setItem('pView','grid');
  }
}
(function(){
  if (localStorage.getItem('pView')==='list') setView('list');
})();
</script>

<%@ include file="../layout/footer.jsp" %>
