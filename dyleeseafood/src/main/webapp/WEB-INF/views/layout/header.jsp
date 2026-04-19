<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dylee Seafood 🐟</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root {
      --primary:#0077b6;
      --dark:#023e8a;
      --accent:#ffc107;
    }
    * { box-sizing:border-box; }
    body { font-family:'Segoe UI',sans-serif; background:#f5f6fa; padding-top:0; margin:0; }

    /* ===== TOP BAR ===== */
    .top-bar {
      background:var(--dark);
      padding:8px 0;
      font-size:12px;
      color:rgba(255,255,255,0.7);
    }
    .top-bar a { color:rgba(255,255,255,0.7); text-decoration:none; }
    .top-bar a:hover { color:white; }

    /* ===== HEADER ===== */
    .site-header { background:var(--primary); padding:10px 0; }
    .logo {
      font-size:1.55rem; font-weight:800;
      color:white; text-decoration:none;
      white-space:nowrap; letter-spacing:-0.5px;
    }
    .logo:hover { color:white; }
    .logo span { color:var(--accent); }

    /* SEARCH */
    .search-wrap {
      flex:1; max-width:540px;
      display:flex; border-radius:8px;
      overflow:hidden; box-shadow:0 2px 8px rgba(0,0,0,0.15);
    }
    .search-wrap input {
      border:none; padding:9px 16px;
      font-size:14px; flex:1; outline:none;
      color:#333;
    }
    .search-wrap button {
      background:var(--accent); border:none;
      padding:9px 18px; color:#333;
      font-size:17px; cursor:pointer;
      transition:0.15s;
    }
    .search-wrap button:hover { background:#ffb300; }

    /* PHONE */
    .phone-wrap {
      color:white; text-align:center;
      white-space:nowrap;
    }
    .phone-wrap small { display:block; font-size:11px; opacity:0.75; }
    .phone-wrap strong { font-size:15px; }

    /* ICON BTNS */
    .hdr-btn {
      display:flex; flex-direction:column;
      align-items:center; color:white;
      text-decoration:none; font-size:11px;
      gap:2px; position:relative;
      border:none; background:transparent;
      cursor:pointer; padding:0 4px;
    }
    .hdr-btn i { font-size:1.45rem; }
    .hdr-btn:hover { color:var(--accent); }
    .cart-badge {
      position:absolute; top:-3px; right:-2px;
      background:#dc3545; color:white;
      border-radius:50%; width:17px; height:17px;
      font-size:10px; font-weight:700;
      display:flex; align-items:center;
      justify-content:center;
    }

    /* ===== NAV BAR ===== */
    .site-nav { background:var(--dark); position:relative; }
    .site-nav .container { display:flex; align-items:stretch; }

    /* Cat button */
    .cat-toggle {
      background:var(--accent); color:#1a2035;
      font-weight:700; font-size:13px;
      padding:0 20px; border:none; cursor:pointer;
      display:flex; align-items:center; gap:8px;
      white-space:nowrap; min-height:42px;
      transition:background 0.15s;
      flex-shrink:0;
    }
    .cat-toggle:hover { background:#ffb300; }

    /* Cat dropdown */
    .cat-drop {
      display:none; position:absolute;
      top:100%; left:0; z-index:9999;
      background:white; min-width:230px;
      box-shadow:0 8px 28px rgba(0,0,0,0.15);
      border-radius:0 0 10px 10px;
    }
    .cat-drop.open { display:block; }
    .cat-drop a {
      display:flex; align-items:center;
      gap:10px; padding:9px 16px;
      color:#333; text-decoration:none;
      font-size:13px;
      border-bottom:1px solid #f0f2f5;
      transition:0.15s;
    }
    .cat-drop a:last-child { border:none; }
    .cat-drop a:hover { background:#e3f2fd; color:var(--primary); padding-left:20px; }

    /* Nav links */
    .nav-links { display:flex; align-items:center; flex:1; }
    .nav-links a {
      color:rgba(255,255,255,0.85);
      text-decoration:none; font-size:13px;
      padding:0 14px; height:42px;
      display:flex; align-items:center;
      transition:0.15s; white-space:nowrap;
    }
    .nav-links a:hover,
    .nav-links a.active { color:var(--accent); }

    /* ===== HISTORY DROPDOWN ===== */
    .hist-drop {
      display:none; position:absolute;
      top:calc(100% + 6px); right:0;
      z-index:9999; background:white;
      width:310px;
      box-shadow:0 8px 32px rgba(0,0,0,0.15);
      border-radius:14px; overflow:hidden;
    }
    .hist-drop.open { display:block; }
    .hist-head {
      background:linear-gradient(135deg,var(--dark),var(--primary));
      padding:12px 16px;
      display:flex; justify-content:space-between;
      align-items:center;
    }
    .hist-item {
      display:flex; align-items:center; gap:10px;
      padding:10px 14px;
      border-bottom:1px solid #f0f2f5;
      text-decoration:none; color:#1a2035;
      transition:background 0.15s;
    }
    .hist-item:hover { background:#f7f9fc; }
    .hist-item:last-child { border:none; }

    /* ===== CART TOAST ===== */
    #cartToast {
      position:fixed; bottom:20px; right:20px;
      z-index:99999; width:330px;
      border-radius:14px; display:none;
      box-shadow:0 8px 32px rgba(0,0,0,0.18);
    }
    #cartToast.show {
      display:block;
      animation:toastIn 0.35s ease forwards;
    }
    #cartToast.hide { animation:toastOut 0.3s ease forwards; }
    @keyframes toastIn  { from{transform:translateX(110%);opacity:0} to{transform:translateX(0);opacity:1} }
    @keyframes toastOut { from{transform:translateX(0);opacity:1} to{transform:translateX(110%);opacity:0} }

    /* ===== USER DROPDOWN ===== */
    .dropdown-menu { border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.12); border:none; }
  </style>
</head>
<body>

<!-- ===== TOP BAR ===== -->
<div class="top-bar d-none d-md-block">
  <div class="container d-flex justify-content-between align-items-center">
    <div class="d-flex gap-3">
      <span><i class="bi bi-geo-alt-fill me-1" style="color:#ffc107;"></i>Hải Phòng, Việt Nam</span>
      <span><i class="bi bi-clock-fill me-1" style="color:#ffc107;"></i>7:00 – 21:00 hàng ngày</span>
    </div>
    <div class="d-flex gap-3">
      <a href="/dyleeseafood/about">Giới thiệu</a>
      <span>|</span>
      <a href="/dyleeseafood/contact">Liên hệ</a>
      <span>|</span>
      <a href="/dyleeseafood/faq">FAQ</a>
      <span>|</span>
      <a href="/dyleeseafood/guide/order">Hướng dẫn đặt hàng</a>
    </div>
  </div>
</div>

<!-- ===== SITE HEADER ===== -->
<div class="site-header">
  <div class="container d-flex align-items-center gap-3">

    <!-- Logo -->
    <a class="logo me-3" href="/dyleeseafood/home">
      🐟 Dylee<span>Seafood</span>
    </a>

    <!-- Search -->
    <form class="search-wrap flex-fill" action="/dyleeseafood/products" method="get">
      <input type="text" name="keyword" placeholder="Tìm kiếm tôm, cua, cá, mực..." value="${keyword}">
      <button type="submit"><i class="bi bi-search"></i></button>
    </form>

    <!-- Phone -->
    <div class="phone-wrap d-none d-lg-block">
      <small><i class="bi bi-telephone-fill me-1" style="color:#ffc107;"></i>Gọi mua hàng</small>
      <strong>0123 456 789</strong>
    </div>

    <!-- Cart -->
    <a href="/dyleeseafood/cart" class="hdr-btn ms-1">
      <i class="bi bi-cart3"></i>
      <span class="cart-badge" id="cartBadge"
            style="${empty sessionScope.cart || sessionScope.cart.size()==0 ? 'display:none' : ''}">
        ${empty sessionScope.cart ? 0 : sessionScope.cart.size()}
      </span>
      Giỏ hàng
    </a>

    <!-- History / User -->
    <c:choose>
      <c:when test="${not empty sessionScope.loggedUser}">

        <!-- Lịch sử -->
        <div style="position:relative;" id="histMenu">
          <button class="hdr-btn" onclick="toggleHist(event)">
            <i class="bi bi-clock-history"></i>
            Đơn hàng
          </button>
          <div class="hist-drop" id="histDrop">
            <div class="hist-head">
              <span class="text-white fw-bold" style="font-size:13px;"><i class="bi bi-clock-history me-2"></i>Đơn hàng gần đây</span>
              <a href="/dyleeseafood/order/history" class="text-white" style="font-size:12px;opacity:0.85;">Xem tất cả →</a>
            </div>
            <c:choose>
              <c:when test="${not empty recentOrders}">
                <c:forEach var="o" items="${recentOrders}">
                  <a href="/dyleeseafood/order/tracking/${o.id}" class="hist-item">
                    <span style="width:8px;height:8px;border-radius:50%;flex-shrink:0;background:
                      ${o.status=='Delivered'?'#16a34a':o.status=='Shipping'?'#0077b6':o.status=='Cancelled'?'#dc2626':'#f59e0b'};
                    "></span>
                    <div style="flex:1;min-width:0;">
                      <div class="fw-bold" style="font-size:13px;">#DL${o.id}</div>
                      <small class="text-muted">${o.orderDate}</small>
                    </div>
                    <div class="text-end">
                      <div style="color:#0077b6;font-weight:700;font-size:13px;"><fmt:formatNumber value="${o.total}" pattern="#,###"/>đ</div>
                      <small style="font-size:10px;color:${o.status=='Delivered'?'#16a34a':o.status=='Shipping'?'#0077b6':'#e65100'};">
                        <c:choose>
                          <c:when test="${o.status=='Pending'}">⏳ Chờ xác nhận</c:when>
                          <c:when test="${o.status=='Confirmed'}">✅ Đã xác nhận</c:when>
                          <c:when test="${o.status=='Shipping'}">🚚 Đang giao</c:when>
                          <c:when test="${o.status=='Delivered'}">📦 Đã giao</c:when>
                          <c:when test="${o.status=='Cancelled'}">❌ Đã hủy</c:when>
                        </c:choose>
                      </small>
                    </div>
                  </a>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <div class="text-center py-4" style="color:#8a9ab0;">
                  <i class="bi bi-bag-x" style="font-size:2.2rem;color:#dde3ed;"></i>
                  <p class="mt-2 mb-2" style="font-size:13px;">Chưa có đơn hàng nào</p>
                  <a href="/dyleeseafood/products" class="btn btn-primary btn-sm px-4">Mua sắm ngay</a>
                </div>
              </c:otherwise>
            </c:choose>
            <div style="padding:10px;border-top:1px solid #f0f2f5;background:#f7f9fc;">
              <a href="/dyleeseafood/order/history" class="btn btn-outline-primary btn-sm w-100" style="border-radius:8px;font-size:12px;">
                <i class="bi bi-clock-history me-1"></i>Xem toàn bộ lịch sử
              </a>
            </div>
          </div>
        </div>

        <!-- User -->
        <div class="dropdown">
          <button class="hdr-btn dropdown-toggle" data-bs-toggle="dropdown">
            <i class="bi bi-person-circle"></i>
            ${sessionScope.loggedCustomer.name}
          </button>
          <ul class="dropdown-menu dropdown-menu-end">
            <c:if test="${sessionScope.loggedUser.roleId==1 || sessionScope.loggedUser.roleId==2}">
              <li><a class="dropdown-item py-2" href="/dyleeseafood/admin/dashboard"><i class="bi bi-speedometer2 me-2 text-primary"></i>Quản trị</a></li>
              <li><hr class="dropdown-divider"></li>
            </c:if>
            <li><a class="dropdown-item py-2" href="/dyleeseafood/profile"><i class="bi bi-person-circle me-2 text-primary"></i>Tài khoản của tôi</a></li>
            <li><a class="dropdown-item py-2" href="/dyleeseafood/order/history"><i class="bi bi-clock-history me-2 text-primary"></i>Lịch sử đơn hàng</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item py-2 text-danger" href="/dyleeseafood/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
          </ul>
        </div>

      </c:when>
      <c:otherwise>
        <a href="/dyleeseafood/login" class="hdr-btn">
          <i class="bi bi-person"></i>
          Đăng nhập
        </a>
        <a href="/dyleeseafood/register" class="btn btn-warning btn-sm fw-bold ms-1" style="border-radius:8px;white-space:nowrap;font-size:12px;">
          Đăng ký
        </a>
      </c:otherwise>
    </c:choose>

  </div>
</div>

<!-- ===== NAV BAR ===== -->
<div class="site-nav">
  <div class="container">

    <!-- Danh mục -->
    <div style="position:relative;" id="catWrap">
      <button class="cat-toggle" onclick="toggleCat(event)" onblur="delayClose()">
        <i class="bi bi-list" style="font-size:1.1rem;"></i>
        DANH MỤC SẢN PHẨM
        <i class="bi bi-chevron-down" style="font-size:0.75rem;" id="catChevron"></i>
      </button>
      <div class="cat-drop" id="catDrop">
        <a href="/dyleeseafood/products">
          <i class="bi bi-grid-fill" style="color:var(--primary);"></i>Tất cả sản phẩm
        </a>
        <c:forEach var="cat" items="${categories}">
          <a href="/dyleeseafood/products?category=${cat.id}">
            <i class="bi ${cat.icon}" style="color:var(--primary);"></i>${cat.name}
          </a>
        </c:forEach>
      </div>
    </div>

    <!-- Nav links -->
    <nav class="nav-links ms-2">
      <a href="/dyleeseafood/home"><i class="bi bi-house me-1"></i>Trang chủ</a>
      <a href="/dyleeseafood/products"><i class="bi bi-shop me-1"></i>Sản phẩm</a>
      <a href="/dyleeseafood/about"><i class="bi bi-info-circle me-1"></i>Giới thiệu</a>
      <a href="/dyleeseafood/news"><i class="bi bi-newspaper me-1"></i>Kiến thức hải sản</a>
      <a href="/dyleeseafood/recruitment"><i class="bi bi-briefcase me-1"></i>Tuyển dụng</a>
      <a href="/dyleeseafood/contact"><i class="bi bi-telephone me-1"></i>Liên hệ</a>
      <c:if test="${not empty sessionScope.loggedUser}">
        <a href="/dyleeseafood/order/history"><i class="bi bi-bag me-1"></i>Đơn hàng</a>
      </c:if>
    </nav>

  </div>
</div>

<!-- ===== CART TOAST ===== -->
<div id="cartToast">
  <div style="background:white;border-radius:14px;overflow:hidden;">
    <div style="background:#e8f5e9;padding:10px 14px;display:flex;justify-content:space-between;align-items:center;">
      <span class="fw-bold text-success" style="font-size:13px;"><i class="bi bi-cart-check-fill me-1"></i>Đã thêm vào giỏ!</span>
      <button onclick="closeToast()" style="background:none;border:none;font-size:18px;cursor:pointer;color:#888;line-height:1;">&times;</button>
    </div>
    <div style="padding:12px 14px;">
      <div class="d-flex gap-3 align-items-center">
        <img id="toastImg" src="" style="width:60px;height:60px;object-fit:cover;border-radius:8px;border:1px solid #e0e0e0;" alt="">
        <div style="flex:1;min-width:0;">
          <div class="fw-bold" id="toastName" style="font-size:13px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"></div>
          <div style="color:#0077b6;font-weight:700;" id="toastPrice"></div>
          <small class="text-muted"><i class="bi bi-check-circle text-success me-1"></i>Số lượng: 1</small>
        </div>
      </div>
    </div>
    <div style="padding:0 14px 12px;display:flex;gap:8px;">
      <button onclick="closeToast()" class="btn btn-outline-secondary btn-sm flex-fill" style="border-radius:8px;">Tiếp tục mua</button>
      <a href="/dyleeseafood/cart" class="btn btn-primary btn-sm flex-fill" style="border-radius:8px;">
        <i class="bi bi-cart3 me-1"></i>Xem giỏ <span id="toastCount" class="badge bg-warning text-dark ms-1"></span>
      </a>
    </div>
    <div style="height:3px;background:#e0e0e0;">
      <div id="toastBar" style="height:3px;background:#0077b6;width:100%;transition:none;"></div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// ===== CATEGORY =====
function toggleCat(e) {
  e && e.stopPropagation();
  var d = document.getElementById('catDrop');
  var c = document.getElementById('catChevron');
  d.classList.toggle('open');
  c.style.transform = d.classList.contains('open') ? 'rotate(180deg)' : '';
}
function delayClose() { setTimeout(function(){ document.getElementById('catDrop').classList.remove('open'); document.getElementById('catChevron').style.transform=''; }, 200); }
document.addEventListener('click', function(e) {
  var w = document.getElementById('catWrap');
  if (w && !w.contains(e.target)) { document.getElementById('catDrop').classList.remove('open'); document.getElementById('catChevron').style.transform=''; }
});

// ===== HISTORY =====
function toggleHist(e) {
  e && e.stopPropagation();
  document.getElementById('histDrop').classList.toggle('open');
}
document.addEventListener('click', function(e) {
  var m = document.getElementById('histMenu');
  if (m && !m.contains(e.target)) document.getElementById('histDrop').classList.remove('open');
});

// ===== CART =====
var toastTimer = null;
function addToCart(id, name, price, img) {
  fetch('/dyleeseafood/cart/add-ajax/' + id)
    .then(function(r){ return r.json(); })
    .then(function(d){
      if (d.success) {
        document.getElementById('toastName').textContent  = name;
        document.getElementById('toastPrice').textContent = price;
        document.getElementById('toastImg').src = img || 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80';
        document.getElementById('toastCount').textContent = d.cartCount;
        var b = document.getElementById('cartBadge');
        b.textContent = d.cartCount;
        b.style.display = 'flex';
        b.style.transform = 'scale(1.6)';
        setTimeout(function(){ b.style.transform = 'scale(1)'; }, 300);
        showToast();
      }
    })
    .catch(function(){ window.location.href = '/dyleeseafood/cart/add/' + id; });
}
function showToast() {
  var t = document.getElementById('cartToast');
  var bar = document.getElementById('toastBar');
  if (toastTimer) clearTimeout(toastTimer);
  t.classList.remove('hide');
  t.classList.add('show');
  bar.style.transition = 'none'; bar.style.width = '100%';
  setTimeout(function(){ bar.style.transition = 'width 3s linear'; bar.style.width = '0%'; }, 30);
  toastTimer = setTimeout(closeToast, 3000);
}
function closeToast() {
  var t = document.getElementById('cartToast');
  if (toastTimer) clearTimeout(toastTimer);
  t.classList.remove('show'); t.classList.add('hide');
  setTimeout(function(){ t.classList.remove('hide'); }, 350);
}
</script>
