<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
  .strength-bar {
    height:5px; border-radius:3px;
    background:#e8edf5; overflow:hidden;
    margin-top:6px;
  }
  .strength-fill {
    height:100%; border-radius:3px;
    transition:width 0.3s, background 0.3s;
    width:0%;
  }
  .rule-item {
    display:flex; align-items:center;
    gap:6px; font-size:12px;
    color:#8a9ab0; margin-bottom:3px;
    transition:color 0.2s;
  }
  .rule-item.pass { color:#16a34a; }
  .rule-item.fail { color:#8a9ab0; }
</style>

<div class="container mt-5 mb-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card border-0 shadow-sm p-4"
           style="border-radius:16px;">

        <div class="text-center mb-4">
          <h2 class="fw-bold">📝 Đăng ký tài khoản</h2>
          <p class="text-muted">
            Tạo tài khoản để mua sắm dễ dàng hơn!
          </p>
        </div>

        <c:if test="${not empty error}">
          <div class="alert alert-danger
                      d-flex align-items-center gap-2">
            <i class="bi bi-exclamation-circle-fill"></i>
            ${error}
          </div>
        </c:if>

        <form method="post"
              action="/dyleeseafood/register"
              onsubmit="return validateForm()">
          <div class="row g-3">

            <!-- Họ tên -->
            <div class="col-12">
              <label class="form-label fw-bold">
                Họ và tên
                <span class="text-danger">*</span>
              </label>
              <input type="text" name="name"
                     class="form-control"
                     placeholder="Nhập họ và tên..."
                     required>
            </div>

            <!-- Tên đăng nhập -->
            <div class="col-12">
              <label class="form-label fw-bold">
                Tên đăng nhập
                <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-person"></i>
                </span>
                <input type="text" name="username"
                       id="usernameInput"
                       class="form-control"
                       placeholder="Nhập username..."
                       oninput="checkUsername(this.value)"
                       required>
              </div>
              <small id="usernameHint"
                     class="text-muted">
                Chỉ dùng chữ, số và dấu gạch dưới
              </small>
            </div>

            <!-- Email + SĐT -->
            <div class="col-md-6">
              <label class="form-label fw-bold">
                Email
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-envelope"></i>
                </span>
                <input type="email" name="email"
                       class="form-control"
                       placeholder="email@gmail.com">
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold">
                Số điện thoại
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-phone"></i>
                </span>
                <input type="text" name="phone"
                       class="form-control"
                       placeholder="0912 345 678">
              </div>
            </div>

            <!-- Mật khẩu -->
            <div class="col-12">
              <label class="form-label fw-bold">
                Mật khẩu
                <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-lock"></i>
                </span>
                <input type="password" name="password"
                       id="pwdInput"
                       class="form-control"
                       placeholder="Tối thiểu 6 ký tự..."
                       oninput="checkStrength(this.value);
                                checkConfirm()"
                       required>
                <button type="button"
                        class="input-group-text"
                        style="cursor:pointer;"
                        onclick="toggleField(
                          'pwdInput','eye1')">
                  <i class="bi bi-eye" id="eye1"></i>
                </button>
              </div>

              <!-- Thanh độ mạnh -->
              <div class="strength-bar">
                <div id="strengthFill"
                     class="strength-fill"></div>
              </div>
              <div class="d-flex justify-content-between
                          mt-1">
                <small id="strengthText"
                       class="text-muted"></small>
              </div>

              <!-- Rules -->
              <div class="mt-2">
                <div class="rule-item" id="rule-len">
                  <i class="bi bi-circle"
                     style="font-size:10px;"></i>
                  Ít nhất 6 ký tự
                </div>
                <div class="rule-item" id="rule-upper">
                  <i class="bi bi-circle"
                     style="font-size:10px;"></i>
                  Có chữ hoa (A-Z) — khuyến khích
                </div>
                <div class="rule-item" id="rule-num">
                  <i class="bi bi-circle"
                     style="font-size:10px;"></i>
                  Có số (0-9) — khuyến khích
                </div>
              </div>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="col-12">
              <label class="form-label fw-bold">
                Xác nhận mật khẩu
                <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="bi bi-lock-fill"></i>
                </span>
                <input type="password"
                       id="confirmInput"
                       name="confirmPassword"
                       class="form-control"
                       placeholder="Nhập lại mật khẩu..."
                       oninput="checkConfirm()"
                       required>
                <button type="button"
                        class="input-group-text"
                        style="cursor:pointer;"
                        onclick="toggleField(
                          'confirmInput','eye2')">
                  <i class="bi bi-eye" id="eye2"></i>
                </button>
              </div>
              <small id="matchText"
                     class="d-block mt-1"></small>
            </div>

          </div>

          <!-- Nút đăng ký -->
          <button type="submit"
                  class="btn btn-primary
                         w-100 py-2 fw-bold mt-4"
                  style="border-radius:10px;">
            <i class="bi bi-person-plus me-2"></i>
            Đăng ký
          </button>
        </form>

        <hr>
        <p class="text-center mb-0">
          Đã có tài khoản?
          <a href="/dyleeseafood/login"
             class="text-primary fw-bold">
            Đăng nhập
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<script>
// Show/hide password
function toggleField(inputId, iconId) {
  var i = document.getElementById(inputId);
  var e = document.getElementById(iconId);
  if (i.type === 'password') {
    i.type = 'text';
    e.className = 'bi bi-eye-slash';
  } else {
    i.type = 'password';
    e.className = 'bi bi-eye';
  }
}

