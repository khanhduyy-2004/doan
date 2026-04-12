<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${pageTitle} — Dylee Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background: #f0f2f5; }
    .sidebar {
      background: #023e8a; min-height: 100vh;
      width: 240px; position: fixed;
      top: 0; left: 0; z-index: 100;
    }
    .sidebar .nav-link {
      color: rgba(255,255,255,0.8);
      padding: 12px 20px; border-radius: 8px;
      margin: 2px 8px; transition: 0.2s;
      display: flex; align-items: center; gap: 8px;
    }
    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
      background: rgba(255,255,255,0.15);
      color: white;
    }
    .main-content { margin-left: 240px; padding: 24px; }
    .stat-card { border-radius: 12px; border: none; transition: transform 0.2s; }
    .stat-card:hover { transform: translateY(-2px); }
    .order-row:hover { background: #f8f9fa; cursor: pointer; }
    .table thead th {
      font-size: 12px; font-weight: 600;
      color: #6c757d; text-transform: uppercase;
      letter-spacing: 0.05em; background: #f8f9fa;
      padding: 12px 16px; border-bottom: 1px solid #dee2e6;
    }
    .table tbody td { padding: 14px 16px; vertical-align: middle; }
    .form-control, .form-select {
      border-radius: 9px; padding: 10px 14px;
      font-size: 14px; border: 1.5px solid #e0e7ef;
    }
    .form-control:focus, .form-select:focus {
      border-color: #0077b6;
      box-shadow: 0 0 0 3px rgba(0,119,182,0.1);
    }
    .form-label { font-size: 13px; font-weight: 600; color: #4a5568; margin-bottom: 5px; }
    .modal-content { border-radius: 16px; }
    .modal-header {
      background: #023e8a; color: white;
      border-radius: 16px 16px 0 0; padding: 16px 24px;
    }
    .modal-header .btn-close { filter: invert(1); }
    .card-box {
      background: white; border-radius: 12px;
      border: 1px solid #edf0f5;
      box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    }
    .badge-status {
      display: inline-flex; align-items: center;
      padding: 4px 10px; border-radius: 20px;
      font-size: 11px; font-weight: 600;
    }
    .bs-pending   { background: #fff8e6; color: #e65100; }
    .bs-confirmed { background: #e8f4fd; color: #0077b6; }
    .bs-shipping  { background: #f3e8ff; color: #7c3aed; }
    .bs-delivered { background: #f0fdf4; color: #16a34a; }
    .bs-cancelled { background: #fef2f2; color: #dc2626; }
  </style>
</head>
<body>

<!-- SIDEBAR — giống y chang dashboard.jsp gốc -->
<div class="sidebar py-3">
  <div class="text-center mb-4 px-3">
    <span style="font-size: 2rem;">🐟</span>
    <h5 class="text-white fw-bold mb-0 mt-1">Dylee Admin</h5>
    <small style="color: rgba(255,255,255,0.5);">
      ${sessionScope.loggedUser.roleId == 1
        ? 'Quản trị viên' : 'Nhân viên'}
    </small>
  </div>
  <nav class="nav flex-column px-2">
    <a href="/dyleeseafood/admin/dashboard"
       class="nav-link ${pageTitle == 'Dashboard' ? 'active' : ''}">
      <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="/dyleeseafood/admin/products"
       class="nav-link ${pageTitle == 'Sản phẩm' ? 'active' : ''}">
      <i class="bi bi-box-seam"></i> Sản phẩm
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/categories"
         class="nav-link ${pageTitle == 'Danh mục' ? 'active' : ''}">
        <i class="bi bi-grid"></i> Danh mục
      </a>
      <a href="/dyleeseafood/admin/orders"
         class="nav-link ${pageTitle == 'Đơn hàng' ? 'active' : ''}">
        <i class="bi bi-cart-check"></i> Đơn hàng
        <c:if test="${pendingOrders > 0}">
          <span class="badge bg-danger ms-1">${pendingOrders}</span>
        </c:if>
      </a>
    </c:if>
    <a href="/dyleeseafood/admin/customers"
       class="nav-link ${pageTitle == 'Khách hàng' ? 'active' : ''}">
      <i class="bi bi-people"></i> Khách hàng
    </a>
    <c:if test="${sessionScope.loggedUser.roleId == 1}">
      <a href="/dyleeseafood/admin/staff"
         class="nav-link ${pageTitle == 'Nhân viên' ? 'active' : ''}">
        <i class="bi bi-person-badge"></i> Nhân viên
      </a>
      <a href="/dyleeseafood/admin/suppliers"
         class="nav-link ${pageTitle == 'Nhà cung cấp' ? 'active' : ''}">
        <i class="bi bi-truck"></i> NCC &amp; Kho hàng
      </a>
    </c:if>
    <a href="/dyleeseafood/home" class="nav-link">
      <i class="bi bi-shop"></i> Xem web
    </a>
    <hr style="border-color: rgba(255,255,255,0.15);" class="mx-2">
    <a href="/dyleeseafood/logout" class="nav-link"
       style="color: rgba(255,100,100,0.9) !important;">
      <i class="bi bi-box-arrow-right"></i> Đăng xuất
    </a>
  </nav>
</div>

<!-- MAIN BẮT ĐẦU -->
<div class="main-content">