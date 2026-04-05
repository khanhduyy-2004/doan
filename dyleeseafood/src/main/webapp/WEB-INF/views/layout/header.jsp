<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dylee Seafood</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root { --primary: #0077b6; --secondary: #00b4d8; }
    body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; }
    .navbar { background: var(--primary) !important; }
    .navbar-brand { font-weight: 700; font-size: 1.4rem; }
    .nav-link { color: rgba(255,255,255,0.9) !important; }
    .nav-link:hover { color: white !important; }
    .btn-primary { background: var(--primary); border-color: var(--primary); }
    .btn-primary:hover { background: #005f8e; }
    .cart-badge { font-size: 0.7rem; }
    .category-sidebar .list-group-item.active { background: var(--primary); border-color: var(--primary); }
    .product-card { transition: transform 0.2s, box-shadow 0.2s; border: none; border-radius: 12px; overflow: hidden; }
    .product-card:hover { transform: translateY(-4px); box-shadow: 0 8px 25px rgba(0,0,0,0.12); }
    .product-card img { height: 200px; object-fit: cover; }
    .price { color: var(--primary); font-weight: 700; font-size: 1.1rem; }
    footer { background: #023e8a; color: white; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow">
  <div class="container">
    <a class="navbar-brand text-white" href="/dyleeseafood/home">
      🐟 Dylee Seafood
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
      <!-- Search -->
      <form class="d-flex mx-auto" action="/dyleeseafood/products" method="get" style="width:40%">
        <input class="form-control me-2" type="search" name="keyword"
               placeholder="Tìm sản phẩm..." value="${keyword}">
        <button class="btn btn-light" type="submit">
          <i class="bi bi-search"></i>
        </button>
      </form>

      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item">
          <a class="nav-link" href="/dyleeseafood/home">
            <i class="bi bi-house"></i> Trang chủ
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/dyleeseafood/products">
            <i class="bi bi-grid"></i> Sản phẩm
          </a>
        </li>
        <!-- Giỏ hàng -->
        <li class="nav-item">
          <a class="nav-link position-relative" href="/dyleeseafood/cart">
            <i class="bi bi-cart3 fs-5"></i>
            <c:if test="${not empty sessionScope.cart}">
              <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-badge">
                ${sessionScope.cart.size()}
              </span>
            </c:if>
          </a>
        </li>
        <!-- User -->
        <c:choose>
          <c:when test="${not empty sessionScope.loggedUser}">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle"></i>
                ${sessionScope.loggedCustomer.name}
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <c:if test="${sessionScope.loggedUser.roleId == 1 || sessionScope.loggedUser.roleId == 2}">
                  <li><a class="dropdown-item" href="/dyleeseafood/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> Quản trị
                  </a></li>
                  <li><hr class="dropdown-divider"></li>
                </c:if>
                <li><a class="dropdown-item" href="/dyleeseafood/logout">
                  <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a></li>
              </ul>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item">
              <a class="nav-link" href="/dyleeseafood/login">
                <i class="bi bi-person"></i> Đăng nhập
              </a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>