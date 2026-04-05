<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Quản lý sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background: #f0f2f5; }
    .sidebar { background: #023e8a; min-height: 100vh; width: 240px; position: fixed; top:0; left:0; }
    .sidebar .nav-link { color: rgba(255,255,255,0.8); padding: 12px 20px; border-radius: 8px; margin: 2px 8px; }
    .sidebar .nav-link:hover, .sidebar .nav-link.active { background: rgba(255,255,255,0.15); color: white; }
    .main-content { margin-left: 240px; padding: 24px; }
    .topbar { background: white; padding: 16px 24px; border-radius: 12px; margin-bottom: 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
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
  <div class="topbar d-flex justify-content-between align-items-center">
    <h5 class="fw-bold mb-0">📦 Quản lý sản phẩm</h5>
    <a href="/dyleeseafood/admin/products/add" class="btn btn-primary">
      <i class="bi bi-plus-circle"></i> Thêm sản phẩm
    </a>
  </div>

  <div class="card border-0 shadow-sm" style="border-radius:12px; overflow:hidden;">
    <table class="table table-hover mb-0">
      <thead style="background:#0077b6; color:white;">
        <tr>
          <th class="ps-3">#</th>
          <th>Tên sản phẩm</th>
          <th>Danh mục</th>
          <th>Giá</th>
          <th>Tồn kho</th>
          <th>Nổi bật</th>
          <th>Thao tác</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="p" items="${products}" varStatus="s">
          <tr>
            <td class="ps-3">${s.index + 1}</td>
            <td class="fw-bold">${p.name}</td>
            <td><span class="badge bg-info text-dark">${p.categoryName}</span></td>
            <td style="color:#0077b6; font-weight:bold;">
              <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
            </td>
            <td>${p.stock} ${p.unit}</td>
            <td>
              <c:choose>
                <c:when test="${p.featured}">
                  <span class="badge bg-warning text-dark">⭐ Có</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-secondary">Không</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <a href="/dyleeseafood/admin/products/edit/${p.id}"
                 class="btn btn-sm btn-warning">
                <i class="bi bi-pencil"></i>
              </a>
              <a href="/dyleeseafood/admin/products/delete/${p.id}"
                 class="btn btn-sm btn-danger ms-1"
                 onclick="return confirm('Xóa sản phẩm này?')">
                <i class="bi bi-trash"></i>
              </a>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty products}">
          <tr><td colspan="7" class="text-center py-4 text-muted">
            Chưa có sản phẩm nào!
          </td></tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>