// Kiểm tra username
function checkUsername(val) {
  var hint = document.getElementById('usernameHint');
  var ok = /^[a-zA-Z0-9_]+$/.test(val);
  if (val.length === 0) {
    hint.textContent = 'Chỉ dùng chữ, số và dấu gạch dưới';
    hint.style.color = '#8a9ab0';
  } else if (!ok) {
    hint.innerHTML =
      '<i class="bi bi-x-circle-fill me-1"' +
      ' style="color:#dc3545;"></i>' +
      '<span style="color:#dc3545;">Không dùng ký tự đặc biệt hoặc khoảng trắng</span>';
  } else if (val.length < 4) {
    hint.innerHTML =
      '<i class="bi bi-exclamation-circle me-1"' +
      ' style="color:#e65100;"></i>' +
      '<span style="color:#e65100;">Nên dùng ít nhất 4 ký tự</span>';
  } else {
    hint.innerHTML =
      '<i class="bi bi-check-circle-fill me-1"' +
      ' style="color:#16a34a;"></i>' +
      '<span style="color:#16a34a;">Tên đăng nhập hợp lệ</span>';
  }
}

// Kiểm tra độ mạnh mật khẩu
function checkStrength(val) {
  var fill  = document.getElementById('strengthFill');
  var text  = document.getElementById('strengthText');
  var rLen  = document.getElementById('rule-len');
  var rUp   = document.getElementById('rule-upper');
  var rNum  = document.getElementById('rule-num');

  if (val.length === 0) {
    fill.style.width = '0%';
    text.textContent = '';
    setRule(rLen,  false);
    setRule(rUp,   false);
    setRule(rNum,  false);
    return;
  }

  var score = 0;
  var hasLen   = val.length >= 6;
  var hasUpper = /[A-Z]/.test(val);
  var hasNum   = /[0-9]/.test(val);
  var hasSpec  = /[^a-zA-Z0-9]/.test(val);
  var hasLong  = val.length >= 10;

  if (hasLen)   score++;
  if (hasUpper) score++;
  if (hasNum)   score++;
  if (hasSpec)  score++;
  if (hasLong)  score++;

  setRule(rLen,   hasLen);
  setRule(rUp,    hasUpper);
  setRule(rNum,   hasNum);

  var colors = ['#dc3545','#fd7e14',
                '#ffc107','#20c997','#198754'];
  var labels = ['Rất yếu','Yếu',
                'Trung bình','Mạnh','Rất mạnh'];
  var idx = Math.min(score - 1, 4);
  if (idx < 0) idx = 0;

  fill.style.width    = ((score / 5) * 100) + '%';
  fill.style.background = colors[idx];
  text.textContent    = labels[idx];
  text.style.color    = colors[idx];
}

function setRule(el, pass) {
  if (pass) {
    el.className = 'rule-item pass';
    el.querySelector('i').className =
      'bi bi-check-circle-fill';
    el.querySelector('i').style.fontSize = '10px';
    el.querySelector('i').style.color = '#16a34a';
  } else {
    el.className = 'rule-item fail';
    el.querySelector('i').className = 'bi bi-circle';
    el.querySelector('i').style.fontSize = '10px';
    el.querySelector('i').style.color = '#8a9ab0';
  }
}

// Kiểm tra mật khẩu khớp
function checkConfirm() {
  var pwd  = document.getElementById(
    'pwdInput').value;
  var conf = document.getElementById(
    'confirmInput').value;
  var mt   = document.getElementById('matchText');

  if (conf.length === 0) {
    mt.innerHTML = '';
    return;
  }
  if (pwd === conf) {
    mt.innerHTML =
      '<i class="bi bi-check-circle-fill me-1"' +
      ' style="color:#16a34a;font-size:12px;"></i>' +
      '<span style="color:#16a34a;font-size:12px;">' +
      'Mật khẩu khớp</span>';
  } else {
    mt.innerHTML =
      '<i class="bi bi-x-circle-fill me-1"' +
      ' style="color:#dc3545;font-size:12px;"></i>' +
      '<span style="color:#dc3545;font-size:12px;">' +
      'Mật khẩu chưa khớp</span>';
  }
}

// Validate trước submit
function validateForm() {
  var pwd  = document.getElementById('pwdInput').value;
  var conf = document.getElementById('confirmInput').value;
  var user = document.getElementById('usernameInput').value;

  if (!/^[a-zA-Z0-9_]+$/.test(user)) {
    alert('Tên đăng nhập chỉ được dùng chữ, số và dấu gạch dưới!');
    return false;
  }
  if (pwd.length < 6) {
    alert('Mật khẩu phải có ít nhất 6 ký tự!');
    return false;
  }
  if (pwd !== conf) {
    alert('Mật khẩu xác nhận không khớp!');
    return false;
  }
  return true;
}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
