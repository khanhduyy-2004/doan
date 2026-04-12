<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<%-- Toast đăng ký thành công --%>
<c:if test="${param.registered == 'true'}">
  <div id="regToast"
       style="position:fixed;top:20px;right:20px;
              z-index:9999;width:300px;
              animation:slideDown 0.4s ease;">
    <div class="d-flex align-items-center gap-3"
         style="background:white;border-radius:14px;
                border:none;padding:14px 16px;
                box-shadow:0 8px 32px rgba(0,0,0,0.12);">
      <div style="width:40px;height:40px;
                  background:#d1fae5;border-radius:50%;
                  display:flex;align-items:center;
                  justify-content:center;flex-shrink:0;">
        <i class="bi bi-check-circle-fill"
           style="color:#16a34a;font-size:1.2rem;"></i>
      </div>
      <div style="flex:1;">
        <div class="fw-bold"
             style="font-size:14px;color:#065f46;">
          Đăng ký thành công!
        </div>
        <div style="font-size:12px;color:#6b7280;">
          Vui lòng đăng nhập để tiếp tục
        </div>
      </div>
      <button type="button"
              onclick="closeRegToast()"
              style="background:none;border:none;
                     cursor:pointer;color:#9ca3af;
                     font-size:20px;line-height:1;
                     padding:0;flex-shrink:0;">
        &times;
      </button>
    </div>
    <div style="height:3px;background:#d1fae5;
                border-radius:0 0 14px 14px;
                overflow:hidden;">
      <div id="regProgress"
           style="height:3px;background:#16a34a;
                  width:100%;
                  transition:width 4s linear;">
      </div>
    </div>
  </div>
  <style>
    @keyframes slideDown {
      from { transform:translateY(-20px);opacity:0; }
      to   { transform:translateY(0);opacity:1; }
    }
  </style>
  <script>
    setTimeout(function() {
      document.getElementById('regProgress')
        .style.width = '0%';
    }, 100);
    setTimeout(closeRegToast, 4200);
    function closeRegToast() {
      var t = document.getElementById('regToast');
      if (!t) return;
      t.style.transition = 'opacity 0.3s, transform 0.3s';
      t.style.opacity = '0';
      t.style.transform = 'translateY(-20px)';
      setTimeout(function(){ t.remove(); }, 300);
    }
  </script>
</c:if>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card border-0 shadow-sm p-4"
           style="border-radius:16px;">
        <div class="text-center mb-4">
          <h2 class="fw-bold">🔐 Đăng nhập</h2>
          <p class="text-muted">Chào mừng bạn trở lại!</p>
        </div>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">
            <i class="bi bi-exclamation-circle"></i>
            ${error}
          </div>
        </c:if>

        <form method="post" action="/dyleeseafood/login">
          <div class="mb-3">
            <label class="form-label fw-bold">
              Tên đăng nhập
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-person"></i>
              </span>
              <input type="text" name="username"
                     class="form-control"
                     placeholder="Nhập username..."
                     required>
            </div>
          </div>
          <div class="mb-4">
            <label class="form-label fw-bold">
              Mật khẩu
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-lock"></i>
              </span>
              <input type="password" name="password"
                     id="pwdInput"
                     class="form-control"
                     placeholder="Nhập mật khẩu..."
                     required>
              <button type="button"
                      class="input-group-text"
                      style="cursor:pointer;"
                      onclick="togglePwd()">
                <i class="bi bi-eye"
                   id="eyeIcon"></i>
              </button>
            </div>
          </div>
          <button type="submit"
                  class="btn btn-primary w-100 py-2 fw-bold">
            <i class="bi bi-box-arrow-in-right"></i>
            Đăng nhập
          </button>
        </form>

        <hr>

        <p class="text-center mb-0">
          Chưa có tài khoản?
          <a href="/dyleeseafood/register"
             class="text-primary fw-bold">
            Đăng ký ngay
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<script>
function togglePwd() {
  var input = document.getElementById('pwdInput');
  var icon  = document.getElementById('eyeIcon');
  if (input.type === 'password') {
    input.type = 'text';
    icon.className = 'bi bi-eye-slash';
  } else {
    input.type = 'password';
    icon.className = 'bi bi-eye';
  }
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
