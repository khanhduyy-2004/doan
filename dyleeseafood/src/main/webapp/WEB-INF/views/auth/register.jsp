<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header.jsp" %>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card border-0 shadow-sm p-4"
           style="border-radius:16px;">
        <div class="text-center mb-4">
          <h2 class="fw-bold">📝 Đăng ký tài khoản</h2>
          <p class="text-muted">Tạo tài khoản để mua sắm dễ dàng hơn!</p>
        </div>
        <c:if test="${not empty error}">
          <div class="alert alert-danger">
            <i class="bi bi-exclamation-circle"></i> ${error}
          </div>
        </c:if>
        <form method="post" action="/dyleeseafood/register">
          <div class="row g-3">
            <div class="col-12">
              <label class="form-label fw-bold">Họ và tên *</label>
              <input type="text" name="name" class="form-control"
                     placeholder="Nhập họ và tên..." required>
            </div>
            <div class="col-12">
              <label class="form-label fw-bold">Tên đăng nhập *</label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-person"></i>
                </span>
                <input type="text" name="username" class="form-control"
                       placeholder="Nhập username..." required>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold">Email</label>
              <input type="email" name="email" class="form-control"
                     placeholder="email@gmail.com">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold">Số điện thoại</label>
              <input type="text" name="phone" class="form-control"
                     placeholder="0912345678">
            </div>
            <div class="col-12">
              <label class="form-label fw-bold">Mật khẩu *</label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-lock"></i>
                </span>
                <input type="password" name="password" class="form-control"
                       placeholder="Tối thiểu 6 ký tự..." required>
              </div>
            </div>
          </div>
          <button type="submit"
                  class="btn btn-primary w-100 py-2 fw-bold mt-4">
            <i class="bi bi-person-plus"></i> Đăng ký
          </button>
        </form>
        <hr>
        <p class="text-center mb-0">
          Đã có tài khoản?
          <a href="/dyleeseafood/login" class="text-primary fw-bold">
            Đăng nhập
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<%@ include file="../layout/footer.jsp" %>