<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<style>
  .card-img-wrap {
    position:relative; overflow:hidden;
  }
  .card-img-wrap img {
    transition:transform 0.4s ease;
    width:100%; height:200px; object-fit:cover;
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
  .product-card:hover .hover-btns { bottom:0; }
  .category-sidebar .list-group-item.active {
    background:#0077b6; border-color:#0077b6;
  }
</style>

<div class="container mt-4 mb-5">
  <div class="row">

    <!-- SIDEBAR -->
    <div class="col-md-3">
      <div class="card border-0 shadow-sm mb-3">
        <div class="card-header fw-bold"
             style="background:#0077b6;color:white;">
          <i class="bi bi-grid"></i> Danh mục
        </div>
        <div class="list-group list-group-flush
                    category-sidebar">
          <a href="/dyleeseafood/products"
             class="list-group-item list-group-item-action
                    ${empty selectedCategory ? 'active' : ''}">
            <i class="bi bi-grid-fill"></i> Tất cả sản phẩm
          </a>
          <c:forEach var="cat" items="${categories}">
            <a href="/dyleeseafood/products?category=${cat.id}"
               class="list-group-item list-group-item-action
                      ${selectedCategory == cat.id ? 'active' : ''}">
              <i class="bi ${cat.icon}"></i> ${cat.name}
            </a>
          </c:forEach>
        </div>
      </div>
    </div>

    <!-- DANH SÁCH SẢN PHẨM -->
    <div class="col-md-9">
      <div class="d-flex justify-content-between
                  align-items-center mb-3">
        <h5 class="fw-bold mb-0">
          <c:choose>
            <c:when test="${not empty keyword}">
              🔍 Kết quả: "${keyword}"
            </c:when>
            <c:otherwise>🐟 Tất cả sản phẩm</c:otherwise>
          </c:choose>
        </h5>
        <span class="text-muted">
          ${products.size()} sản phẩm
        </span>
      </div>

      <c:choose>
        <c:when test="${empty products}">
          <div class="text-center py-5">
            <i class="bi bi-inbox text-muted"
               style="font-size:4rem;"></i>
            <h5 class="text-muted mt-3">
              Không tìm thấy sản phẩm
            </h5>
            <a href="/dyleeseafood/products"
               class="btn btn-primary mt-2">
              Xem tất cả
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="row g-3">
            <c:forEach var="p" items="${products}">
              <div class="col-6 col-lg-4">
                <div class="card product-card shadow-sm h-100">

                  <!-- ẢNH + HOVER BUTTONS -->
                  <div class="card-img-wrap">
                    <img src="${not empty p.imageUrl
                         ? p.imageUrl
                         : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=300&q=80'}"
                         onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=300&q=80';"
                         alt="${p.name}">
                    <c:if test="${p.featured}">
                      <span class="badge bg-warning text-dark"
                            style="position:absolute;
                                   top:8px;left:8px;
                                   font-size:11px;z-index:1;">
                        ⭐ Nổi bật
                      </span>
                    </c:if>
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

                  <!-- THÔNG TIN SẢN PHẨM -->
                  <div class="card-body d-flex flex-column">
                    <span class="badge bg-info text-dark mb-1"
                          style="width:fit-content;">
                      ${p.categoryName}
                    </span>
                    <h6 class="fw-bold">${p.name}</h6>
                    <p class="text-muted small mb-2"
                       style="overflow:hidden;display:-webkit-box;
                              -webkit-line-clamp:2;
                              -webkit-box-orient:vertical;">
                      ${p.description}
                    </p>
                    <div class="mt-auto">
                      <div class="price mb-1">
                        <fmt:formatNumber value="${p.price}"
                                          pattern="#,###"/>đ
                        <small class="text-muted fw-normal">
                          /${p.unit}
                        </small>
                      </div>
                      <small class="text-muted d-block">
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

<%@ include file="../layout/footer.jsp" %>