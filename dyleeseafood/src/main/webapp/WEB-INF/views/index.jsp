<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="layout/header.jsp" %>

<style>
  .card-img-wrap {
    position:relative; overflow:hidden;
  }
  .card-img-wrap img {
    transition:transform 0.4s ease;
    width:100%; height:180px; object-fit:cover;
  }
  .product-card:hover .card-img-wrap img {
    transform:scale(1.08);
  }
  .hover-btns {
    position:absolute; bottom:-60px;
    left:0; right:0;
    display:flex; gap:6px; padding:8px;
    background:rgba(0,0,0,0.5);
    transition:bottom 0.3s ease;
  }
  .product-card:hover .hover-btns {
    bottom:0;
  }
</style>

<!-- BANNER -->
<div id="bannerSlider" class="carousel slide"
     data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#bannerSlider"
            data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#bannerSlider"
            data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#bannerSlider"
            data-bs-slide-to="2"></button>
  </div>
  <div class="carousel-inner" style="height:500px;">
    <div class="carousel-item active h-100">
      <img src="https://vcdn1-kinhdoanh.vnecdn.net/2023/11/14/tom-jpeg-1699940158-5302-1699940343.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=taQZag8kkZjTKFHSMJkrFQ"
           class="d-block w-100 h-100"
           style="object-fit:cover;" alt="">
      <div class="carousel-caption d-flex flex-column
                  align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🦞 Tôm Hùm Tươi Sống</h1>
        <p class="lead mb-3">
          Đánh bắt tự nhiên – Giao tận nhà trong ngày
        </p>
        <a href="/dyleeseafood/products?category=1"
           class="btn btn-warning btn-lg fw-bold px-5">
          Mua ngay →
        </a>
      </div>
    </div>
    <div class="carousel-item h-100">
      <img src="https://i.pinimg.com/1200x/6d/ef/ca/6defca0bbda72b74aad27228f51b2202.jpg"
           class="d-block w-100 h-100"
           style="object-fit:cover;" alt="">
      <div class="carousel-caption d-flex flex-column
                  align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🦀 Cua Gạch Cà Mau</h1>
        <p class="lead mb-3">
          Cua gạch son tươi ngon – Chất lượng đảm bảo
        </p>
        <a href="/dyleeseafood/products?category=2"
           class="btn btn-warning btn-lg fw-bold px-5">
          Mua ngay →
        </a>
      </div>
    </div>
    <div class="carousel-item h-100">
      <img src="https://giangghe.com/upload/filemanager/images/kinh-nghiem-chon-hai-san.jpg"
           class="d-block w-100 h-100"
           style="object-fit:cover;" alt="">
      <div class="carousel-caption d-flex flex-column
                  align-items-center justify-content-center"
           style="top:0;bottom:0;background:rgba(0,0,0,0.45);">
        <h1 class="fw-bold display-5">🐟 Hải Sản Sạch</h1>
        <p class="lead mb-3">
          Cam kết tươi sống – Nhận hàng trong 2 giờ
        </p>
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

<!-- THỐNG KÊ -->
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

<!-- DANH MỤC + SẢN PHẨM NỔI BẬT -->
<div class="container mt-4 mb-5">
  <div class="row g-4">

    <!-- SIDEBAR DANH MỤC -->
    <div class="col-md-2">
      <div class="card border-0 shadow-sm"
           style="border-radius:12px; overflow:hidden;
                  position:sticky; top:80px;">
        <div class="card-header border-0 py-2 px-3"
             style="background:#0077b6;">
          <span class="text-white fw-bold"
                style="font-size:13px;">
            <i class="bi bi-grid-fill"></i> Danh mục
          </span>
        </div>
        <div class="list-group list-group-flush">
          <a href="/dyleeseafood/products"
             class="list-group-item list-group-item-action
                    py-2 px-3 border-0"
             style="font-size:13px;">
            <i class="bi bi-grid text-primary me-2"></i>
            Tất cả
          </a>
          <c:forEach var="cat" items="${categories}">
            <a href="/dyleeseafood/products?category=${cat.id}"
               class="list-group-item list-group-item-action
                      py-2 px-3 border-0"
               style="font-size:13px;
                      border-bottom:0.5px solid #f5f5f5 !important;">
              <i class="bi ${cat.icon} text-primary me-2"></i>
              ${cat.name}
            </a>
          </c:forEach>
        </div>
      </div>
    </div>

    <!-- SẢN PHẨM NỔI BẬT -->
    <div class="col-md-10">
      <div class="d-flex justify-content-between
                  align-items-center mb-3">
        <h5 class="fw-bold mb-0">⭐ Sản phẩm nổi bật</h5>
        <a href="/dyleeseafood/products"
           class="btn btn-outline-primary btn-sm">
          Xem tất cả
        </a>
      </div>

      <c:choose>
        <c:when test="${empty featuredProducts}">
          <div class="text-center py-5">
            <i class="bi bi-box text-muted"
               style="font-size:4rem;"></i>
            <p class="text-muted mt-2">
              Chưa có sản phẩm nổi bật
            </p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="row g-3">
            <c:forEach var="p" items="${featuredProducts}">
              <div class="col-6 col-md-4 col-lg-3">
                <div class="card product-card shadow-sm h-100">

                  <!-- ẢNH + HOVER BUTTONS -->
                  <div class="card-img-wrap">
                    <img src="${not empty p.imageUrl
                         ? p.imageUrl
                         : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'}"
                         onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'"
                         alt="${p.name}">
                    <span class="badge bg-warning text-dark"
                          style="position:absolute;
                                 top:8px;left:8px;
                                 font-size:10px;z-index:1;">
                      ⭐ Nổi bật
                    </span>
                    <!-- Nút hiện khi hover -->
                    <div class="hover-btns">
                      <a href="/dyleeseafood/products/${p.id}"
                         class="btn btn-light btn-sm
                                flex-fill fw-bold"
                         style="font-size:12px;">
                        <i class="bi bi-eye"></i> Chi tiết
                      </a>
                      <button type="button"
                              class="btn btn-primary btn-sm
                                     flex-fill fw-bold"
                              style="font-size:12px;"
                              onclick="addToCart(${p.id},
                                '${p.name}',
                                '<fmt:formatNumber value="${p.price}" pattern="#,###"/>đ/${p.unit}',
                                '${not empty p.imageUrl ? p.imageUrl : ""}')">
                        <i class="bi bi-cart-plus"></i> Thêm giỏ
                      </button>
                    </div>
                  </div>

                  <!-- THÔNG TIN -->
                  <div class="card-body d-flex flex-column p-2">
                    <span class="badge bg-info text-dark mb-1"
                          style="font-size:10px;width:fit-content;">
                      ${p.categoryName}
                    </span>
                    <h6 class="fw-bold mb-1"
                        style="font-size:13px;white-space:nowrap;
                               overflow:hidden;text-overflow:ellipsis;">
                      ${p.name}
                    </h6>
                    <div class="mt-auto">
                      <div class="price mb-0"
                           style="font-size:14px;">
                        <fmt:formatNumber value="${p.price}"
                                          pattern="#,###"/>đ
                        <small class="text-muted fw-normal"
                               style="font-size:11px;">
                          /${p.unit}
                        </small>
                      </div>
                      <small class="text-muted">
                        <i class="bi bi-box-seam"></i>
                        Còn: ${p.stock} ${p.unit}
                      </small>
                    </div>
                  </div>

                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</div>

<%@ include file="layout/footer.jsp" %>