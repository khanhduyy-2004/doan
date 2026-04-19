<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="layout/header.jsp" %>

<style>
  /* ===== LAYOUT ===== */
  .home-hero { background:#f5f6fa; padding:0; }

  /* SIDEBAR DANH MỤC */
  .cat-sidebar {
    background:white;
    border-radius:0 0 10px 10px;
    overflow:hidden;
    box-shadow:0 2px 12px rgba(0,0,0,0.08);
    position:sticky; top:0;
  }
  .cat-sidebar-head {
    background:var(--dark);
    padding:11px 16px;
    color:white; font-weight:700;
    font-size:13px;
    display:flex; align-items:center; gap:8px;
  }
  .cat-sidebar a {
    display:flex; align-items:center; gap:10px;
    padding:9px 16px; color:#333;
    text-decoration:none; font-size:13px;
    border-bottom:1px solid #f5f5f5;
    transition:all 0.15s;
  }
  .cat-sidebar a:hover {
    background:#e3f2fd; color:#0077b6;
    padding-left:20px;
  }
  .cat-sidebar a:last-child { border:none; }

  /* BANNER */
  .hero-slider { position:relative; height:380px; overflow:hidden; border-radius:0 0 10px 10px; }
  .slide { position:absolute; inset:0; opacity:0; transition:opacity 0.9s ease; z-index:0; }
  .slide.active { opacity:1; z-index:1; }
  .slide-img { position:absolute; inset:0; background-size:cover; background-position:center; transform:scale(1.05); transition:transform 7s ease; }
  .slide.active .slide-img { transform:scale(1); }
  .slide-overlay { position:absolute; inset:0; background:linear-gradient(100deg,rgba(1,30,66,0.78) 0%,rgba(0,60,120,0.4) 50%,transparent 100%); z-index:1; }
  .slide-content { position:absolute; z-index:2; left:7%; top:50%; transform:translateY(-50%); max-width:380px; }
  .slide-badge { display:inline-block; padding:4px 14px; border-radius:20px; font-size:12px; font-weight:600; margin-bottom:10px; opacity:0; transform:translateY(12px); transition:all 0.5s ease 0.15s; }
  .slide.active .slide-badge { opacity:1; transform:translateY(0); }
  .slide-title { font-size:2rem; font-weight:800; color:white; line-height:1.2; margin-bottom:10px; text-shadow:0 2px 14px rgba(0,0,0,0.4); opacity:0; transform:translateY(20px); transition:all 0.55s ease 0.3s; }
  .slide.active .slide-title { opacity:1; transform:translateY(0); }
  .slide-desc { font-size:13px; color:rgba(255,255,255,0.88); line-height:1.7; margin-bottom:18px; opacity:0; transform:translateY(14px); transition:all 0.55s ease 0.45s; }
  .slide.active .slide-desc { opacity:1; transform:translateY(0); }
  .slide-btns { display:flex; gap:10px; opacity:0; transform:translateY(12px); transition:all 0.55s ease 0.6s; }
  .slide.active .slide-btns { opacity:1; transform:translateY(0); }
  .slider-arrow { position:absolute; top:50%; transform:translateY(-50%); z-index:10; width:36px; height:36px; border-radius:50%; background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.3); color:white; display:flex; align-items:center; justify-content:center; cursor:pointer; font-size:14px; transition:0.2s; backdrop-filter:blur(4px); }
  .slider-arrow:hover { background:rgba(255,255,255,0.28); }
  .slider-arrow.prev { left:12px; }
  .slider-arrow.next { right:12px; }
  .slider-dots { position:absolute; bottom:12px; left:50%; transform:translateX(-50%); z-index:10; display:flex; gap:6px; }
  .dot { width:7px; height:7px; border-radius:4px; background:rgba(255,255,255,0.4); cursor:pointer; transition:all 0.3s; border:none; padding:0; }
  .dot.active { width:22px; background:white; }
  .slide-progress { position:absolute; bottom:0; left:0; height:3px; background:#0077b6; z-index:10; width:0%; }

  /* FEATURE STRIP */
  .feature-strip { background:white; border-top:3px solid #0077b6; }
  .feature-item { display:flex; align-items:center; gap:12px; padding:14px 0; }
  .feature-item + .feature-item { border-left:1px solid #f0f2f5; padding-left:20px; margin-left:4px; }
  .feature-icon { width:44px; height:44px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:1.3rem; flex-shrink:0; }

  /* PRODUCT CARD */
  .product-card { border:none; border-radius:12px; overflow:hidden; transition:all 0.22s; }
  .product-card:hover { transform:translateY(-5px); box-shadow:0 10px 24px rgba(0,0,0,0.12)!important; }
  .card-img-wrap { position:relative; overflow:hidden; }
  .card-img-wrap img { transition:transform 0.4s; width:100%; height:175px; object-fit:cover; }
  .product-card:hover .card-img-wrap img { transform:scale(1.06); }
  .hover-btns { position:absolute; bottom:-56px; left:0; right:0; display:flex; gap:6px; padding:8px; background:rgba(0,0,0,0.55); transition:bottom 0.25s; }
  .product-card:hover .hover-btns { bottom:0; }

  /* MISC */
  .section-head { display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:20px; }
  .section-title { font-size:1.25rem; font-weight:800; color:#023e8a; position:relative; }
  .section-title::after { content:''; display:block; width:40px; height:3px; background:#0077b6; border-radius:2px; margin-top:3px; }
  .why-card { border-radius:14px; padding:24px 16px; text-align:center; background:white; box-shadow:0 2px 12px rgba(0,0,0,0.06); transition:transform 0.2s; }
  .why-card:hover { transform:translateY(-3px); }
  .why-icon { width:58px; height:58px; border-radius:50%; margin:0 auto 12px; display:flex; align-items:center; justify-content:center; font-size:1.5rem; }
  .review-card { background:white; border-radius:14px; padding:20px; box-shadow:0 2px 12px rgba(0,0,0,0.06); }
  .promo-card { border-radius:14px; padding:24px; color:white; position:relative; overflow:hidden; }
  :root { --primary:#0077b6; --dark:#023e8a; --accent:#ffc107; }
</style>

<!-- ===== HERO: SIDEBAR + BANNER ===== -->
<div class="home-hero">
  <div class="container py-3">
    <div class="row g-3 align-items-stretch">

      <!-- SIDEBAR DANH MỤC -->
      <div class="col-md-3 d-none d-md-block">
        <div class="cat-sidebar h-100">
          <div class="cat-sidebar-head">
            <i class="bi bi-list" style="font-size:1.1rem;"></i>
            DANH MỤC SẢN PHẨM
          </div>
          <a href="/dyleeseafood/products">
            <i class="bi bi-grid-fill" style="color:#0077b6;"></i>
            Tất cả sản phẩm
          </a>
          <c:forEach var="cat" items="${categories}">
            <a href="/dyleeseafood/products?category=${cat.id}">
              <i class="bi ${cat.icon}" style="color:#0077b6;"></i>
              ${cat.name}
            </a>
          </c:forEach>
        </div>
      </div>

      <!-- BANNER -->
      <div class="col-md-9">
        <div class="hero-slider">

          <!-- Slide 1 -->
          <div class="slide active">
            <div class="slide-img" style="background-image:url('https://vcdn1-kinhdoanh.vnecdn.net/2023/11/14/tom-jpeg-1699940158-5302-1699940343.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=taQZag8kkZjTKFHSMJkrFQ');"></div>
            <div class="slide-overlay"></div>
            <div class="slide-content">
              <span class="slide-badge" style="background:rgba(255,193,7,0.92);color:#1a2035;">🔥 Hàng hot</span>
              <h2 class="slide-title">Tôm Hùm<br>Tươi Sống</h2>
              <p class="slide-desc">Đánh bắt tự nhiên — Giao trong 2 giờ. Tươi hoặc hoàn tiền 100%!</p>
              <div class="slide-btns">
                <a href="/dyleeseafood/products?category=1" class="btn btn-warning fw-bold px-3" style="border-radius:10px;color:#1a2035;font-size:13px;">Mua ngay →</a>
                <a href="/dyleeseafood/about" class="btn btn-outline-light px-3" style="border-radius:10px;font-size:13px;">Giới thiệu</a>
              </div>
            </div>
          </div>

          <!-- Slide 2 -->
          <div class="slide">
            <div class="slide-img" style="background-image:url('https://i.pinimg.com/1200x/6d/ef/ca/6defca0bbda72b74aad27228f51b2202.jpg');"></div>
            <div class="slide-overlay" style="background:linear-gradient(100deg,rgba(80,8,8,0.8) 0%,rgba(150,20,20,0.4) 50%,transparent 100%);"></div>
            <div class="slide-content">
              <span class="slide-badge" style="background:rgba(230,57,70,0.92);color:white;">👑 Đặc sản</span>
              <h2 class="slide-title">Cua Gạch<br>Cà Mau</h2>
              <p class="slide-desc">Gạch đầy, thịt chắc — Chất lượng từ vùng biển Cà Mau nổi tiếng.</p>
              <div class="slide-btns">
                <a href="/dyleeseafood/products?category=2" class="btn btn-danger fw-bold px-3" style="border-radius:10px;font-size:13px;">Mua ngay →</a>
                <a href="/dyleeseafood/products" class="btn btn-outline-light px-3" style="border-radius:10px;font-size:13px;">Xem thêm</a>
              </div>
            </div>
          </div>

          <!-- Slide 3 -->
          <div class="slide">
            <div class="slide-img" style="background-image:url('https://giangghe.com/upload/filemanager/images/kinh-nghiem-chon-hai-san.jpg');"></div>
            <div class="slide-overlay" style="background:linear-gradient(100deg,rgba(0,55,15,0.8) 0%,rgba(0,100,40,0.4) 50%,transparent 100%);"></div>
            <div class="slide-content">
              <span class="slide-badge" style="background:rgba(46,125,50,0.92);color:white;">✅ Cam kết</span>
              <h2 class="slide-title">Hải Sản Sạch<br>100%</h2>
              <p class="slide-desc">Nguồn gốc rõ ràng, an toàn vệ sinh thực phẩm — Giao tận nhà!</p>
              <div class="slide-btns">
                <a href="/dyleeseafood/products" class="btn btn-success fw-bold px-3" style="border-radius:10px;font-size:13px;">Xem tất cả →</a>
                <a href="/dyleeseafood/guide/order" class="btn btn-outline-light px-3" style="border-radius:10px;font-size:13px;">Hướng dẫn</a>
              </div>
            </div>
          </div>

          <button class="slider-arrow prev" onclick="chg(-1)"><i class="bi bi-chevron-left"></i></button>
          <button class="slider-arrow next" onclick="chg(1)"><i class="bi bi-chevron-right"></i></button>
          <div class="slider-dots">
            <button class="dot active" onclick="go(0)"></button>
            <button class="dot"        onclick="go(1)"></button>
            <button class="dot"        onclick="go(2)"></button>
          </div>
          <div class="slide-progress" id="slProg"></div>
        </div>
      </div>

    </div>
  </div>
</div>

<!-- ===== FEATURE STRIP ===== -->
<div class="feature-strip shadow-sm mb-4">
  <div class="container">
    <div class="row g-0">
      <div class="col-6 col-md-3">
        <div class="feature-item">
          <div class="feature-icon" style="background:#e3f2fd;"><i class="bi bi-truck" style="color:#0077b6;"></i></div>
          <div>
            <div class="fw-bold" style="font-size:13px;">Miễn phí giao hàng</div>
            <div class="text-muted" style="font-size:11px;">Toàn khu vực Hải Phòng</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="feature-item ps-3">
          <div class="feature-icon" style="background:#e8f5e9;"><i class="bi bi-headset" style="color:#28a745;"></i></div>
          <div>
            <div class="fw-bold" style="font-size:13px;">Tư vấn 7:00–21:00</div>
            <div class="text-muted" style="font-size:11px;">Hỗ trợ nhiệt tình, tận tâm</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="feature-item ps-3">
          <div class="feature-icon" style="background:#fff8e6;"><i class="bi bi-fish" style="color:#ff9800;"></i></div>
          <div>
            <div class="fw-bold" style="font-size:13px;">Hải sản tươi sống</div>
            <div class="text-muted" style="font-size:11px;">Đảm bảo tươi khi nhận</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="feature-item ps-3">
          <div class="feature-icon" style="background:#fce4ec;"><i class="bi bi-arrow-repeat" style="color:#e91e63;"></i></div>
          <div>
            <div class="fw-bold" style="font-size:13px;">Đổi trả hàng hóa</div>
            <div class="text-muted" style="font-size:11px;">Trong 24h nếu không đúng</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ===== NỘI DUNG CHÍNH ===== -->
<div class="container mb-5">

  <!-- PROMO 2 BANNER -->
  <div class="row g-3 mb-4">
    <div class="col-md-6">
      <div class="promo-card" style="background:linear-gradient(135deg,#023e8a,#0077b6);">
        <div style="position:absolute;right:-10px;top:-10px;font-size:6rem;opacity:0.07;">🦐</div>
        <span class="badge mb-2" style="background:rgba(255,255,255,0.18);font-size:11px;">Ưu đãi hôm nay</span>
        <h5 class="fw-bold mb-1">Miễn phí giao hàng</h5>
        <p style="font-size:13px;opacity:0.85;margin-bottom:14px;">Tất cả đơn hàng — không giới hạn giá trị.</p>
        <a href="/dyleeseafood/products" class="btn btn-warning btn-sm fw-bold" style="border-radius:8px;color:#1a2035;">Đặt hàng ngay →</a>
      </div>
    </div>
    <div class="col-md-6">
      <div class="promo-card" style="background:linear-gradient(135deg,#e63946,#f4a261);">
        <div style="position:absolute;right:-10px;top:-10px;font-size:6rem;opacity:0.07;">👑</div>
        <span class="badge mb-2" style="background:rgba(255,255,255,0.18);font-size:11px;">Hội viên VIP</span>
        <h5 class="fw-bold mb-1">Giảm đến 10%</h5>
        <p style="font-size:13px;opacity:0.85;margin-bottom:14px;">VIP -5%, VVIP -10% trên mọi đơn hàng.</p>
        <a href="/dyleeseafood/register" class="btn btn-light btn-sm fw-bold" style="border-radius:8px;color:#e63946;">Đăng ký ngay →</a>
      </div>
    </div>
  </div>

  <!-- SẢN PHẨM NỔI BẬT -->
  <div class="mb-5">
    <div class="section-head">
      <div><h2 class="section-title">⭐ Sản phẩm nổi bật</h2><p class="text-muted mt-1 mb-0" style="font-size:13px;">Được khách hàng yêu thích nhất</p></div>
      <a href="/dyleeseafood/products" class="btn btn-outline-primary btn-sm">Xem tất cả →</a>
    </div>
    <c:choose>
      <c:when test="${empty featuredProducts}">
        <div class="text-center py-5"><i class="bi bi-box text-muted" style="font-size:3.5rem;"></i><p class="text-muted mt-2">Chưa có sản phẩm nổi bật</p></div>
      </c:when>
      <c:otherwise>
        <div class="row g-3">
          <c:forEach var="p" items="${featuredProducts}">
            <div class="col-6 col-md-4 col-lg-2">
              <div class="card product-card shadow-sm h-100">
                <div class="card-img-wrap">
                  <img src="${not empty p.imageUrl ? p.imageUrl : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'}"
                       onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'" alt="${p.name}">
                  <span class="badge bg-warning text-dark" style="position:absolute;top:6px;left:6px;font-size:10px;">⭐</span>
                  <c:if test="${p.stock < 10 && p.stock > 0}">
                    <span class="badge bg-danger" style="position:absolute;top:6px;right:6px;font-size:10px;">Sắp hết</span>
                  </c:if>
                  <div class="hover-btns">
                    <a href="/dyleeseafood/products/${p.id}" class="btn btn-light btn-sm flex-fill" style="font-size:11px;"><i class="bi bi-eye"></i> Xem</a>
                    <a href="/dyleeseafood/cart/select/${p.id}"
                       class="btn btn-primary btn-sm flex-fill"
                       style="font-size:11px;text-decoration:none;">
                      <i class="bi bi-cart-plus"></i> Giỏ
                    </a>
                  </div>
                </div>
                <div class="card-body d-flex flex-column p-2">
                  <span class="badge bg-info text-dark mb-1" style="font-size:10px;width:fit-content;">${p.categoryName}</span>
                  <h6 class="fw-bold mb-1" style="font-size:13px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="${p.name}">${p.name}</h6>
                  <div class="mt-auto">
                    <div style="font-size:14px;font-weight:700;color:#0077b6;"><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ<small class="text-muted fw-normal" style="font-size:11px;">/${p.unit}</small></div>
                    <small class="text-muted" style="font-size:11px;"><i class="bi bi-box-seam"></i> ${p.stock} ${p.unit}</small>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- VÌ SAO CHỌN -->
  <div class="mb-5">
    <div class="text-center mb-3"><h2 class="section-title d-inline-block">Vì sao chọn Dylee Seafood?</h2></div>
    <div class="row g-3">
      <div class="col-6 col-md-3"><div class="why-card"><div class="why-icon" style="background:#e3f2fd;"><i class="bi bi-fish" style="color:#0077b6;"></i></div><h6 class="fw-bold mb-1" style="font-size:14px;">Tươi sống 100%</h6><p class="text-muted mb-0" style="font-size:12px;">Đánh bắt trong ngày, kiểm tra trước khi giao</p></div></div>
      <div class="col-6 col-md-3"><div class="why-card"><div class="why-icon" style="background:#e8f5e9;"><i class="bi bi-truck" style="color:#28a745;"></i></div><h6 class="fw-bold mb-1" style="font-size:14px;">Giao hàng 2 giờ</h6><p class="text-muted mb-0" style="font-size:12px;">Miễn phí toàn bộ khu vực Hải Phòng</p></div></div>
      <div class="col-6 col-md-3"><div class="why-card"><div class="why-icon" style="background:#fff8e6;"><i class="bi bi-shield-check" style="color:#ff9800;"></i></div><h6 class="fw-bold mb-1" style="font-size:14px;">An toàn vệ sinh</h6><p class="text-muted mb-0" style="font-size:12px;">Đạt chuẩn VSATTP, đóng gói sạch</p></div></div>
      <div class="col-6 col-md-3"><div class="why-card"><div class="why-icon" style="background:#fce4ec;"><i class="bi bi-arrow-repeat" style="color:#e91e63;"></i></div><h6 class="fw-bold mb-1" style="font-size:14px;">Đổi trả dễ dàng</h6><p class="text-muted mb-0" style="font-size:12px;">Đổi trong 24h, hoàn tiền 100% nếu lỗi</p></div></div>
    </div>
  </div>

  <!-- ĐƠN HÀNG GẦN ĐÂY -->
  <c:if test="${not empty sessionScope.loggedUser && not empty recentOrders}">
    <div class="mb-5">
      <div class="section-head">
        <div><h2 class="section-title">🕐 Đơn hàng gần đây</h2><p class="text-muted mt-1 mb-0" style="font-size:13px;">Chào, <strong>${sessionScope.loggedCustomer.name}</strong>!</p></div>
        <a href="/dyleeseafood/order/history" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
      </div>
      <div class="row g-3">
        <c:forEach var="order" items="${recentOrders}">
          <div class="col-md-4">
            <div style="background:white;border-radius:12px;padding:16px;box-shadow:0 2px 10px rgba(0,0,0,0.06);border-left:3px solid #0077b6;">
              <div class="d-flex justify-content-between mb-1">
                <span class="fw-bold" style="color:#0077b6;font-size:14px;">#DL${order.id}</span>
                <c:choose>
                  <c:when test="${order.status=='Pending'}"><span class="badge bg-warning text-dark" style="font-size:11px;">⏳ Chờ xác nhận</span></c:when>
                  <c:when test="${order.status=='Shipping'}"><span class="badge bg-primary" style="font-size:11px;">🚚 Đang giao</span></c:when>
                  <c:when test="${order.status=='Delivered'}"><span class="badge bg-success" style="font-size:11px;">✔ Đã giao</span></c:when>
                  <c:otherwise><span class="badge bg-info" style="font-size:11px;">${order.status}</span></c:otherwise>
                </c:choose>
              </div>
              <div style="font-size:12px;color:#8a9ab0;">${order.orderDate}</div>
              <div style="font-weight:700;color:#0077b6;font-size:15px;margin:4px 0;"><fmt:formatNumber value="${order.total}" pattern="#,###"/>đ</div>
              <a href="/dyleeseafood/order/tracking/${order.id}" class="btn btn-outline-primary btn-sm w-100" style="border-radius:8px;font-size:12px;"><i class="bi bi-geo-alt me-1"></i>Theo dõi đơn</a>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
  <div class="mb-5">
    <div class="text-center mb-3">
      <h2 class="section-title d-inline-block">💬 Khách hàng nói gì?</h2>
      <p class="text-muted mt-2" style="font-size:13px;">
        <span style="color:#ffc107;">★★★★★</span>
        <strong>4.8/5</strong> — Hơn 200 khách hàng tin dùng
      </p>
    </div>
    <div class="row g-3">
      <div class="col-md-4">
        <div class="review-card">
          <div class="d-flex gap-3 mb-2">
            <div style="width:42px;height:42px;border-radius:50%;background:#e3f2fd;color:#0077b6;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:16px;flex-shrink:0;">H</div>
            <div><div class="fw-bold" style="font-size:13px;">Nguyễn Thị Hoa</div><div style="color:#ffc107;font-size:12px;">★★★★★</div></div>
          </div>
          <p class="text-muted mb-0" style="font-size:13px;line-height:1.75;">"Tôm hùm tươi rói, giao đúng hẹn. Đặt lúc 9h, 10h30 đã có hàng. Sẽ đặt lại!"</p>
          <small class="text-muted d-block mt-2"><i class="bi bi-geo-alt me-1"></i>Ngô Quyền, Hải Phòng</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="review-card">
          <div class="d-flex gap-3 mb-2">
            <div style="width:42px;height:42px;border-radius:50%;background:#e8f5e9;color:#28a745;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:16px;flex-shrink:0;">M</div>
            <div><div class="fw-bold" style="font-size:13px;">Trần Văn Minh</div><div style="color:#ffc107;font-size:12px;">★★★★★</div></div>
          </div>
          <p class="text-muted mb-0" style="font-size:13px;line-height:1.75;">"Cua gạch béo ngậy, đóng gói cẩn thận, không bị chết cua. Rất hài lòng!"</p>
          <small class="text-muted d-block mt-2"><i class="bi bi-geo-alt me-1"></i>Lê Chân, Hải Phòng</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="review-card">
          <div class="d-flex gap-3 mb-2">
            <div style="width:42px;height:42px;border-radius:50%;background:#fce4ec;color:#e91e63;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:16px;flex-shrink:0;">L</div>
            <div><div class="fw-bold" style="font-size:13px;">Lê Thị Lan</div><div style="color:#ffc107;font-size:12px;">★★★★☆</div></div>
          </div>
          <p class="text-muted mb-0" style="font-size:13px;line-height:1.75;">"Giá hợp lý, thanh toán MoMo tiện lợi. Dịch vụ CSKH tốt, sẽ đặt tiếp!"</p>
          <small class="text-muted d-block mt-2"><i class="bi bi-geo-alt me-1"></i>Hồng Bàng, Hải Phòng</small>
        </div>
      </div>
    </div>
  </div>

  <!-- NEWSLETTER -->
  <div class="p-4 text-center" style="background:linear-gradient(135deg,#023e8a,#0077b6);border-radius:16px;color:white;">
    <h4 class="fw-bold mb-1">🔔 Đăng ký nhận tin khuyến mãi</h4>
    <p style="opacity:0.85;font-size:14px;margin-bottom:18px;">Nhận ngay ưu đãi <strong>10% cho đơn đầu tiên</strong>!</p>
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="input-group">
          <input type="email" class="form-control" placeholder="Nhập email của bạn..." style="border-radius:10px 0 0 10px;border:none;font-size:13px;">
          <button class="btn btn-warning fw-bold px-4" type="button" style="border-radius:0 10px 10px 0;color:#1a2035;"><i class="bi bi-send-fill me-1"></i>Đăng ký</button>
        </div>
      </div>
    </div>
  </div>

</div>

<!-- BANNER JS -->
<script>
(function(){
  var sl=document.querySelectorAll('.slide'),dt=document.querySelectorAll('.dot'),pr=document.getElementById('slProg'),cur=0,tot=sl.length,DUR=5200,tm;
  function go(n){sl[cur].classList.remove('active');dt[cur].classList.remove('active');cur=(n+tot)%tot;sl[cur].classList.add('active');dt[cur].classList.add('active');clearTimeout(tm);run();}
  function chg(d){go(cur+d);}
  function run(){pr.style.transition='none';pr.style.width='0%';requestAnimationFrame(function(){requestAnimationFrame(function(){pr.style.transition='width '+DUR+'ms linear';pr.style.width='100%';});});tm=setTimeout(function(){go(cur+1);},DUR);}
  var el=document.querySelector('.hero-slider');
  if(el){el.addEventListener('mouseenter',function(){clearTimeout(tm);pr.style.transition='none';});el.addEventListener('mouseleave',run);}
  var tx=0;
  if(el){el.addEventListener('touchstart',function(e){tx=e.changedTouches[0].clientX;},{passive:true});el.addEventListener('touchend',function(e){var d=tx-e.changedTouches[0].clientX;if(Math.abs(d)>50)go(cur+(d>0?1:-1));},{passive:true});}
  window.go=go; window.chg=chg; run();
})();
</script>

<%@ include file="layout/footer.jsp" %>
