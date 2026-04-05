<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập - Dylee Seafood</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body { background: linear-gradient(135deg,#0077b6,#00b4d8); min-height: 100vh; display:flex; align-items:center; }
    .card { border-radius: 16px; border: none; }
    .btn-primary { background: #0077b6; border-color: #0077b6; }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="text-center mb-4">
        <h2 class="text-white fw-bold">🐟 Dylee Seafood</h2>
      </div>
      <div class="card shadow-lg p-4">
        <h4 class="fw-bold mb-4 text-center">Đăng nhập</h4>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">${success}</div>
        </c:if>

        <form method="post" action="/dyleeseafood/login">
          <div class="mb-3">
            <label class="form-label fw-bold">Tên đăng nhập</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-person"></i></span>
              <input type="text" name="username" class="form-control"
                     placeholder="Nhập tên đăng nhập..." required>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">Mật khẩu</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-lock"></i></span>
              <input type="password" name="password" class="form-control"
                     placeholder="Nhập mật khẩu..." required>
            </div>
          </div>
          <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">
            <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
          </button>
        </form>

        <hr>
        <p class="text-center mb-0">
          Chưa có tài khoản?
          <a href="/dyleeseafood/register" class="text-primary fw-bold">Đăng ký ngay</a>
        </p>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>