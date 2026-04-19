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
    /* ── NỀN TRANG ── */
    body { background: #eef2f7; }

    /* ── SIDEBAR ── */
    .sidebar {
      background: linear-gradient(180deg, #011f4b 0%, #023e8a 55%, #0353a4 100%);
      min-height: 100vh; width: 240px;
      position: fixed; top: 0; left: 0; z-index: 100;
      box-shadow: 4px 0 18px rgba(2,62,138,0.22);
    }

    /* Brand header trong sidebar */
    .sidebar .sidebar-brand {
      padding: 22px 16px 16px;
      border-bottom: 1px solid rgba(255,255,255,0.1);
      margin-bottom: 8px;
    }
    .sidebar .brand-icon {
      width: 42px; height: 42px; border-radius: 11px;
      background: rgba(255,193,7,0.18);
      display: flex; align-items: center; justify-content: center;
      font-size: 1.5rem; margin-bottom: 8px;
    }

    /* Nav links */
    .sidebar .nav-link {
      color: rgba(255,255,255,0.68);
      padding: 9px 14px;
      border-radius: 8px;
      margin: 1px 8px;
      transition: all 0.15s;
      display: flex; align-items: center; gap: 9px;
      font-size: 13px; font-weight: 500;
      border-left: 2.5px solid transparent;
    }
    .sidebar .nav-link i { width: 17px; text-align: center; font-size: .95rem; }
    .sidebar .nav-link:hover {
      background: rgba(255,255,255,0.1);
      color: white;
      border-left-color: rgba(255,255,255,0.3);
    }
    .sidebar .nav-link.active {
      background: rgba(255,255,255,0.16);
      color: white;
      font-weight: 600;
      border-left-color: #ffc107;
    }
    .sidebar .nav-section-label {
      font-size: 10px; font-weight: 700;
      color: rgba(255,255,255,0.3);
      text-transform: uppercase; letter-spacing: .08em;
      padding: 10px 22px 3px;
    }
    .sidebar hr { border-color: rgba(255,255,255,0.12); margin: 6px 16px; }

    /* ── MAIN CONTENT ── */
    .main-content { margin-left: 240px; }

    /* ── STAT CARDS ── */
    .stat-card {
      border-radius: 12px; border: none;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 2px 10px rgba(2,62,138,0.08);
    }
    .stat-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 20px rgba(2,62,138,0.14);
    }

    /* ── TABLE ── */
    .order-row:hover { background: #f0f5fa !important; cursor: pointer; }
    .table thead th {
      font-size: 11.5px; font-weight: 700;
      color: #5a6a7e; text-transform: uppercase;
      letter-spacing: .05em; background: #f5f8fc;
      padding: 12px 16px; border-bottom: 1px solid #e5eaf2;
      border-top: none;
    }
    .table tbody td { padding: 12px 16px; vertical-align: middle; font-size: 13px; }
    .table tbody tr { border-bottom: 1px solid #f1f5f9; }
    .table tbody tr:last-child { border: none; }

    /* ── FORM ── */
    .form-control, .form-select {
      border-radius: 9px; padding: 10px 14px;
      font-size: 13.5px; border: 1.5px solid #dde4ee;
      background: #fafdff;
    }
    .form-control:focus, .form-select:focus {
      border-color: #0077b6;
      box-shadow: 0 0 0 3px rgba(0,119,182,0.1);
      background: white;
    }
    .form-label {
      font-size: 12px; font-weight: 700; color: #4a5568;
      margin-bottom: 5px; text-transform: uppercase; letter-spacing: .04em;
    }

    /* ── MODAL ── */
    .modal-content { border-radius: 14px; border: none; box-shadow: 0 16px 48px rgba(0,0,0,0.18); }
    .modal-header {
      background: linear-gradient(135deg, #011f4b, #0077b6);
      color: white; border-radius: 14px 14px 0 0; padding: 15px 22px;
    }
    .modal-header .btn-close { filter: invert(1); opacity: .7; }
    .modal-footer { border-top: 1px solid #f1f5f9; padding: 12px 20px; }

    /* ── CARD-BOX (dùng ở nhiều trang) ── */
    .card-box {
      background: white; border-radius: 12px;
      border: 1px solid #e5eaf2;
      box-shadow: 0 1px 6px rgba(2,62,138,0.06);
    }

    /* ── STATUS BADGES ── */
    .badge-status {
      display: inline-flex; align-items: center;
      padding: 4px 10px; border-radius: 20px;
      font-size: 11px; font-weight: 700; white-space: nowrap;
    }
    .bs-pending   { background: #fff8e6; color: #b45309; }
    .bs-confirmed { background: #e3f2fd; color: #0369a1; }
    .bs-shipping  { background: #f3e8ff; color: #7c3aed; }
    .bs-delivered { background: #f0fdf4; color: #16a34a; }
    .bs-cancelled { background: #fef2f2; color: #dc2626; }

    /* ── BOOTSTRAP OVERRIDES ── */
    .btn-primary               { background: #0077b6; border-color: #0077b6; border-radius: 8px; }
    .btn-primary:hover         { background: #005f92; border-color: #005f92; }
    .btn-outline-primary       { color: #0077b6; border-color: #0077b6; border-radius: 8px; }
    .btn-outline-primary:hover { background: #0077b6; border-color: #0077b6; }
    .btn-outline-success       { border-radius: 8px; }
    .btn-outline-warning       { border-radius: 8px; }
    .btn-outline-info          { border-radius: 8px; }
    .btn-outline-secondary     { border-radius: 8px; }
    .btn-outline-danger        { border-radius: 8px; }
    .badge.bg-warning { color: #333 !important; }

    /* Quick action buttons */
    .btn.py-3 {
      border-radius: 10px !important;
      font-size: 13px !important;
      font-weight: 600 !important;
      transition: transform .15s, box-shadow .15s !important;
    }
    .btn.py-3:hover {
      transform: translateY(-2px) !important;
      box-shadow: 0 4px 14px rgba(0,0,0,0.12) !important;
    }

    /* Cards dạng shadow */
    .card.border-0.shadow-sm { border-radius: 12px !important; border: 1px solid #e8edf5 !important; }
    .card-header.bg-white { border-bottom: 1px solid #f1f5f9 !important; padding: 14px 20px !important; }
  </style>
</head>
<body>

<!-- SIDEBAR — giữ nguyên HTML gốc, chỉ thêm class sidebar-brand -->
<div class="sidebar py-0">
  <div class="sidebar-brand text-center">
    <div class="brand-icon mx-auto">🐟</div>
    <h5 class="text-white fw-bold mb-0" style="font-size:15px;letter-spacing:-.3px;">
      Dylee<span style="color:#ffc107;">Admin</span>
    </h5>
    <small style="color:rgba(255,255,255,0.45);font-size:11px;">
      ${sessionScope.loggedUser.roleId == 1 ? 'Quản trị viên' : 'Nhân viên'}
    </small>
  </div>

  <nav class="nav flex-column px-1 mt-1">

    <div class="nav-section-label">Tổng quan</div>
    <a href="/dyleeseafood/admin/dashboard"
       class="nav-link ${pageTitle == 'Dashboard' ? 'active' : ''}">
      <i class="bi bi-speedometer2"></i> Dashboard
    </a>

    <div class="nav-section-label">Hàng hoá</div>
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

    <hr style="border-color: rgba(255,255,255,0.12);" class="mx-2">
    <a href="/dyleeseafood/home" class="nav-link">
      <i class="bi bi-shop"></i> Xem web
    </a>
    <a href="/dyleeseafood/logout" class="nav-link"
       style="color: rgba(255,120,120,0.9) !important;">
      <i class="bi bi-box-arrow-right"></i> Đăng xuất
    </a>
  </nav>
</div>

<!-- MAIN BẮT ĐẦU -->
<div class="main-content">
