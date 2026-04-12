<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header.jsp" %>

<div class="container mt-4 mb-5">
  <nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/dyleeseafood/home">Trang chủ</a></li>
      <li class="breadcrumb-item"><a href="/dyleeseafood/products">Sản phẩm</a></li>
      <li class="breadcrumb-item active">${product.name}</li>
    </ol>
  </nav>

  <div class="card border-0 shadow-sm p-4" style="border-radius:16px;">
    <div class="row g-4">
      <div class="col-md-5">
        <img src="${not empty product.imageUrl ? product.imageUrl :
             'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=600&q=80'}"
             style="width:100%;height:380px;object-fit:cover;
                    border-radius:12px;border:2px solid #e0e0e0;"
             onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=600&q=80'"
             alt="${product.name}">
      </div>
      <div class="col-md-7">
        <span class="badge bg-info text-dark mb-2"
              style="font-size:13px;padding:6px 12px;">
          <i class="bi bi-grid"></i> ${product.categoryName}
        </span>
        <h2 class="fw-bold mb-2">${product.name}</h2>
        <div class="mb-3" style="font-size:2rem;font-weight:700;color:#0077b6;">
          <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ
          <small class="text-muted" style="font-size:1rem;font-weight:400;">
            / ${product.unit}
          </small>
        </div>
        <div class="mb-3">
          <c:choose>
            <c:when test="${product.stock > 10}">
              <span class="badge bg-success" style="font-size:13px;padding:6px 12px;">
                <i class="bi bi-check-circle"></i>
                Còn hàng (${product.stock} ${product.unit})
              </span>
            </c:when>
            <c:when test="${product.stock > 0}">
              <span class="badge bg-warning text-dark"
                    style="font-size:13px;padding:6px 12px;">
                <i class="bi bi-exclamation-circle"></i>
                Sắp hết (còn ${product.stock} ${product.unit})
              </span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-danger" style="font-size:13px;padding:6px 12px;">
                <i class="bi bi-x-circle"></i> Hết hàng
              </span>
            </c:otherwise>
          </c:choose>
        </div>
        <p class="text-muted mb-4" style="font-size:15px;line-height:1.7;">
          ${product.description}
        </p>
        <hr>
        <div class="row g-2 mb-4">
          <div class="col-6">
            <div class="p-3 bg-light rounded-3 text-center">
              <i class="bi bi-box-seam text-primary" style="font-size:1.5rem;"></i>
              <p class="mb-0 fw-bold mt-1">${product.stock} ${product.unit}</p>
              <small class="text-muted">Tồn kho</small>
            </div>
          </div>
          <div class="col-6">
            <div class="p-3 bg-light rounded-3 text-center">
              <i class="bi bi-truck text-primary" style="font-size:1.5rem;"></i>
              <p class="mb-0 fw-bold mt-1">Miễn phí</p>
              <small class="text-muted">Giao hàng</small>
            </div>
          </div>
          <div class="col-6">
            <div class="p-3 bg-light rounded-3 text-center">
              <i class="bi bi-shield-check text-primary" style="font-size:1.5rem;"></i>
              <p class="mb-0 fw-bold mt-1">100%</p>
              <small class="text-muted">Tươi sống</small>
            </div>
          </div>
          <div class="col-6">
            <div class="p-3 bg-light rounded-3 text-center">
              <i class="bi bi-arrow-repeat text-primary" style="font-size:1.5rem;"></i>
              <p class="mb-0 fw-bold mt-1">24h</p>
              <small class="text-muted">Đổi trả</small>
            </div>
          </div>
        </div>
        <c:choose>
          <c:when test="${product.stock > 0}">
            <div class="d-flex gap-3">
              <button type="button" class="btn btn-primary btn-lg px-5 fw-bold"
                      onclick="addToCart(${product.id},'${product.name}',
                        '<fmt:formatNumber value="${product.price}" pattern="#,###"/>đ/${product.unit}',
                        '${not empty product.imageUrl ? product.imageUrl : ""}')">
                <i class="bi bi-cart-plus"></i> Thêm vào giỏ hàng
              </button>
              <a href="/dyleeseafood/products"
                 class="btn btn-outline-secondary btn-lg">← Quay lại</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="d-flex gap-3">
              <button class="btn btn-secondary btn-lg px-5" disabled>
                <i class="bi bi-x-circle"></i> Hết hàng
              </button>
              <a href="/dyleeseafood/products"
                 class="btn btn-outline-secondary btn-lg">← Quay lại</a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

  <div class="card border-0 shadow-sm mt-4 p-4" style="border-radius:16px;">
    <h5 class="fw-bold mb-3">
      <i class="bi bi-file-text text-primary"></i> Thông tin sản phẩm
    </h5>
    <hr>
    <table class="table table-bordered table-hover">
      <tbody>
        <tr>
          <td class="fw-bold bg-light" style="width:35%;">Tên sản phẩm</td>
          <td>${product.name}</td>
        </tr>
        <tr>
          <td class="fw-bold bg-light">Danh mục</td>
          <td>${product.categoryName}</td>
        </tr>
        <tr>
          <td class="fw-bold bg-light">Đơn giá</td>
          <td style="color:#0077b6;font-weight:bold;">
            <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ
            / ${product.unit}
          </td>
        </tr>
        <tr>
          <td class="fw-bold bg-light">Tồn kho</td>
          <td>${product.stock} ${product.unit}</td>
        </tr>
        <tr>
          <td class="fw-bold bg-light">Trạng thái</td>
          <td>
            <c:choose>
              <c:when test="${product.stock > 0}">
                <span class="text-success fw-bold">✅ Còn hàng</span>
              </c:when>
              <c:otherwise>
                <span class="text-danger fw-bold">❌ Hết hàng</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <td class="fw-bold bg-light">Mô tả</td>
          <td>${product.description}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="card border-0 shadow-sm mt-4 p-4" style="border-radius:16px;">
    <h5 class="fw-bold mb-3">
      <i class="bi bi-award text-warning"></i> Cam kết của Dylee Seafood
    </h5>
    <div class="row g-3 text-center">
      <div class="col-md-3 col-6">
        <i class="bi bi-fish text-primary" style="font-size:2.5rem;"></i>
        <p class="fw-bold mt-2 mb-0">Tươi sống 100%</p>
        <small class="text-muted">Đánh bắt trong ngày</small>
      </div>
      <div class="col-md-3 col-6">
        <i class="bi bi-truck text-success" style="font-size:2.5rem;"></i>
        <p class="fw-bold mt-2 mb-0">Giao hàng nhanh</p>
        <small class="text-muted">Trong vòng 2 giờ</small>
      </div>
      <div class="col-md-3 col-6">
        <i class="bi bi-shield-check text-info" style="font-size:2.5rem;"></i>
        <p class="fw-bold mt-2 mb-0">An toàn vệ sinh</p>
        <small class="text-muted">Đạt tiêu chuẩn VSATTP</small>
      </div>
      <div class="col-md-3 col-6">
        <i class="bi bi-arrow-repeat text-warning" style="font-size:2.5rem;"></i>
        <p class="fw-bold mt-2 mb-0">Đổi trả dễ dàng</p>
        <small class="text-muted">Trong 24h nếu lỗi</small>
      </div>
    </div>
  </div>
</div>

<%@ include file="../layout/footer.jsp" %>