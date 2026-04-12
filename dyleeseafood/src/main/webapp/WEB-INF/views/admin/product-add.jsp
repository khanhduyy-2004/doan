<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thêm sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background:#f0f2f5; }
    .sidebar { background:#023e8a; min-height:100vh; width:240px; position:fixed; top:0; left:0; z-index:100; }
    .sidebar .nav-link { color:rgba(255,255,255,0.8); padding:12px 20px; border-radius:8px; margin:2px 8px; transition:0.2s; }
    .sidebar .nav-link:hover, .sidebar .nav-link.active { background:rgba(255,255,255,0.15); color:white; }
    .main-content { margin-left:240px; padding:24px; }
    .img-upload-box {
      border:2px dashed #0077b6;
      border-radius:12px;
      padding:40px 20px;
      text-align:center;
      background:#f0f8ff;
      cursor:pointer;
      transition:0.2s;
    }
    .img-upload-box:hover { background:#dbeafe; }
    .preview-img {
      width:100%; max-height:250px;
      object-fit:cover; border-radius:10px;
      border:2px solid #0077b6;
    }
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <span style="font-size:2rem;">🐟</span>
    <h5 class="text-white fw-bold mb-0 mt-1">Dylee Admin</h5>
    <small style="color:rgba(255,255,255,0.5);">
      ${sessionScope.loggedUser.roleId == 1
        ? 'Quản trị viên' : 'Nhân viên'}
    </small>
  </div>
  <nav class="nav flex-column px-2">
    <a href="/dyleeseafood/admin/dashboard" class="nav-link">
      <i class="bi bi-speedometer2 me-2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products"
       class="nav-link active">
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

<!-- MAIN CONTENT -->
<div class="main-content">

  <!-- HEADER -->
  <div class="d-flex align-items-center gap-3 mb-4">
    <a href="/dyleeseafood/admin/products"
       class="btn btn-outline-secondary btn-sm">
      <i class="bi bi-arrow-left"></i> Quay lại
    </a>
    <div>
      <h4 class="fw-bold mb-0">
        <i class="bi bi-plus-circle text-primary"></i>
        Thêm sản phẩm mới
      </h4>
      <small class="text-muted">
        Điền đầy đủ thông tin sản phẩm
      </small>
    </div>
  </div>

  <!-- ERROR -->
  <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible
                fade show" role="alert">
      <i class="bi bi-exclamation-triangle"></i>
      ${error}
      <button type="button" class="btn-close"
              data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <form method="post"
        action="/dyleeseafood/admin/products/add"
        enctype="multipart/form-data">

    <div class="row g-4">

      <!-- CỘT TRÁI: Thông tin sản phẩm -->
      <div class="col-md-8">
        <div class="card border-0 shadow-sm p-4"
             style="border-radius:12px;">
          <h6 class="fw-bold mb-3">
            <i class="bi bi-info-circle text-primary"></i>
            Thông tin cơ bản
          </h6>

          <!-- Tên sản phẩm -->
          <div class="mb-3">
            <label class="form-label fw-bold">
              Tên sản phẩm <span class="text-danger">*</span>
            </label>
            <input type="text" name="name"
                   class="form-control"
                   placeholder="VD: Tôm Hùm Bông"
                   required>
          </div>

          <!-- Mô tả -->
          <div class="mb-3">
            <label class="form-label fw-bold">Mô tả</label>
            <textarea name="description"
                      class="form-control" rows="4"
                      placeholder="Mô tả chi tiết về sản phẩm..."></textarea>
          </div>

          <!-- Slug -->
          <div class="mb-3">
            <label class="form-label fw-bold">
              Slug (URL)
              <small class="text-muted fw-normal">
                — tự động tạo nếu để trống
              </small>
            </label>
            <div class="input-group">
              <span class="input-group-text
                           text-muted">/products/</span>
              <input type="text" name="slug"
                     class="form-control"
                     placeholder="tom-hum-bong"
                     id="slugInput">
            </div>
          </div>

          <div class="row g-3">
            <!-- Danh mục -->
            <div class="col-md-6">
              <label class="form-label fw-bold">
                Danh mục <span class="text-danger">*</span>
              </label>
              <select name="categoryId"
                      class="form-select" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categories}">
                  <option value="${cat.id}">
                    ${cat.name}
                  </option>
                </c:forEach>
              </select>
            </div>

            <!-- Đơn vị -->
            <div class="col-md-6">
              <label class="form-label fw-bold">Đơn vị</label>
              <select name="unit" class="form-select">
                <option value="kg">kg</option>
                <option value="con">con</option>
                <option value="hộp">hộp</option>
                <option value="túi">túi</option>
                <option value="gói">gói</option>
              </select>
            </div>

            <!-- Giá -->
            <div class="col-md-6">
              <label class="form-label fw-bold">
                Giá bán (VNĐ) <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <input type="number" name="price"
                       class="form-control"
                       placeholder="0" min="0"
                       step="1000" required>
                <span class="input-group-text">đ</span>
              </div>
            </div>

            <!-- Tồn kho -->
            <div class="col-md-6">
              <label class="form-label fw-bold">
                Tồn kho
              </label>
              <input type="number" name="stock"
                     class="form-control"
                     placeholder="0" min="0"
                     step="0.5" value="0">
            </div>
          </div>
        </div>
      </div>

      <!-- CỘT PHẢI: Ảnh + Cài đặt -->
      <div class="col-md-4">

        <!-- Upload ảnh -->
        <div class="card border-0 shadow-sm p-4 mb-3"
             style="border-radius:12px;">
          <h6 class="fw-bold mb-3">
            <i class="bi bi-image text-primary"></i>
            Hình ảnh sản phẩm
          </h6>

          <!-- Preview ảnh -->
          <img id="previewImg" src=""
               class="preview-img d-none mb-3" alt="">

          <!-- Upload box -->
          <div class="img-upload-box"
               onclick="document.getElementById('imageFile').click()">
            <i class="bi bi-cloud-arrow-up"
               style="font-size:2.5rem;color:#0077b6;"></i>
            <p class="fw-bold text-primary mb-1 mt-2">
              Click để chọn ảnh
            </p>
            <small class="text-muted">
              JPG, PNG, WEBP — Tối đa 10MB
            </small>
          </div>
          <input type="file" name="imageFile"
                 id="imageFile" accept="image/*"
                 class="d-none"
                 onchange="previewImage(this)">

          <!-- Hoặc nhập URL -->
          <div class="mt-3">
            <label class="form-label text-muted"
                   style="font-size:12px;">
              Hoặc nhập URL ảnh:
            </label>
            <input type="text" name="imageUrl"
                   class="form-control form-control-sm"
                   placeholder="https://..."
                   onchange="previewUrl(this.value)">
          </div>
        </div>

        <!-- Cài đặt -->
        <div class="card border-0 shadow-sm p-4"
             style="border-radius:12px;">
          <h6 class="fw-bold mb-3">
            <i class="bi bi-gear text-primary"></i>
            Cài đặt
          </h6>

          <!-- Nổi bật -->
          <div class="mb-3">
            <label class="form-label fw-bold">
              Sản phẩm nổi bật
            </label>
            <select name="featured" class="form-select">
              <option value="false">Không</option>
              <option value="true">⭐ Có</option>
            </select>
            <small class="text-muted">
              Hiển thị trên trang chủ
            </small>
          </div>

          <!-- Trạng thái -->
          <div class="mb-3">
            <label class="form-label fw-bold">
              Trạng thái
            </label>
            <select name="active" class="form-select">
              <option value="true">✅ Đang bán</option>
              <option value="false">❌ Ngừng bán</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <!-- NÚT ACTION -->
    <div class="d-flex gap-3 mt-4">
      <button type="submit"
              class="btn btn-primary px-5 py-2">
        <i class="bi bi-plus-circle"></i>
        Thêm sản phẩm
      </button>
      <a href="/dyleeseafood/admin/products"
         class="btn btn-outline-secondary px-5 py-2">
        Hủy
      </a>
    </div>

  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Preview ảnh khi upload file
function previewImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      var img = document.getElementById('previewImg');
      img.src = e.target.result;
      img.classList.remove('d-none');
    };
    reader.readAsDataURL(input.files[0]);
  }
}

// Preview ảnh khi nhập URL
function previewUrl(url) {
  if (url) {
    var img = document.getElementById('previewImg');
    img.src = url;
    img.classList.remove('d-none');
    img.onerror = function() {
      img.classList.add('d-none');
    };
  }
}

// Tự động tạo slug từ tên sản phẩm
document.querySelector('input[name="name"]')
  .addEventListener('input', function() {
    var slug = this.value
      .toLowerCase()
      .replace(/[àáạảãâầấậẩẫăằắặẳẵ]/g, 'a')
      .replace(/[èéẹẻẽêềếệểễ]/g, 'e')
      .replace(/[ìíịỉĩ]/g, 'i')
      .replace(/[òóọỏõôồốộổỗơờớợởỡ]/g, 'o')
      .replace(/[ùúụủũưừứựửữ]/g, 'u')
      .replace(/[ỳýỵỷỹ]/g, 'y')
      .replace(/đ/g, 'd')
      .replace(/[^a-z0-9\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .trim();
    document.getElementById('slugInput').value = slug;
  });
</script>
</body>
</html>