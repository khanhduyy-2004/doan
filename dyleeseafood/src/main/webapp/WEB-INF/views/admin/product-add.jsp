<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thêm sản phẩm — Dylee Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root{--p:#0077b6;--dk:#023e8a;--dkr:#011f4b;--ac:#ffc107;--bg:#eef2f7;--bd:#e5eaf2;--tx:#0f172a;--tx2:#475569;--tx3:#94a3b8;}
    body{background:var(--bg);}
    .sidebar{background:linear-gradient(180deg,var(--dkr) 0%,var(--dk) 55%,#0353a4 100%);min-height:100vh;width:240px;position:fixed;top:0;left:0;z-index:100;box-shadow:4px 0 18px rgba(2,62,138,.2);}
    .sidebar-brand{padding:20px 18px 16px;border-bottom:1px solid rgba(255,255,255,.1);margin-bottom:8px;}
    .sidebar-brand .lw{width:40px;height:40px;border-radius:10px;background:rgba(255,193,7,.18);display:flex;align-items:center;justify-content:center;font-size:1.4rem;margin-bottom:8px;}
    .sidebar-brand span{color:var(--ac);font-weight:800;font-size:15px;}
    .sidebar-brand small{display:block;color:rgba(255,255,255,.4);font-size:11px;margin-top:2px;}
    .ngl{padding:8px 18px 3px;font-size:10px;font-weight:700;color:rgba(255,255,255,.3);text-transform:uppercase;letter-spacing:.08em;}
    .ni{display:flex;align-items:center;gap:9px;padding:9px 18px;color:rgba(255,255,255,.65);text-decoration:none;font-size:13px;font-weight:500;transition:all .15s;border-left:2.5px solid transparent;margin:1px 8px 1px 0;border-radius:0 7px 7px 0;}
    .ni:hover{background:rgba(255,255,255,.09);color:white;border-left-color:rgba(255,255,255,.25);}
    .ni.on{background:rgba(0,119,182,.28);color:white;border-left-color:var(--ac);font-weight:600;}
    .ni.red{color:rgba(255,120,120,.85)!important;}.ni.red:hover{background:rgba(248,81,73,.1);}
    .ni i{font-size:.92rem;width:17px;text-align:center;}
    .sidebar hr{border-color:rgba(255,255,255,.12);margin:6px 16px;}
    .main-content{margin-left:240px;padding:24px;}
    .back-btn{background:#f1f5f9;color:var(--tx2);border:1.5px solid var(--bd);border-radius:8px;padding:7px 14px;font-size:13px;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:6px;transition:.15s;}
    .back-btn:hover{border-color:var(--p);color:var(--p);}
    .fcard{background:white;border-radius:14px;border:1px solid var(--bd);box-shadow:0 1px 8px rgba(2,62,138,.07);padding:24px;margin-bottom:0;}
    .fcard-title{font-size:14px;font-weight:700;color:var(--tx);margin-bottom:16px;padding-bottom:12px;border-bottom:1px solid #f1f5f9;display:flex;align-items:center;gap:8px;}
    .form-control,.form-select{border:1.5px solid var(--bd);border-radius:8px;padding:9px 13px;font-size:13.5px;background:#f8fafc;color:var(--tx);}
    .form-control:focus,.form-select:focus{border-color:var(--p);box-shadow:0 0 0 3px rgba(0,119,182,.1);background:white;}
    .form-label{font-size:12px;font-weight:700;color:var(--tx2);margin-bottom:5px;text-transform:uppercase;letter-spacing:.04em;}
    .input-group-text{background:#f1f5f9;border:1.5px solid var(--bd);border-radius:8px;font-size:13px;color:var(--tx3);}
    .input-group .form-control{border-radius:0 8px 8px 0!important;}
    .input-group .input-group-text:first-child{border-radius:8px 0 0 8px!important;}
    .btn{border-radius:9px;font-weight:600;}
    .btn-primary{background:var(--p);border-color:var(--p);}
    .btn-primary:hover{background:var(--dk);border-color:var(--dk);}
    .btn-outline-secondary{border-color:var(--bd);color:var(--tx2);}
    .btn-outline-secondary:hover{background:#f1f5f9;color:var(--tx);}
    .img-upload-box{border:2px dashed var(--p);border-radius:12px;padding:36px 20px;text-align:center;background:#f0f8ff;cursor:pointer;transition:.2s;}
    .img-upload-box:hover{background:#dbeafe;}
    .preview-img{width:100%;max-height:220px;object-fit:cover;border-radius:10px;border:2px solid var(--p);}
    .alert-danger{border-radius:10px;border-left:4px solid #dc2626;}
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
  <div class="sidebar-brand">
    <div class="lw">🐟</div>
    <span>DyleeAdmin</span>
    <small>${sessionScope.loggedUser.roleId==1?'Quản trị viên':'Nhân viên'}</small>
  </div>
  <div class="ngl">Tổng quan</div>
  <a href="/dyleeseafood/admin/dashboard" class="ni"><i class="bi bi-speedometer2"></i>Dashboard</a>
  <div class="ngl">Hàng hoá</div>
  <a href="/dyleeseafood/admin/products"   class="ni on"><i class="bi bi-fish"></i>Sản phẩm</a>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/categories" class="ni"><i class="bi bi-grid"></i>Danh mục</a>
    <a href="/dyleeseafood/admin/suppliers"  class="ni"><i class="bi bi-truck"></i>Nhà cung cấp</a>
  </c:if>
  <div class="ngl">Bán hàng</div>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/orders"    class="ni"><i class="bi bi-bag-check"></i>Đơn hàng</a>
  </c:if>
  <a href="/dyleeseafood/admin/customers"  class="ni"><i class="bi bi-people"></i>Khách hàng</a>
  <div class="ngl">Hệ thống</div>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/staff" class="ni"><i class="bi bi-person-badge"></i>Nhân viên</a>
  </c:if>
  <hr/>
  <a href="/dyleeseafood/home"   class="ni"><i class="bi bi-house"></i>Về trang chủ</a>
  <a href="/dyleeseafood/logout" class="ni red"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a>
</div>

<!-- MAIN -->
<div class="main-content">
  <div class="d-flex align-items-center gap-3 mb-4">
    <a href="/dyleeseafood/admin/products" class="back-btn">
      <i class="bi bi-arrow-left"></i> Quay lại
    </a>
    <div>
      <h4 class="fw-bold mb-0" style="color:var(--tx);">
        <i class="bi bi-plus-circle me-2" style="color:var(--p);"></i>Thêm sản phẩm mới
      </h4>
      <small class="text-muted">Điền đầy đủ thông tin sản phẩm</small>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show mb-4">
      <i class="bi bi-exclamation-triangle me-2"></i>${error}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <form method="post" action="/dyleeseafood/admin/products/add" enctype="multipart/form-data">
    <div class="row g-4">

      <!-- CỘT TRÁI -->
      <div class="col-md-8">
        <div class="fcard">
          <div class="fcard-title"><i class="bi bi-info-circle" style="color:var(--p);"></i>Thông tin cơ bản</div>

          <div class="mb-3">
            <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
            <input type="text" name="name" class="form-control" placeholder="VD: Tôm Hùm Bông" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="description" class="form-control" rows="4" placeholder="Mô tả chi tiết..."></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Slug (URL) <small class="text-muted fw-normal text-lowercase">— tự động tạo nếu để trống</small></label>
            <div class="input-group">
              <span class="input-group-text text-muted">/products/</span>
              <input type="text" name="slug" class="form-control" placeholder="tom-hum-bong" id="slugInput">
            </div>
          </div>

          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Danh mục <span class="text-danger">*</span></label>
              <select name="categoryId" class="form-select" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categories}">
                  <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label">Nhà cung cấp</label>
              <select name="supplierId" class="form-select">
                <option value="">-- Không chọn --</option>
                <c:forEach var="s" items="${suppliers}">
                  <option value="${s.id}">${s.name}</option>
                </c:forEach>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Đơn vị</label>
              <select name="unit" class="form-select">
                <option value="kg">kg</option>
                <option value="con">con</option>
                <option value="hộp">hộp</option>
                <option value="túi">túi</option>
                <option value="gói">gói</option>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Giá bán (VNĐ) <span class="text-danger">*</span></label>
              <div class="input-group">
                <input type="number" name="price" class="form-control" placeholder="0" min="0" step="1000" required>
                <span class="input-group-text">đ</span>
              </div>
            </div>
            <div class="col-md-4">
              <label class="form-label">Tồn kho</label>
              <input type="number" name="stock" class="form-control" placeholder="0" min="0" step="0.5" value="0">
            </div>
          </div>
        </div>
      </div>

      <!-- CỘT PHẢI -->
      <div class="col-md-4">
        <div class="fcard mb-4">
          <div class="fcard-title"><i class="bi bi-image" style="color:var(--p);"></i>Hình ảnh sản phẩm</div>

          <img id="previewImg" src="" class="preview-img d-none mb-3" alt="">

          <div class="img-upload-box" onclick="document.getElementById('imageFile').click()">
            <i class="bi bi-cloud-arrow-up" style="font-size:2.2rem;color:var(--p);"></i>
            <p class="fw-bold mb-1 mt-2" style="color:var(--p);font-size:14px;">Click để chọn ảnh</p>
            <small class="text-muted">JPG, PNG, WEBP — Tối đa 10MB</small>
          </div>
          <input type="file" name="imageFile" id="imageFile" accept="image/*" class="d-none" onchange="previewImage(this)">

          <div class="mt-3">
            <label class="form-label">Hoặc nhập URL ảnh:</label>
            <input type="text" name="imageUrl" class="form-control form-control-sm"
                   placeholder="https://..." oninput="previewUrl(this.value)">
          </div>
        </div>

        <div class="fcard">
          <div class="fcard-title"><i class="bi bi-gear" style="color:var(--p);"></i>Cài đặt</div>

          <div class="mb-3">
            <label class="form-label">Sản phẩm nổi bật</label>
            <select name="featured" class="form-select">
              <option value="false">Không</option>
              <option value="true">⭐ Có — hiển thị trang chủ</option>
            </select>
          </div>

          <div class="mb-1">
            <label class="form-label">Trạng thái</label>
            <select name="active" class="form-select">
              <option value="true">✅ Đang bán</option>
              <option value="false">❌ Ngừng bán</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <div class="d-flex gap-3 mt-4 pb-4">
      <button type="submit" class="btn btn-primary px-5 py-2">
        <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm
      </button>
      <a href="/dyleeseafood/admin/products" class="btn btn-outline-secondary px-5 py-2">Hủy</a>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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
function previewUrl(url) {
  var img = document.getElementById('previewImg');
  if (url && url.trim()) {
    img.src = url;
    img.classList.remove('d-none');
    img.onerror = function() { img.classList.add('d-none'); };
  } else {
    img.classList.add('d-none');
  }
}
document.querySelector('input[name="name"]').addEventListener('input', function() {
  var slug = this.value.toLowerCase()
    .replace(/[àáạảãâầấậẩẫăằắặẳẵ]/g,'a')
    .replace(/[èéẹẻẽêềếệểễ]/g,'e')
    .replace(/[ìíịỉĩ]/g,'i')
    .replace(/[òóọỏõôồốộổỗơờớợởỡ]/g,'o')
    .replace(/[ùúụủũưừứựửữ]/g,'u')
    .replace(/[ỳýỵỷỹ]/g,'y')
    .replace(/đ/g,'d')
    .replace(/[^a-z0-9\s-]/g,'')
    .replace(/\s+/g,'-')
    .replace(/-+/g,'-').trim();
  document.getElementById('slugInput').value = slug;
});
</script>
</body>
</html>
