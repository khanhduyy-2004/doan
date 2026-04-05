<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin - Dylee Seafood</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background: #f0f2f5; }
    .sidebar { background: #023e8a; min-height: 100vh; width: 240px; position: fixed; top:0; left:0; }
    .sidebar .nav-link { color: rgba(255,255,255,0.8); padding: 12px 20px; border-radius: 8px; margin: 2px 8px; }
    .sidebar .nav-link:hover, .sidebar .nav-link.active { background: rgba(255,255,255,0.15); color: white; }
    .sidebar .nav-link i { width: 20px; }
    .main-content { margin-left: 240px; padding: 24px; }
    .stat-card { border-radius: 12px; border: none; }
    .topbar { background: white; padding: 16px 24px; border-radius: 12px; margin-bottom: 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <h5 class="text-white fw-bold">🐟 Dylee Admin</h5>
    <small class="text-white-50">${sessionScope.loggedCustomer.name}</small>
  </div>
  <nav class="nav flex-column">
    <a href="/dyleeseafood/admin/dashboard"
       class="nav-link active">
      <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products"
       class="nav-link">
      <i class="bi bi-box-seam"></i> Sản phẩm
    </a>
    <a href="/dyleeseafood/home"
       class="nav-link">
      <i class="bi bi-shop"></i> Xem web
    </a>
    <hr class="border-secondary mx-3">
    <a href="/dyleeseafood/logout" class="nav-link text-danger">
      <i class="bi bi-box-arrow-right"></i> Đăng xuất
    </a>
  </nav>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
  <!-- Topbar -->
  <div class="topbar d-flex justify-content-between align-items-center">
    <h5 class="fw-bold mb-0">📊 Dashboard</h5>
    <span class="text-muted">Chào mừng, <strong>${sessionScope.loggedCustomer.name}</strong></span>
  </div>

  <!-- Stat Cards -->
  <div class="row g-4 mb-4">
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="background:linear-gradient(135deg,#0077b6,#00b4d8);">
        <div class="text-white">
          <i class="bi bi-box-seam fs-2"></i>
          <h3 class="fw-bold mt-2">${totalProducts}</h3>
          <p class="mb-0">Sản phẩm</p>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="background:linear-gradient(135deg,#2a9d8f,#57cc99);">
        <div class="text-white">
          <i class="bi bi-grid fs-2"></i>
          <h3 class="fw-bold mt-2">${totalCategories}</h3>
          <p class="mb-0">Danh mục</p>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="background:linear-gradient(135deg,#f77f00,#fcbf49);">
        <div class="text-white">
          <i class="bi bi-bag-check fs-2"></i>
          <h3 class="fw-bold mt-2">0</h3>
          <p class="mb-0">Đơn hàng</p>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card shadow-sm p-3"
           style="background:linear-gradient(135deg,#e63946,#ff6b6b);">
        <div class="text-white">
          <i class="bi bi-people fs-2"></i>
          <h3 class="fw-bold mt-2">0</h3>
          <p class="mb-0">Khách hàng</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="card border-0 shadow-sm p-4" style="border-radius:12px;">
    <h6 class="fw-bold mb-3">⚡ Thao tác nhanh</h6>
    <div class="d-flex gap-3">
      <a href="/dyleeseafood/admin/products/add"
         class="btn btn-primary">
        <i class="bi bi-plus-circle"></i> Thêm sản phẩm
      </a>
      <a href="/dyleeseafood/admin/products"
         class="btn btn-outline-primary">
        <i class="bi bi-list"></i> Xem sản phẩm
      </a>
      <a href="/dyleeseafood/home"
         class="btn btn-outline-secondary">
        <i class="bi bi-shop"></i> Xem web
      </a>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>