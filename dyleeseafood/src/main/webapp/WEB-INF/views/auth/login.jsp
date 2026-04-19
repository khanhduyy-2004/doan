<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<%-- Toast đăng ký thành công --%>
<c:if test="${param.registered == 'true'}">
  <div id="regToast" style="position:fixed;top:20px;right:20px;z-index:9999;width:300px;animation:slideDown 0.4s ease;">
    <div class="d-flex align-items-center gap-3" style="background:white;border-radius:14px;padding:14px 16px;box-shadow:0 8px 32px rgba(0,0,0,0.12);">
      <div style="width:40px;height:40px;background:#d1fae5;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
        <i class="bi bi-check-circle-fill" style="color:#16a34a;font-size:1.2rem;"></i>
      </div>
      <div style="flex:1;">
        <div class="fw-bold" style="font-size:14px;color:#065f46;">Đăng ký thành công!</div>
        <div style="font-size:12px;color:#6b7280;">Vui lòng đăng nhập để tiếp tục</div>
      </div>
      <button type="button" onclick="closeRegToast()" style="background:none;border:none;cursor:pointer;color:#9ca3af;font-size:20px;line-height:1;padding:0;flex-shrink:0;">&times;</button>
    </div>
    <div style="height:3px;background:#d1fae5;border-radius:0 0 14px 14px;overflow:hidden;">
      <div id="regProgress" style="height:3px;background:#16a34a;width:100%;transition:width 4s linear;"></div>
    </div>
  </div>
  <style>@keyframes slideDown { from{transform:translateY(-20px);opacity:0} to{transform:translateY(0);opacity:1} }</style>
  <script>
    setTimeout(function(){ document.getElementById('regProgress').style.width='0%'; },100);
    setTimeout(closeRegToast,4200);
    function closeRegToast(){var t=document.getElementById('regToast');if(!t)return;t.style.transition='opacity 0.3s,transform 0.3s';t.style.opacity='0';t.style.transform='translateY(-20px)';setTimeout(function(){t.remove();},300);}
  </script>
</c:if>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card border-0 shadow-sm p-4" style="border-radius:16px;">
        <div class="text-center mb-4">
          <h2 class="fw-bold">🔐 Đăng nhập</h2>
          <p class="text-muted">Chào mừng bạn trở lại!</p>
        </div>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">
            <i class="bi bi-exclamation-circle"></i> ${error}
          </div>
        </c:if>

        <form method="post" action="/dyleeseafood/login">
          <div class="mb-3">
            <label class="form-label fw-bold">Tên đăng nhập</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-person"></i></span>
              <input type="text" name="username" class="form-control" placeholder="Nhập username..." required>
            </div>
          </div>
          <div class="mb-2">
            <label class="form-label fw-bold">Mật khẩu</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-lock"></i></span>
              <input type="password" name="password" id="pwdInput" class="form-control" placeholder="Nhập mật khẩu..." required>
              <button type="button" class="input-group-text" style="cursor:pointer;" onclick="togglePwd()">
                <i class="bi bi-eye" id="eyeIcon"></i>
              </button>
            </div>
          </div>

          <!-- QUÊN MẬT KHẨU -->
          <div class="text-end mb-4">
            <a href="#forgotModal" data-bs-toggle="modal" style="font-size:13px;color:#8a9ab0;text-decoration:none;">
              <i class="bi bi-question-circle me-1"></i>Quên mật khẩu?
            </a>
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

<!-- MODAL QUÊN MẬT KHẨU -->
<div class="modal fade" id="forgotModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius:16px;border:none;">
      <div class="modal-body p-4 text-center">
        <div style="width:64px;height:64px;background:#fff8e6;border-radius:50%;margin:0 auto 16px;display:flex;align-items:center;justify-content:center;">
          <i class="bi bi-key-fill" style="font-size:1.8rem;color:#e65100;"></i>
        </div>
        <h5 class="fw-bold mb-1">Quên mật khẩu?</h5>
        <p class="text-muted mb-4" style="font-size:14px;">
          Hệ thống không hỗ trợ tự reset mật khẩu.<br>Vui lòng liên hệ quản trị viên để được hỗ trợ.
        </p>

        <div style="background:#f7f9fc;border-radius:12px;padding:18px;border:1px solid #e8edf5;text-align:left;">
          <div style="font-size:12px;font-weight:600;color:#8a9ab0;text-transform:uppercase;letter-spacing:0.05em;margin-bottom:10px;">Liên hệ admin</div>
          <div class="d-flex align-items-center gap-2 mb-2" style="font-size:14px;">
            <i class="bi bi-telephone-fill text-primary"></i>
            <span><strong>0123 456 789</strong></span>
          </div>
          <div class="d-flex align-items-center gap-2 mb-2" style="font-size:14px;">
            <i class="bi bi-envelope-fill text-primary"></i>
            <span>admin@dyleeseafood.vn</span>
          </div>
          <div class="d-flex align-items-center gap-2" style="font-size:14px;">
            <i class="bi bi-clock-fill text-primary"></i>
            <span>Cả ngày</span>
          </div>
        </div>

        <div class="mt-3 p-3 text-start" style="background:#e8f4fd;border-radius:10px;font-size:13px;color:#1a2035;">
          <div class="fw-bold mb-2"><i class="bi bi-info-circle text-primary me-1"></i>Quy trình reset:</div>
          <div class="d-flex gap-2 mb-1"><span style="color:#0077b6;font-weight:700;min-width:18px;">1.</span>Liên hệ admin qua SĐT hoặc email</div>
          <div class="d-flex gap-2 mb-1"><span style="color:#0077b6;font-weight:700;min-width:18px;">2.</span>Admin xác minh danh tính và reset mật khẩu</div>
          <div class="d-flex gap-2 mb-1"><span style="color:#0077b6;font-weight:700;min-width:18px;">3.</span>Đăng nhập bằng mật khẩu mặc định <code style="background:#fff;padding:1px 6px;border-radius:4px;">123456</code></div>
          <div class="d-flex gap-2"><span style="color:#0077b6;font-weight:700;min-width:18px;">4.</span>Vào <strong>Tài khoản</strong> → đổi mật khẩu mới ngay</div>
        </div>

        <button type="button" class="btn btn-primary w-100 mt-3 py-2" style="border-radius:10px;" data-bs-dismiss="modal">Đã hiểu</button>
      </div>
    </div>
  </div>
</div>

<script>
function togglePwd(){
  var i=document.getElementById('pwdInput');
  var e=document.getElementById('eyeIcon');
  if(i.type==='password'){i.type='text';e.className='bi bi-eye-slash';}
  else{i.type='password';e.className='bi bi-eye';}
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
