<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Form sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background: #f0f2f5; }
    .sidebar { background: #023e8a; min-height: 100vh; width: 240px; position: fixed; top:0; left:0; }
    .sidebar .nav-link { color: rgba(255,255,255,0.8); padding: 12px 20px; border-radius: 8px; margin: 2px 8px; }
    .sidebar .nav-link:hover { background: rgba(255,255,255,0.15); color: white; }
    .main-content { margin-left: 240px; padding: 24px; }
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <h5 class="text-white fw-bold">🐟 Dylee Admin</h5>
  </div>
  <nav class="nav flex-column">
    <a href="/dyleeseafood/admin/dashboard" class="nav-link">
      <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products" class="nav-link active">
      <i class="bi bi-box-seam"></i> Sản phẩm
    </a>
    <a href="/dyleeseafood/home" class="nav-link">
      <i class="bi bi-shop"></i> Xem web
    </a>
    <hr class="border-secondary mx-3">
    <a href="/dyleeseafood/logout" class="nav-link text-danger">
      <i class="bi bi-box-arrow-right"></i> Đăng xuất
    </a>
  </nav>
</div>

<!-- MAIN -->
<div class="main-content">
  <div class="card border-0 shadow-sm p-4" style="border-radius:12px; max-width:700px;">
    <h5 class="fw-bold mb-4">
      ${empty product.id ? '➕ Thêm sản phẩm' : '✏️ Sửa sản phẩm'}
    </h5>

    <c:choose>
      <c:when test="${empty product.id}">
        <form method="post" action="/dyleeseafood/admin/products/add">
      </c:when>
      <c:otherwise>
        <form method="post" action="/dyleeseafood/admin/products/edit/${product.id}">
      </c:otherwise>
    </c:choose>

      <div class="row g-3">
        <div class="col-12">
          <label class="form-label fw-bold">Tên sản phẩm *</label>
          <input type="text" name="name" class="form-control"
                 value="${product.name}" required>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Danh mục *</label>
          <select name="categoryId" class="form-select" required>
            <option value="">-- Chọn danh mục --</option>
            <c:forEach var="cat" items="${categories}">
              <option value="${cat.id}"
                ${product.categoryId == cat.id ? 'selected' : ''}>
                ${cat.name}
              </option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Đơn vị</label>
          <select name="unit" class="form-select">
            <option value="kg" ${product.unit == 'kg' ? 'selected' : ''}>kg</option>
            <option value="con" ${product.unit == 'con' ? 'selected' : ''}>con</option>
            <option value="hộp" ${product.unit == 'hộp' ? 'selected' : ''}>hộp</option>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Giá (VNĐ) *</label>
          <input type="number" name="price" class="form-control"
                 value="${product.price}" min="0" required>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Tồn kho</label>
          <input type="number" name="stock" class="form-control"
                 value="${product.stock}" min="0" step="0.5">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Slug (URL)</label>
          <input type="text" name="slug" class="form-control"
                 value="${product.slug}" placeholder="vd: tom-hum-bong">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Sản phẩm nổi bật</label>
          <select name="featured" class="form-select">
            <option value="false" ${!product.featured ? 'selected' : ''}>Không</option>
            <option value="true" ${product.featured ? 'selected' : ''}>⭐ Có</option>
          </select>
        </div>
        <div class="col-12">
          <label class="form-label fw-bold">Mô tả</label>
          <textarea name="description" class="form-control"
                    rows="4">${product.description}</textarea>
        </div>
      </div>

      <div class="d-flex gap-3 mt-4">
        <button type="submit" class="btn btn-primary px-4">
          <i class="bi bi-save"></i> Lưu
        </button>
        <a href="/dyleeseafood/admin/products"
           class="btn btn-outline-secondary px-4">
          ← Quay lại
        </a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>