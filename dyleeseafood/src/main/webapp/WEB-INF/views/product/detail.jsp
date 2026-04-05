<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<div class="container mt-4">
  <div class="row">
    <!-- SIDEBAR DANH MỤC -->
    <div class="col-md-3">
      <div class="card border-0 shadow-sm mb-3">
        <div class="card-header fw-bold" style="background:#0077b6; color:white;">
          <i class="bi bi-grid"></i> Danh mục
        </div>
        <div class="list-group list-group-flush category-sidebar">
          <a href="/dyleeseafood/products"
             class="list-group-item list-group-item-action ${empty selectedCategory ? 'active' : ''}">
            <i class="bi bi-grid-fill"></i> Tất cả sản phẩm
          </a>
          <c:forEach var="cat" items="${categories}">
            <a href="/dyleeseafood/products?category=${cat.id}"
               class="list-group-item list-group-item-action ${selectedCategory == cat.id ? 'active' : ''}">
              <i class="bi ${cat.icon}"></i> ${cat.name}
            </a>
          </c:forEach>
        </div>
      </div>
    </div>

    <!-- DANH SÁCH SẢN PHẨM -->
    <div class="col-md-9">
      <!-- Tiêu đề + kết quả tìm kiếm -->
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0">
          <c:choose>
            <c:when test="${not empty keyword}">
              🔍 Kết quả tìm kiếm: "${keyword}"
            </c:when>
            <c:otherwise>
              🐟 Tất cả sản phẩm
            </c:otherwise>
          </c:choose>
        </h5>
        <span class="text-muted">${products.size()} sản phẩm</span>
      </div>

      <c:choose>
        <c:when test="${empty products}">
          <div class="text-center py-5">
            <i class="bi bi-inbox text-muted" style="font-size:4rem;"></i>
            <h5 class="text-muted mt-3">Không tìm thấy sản phẩm</h5>
            <a href="/dyleeseafood/products" class="btn btn-primary mt-2">Xem tất cả</a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="row g-3">
            <c:forEach var="p" items="${products}">
              <div class="col-6 col-lg-4">
                <div class="card product-card shadow-sm h-100">
                  <img src="${not empty p.imageUrl ? p.imageUrl : 'https://via.placeholder.com/300x200/0077b6/white?text='.concat(p.name)}"
                       class="card-img-top"
                       onerror="this.src='https://via.placeholder.com/300x200/0077b6/white?text=Hải+Sản'"
                       alt="${p.name}">
                  <div class="card-body d-flex flex-column">
                    <span class="badge bg-info text-dark mb-1">${p.categoryName}</span>
                    <h6 class="fw-bold">${p.name}</h6>
                    <p class="text-muted small mb-2" style="overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;">
                      ${p.description}
                    </p>
                    <div class="mt-auto">
                      <div class="price mb-2">
                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                        <small class="text-muted fw-normal">/${p.unit}</small>
                      </div>
                      <small class="text-muted">Còn: ${p.stock} ${p.unit}</small>
                      <div class="d-flex gap-2 mt-2">
                        <a href="/dyleeseafood/products/${p.id}"
                           class="btn btn-outline-primary btn-sm flex-fill">Chi tiết</a>
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
  </div>
</div>

<%@ include file="../layout/footer.jsp" %>