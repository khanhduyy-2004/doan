<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
:root{--p:#0077b6;--dk:#023e8a;}
.profile-hero{background:linear-gradient(135deg,var(--dk),var(--p));padding:36px 0 64px;}
.profile-wrap{max-width:860px;margin:0 auto;padding:0 16px;}
.profile-card{background:white;border-radius:20px;box-shadow:0 4px 24px rgba(0,0,0,.1);margin-top:-48px;overflow:hidden;}

/* AVATAR */
.avatar-wrap{position:relative;display:inline-block;cursor:pointer;}
.avatar-img{width:88px;height:88px;border-radius:50%;object-fit:cover;
  border:3px solid rgba(255,255,255,.5);}
.avatar-letter{width:88px;height:88px;border-radius:50%;
  background:rgba(255,255,255,.2);display:flex;align-items:center;
  justify-content:center;font-size:2.2rem;font-weight:800;color:white;
  border:3px solid rgba(255,255,255,.4);}


/* TABS */
.tab-nav{display:flex;border-bottom:2px solid #f0f2f5;background:white;overflow-x:auto;}
.tab-nav::-webkit-scrollbar{height:0;}
.tab-btn{padding:14px 20px;border:none;background:transparent;font-size:13.5px;
  font-weight:500;color:#8a9ab0;border-bottom:2.5px solid transparent;
  margin-bottom:-2px;cursor:pointer;white-space:nowrap;transition:.15s;display:flex;
  align-items:center;gap:7px;}
.tab-btn.active{color:var(--p);border-bottom-color:var(--p);font-weight:700;}
.tab-btn:hover{color:var(--p);background:#f7f9fc;}
.tab-panel{display:none;padding:28px;}
.tab-panel.active{display:block;}

/* FORM */
.form-label{font-size:13px;font-weight:600;color:#4a5568;}
.form-control{border:1.5px solid #e8edf5;border-radius:10px;font-size:14px;
  padding:10px 14px;transition:border-color .15s;}
.form-control:focus{border-color:var(--p);box-shadow:0 0 0 3px rgba(0,119,182,.1);}
.form-control[readonly]{background:#f7f9fc;color:#8a9ab0;}
.section-label{font-size:11px;font-weight:700;color:#8a9ab0;
  text-transform:uppercase;letter-spacing:.06em;margin-bottom:12px;}

/* PASSWORD */
.strength-bar{height:5px;border-radius:3px;background:#e8edf5;overflow:hidden;margin-top:6px;}
.strength-fill{height:100%;border-radius:3px;transition:width .3s,background .3s;width:0%;}
.rule-item{display:flex;align-items:center;gap:6px;font-size:12px;color:#8a9ab0;margin-bottom:3px;}
.rule-item.pass{color:#16a34a;}

/* ADDRESS CARDS */
.addr-card{border:1.5px solid #e8edf5;border-radius:14px;padding:16px;
  margin-bottom:12px;transition:border-color .15s;background:white;}
.addr-card.is-default{border-color:var(--p);background:#f0f8ff;}
.addr-actions{display:flex;gap:8px;flex-wrap:wrap;margin-top:10px;}
.addr-btn{border:1.5px solid #e8edf5;border-radius:8px;padding:4px 12px;
  font-size:12px;font-weight:600;cursor:pointer;background:white;
  color:#475569;transition:.15s;text-decoration:none;display:inline-block;}
.addr-btn:hover{border-color:var(--p);color:var(--p);}
.addr-btn.danger:hover{border-color:#dc2626;color:#dc2626;}
.addr-btn.primary{background:var(--p);border-color:var(--p);color:white;}
.addr-btn.primary:hover{background:var(--dk);}

/* TIER BADGE */
.tier-badge{display:inline-flex;align-items:center;gap:6px;padding:5px 14px;
  border-radius:20px;font-size:13px;font-weight:600;}

/* COLLAPSE */
.addr-form-wrap{display:none;margin-top:14px;padding:16px;
  background:#f7f9fc;border-radius:12px;border:1px solid #e8edf5;}
.addr-form-wrap.show{display:block;}

/* TOAST */
.toast-float{position:fixed;bottom:24px;right:24px;padding:14px 20px;
  border-radius:12px;font-size:13px;font-weight:600;display:flex;
  align-items:center;gap:10px;min-width:260px;z-index:9999;
  box-shadow:0 8px 24px rgba(0,0,0,.12);animation:slideIn .3s ease;}
.toast-success{background:#f0fdf4;color:#16a34a;border:1px solid #bbf7d0;}
.toast-error{background:#fef2f2;color:#dc2626;border:1px solid #fecaca;}
@keyframes slideIn{from{transform:translateX(120%);opacity:0}to{transform:translateX(0);opacity:1}}
</style>

<!-- HERO -->
<div class="profile-hero">
  <div class="profile-wrap">
    <div class="d-flex align-items-center gap-4">
      <!-- Avatar chữ cái -->
      <div class="avatar-letter">${customer.name.substring(0,1)}</div>
      <div>
        <h4 class="text-white fw-bold mb-1">${customer.name}</h4>
        <div style="color:rgba(255,255,255,.75);font-size:14px;">
          <i class="bi bi-at me-1"></i>${user.username}
        </div>
        <div class="mt-2 d-flex align-items-center gap-2 flex-wrap">
          <c:choose>
            <c:when test="${customer.tierId==3}">
              <span class="tier-badge" style="background:rgba(255,255,255,.2);color:white;">
                👑 VVIP — Giảm 10%
              </span>
            </c:when>
            <c:when test="${customer.tierId==2}">
              <span class="tier-badge" style="background:rgba(255,255,255,.2);color:white;">
                ⭐ VIP — Giảm 5%
              </span>
            </c:when>
            <c:otherwise>
              <span class="tier-badge" style="background:rgba(255,255,255,.15);color:rgba(255,255,255,.85);">
                🐟 Thành viên thường
              </span>
            </c:otherwise>
          </c:choose>
          <c:if test="${customer.totalSpent > 0}">
            <span style="color:rgba(255,255,255,.7);font-size:13px;">
              <i class="bi bi-wallet2 me-1"></i>
              <fmt:formatNumber value="${customer.totalSpent}" pattern="#,###"/>đ đã mua
            </span>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- CARD -->
<div class="profile-wrap mb-5">
  <div class="profile-card">

    <!-- TABS -->
    <div class="tab-nav">
      <button class="tab-btn ${(empty activeTab || activeTab=='info') && empty addrSuccess && empty addrError ? 'active' : ''}"
              onclick="switchTab('info',this)">
        <i class="bi bi-person"></i>Thông tin
      </button>
      <button class="tab-btn ${activeTab=='password' || not empty pwdError || not empty pwdSuccess ? 'active' : ''}"
              onclick="switchTab('password',this)">
        <i class="bi bi-lock"></i>Mật khẩu
      </button>
      <c:if test="${user.roleId==3}">
        <button class="tab-btn ${not empty addrSuccess || not empty addrError ? 'active' : ''}"
                onclick="switchTab('address',this)">
          <i class="bi bi-geo-alt"></i>Địa chỉ
          <c:if test="${not empty addresses}">
            <span style="background:#0077b6;color:white;border-radius:10px;
                         padding:1px 7px;font-size:10px;">${addresses.size()}</span>
          </c:if>
        </button>
        <button class="tab-btn" onclick="location.href='/dyleeseafood/order/history'">
          <i class="bi bi-bag-check"></i>Đơn hàng
        </button>
      </c:if>
    </div>

    <!-- ═══ TAB 1: THÔNG TIN ═══ -->
    <div id="panel-info"
         class="tab-panel ${(empty activeTab || activeTab=='info') && empty addrSuccess && empty addrError ? 'active' : ''}">

      <c:if test="${not empty infoSuccess}">
        <div class="alert alert-success d-flex align-items-center gap-2 mb-4"
             style="border-radius:12px;border:none;">
          <i class="bi bi-check-circle-fill"></i>${infoSuccess}
        </div>
      </c:if>
      <c:if test="${not empty infoError}">
        <div class="alert alert-danger d-flex align-items-center gap-2 mb-4"
             style="border-radius:12px;border:none;">
          <i class="bi bi-exclamation-circle-fill"></i>${infoError}
        </div>
      </c:if>

      <div class="section-label">Thông tin tài khoản</div>
      <div class="row g-3 mb-4">
        <div class="col-md-6">
          <label class="form-label">Tên đăng nhập</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-at"></i></span>
            <input type="text" class="form-control" value="${user.username}" readonly>
          </div>
        </div>
        <div class="col-md-6">
          <label class="form-label">Vai trò</label>
          <input type="text" class="form-control"
                 value="${user.roleId==1?'Quản trị viên':user.roleId==2?'Nhân viên':'Khách hàng'}" readonly>
        </div>
      </div>

      <div class="section-label">Chỉnh sửa thông tin</div>
      <form method="post" action="/dyleeseafood/profile/update">
        <div class="row g-3">
          <div class="col-12">
            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
            <input type="text" name="name" class="form-control"
                   value="${customer.name}" required placeholder="Nhập họ và tên...">
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-envelope"></i></span>
              <input type="email" name="email" class="form-control"
                     value="${customer.email}" placeholder="email@gmail.com">
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-phone"></i></span>
              <input type="text" name="phone" class="form-control"
                     value="${customer.phone}" placeholder="0912 345 678">
            </div>
          </div>
          <div class="col-12">
            <button type="submit" class="btn btn-primary px-4 py-2" style="border-radius:10px;">
              <i class="bi bi-check-circle me-2"></i>Lưu thông tin
            </button>
          </div>
        </div>
      </form>


    </div>

    <!-- ═══ TAB 2: MẬT KHẨU ═══ -->
    <div id="panel-password"
         class="tab-panel ${activeTab=='password' || not empty pwdError || not empty pwdSuccess ? 'active' : ''}">

      <c:if test="${not empty pwdError}">
        <div class="alert alert-danger d-flex align-items-center gap-2 mb-4"
             style="border-radius:12px;border:none;">
          <i class="bi bi-exclamation-circle-fill"></i>${pwdError}
        </div>
      </c:if>
      <c:if test="${not empty pwdSuccess}">
        <div class="alert alert-success d-flex align-items-center gap-2 mb-4"
             style="border-radius:12px;border:none;">
          <i class="bi bi-check-circle-fill"></i>${pwdSuccess}
        </div>
      </c:if>

      <div class="p-3 mb-4" style="background:#f7f9fc;border-radius:12px;border:1px solid #e8edf5;">
        <div style="font-size:12px;color:#8a9ab0;font-weight:600;margin-bottom:8px;">
          <i class="bi bi-info-circle me-1"></i>Yêu cầu mật khẩu:
        </div>
        <div class="rule-item" id="rule-len">
          <i class="bi bi-circle" style="font-size:10px;"></i>Ít nhất 6 ký tự
        </div>
        <div class="rule-item" id="rule-match">
          <i class="bi bi-circle" style="font-size:10px;"></i>Xác nhận phải khớp
        </div>
      </div>

      <form method="post" action="/dyleeseafood/profile/change-password"
            onsubmit="return validatePwd()" style="max-width:480px;">
        <div class="mb-3">
          <label class="form-label">Mật khẩu hiện tại <span class="text-danger">*</span></label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock"></i></span>
            <input type="password" name="currentPassword" id="curPwd"
                   class="form-control" required placeholder="Nhập mật khẩu hiện tại">
            <button type="button" class="input-group-text" style="cursor:pointer;"
                    onclick="togglePwd('curPwd','eye0')">
              <i class="bi bi-eye" id="eye0"></i>
            </button>
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" name="newPassword" id="newPwd"
                   class="form-control" required placeholder="Tối thiểu 6 ký tự"
                   oninput="checkStrength(this.value);checkMatch()">
            <button type="button" class="input-group-text" style="cursor:pointer;"
                    onclick="togglePwd('newPwd','eye1')">
              <i class="bi bi-eye" id="eye1"></i>
            </button>
          </div>
          <div class="strength-bar"><div id="sBar" class="strength-fill"></div></div>
          <small id="sText" class="text-muted"></small>
        </div>

        <div class="mb-4">
          <label class="form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" name="confirmPassword" id="cfmPwd"
                   class="form-control" required placeholder="Nhập lại mật khẩu mới"
                   oninput="checkMatch()">
            <button type="button" class="input-group-text" style="cursor:pointer;"
                    onclick="togglePwd('cfmPwd','eye2')">
              <i class="bi bi-eye" id="eye2"></i>
            </button>
          </div>
          <small id="matchText" class="d-block mt-1"></small>
        </div>

        <button type="submit" class="btn btn-primary px-4 py-2" style="border-radius:10px;">
          <i class="bi bi-shield-lock me-2"></i>Đổi mật khẩu
        </button>
      </form>
    </div>

    <!-- ═══ TAB 3: ĐỊA CHỈ ═══ -->
    <c:if test="${user.roleId==3}">
    <div id="panel-address"
         class="tab-panel ${not empty addrSuccess || not empty addrError ? 'active' : ''}">

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h6 class="fw-bold mb-1"><i class="bi bi-geo-alt-fill me-2" style="color:var(--p);"></i>Địa chỉ giao hàng</h6>
          <small class="text-muted">Quản lý địa chỉ để checkout nhanh hơn</small>
        </div>
        <button class="btn btn-primary btn-sm" style="border-radius:9px;"
                onclick="toggleAddForm()">
          <i class="bi bi-plus me-1"></i>Thêm địa chỉ
        </button>
      </div>

      <!-- Form thêm địa chỉ mới -->
      <div id="addAddrWrap" class="addr-form-wrap mb-4">
        <div class="fw-bold mb-3" style="font-size:14px;">
          <i class="bi bi-plus-circle me-2" style="color:var(--p);"></i>Thêm địa chỉ mới
        </div>
        <form method="post" action="/dyleeseafood/profile/address/add">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Họ tên người nhận <span class="text-danger">*</span></label>
              <input type="text" name="fullName" class="form-control"
                     value="${customer.name}" required>
            </div>
            <div class="col-md-6">
              <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
              <input type="text" name="phone" class="form-control"
                     value="${customer.phone}" required>
            </div>
            <div class="col-12">
              <label class="form-label">Địa chỉ (số nhà, tên đường) <span class="text-danger">*</span></label>
              <input type="text" name="address" class="form-control"
                     placeholder="VD: 123 Đường Lê Lợi" required>
            </div>
            <div class="col-md-4">
              <label class="form-label">Phường/Xã</label>
              <input type="text" name="ward" class="form-control" placeholder="Phường Bến Nghé">
            </div>
            <div class="col-md-4">
              <label class="form-label">Quận/Huyện</label>
              <input type="text" name="district" class="form-control" placeholder="Quận 1">
            </div>
            <div class="col-md-4">
              <label class="form-label">Tỉnh/Thành phố <span class="text-danger">*</span></label>
              <input type="text" name="city" class="form-control"
                     placeholder="TP. Hồ Chí Minh" required>
            </div>
            <div class="col-12">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="isDefault" id="chkDefault">
                <label class="form-check-label" for="chkDefault" style="font-size:13px;">
                  Đặt làm địa chỉ mặc định
                </label>
              </div>
            </div>
            <div class="col-12 d-flex gap-2">
              <button type="submit" class="btn btn-primary btn-sm px-4" style="border-radius:8px;">
                <i class="bi bi-check me-1"></i>Lưu địa chỉ
              </button>
              <button type="button" class="btn btn-outline-secondary btn-sm px-3"
                      style="border-radius:8px;" onclick="toggleAddForm()">Huỷ</button>
            </div>
          </div>
        </form>
      </div>

      <!-- Danh sách địa chỉ -->
      <c:choose>
        <c:when test="${empty addresses}">
          <div class="text-center py-5" style="color:#8a9ab0;">
            <i class="bi bi-geo-alt" style="font-size:3rem;opacity:.25;"></i>
            <p class="mt-2 mb-3">Chưa có địa chỉ nào</p>
            <button class="btn btn-primary btn-sm" style="border-radius:9px;"
                    onclick="toggleAddForm()">
              <i class="bi bi-plus me-1"></i>Thêm địa chỉ đầu tiên
            </button>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="addr" items="${addresses}">
            <div class="addr-card ${addr.defaultAddr ? 'is-default' : ''}">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <div class="d-flex align-items-center gap-2 mb-1">
                    <span style="font-weight:700;font-size:14px;">${addr.fullName}</span>
                    <span style="color:#8a9ab0;font-size:13px;">|</span>
                    <span style="font-size:13px;color:#475569;">${addr.phone}</span>
                    <c:if test="${addr.defaultAddr}">
                      <span style="background:#e0f2fe;color:#0077b6;border-radius:20px;
                                   padding:2px 10px;font-size:11px;font-weight:700;">
                        Mặc định
                      </span>
                    </c:if>
                  </div>
                  <div style="font-size:13px;color:#64748b;">${addr.fullAddress}</div>
                </div>
              </div>

              <div class="addr-actions">
                <c:if test="${!addr.defaultAddr}">
                  <form method="post" action="/dyleeseafood/profile/address/default/${addr.id}"
                        style="display:inline;">
                    <button type="submit" class="addr-btn primary">
                      <i class="bi bi-star me-1"></i>Đặt mặc định
                    </button>
                  </form>
                </c:if>
                <button class="addr-btn" onclick="toggleEditForm(${addr.id})">
                  <i class="bi bi-pencil me-1"></i>Sửa
                </button>
                <form method="post" action="/dyleeseafood/profile/address/delete/${addr.id}"
                      style="display:inline;"
                      onsubmit="return confirm('Xoá địa chỉ này?')">
                  <button type="submit" class="addr-btn danger">
                    <i class="bi bi-trash me-1"></i>Xoá
                  </button>
                </form>
              </div>

              <!-- Form sửa (ẩn mặc định) -->
              <div id="editWrap${addr.id}" class="addr-form-wrap mt-3">
                <div class="fw-bold mb-3" style="font-size:13px;color:var(--p);">
                  <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa địa chỉ
                </div>
                <form method="post" action="/dyleeseafood/profile/address/edit/${addr.id}">
                  <div class="row g-2">
                    <div class="col-md-6">
                      <input type="text" name="fullName" class="form-control form-control-sm"
                             value="${addr.fullName}" placeholder="Họ tên *" required>
                    </div>
                    <div class="col-md-6">
                      <input type="text" name="phone" class="form-control form-control-sm"
                             value="${addr.phone}" placeholder="SĐT *" required>
                    </div>
                    <div class="col-12">
                      <input type="text" name="address" class="form-control form-control-sm"
                             value="${addr.address}" placeholder="Địa chỉ *" required>
                    </div>
                    <div class="col-md-4">
                      <input type="text" name="ward" class="form-control form-control-sm"
                             value="${addr.ward}" placeholder="Phường/Xã">
                    </div>
                    <div class="col-md-4">
                      <input type="text" name="district" class="form-control form-control-sm"
                             value="${addr.district}" placeholder="Quận/Huyện">
                    </div>
                    <div class="col-md-4">
                      <input type="text" name="city" class="form-control form-control-sm"
                             value="${addr.city}" placeholder="Tỉnh/TP *" required>
                    </div>
                    <div class="col-12 d-flex gap-2">
                      <button type="submit" class="btn btn-primary btn-sm px-3" style="border-radius:8px;">
                        <i class="bi bi-check me-1"></i>Lưu
                      </button>
                      <button type="button" class="btn btn-outline-secondary btn-sm px-3"
                              style="border-radius:8px;"
                              onclick="toggleEditForm(${addr.id})">Huỷ</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    </c:if>

  </div><!-- /profile-card -->
</div><!-- /profile-wrap -->

<!-- TOAST thông báo địa chỉ -->
<c:if test="${not empty addrSuccess}">
  <div class="toast-float toast-success" id="toast">
    <i class="bi bi-check-circle-fill"></i>${addrSuccess}
  </div>
</c:if>
<c:if test="${not empty addrError}">
  <div class="toast-float toast-error" id="toast">
    <i class="bi bi-exclamation-circle-fill"></i>${addrError}
  </div>
</c:if>

<script>
/* ── TAB SWITCHING ── */
function switchTab(name, btn) {
  ['info','password','address'].forEach(function(t){
    var p = document.getElementById('panel-'+t);
    if (p) p.classList.remove('active');
  });
  document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('active'); });
  var panel = document.getElementById('panel-'+name);
  if (panel) panel.classList.add('active');
  btn.classList.add('active');
}

/* ── ADDRESS FORMS ── */
function toggleAddForm() {
  var w = document.getElementById('addAddrWrap');
  w.classList.toggle('show');
  if (w.classList.contains('show')) w.scrollIntoView({behavior:'smooth',block:'nearest'});
}
function toggleEditForm(id) {
  var w = document.getElementById('editWrap'+id);
  w.classList.toggle('show');
  if (w.classList.contains('show')) w.scrollIntoView({behavior:'smooth',block:'nearest'});
}

/* ── PASSWORD ── */
function togglePwd(inputId, iconId) {
  var i = document.getElementById(inputId);
  var e = document.getElementById(iconId);
  if (i.type==='password') { i.type='text'; e.className='bi bi-eye-slash'; }
  else { i.type='password'; e.className='bi bi-eye'; }
}
function checkStrength(val) {
  var bar=document.getElementById('sBar'), txt=document.getElementById('sText');
  var rLen=document.getElementById('rule-len');
  if (!val) { bar.style.width='0%'; txt.textContent=''; return; }
  var sc=0, ok=val.length>=6;
  if(ok)sc++; if(val.length>=10)sc++;
  if(/[A-Z]/.test(val))sc++; if(/[0-9]/.test(val))sc++;
  if(/[^a-zA-Z0-9]/.test(val))sc++;
  var cs=['#dc3545','#fd7e14','#ffc107','#20c997','#198754'];
  var lb=['Rất yếu','Yếu','Trung bình','Mạnh','Rất mạnh'];
  var idx=Math.max(0,Math.min(sc-1,4));
  bar.style.width=(sc/5*100)+'%'; bar.style.background=cs[idx];
  txt.textContent=lb[idx]; txt.style.color=cs[idx];
  rLen.className=ok?'rule-item pass':'rule-item';
  rLen.innerHTML=(ok?'<i class="bi bi-check-circle-fill" style="font-size:10px;color:#16a34a;"></i>':'<i class="bi bi-circle" style="font-size:10px;"></i>')+' Ít nhất 6 ký tự';
}
function checkMatch() {
  var np=document.getElementById('newPwd').value;
  var cp=document.getElementById('cfmPwd').value;
  var mt=document.getElementById('matchText');
  var rl=document.getElementById('rule-match');
  if (!cp) { mt.innerHTML=''; return; }
  var ok=np===cp;
  mt.innerHTML=ok
    ?'<i class="bi bi-check-circle-fill me-1" style="color:#16a34a;font-size:12px;"></i><span style="color:#16a34a;font-size:12px;">Mật khẩu khớp</span>'
    :'<i class="bi bi-x-circle-fill me-1" style="color:#dc3545;font-size:12px;"></i><span style="color:#dc3545;font-size:12px;">Chưa khớp</span>';
  rl.className=ok?'rule-item pass':'rule-item';
  rl.innerHTML=(ok?'<i class="bi bi-check-circle-fill" style="font-size:10px;color:#16a34a;"></i>':'<i class="bi bi-circle" style="font-size:10px;"></i>')+' Xác nhận phải khớp';
}
function validatePwd() {
  var np=document.getElementById('newPwd').value;
  var cp=document.getElementById('cfmPwd').value;
  if(np!==cp){alert('Mật khẩu xác nhận không khớp!');return false;}
  if(np.length<6){alert('Mật khẩu tối thiểu 6 ký tự!');return false;}
  return true;
}

/* ── TOAST AUTO HIDE ── */
var toast=document.getElementById('toast');
if(toast) setTimeout(function(){toast.style.opacity='0';toast.style.transition='opacity .5s';},4000);
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
