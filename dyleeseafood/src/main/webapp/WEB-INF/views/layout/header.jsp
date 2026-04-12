<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dylee Seafood</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root { --primary:#0077b6; --secondary:#00b4d8; }
    body { font-family:'Segoe UI',sans-serif;
           background:#f8f9fa; padding-top:0; }

    /* TOP BAR */
    .top-header { background:var(--primary); padding:12px 0; }
    .top-header .navbar-brand {
      font-size:1.6rem; font-weight:800;
      color:white !important; letter-spacing:-0.5px;
    }
    .top-header .search-box {
      flex:1; max-width:520px;
      display:flex; border-radius:6px; overflow:hidden;
    }
    .top-header .search-box input {
      border:none; padding:10px 16px;
      font-size:14px; flex:1; outline:none;
    }
    .top-header .search-box button {
      background:#ffc107; border:none;
      padding:10px 18px; font-size:18px; color:#333;
      cursor:pointer;
    }
    .top-header .search-box button:hover {
      background:#ffb300;
    }
    .cart-btn {
      position:relative; color:white;
      text-decoration:none; text-align:center;
      font-size:12px; display:flex;
      flex-direction:column; align-items:center;
    }
    .cart-btn i { font-size:1.6rem; }
    .cart-btn .cart-num {
      position:absolute; top:-4px; right:-6px;
      background:#dc3545; color:white;
      border-radius:50%; width:18px; height:18px;
      font-size:10px; font-weight:700;
      display:flex; align-items:center;
      justify-content:center;
    }
    .phone-box { color:white; font-size:13px; }
    .phone-box .num { font-size:16px; font-weight:700; }

    /* NAVBAR */
    .main-nav { background:#023e8a; }
    .category-btn {
      background:#ffc107; color:#333; font-weight:700;
      font-size:13px; padding:10px 20px; border:none;
      display:flex; align-items:center; gap:8px;
      white-space:nowrap;
    }
    .category-btn:hover { background:#ffb300; }
    .main-nav .nav-link {
      color:rgba(255,255,255,0.9) !important;
      font-size:13px; padding:10px 14px !important;
    }
    .main-nav .nav-link:hover { color:white !important; }

    /* DROPDOWN DANH MỤC */
    .cat-dropdown {
      display:none; position:absolute;
      top:100%; left:0; z-index:9999;
      background:white; min-width:220px;
      box-shadow:0 8px 24px rgba(0,0,0,0.15);
      border-radius:0 0 8px 8px; overflow:hidden;
    }
    .cat-dropdown.show { display:block; }
    .cat-dropdown a {
      display:flex; align-items:center; gap:10px;
      padding:10px 16px; text-decoration:none;
      color:#333; font-size:13px;
      border-bottom:1px solid #f5f5f5; transition:0.15s;
    }
    .cat-dropdown a:hover {
      background:#e3f2fd; color:var(--primary);
    }
    .cat-dropdown a:last-child { border:none; }

    /* DROPDOWN LỊCH SỬ */
    .history-dropdown {
      position:absolute; top:calc(100% + 8px); right:0;
      z-index:9999; background:white; width:320px;
      box-shadow:0 8px 32px rgba(0,0,0,0.15);
      border-radius:14px; overflow:hidden;
      display:none;
    }
    .history-dropdown.show { display:block; }
    .history-dropdown-header {
      background:linear-gradient(135deg,#023e8a,#0077b6);
      padding:14px 18px;
      display:flex; align-items:center;
      justify-content:space-between;
    }
    .history-item {
      display:flex; align-items:center; gap:12px;
      padding:11px 16px;
      border-bottom:1px solid #f0f2f5;
      text-decoration:none; color:#1a2035;
      transition:background 0.15s;
    }
    .history-item:hover { background:#f7f9fc; }
    .history-item:last-child { border:none; }
    .order-dot {
      width:9px; height:9px; border-radius:50%;
      flex-shrink:0;
    }
    .history-footer {
      padding:10px 16px; text-align:center;
      border-top:1px solid #f0f2f5;
      background:#f7f9fc;
    }

    /* PRODUCT CARD */
    .product-card {
      transition:transform 0.2s, box-shadow 0.2s;
      border:none; border-radius:12px; overflow:hidden;
    }
    .product-card:hover {
      transform:translateY(-4px);
      box-shadow:0 8px 25px rgba(0,0,0,0.12);
    }
    .price { color:var(--primary); font-weight:700; }
    footer { background:#023e8a; color:white; }

    /* CART TOAST */
    #cartToast {
      position:fixed; bottom:24px; right:24px;
      z-index:9999; width:340px; border-radius:16px;
      box-shadow:0 8px 32px rgba(0,0,0,0.18);
      display:none; pointer-events:none;
    }
    #cartToast.show {
      display:block; pointer-events:auto;
      animation:slideIn 0.35s ease forwards;
    }
    #cartToast.hide { animation:slideOut 0.35s ease forwards; }
    @keyframes slideIn {
      from{transform:translateX(120%);opacity:0}
      to{transform:translateX(0);opacity:1}
    }
    @keyframes slideOut {
      from{transform:translateX(0);opacity:1}
      to{transform:translateX(120%);opacity:0}
    }
  </style>
</head>
<body>

<!-- ===== TOP HEADER ===== -->
<div class="top-header">
  <div class="container">
    <div class="d-flex align-items-center gap-3">

      <!-- Logo -->
      <a class="navbar-brand me-3"
         href="/dyleeseafood/home">
        🐟 Dylee Seafood
      </a>

      <!-- Search -->
      <form class="search-box flex-fill"
            action="/dyleeseafood/products" method="get">
        <input type="text" name="keyword"
               placeholder="Tìm kiếm hải sản tươi ngon..."
               value="${keyword}">
        <button type="submit">
          <i class="bi bi-search"></i>
        </button>
      </form>

      <!-- Phone -->
      <div class="phone-box text-center
                  d-none d-md-block me-2">
        <div style="font-size:11px;opacity:0.8;">
          Gọi mua hàng
        </div>
        <div class="num">0123 456 789</div>
      </div>

      <!-- Cart -->
      <a href="/dyleeseafood/cart" class="cart-btn ms-2">
        <i class="bi bi-cart3"></i>
        <span class="cart-num" id="cartBadge"
              style="${empty sessionScope.cart ||
                       sessionScope.cart.size()==0
                       ? 'display:none' : ''}">
          ${empty sessionScope.cart
            ? 0 : sessionScope.cart.size()}
        </span>
        <span style="font-size:11px;margin-top:2px;">
          Giỏ hàng
        </span>
      </a>

      <!-- User -->
      <c:choose>
        <c:when test="${not empty sessionScope.loggedUser}">

          <!-- ===== LỊCH SỬ MUA HÀNG ===== -->
          <div style="position:relative;" id="historyMenu">
            <button class="cart-btn ms-2"
                    onclick="toggleHistory()"
                    style="background:transparent;
                           border:none;cursor:pointer;">
              <i class="bi bi-clock-history"></i>
              <span style="font-size:11px;margin-top:2px;">
                Đơn hàng
              </span>
            </button>

            <div class="history-dropdown"
                 id="historyDropdown">

              <!-- Header dropdown -->
              <div class="history-dropdown-header">
                <div class="d-flex align-items-center gap-2">
                  <i class="bi bi-clock-history
                            text-white"></i>
                  <span class="text-white fw-bold"
                        style="font-size:14px;">
                    Đơn hàng gần đây
                  </span>
                </div>
                <a href="/dyleeseafood/order/history"
                   class="text-white"
                   style="font-size:12px;
                          text-decoration:none;
                          opacity:0.8;">
                  Xem tất cả →
                </a>
              </div>

              <!-- Danh sách đơn -->
              <c:choose>
                <c:when test="${not empty recentOrders}">
                  <c:forEach var="order"
                             items="${recentOrders}">
                    <a href="/dyleeseafood/order/tracking/${order.id}"
                       class="history-item">
                      <span class="order-dot"
                            style="background:
                              ${order.status=='Delivered'
                                ?'#16a34a':
                                order.status=='Shipping'
                                ?'#0077b6':
                                order.status=='Cancelled'
                                ?'#dc2626':'#f59e0b'};
                            "></span>
                      <div style="flex:1;min-width:0;">
                        <div class="fw-bold"
                             style="font-size:13.5px;">
                          #DL${order.id}
                        </div>
                        <small style="color:#8a9ab0;">
                          ${order.orderDate}
                        </small>
                      </div>
                      <div class="text-end">
                        <div class="fw-bold"
                             style="color:#0077b6;
                                    font-size:13px;">
                          <fmt:formatNumber
                             value="${order.total}"
                             pattern="#,###"/>đ
                        </div>
                        <c:choose>
                          <c:when test="${order.status=='Pending'}">
                            <span style="font-size:10px;
                                         color:#e65100;">
                              ⏳ Chờ xác nhận
                            </span>
                          </c:when>
                          <c:when test="${order.status=='Confirmed'}">
                            <span style="font-size:10px;
                                         color:#0077b6;">
                              ✅ Đã xác nhận
                            </span>
                          </c:when>
                          <c:when test="${order.status=='Processing'}">
                            <span style="font-size:10px;
                                         color:#7c3aed;">
                              ⚙️ Đang xử lý
                            </span>
                          </c:when>
                          <c:when test="${order.status=='Shipping'}">
                            <span style="font-size:10px;
                                         color:#0077b6;">
                              🚚 Đang giao
                            </span>
                          </c:when>
                          <c:when test="${order.status=='Delivered'}">
                            <span style="font-size:10px;
                                         color:#16a34a;">
                              📦 Đã giao
                            </span>
                          </c:when>
                          <c:when test="${order.status=='Cancelled'}">
                            <span style="font-size:10px;
                                         color:#dc2626;">
                              ❌ Đã hủy
                            </span>
                          </c:when>
                        </c:choose>
                      </div>
                    </a>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-4"
                       style="color:#8a9ab0;">
                    <i class="bi bi-bag-x"
                       style="font-size:2.5rem;
                              color:#dde3ed;"></i>
                    <p class="mt-2 mb-3"
                       style="font-size:13px;">
                      Bạn chưa có đơn hàng nào
                    </p>
                    <a href="/dyleeseafood/products"
                       class="btn btn-primary btn-sm px-4">
                      <i class="bi bi-bag-plus me-1"></i>
                      Mua sắm ngay
                    </a>
                  </div>
                </c:otherwise>
              </c:choose>

              <!-- Footer -->
              <div class="history-footer">
                <a href="/dyleeseafood/order/history"
                   class="btn btn-outline-primary
                          btn-sm w-100"
                   style="border-radius:8px;
                          font-size:13px;">
                  <i class="bi bi-clock-history me-1"></i>
                  Xem toàn bộ lịch sử đơn hàng
                </a>
              </div>

            </div>
          </div>
          <%-- ===== END LỊCH SỬ ===== --%>

          <!-- User dropdown -->
          <div class="dropdown">
            <a class="cart-btn ms-2 dropdown-toggle"
               href="#" role="button"
               data-bs-toggle="dropdown">
              <i class="bi bi-person-circle"></i>
              <span style="font-size:11px;margin-top:2px;">
                ${sessionScope.loggedCustomer.name}
              </span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end"
                style="border-radius:12px;
                       box-shadow:0 4px 20px
                         rgba(0,0,0,0.12);">
              <c:if test="${sessionScope.loggedUser.roleId==1
                         || sessionScope.loggedUser.roleId==2}">
                <li>
                  <a class="dropdown-item py-2"
                     href="/dyleeseafood/admin/dashboard">
                    <i class="bi bi-speedometer2 me-2"></i>
                    Quản trị
                  </a>
                </li>
                <li><hr class="dropdown-divider"></li>
              </c:if>
              <li>
                <a class="dropdown-item py-2"
                   href="/dyleeseafood/order/history">
                  <i class="bi bi-clock-history me-2"></i>
                  Lịch sử đơn hàng
                </a>
              </li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <a class="dropdown-item py-2 text-danger"
                   href="/dyleeseafood/logout">
                  <i class="bi bi-box-arrow-right me-2"></i>
                  Đăng xuất
                </a>
              </li>
            </ul>
          </div>

        </c:when>
        <c:otherwise>
          <a href="/dyleeseafood/login"
             class="cart-btn ms-2">
            <i class="bi bi-person"></i>
            <span style="font-size:11px;margin-top:2px;">
              Đăng nhập
            </span>
          </a>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</div>

<!-- ===== MAIN NAV ===== -->
<nav class="main-nav">
  <div class="container d-flex align-items-stretch">

    <!-- Nút DANH MỤC SẢN PHẨM -->
    <div style="position:relative;" id="catMenu">
      <button class="category-btn h-100"
              onclick="toggleCat()"
              onblur="setTimeout(closeCat,200)">
        <i class="bi bi-list"
           style="font-size:1.1rem;"></i>
        DANH MỤC SẢN PHẨM
        <i class="bi bi-chevron-down"
           style="font-size:0.8rem;"></i>
      </button>
      <div class="cat-dropdown" id="catDropdown">
        <a href="/dyleeseafood/products">
          <i class="bi bi-grid-fill text-primary"></i>
          Tất cả sản phẩm
        </a>
        <c:forEach var="cat" items="${categories}">
          <a href="/dyleeseafood/products?category=${cat.id}">
            <i class="bi ${cat.icon} text-primary"></i>
            ${cat.name}
          </a>
        </c:forEach>
      </div>
    </div>

    <!-- Menu links -->
    <ul class="nav align-items-center">
      <li class="nav-item">
        <a class="nav-link" href="/dyleeseafood/home">
          Trang chủ
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/dyleeseafood/products">
          Sản phẩm
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/dyleeseafood/cart">
          Giỏ hàng
        </a>
      </li>
      <c:if test="${not empty sessionScope.loggedUser}">
        <li class="nav-item">
          <a class="nav-link"
             href="/dyleeseafood/order/history">
            Đơn hàng của tôi
          </a>
        </li>
      </c:if>
    </ul>

  </div>
</nav>

<!-- CART TOAST -->
<div id="cartToast">
  <div class="card border-0"
       style="border-radius:16px;overflow:hidden;">
    <div class="card-header border-0 d-flex
                justify-content-between align-items-center
                py-2 px-3"
         style="background:#e8f5e9;">
      <span class="fw-bold text-success"
            style="font-size:14px;">
        <i class="bi bi-cart-check-fill"></i>
        Đã thêm vào giỏ!
      </span>
      <button type="button" onclick="closeCartToast()"
              class="btn-close btn-sm"></button>
    </div>
    <div class="card-body p-3">
      <div class="d-flex align-items-center gap-3">
        <img id="toastProductImg" src=""
             style="width:65px;height:65px;
                    object-fit:cover;border-radius:10px;
                    border:2px solid #e0e0e0;" alt="">
        <div style="flex:1;min-width:0;">
          <p class="fw-bold mb-1" id="toastProductName"
             style="font-size:13px;white-space:nowrap;
                    overflow:hidden;
                    text-overflow:ellipsis;"></p>
          <p class="text-primary fw-bold mb-0"
             id="toastProductPrice"
             style="font-size:14px;"></p>
          <small class="text-muted">
            <i class="bi bi-check-circle text-success"></i>
            Số lượng: 1
          </small>
        </div>
      </div>
    </div>
    <div class="card-footer border-0 bg-white d-flex
                gap-2 pt-0 px-3 pb-3">
      <button type="button" onclick="closeCartToast()"
              class="btn btn-outline-secondary
                     btn-sm flex-fill">
        ← Tiếp tục mua
      </button>
      <a href="/dyleeseafood/cart"
         class="btn btn-primary btn-sm flex-fill">
        <i class="bi bi-cart3"></i> Xem giỏ
        <span id="toastCartCount"
              class="badge bg-warning text-dark ms-1">
        </span>
      </a>
    </div>
    <div style="background:#f0f0f0;height:4px;
                border-radius:0 0 16px 16px;
                overflow:hidden;">
      <div id="cartToastProgress"
           style="width:100%;height:4px;
                  background:#0077b6;"></div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// ===== DANH MỤC DROPDOWN =====
function toggleCat() {
  document.getElementById('catDropdown')
    .classList.toggle('show');
}
function closeCat() {
  document.getElementById('catDropdown')
    .classList.remove('show');
}

// ===== LỊCH SỬ DROPDOWN =====
var historyOpen = false;
function toggleHistory() {
  var d = document.getElementById('historyDropdown');
  historyOpen = !historyOpen;
  if (historyOpen) {
    d.classList.add('show');
  } else {
    d.classList.remove('show');
  }
}
// Đóng khi click ra ngoài
document.addEventListener('click', function(e) {
  var menu = document.getElementById('historyMenu');
  if (menu && !menu.contains(e.target)) {
    document.getElementById('historyDropdown')
      .classList.remove('show');
    historyOpen = false;
  }
});

// ===== CART TOAST =====
var toastTimer = null;
function addToCart(productId, productName,
                   productPrice, productImg) {
  fetch('/dyleeseafood/cart/add-ajax/' + productId)
    .then(function(r){ return r.json(); })
    .then(function(data){
      if(data.success){
        document.getElementById('toastProductName')
          .textContent = productName;
        document.getElementById('toastProductPrice')
          .textContent = productPrice;
        document.getElementById('toastProductImg').src =
          productImg ||
          'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80';
        document.getElementById('toastCartCount')
          .textContent = data.cartCount;
        var badge = document.getElementById('cartBadge');
        badge.textContent = data.cartCount;
        badge.style.display = 'flex';
        badge.style.transition = 'transform 0.3s';
        badge.style.transform = 'scale(1.6)';
        setTimeout(function(){
          badge.style.transform = 'scale(1)';
        }, 300);
        showCartToast();
      }
    })
    .catch(function(){
      window.location.href =
        '/dyleeseafood/cart/add/' + productId;
    });
}
function showCartToast(){
  var toast = document.getElementById('cartToast');
  var progress =
    document.getElementById('cartToastProgress');
  if(toastTimer) clearTimeout(toastTimer);
  toast.classList.remove('hide');
  toast.style.display = 'block';
  toast.classList.add('show');
  progress.style.transition = 'none';
  progress.style.width = '100%';
  setTimeout(function(){
    progress.style.transition = 'width 3s linear';
    progress.style.width = '0%';
  }, 50);
  toastTimer = setTimeout(closeCartToast, 3000);
}
function closeCartToast(){
  var toast = document.getElementById('cartToast');
  if(toastTimer) clearTimeout(toastTimer);
  toast.classList.remove('show');
  toast.classList.add('hide');
  setTimeout(function(){
    toast.style.display = 'none';
    toast.classList.remove('hide');
  }, 360);
}
</script>
