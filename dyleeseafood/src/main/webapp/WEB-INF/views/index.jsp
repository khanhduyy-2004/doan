<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="layout/header.jsp" %>

<!-- BANNER SLIDER -->
<div id="bannerSlider" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#bannerSlider" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#bannerSlider" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#bannerSlider" data-bs-slide-to="2"></button>
  </div>
  <div class="carousel-inner" style="height:480px;">

    <!-- Slide 1: Tôm Hùm -->
    <div class="carousel-item active h-100">
      <img src="https://images.unsplash.com/photo-1615141982883-c7ad0e69fd62?w=1400&q=80"
           class="d-block w-100 h-100" style="object-fit:cover;" alt="Tôm Hùm">
      <div class="carousel-caption d-flex flex-column align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🦞 Tôm Hùm Tươi Sống</h1>
        <p class="lead mb-3">Đánh bắt tự nhiên – Giao tận nhà trong ngày</p>
        <a href="/dyleeseafood/products?category=1"
           class="btn btn-warning btn-lg fw-bold px-5">
          Mua ngay →
        </a>
      </div>
    </div>

    <!-- Slide 2: Cua -->
    <div class="carousel-item h-100">
      <img src="https://images.unsplash.com/photo-1563715379893-e56e9b8ca3c3?w=1400&q=80"
           class="d-block w-100 h-100" style="object-fit:cover;" alt="Cua">
      <div class="carousel-caption d-flex flex-column align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🦀 Cua Gạch Cà Mau</h1>
        <p class="lead mb-3">Cua gạch son tươi ngon – Chất lượng đảm bảo</p>
        <a href="/dyleeseafood/products?category=2"
           class="btn btn-warning btn-lg fw-bold px-5">
          Mua ngay →
        </a>
      </div>
    </div>

    <!-- Slide 3: Hải sản -->
    <div class="carousel-item h-100">
      <img src="https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=1400&q=80"
           class="d-block w-100 h-100" style="object-fit:cover;" alt="Hải sản">
      <div class="carousel-caption d-flex flex-column align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🐟 Hải Sản Sạch</h1>
        <p class="lead mb-3">Cam kết tươi sống – Nhận hàng trong 2 giờ</p>
        <a href="/dyleeseafood/products"
           class="btn btn-warning btn-lg fw-bold px-5">
          Xem tất cả →
        </a>
      </div>
    </div>

  </div>
  <button class="carousel-control-prev" type="button"
          data-bs-target="#bannerSlider" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button"
          data-bs-target="#bannerSlider" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

<!-- THỐNG KÊ NHỎ -->
<div style="background:#0077b6;" class="py-3">
  <div class="container">
    <div class="row text-white text-center">
      <div class="col-3">
        <h4 class="fw-bold mb-0">500+</h4>
        <small>Sản phẩm</small>
      </div>
      <div class="col-3">
        <h4 class="fw-bold mb-0">1000+</h4>
        <small>Khách hàng</small>
      </div>
      <div class="col-3">
        <h4 class="fw-bold mb-0">2h</h4>
        <small>Giao hàng</small>
      </div>
      <div class="col-3">
        <h4 class="fw-bold mb-0">100%</h4>
        <small>Tươi sống</small>
      </div>
    </div>
  </div>
</div>

<!-- DANH MỤC -->
<div class="container mt-5">
  <h3 class="fw-bold mb-4 text-center">🗂 Danh mục sản phẩm</h3>
  <div class="row g-3 justify-content-center">
    <c:forEach var="cat" items="${categories}">
      <div class="col-6 col-md-3">
        <a href="/dyleeseafood/products?category=${cat.id}" class="text-decoration-none">
          <div class="card text-center border-0 shadow-sm p-3 h-100"
               style="border-radius:12px; transition:0.2s; cursor:pointer;"
               onmouseover="this.style.transform='translateY(-5px)';this.style.boxShadow='0 10px 30px rgba(0,119,182,0.2)'"
               onmouseout="this.style.transform='translateY(0)';this.style.boxShadow=''">
            <i class="bi ${cat.icon} text-primary" style="font-size:2.8rem;"></i>
            <h6 class="mt-2 mb-1 fw-bold text-dark">${cat.name}</h6>
            <small class="text-muted">${cat.description}</small>
          </div>
        </a>
      </div>
    </c:forEach>
  </div>
</div>

<!-- SẢN PHẨM NỔI BẬT -->
<div class="container mt-5 mb-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">⭐ Sản phẩm nổi bật</h3>
    <a href="/dyleeseafood/products" class="btn btn-outline-primary">Xem tất cả</a>
  </div>

  <c:choose>
    <c:when test="${empty featuredProducts}">
      <div class="text-center py-5">
        <i class="bi bi-box text-muted" style="font-size:4rem;"></i>
        <p class="text-muted mt-2">Chưa có sản phẩm nổi bật</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row g-4">
        <c:forEach var="p" items="${featuredProducts}">
          <div class="col-6 col-md-4 col-lg-3">
            <div class="card product-card shadow-sm h-100"
                 style="border-radius:12px; overflow:hidden;">
              <div style="position:relative;">
                <img src="${not empty p.imageUrl ? p.imageUrl :
                     'https://images.unsplash.com/photo-1615141982883-c7ad0e69fd62?w=400&q=80'}"
                     class="card-img-top"
                     style="height:200px; object-fit:cover;"
                     onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'"
                     alt="${p.name}">
                <span class="badge bg-warning text-dark"
                      style="position:absolute;top:10px;left:10px;">
                  ⭐ Nổi bật
                </span>
              </div>
              <div class="card-body d-flex flex-column">
                <span class="badge bg-info text-dark mb-1 w-fit">${p.categoryName}</span>
                <h6 class="card-title fw-bold">${p.name}</h6>
                <p class="text-muted small mb-2"
                   style="overflow:hidden;display:-webkit-box;
                          -webkit-line-clamp:2;-webkit-box-orient:vertical;">
                  ${p.description}
                </p>
                <div class="mt-auto">
                  <div class="price mb-2" style="color:#0077b6;font-size:1.1rem;font-weight:700;">
                    <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                    <small class="text-muted fw-normal" style="font-size:0.8rem;">/${p.unit}</small>
                  </div>
                  <small class="text-muted d-block mb-2">
                    <i class="bi bi-box-seam"></i> Còn: ${p.stock} ${p.unit}
                  </small>
                  <div class="d-flex gap-2">
                    <a href="/dyleeseafood/products/${p.id}"
                       class="btn btn-outline-primary btn-sm flex-fill">
                      Chi tiết
                    </a>
                    <a href="/dyleeseafood/cart/add/${p.id}"
                       class="btn btn-primary btn-sm flex-fill">
                      <i class="bi bi-cart-plus"></i> Thêm
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="layout/footer.jsp" %>