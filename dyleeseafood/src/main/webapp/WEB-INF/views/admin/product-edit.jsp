<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sửa sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body{background:#f0f2f5;}
    .sidebar{background:#023e8a;min-height:100vh;width:240px;position:fixed;top:0;left:0;z-index:100;}
    .sidebar .nav-link{color:rgba(255,255,255,0.8);padding:12px 20px;border-radius:8px;margin:2px 8px;}
    .sidebar .nav-link:hover,.sidebar .nav-link.active{background:rgba(255,255,255,0.15);color:white;}
    .main-content{margin-left:240px;padding:24px;}
    .img-upload-box{border:2px dashed #0077b6;border-radius:12px;padding:30px;text-align:center;background:#f0f8ff;cursor:pointer;}
    .img-upload-box:hover{background:#dbeafe;}
    .preview-img{width:100%;max-height:250px;object-fit:cover;border-radius:10px;border:2px solid #0077b6;}
  </style>
</head>
<body>

<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <span style="font-size:2rem;">🐟</span>
    <h5 class="text-white fw-bold mb-0 mt-1">Dylee Admin</h5>
    <small style="color:rgba(255,255,255,0.5);">
      ${sessionScope.loggedUser.roleId == 1 ? 'Quản trị viên' : 'Nhân viên'}
    </small>
  </div>
  <nav class="nav flex-column px-2">
    <a href="/dyleeseafood/admin/dashboard" class="nav-link">
      <i class="bi bi-speedometer2 me-2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products" class="nav-link active">
      <i class="bi bi-box-seam me-2"></i> Sản phẩm
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/categories" class="nav-link">
        <i class="bi bi-grid me-2"></i> Danh mục
      </a>
      <a href="/dyleeseafood/admin/orders" class="nav-link">
        <i class="bi bi-cart-check me-2"></i> Đơn hàng
      </a>
    </c:if>
    <a href="/dyleeseafood/admin/customers" class="nav-link">
      <i class="bi bi-people me-2"></i> Khách hàng
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/staff" class="nav-link">
        <i class="bi bi-person-badge me-2"></i> Nhân viên
      </a>
    </c:if>
    <a href="/dyleeseafood/home" class="nav-link">
      <i class="bi bi-shop me-2"></i> Xem web
    </a>
    <hr style="border-color:rgba(255,255,255,0.15);" class="mx-2">
    <a href="/dyleeseafood/logout" class="nav-link"
       style="color:rgba(255,100,100,0.9)!important;">
      <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
    </a>
  </nav>
</div>

<div class="main-content">
  <div class="card border-0 shadow-sm p-4"
       style="border-radius:12px;max-width:800px;">
    <div class="d-flex align-items-center mb-4">
      <a href="/dyleeseafood/admin/products"
         class="btn btn-outline-secondary btn-sm me-3">← Quay lại</a>
      <h5 class="fw-bold mb-0">✏️ Sửa: ${product.name}</h5>
    </div>
    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty product.imageUrl}">
      <div class="mb-4 p-3 bg-light rounded-3">
        <p class="fw-bold mb-2">
          <i class="bi bi-image text-primary"></i> Ảnh hiện tại:
        </p>
        <img src="${product.imageUrl}"
             style="height:180px;object-fit:cover;border-radius:8px;"
             onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=300&q=80'"
             alt="${product.name}">
      </div>
    </c:if>
    <form method="post"
          action="/dyleeseafood/admin/products/edit/${product.id}"
          enctype="multipart/form-data">
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
                ${product.categoryId==cat.id ? 'selected' : ''}>
                ${cat.name}
              </option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Đơn vị</label>
          <select name="unit" class="form-select">
            <option value="kg" ${product.unit=='kg' ? 'selected':''}>kg</option>
            <option value="con" ${product.unit=='con' ? 'selected':''}>con</option>
            <option value="hộp" ${product.unit=='hộp' ? 'selected':''}>hộp</option>
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
                 value="${product.slug}">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold">Sản phẩm nổi bật</label>
          <select name="featured" class="form-select">
            <option value="false" ${!product.featured ? 'selected':''}>Không</option>
            <option value="true" ${product.featured ? 'selected':''}>⭐ Có</option>
          </select>
        </div>
        <div class="col-12">
          <label class="form-label fw-bold">Mô tả</label>
          <textarea name="description" class="form-control"
                    rows="3">${product.description}</textarea>
        </div>
        <div class="col-12">
          <label class="form-label fw-bold">
            <i class="bi bi-arrow-repeat"></i> Thay ảnh mới
            <small class="text-muted fw-normal">(để trống nếu không đổi)</small>
          </label>
          <img id="previewImg" src="" class="preview-img d-none mb-2" alt="">
          <div class="img-upload-box"
               onclick="document.getElementById('imageFile').click()">
            <i class="bi bi-cloud-upload" style="font-size:2rem;color:#0077b6;"></i>
            <p class="mb-0 mt-2 fw-bold text-primary">Click để chọn ảnh mới</p>
            <small class="text-muted">JPG, PNG, WEBP – Tối đa 10MB</small>
          </div>
          <input type="file" name="imageFile" id="imageFile"
                 accept="image/*" class="d-none"
                 onchange="previewImage(this)">
        </div>
      </div>
      <div class="d-flex gap-3 mt-4">
        <button type="submit" class="btn btn-warning px-4">
          <i class="bi bi-save"></i> Cập nhật sản phẩm
        </button>
        <a href="/dyleeseafood/admin/products"
           class="btn btn-outline-secondary px-4">Hủy</a>
      </div>
    </form>
  </div>
</div>
<script>
function previewImage(input) {
  if(input.files && input.files[0]){
    var reader = new FileReader();
    reader.onload = function(e){
      var img = document.getElementById('previewImg');
      img.src = e.target.result;
      img.classList.remove('d-none');
    };
    reader.readAsDataURL(input.files[0]);
  }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>