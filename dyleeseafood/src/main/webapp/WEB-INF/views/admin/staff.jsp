<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Nhân viên" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .perm-item { display:flex; align-items:center; gap:10px; padding:8px 12px; border-radius:8px; font-size:13px; margin-bottom:4px; }
  .perm-item.yes { background:#e8f5e9; color:#2e7d32; }
  .perm-item.no  { background:#fef0f0; color:#c62828; }
  .staff-avatar { width:42px; height:42px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:16px; flex-shrink:0; }
  .avatar-active   { background:#e8f5e9; color:#2e7d32; }
  .avatar-inactive { background:#f5f5f5; color:#9e9e9e; }
  .status-pill { display:inline-flex; align-items:center; gap:5px; padding:4px 12px; border-radius:20px; font-size:11px; font-weight:600; }
  .pill-active   { background:#e8f5e9; color:#2e7d32; }
  .pill-inactive { background:#fef0f0; color:#c62828; }
  .btn-toggle { display:inline-flex; align-items:center; gap:5px; padding:6px 14px; border-radius:8px; font-size:12px; font-weight:500; text-decoration:none; border:1px solid; transition:0.15s; cursor:pointer; background:transparent; }
  .btn-toggle.lock   { color:#c62828; border-color:#ffcdd2; }
  .btn-toggle.lock:hover { background:#fef0f0; }
  .btn-toggle.unlock { color:#2e7d32; border-color:#c8e6c9; }
  .btn-toggle.unlock:hover { background:#e8f5e9; }
  .cred-box { background:#f7f9fc; border:1px dashed #b0c4de; border-radius:10px; padding:12px 14px; margin-bottom:14px; }
  .cred-row { display:flex; align-items:center; gap:8px; font-size:13px; color:#4a5568; margin-bottom:3px; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
  <div>
    <h4 class="fw-bold mb-1" style="font-size:20px;">
      <i class="bi bi-person-badge text-primary me-2"></i>Quản lý nhân viên
    </h4>
    <p class="mb-0" style="color:#8a9ab0;font-size:13px;">Thêm và quản lý tài khoản nhân viên bán hàng</p>
  </div>
  <span style="background:#e8f4fd;color:#0077b6;padding:6px 16px;border-radius:20px;font-size:13px;font-weight:600;">
    <i class="bi bi-people me-1"></i>${staffList.size()} nhân viên
  </span>
</div>

<div class="row g-4">

  <!-- CỘT TRÁI -->
  <div class="col-md-4">
    <div class="card-box p-4 mb-4">
      <h6 class="fw-bold mb-1" style="font-size:15px;">
        <i class="bi bi-person-plus text-primary me-2"></i>Thêm nhân viên mới
      </h6>
      <p class="text-muted mb-3" style="font-size:12px;">Tạo tài khoản để nhân viên đăng nhập vào hệ thống</p>

      <div class="cred-box">
        <div style="font-size:11px;font-weight:600;color:#8a9ab0;text-transform:uppercase;letter-spacing:0.05em;margin-bottom:8px;">
          <i class="bi bi-info-circle me-1"></i>Nhân viên sẽ đăng nhập bằng:
        </div>
        <div class="cred-row"><i class="bi bi-link-45deg text-primary"></i>URL: <strong>/dyleeseafood/login</strong></div>
        <div class="cred-row"><i class="bi bi-at text-primary"></i>Username: <em>điền bên dưới</em></div>
        <div class="cred-row"><i class="bi bi-lock text-primary"></i>Password: <em>điền bên dưới</em></div>
      </div>

      <form method="post" action="/dyleeseafood/admin/staff/add">
        <div class="mb-3">
          <label class="form-label fw-bold" style="font-size:13px;">Họ và tên <span class="text-danger">*</span></label>
          <input type="text" name="name" class="form-control" placeholder="Nguyễn Văn A" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-bold" style="font-size:13px;">Tên đăng nhập <span class="text-danger">*</span></label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-at" style="font-size:13px;"></i></span>
            <input type="text" name="username" class="form-control" placeholder="nhanvien01" required>
          </div>
          <small class="text-muted">Chỉ dùng chữ, số và dấu gạch dưới</small>
        </div>
        <div class="mb-3">
          <label class="form-label fw-bold" style="font-size:13px;">Số điện thoại</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-phone" style="font-size:13px;"></i></span>
            <input type="text" name="phone" class="form-control" placeholder="0912 345 678">
          </div>
        </div>
        <div class="mb-4">
          <label class="form-label fw-bold" style="font-size:13px;">Mật khẩu <span class="text-danger">*</span></label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock" style="font-size:13px;"></i></span>
            <input type="password" name="password" id="pwdInput" class="form-control" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
            <button type="button" class="btn btn-outline-secondary" onclick="togglePwd()" style="border-left:none;">
              <i class="bi bi-eye" id="eyeIcon"></i>
            </button>
          </div>
          <small class="text-muted">Tối thiểu 6 ký tự</small>
        </div>
        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold" style="border-radius:10px;">
          <i class="bi bi-person-plus me-2"></i>Tạo tài khoản nhân viên
        </button>
      </form>
    </div>

    <div class="card-box p-4">
      <h6 class="fw-bold mb-1" style="font-size:15px;">
        <i class="bi bi-shield-half text-primary me-2"></i>Quyền của nhân viên
      </h6>
      <p class="text-muted mb-3" style="font-size:12px;">Role: Staff (role_id = 2)</p>
      <p style="font-size:11px;font-weight:600;color:#2e7d32;text-transform:uppercase;letter-spacing:0.06em;margin-bottom:6px;">✅ Được phép</p>
      <div class="perm-item yes"><i class="bi bi-check-circle-fill" style="font-size:13px;"></i>Xem Dashboard &amp; thống kê</div>
      <div class="perm-item yes"><i class="bi bi-check-circle-fill" style="font-size:13px;"></i>Thêm &amp; sửa sản phẩm</div>
      <div class="perm-item yes"><i class="bi bi-check-circle-fill" style="font-size:13px;"></i>Xem &amp; quản lý khách hàng</div>
      <div class="perm-item yes"><i class="bi bi-check-circle-fill" style="font-size:13px;"></i>Đổi hạng thành viên khách hàng</div>
      <p style="font-size:11px;font-weight:600;color:#c62828;text-transform:uppercase;letter-spacing:0.06em;margin:12px 0 6px;">❌ Không được phép</p>
      <div class="perm-item no"><i class="bi bi-x-circle-fill" style="font-size:13px;"></i>Xóa sản phẩm</div>
      <div class="perm-item no"><i class="bi bi-x-circle-fill" style="font-size:13px;"></i>Quản lý danh mục</div>
      <div class="perm-item no"><i class="bi bi-x-circle-fill" style="font-size:13px;"></i>Quản lý &amp; duyệt đơn hàng</div>
      <div class="perm-item no"><i class="bi bi-x-circle-fill" style="font-size:13px;"></i>Quản lý nhân viên khác</div>
      <div class="perm-item no"><i class="bi bi-x-circle-fill" style="font-size:13px;"></i>Quản lý nhà cung cấp</div>
    </div>
  </div>

  <!-- CỘT PHẢI -->
  <div class="col-md-8">
    <div class="card-box">
      <div class="d-flex justify-content-between align-items-center p-4 pb-3" style="border-bottom:1px solid #f0f2f5;">
        <h6 class="fw-bold mb-0" style="font-size:15px;">
          <i class="bi bi-list-ul text-primary me-2"></i>Danh sách nhân viên
        </h6>
        <div style="font-size:12px;color:#8a9ab0;">
          <i class="bi bi-lock me-1"></i>Khóa để ngăn đăng nhập
        </div>
      </div>

      <c:choose>
        <c:when test="${empty staffList}">
          <div class="text-center py-5" style="color:#8a9ab0;">
            <i class="bi bi-person-x" style="font-size:3.5rem;color:#dde3ed;"></i>
            <h6 class="mt-3 fw-bold">Chưa có nhân viên nào</h6>
            <p style="font-size:13px;">Thêm nhân viên từ form bên trái</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-responsive">
            <table class="table table-hover mb-0">
              <thead>
                <tr style="font-size:12px;color:#8a9ab0;">
                  <th class="ps-4" style="width:44px;">#</th>
                  <th>Nhân viên</th>
                  <th>Tài khoản đăng nhập</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="s" items="${staffList}" varStatus="i">
                  <tr>
                    <td class="ps-4 text-muted align-middle">${i.count}</td>
                    <td class="align-middle">
                      <div class="d-flex align-items-center gap-2">
                        <%-- FIX: s.active trực tiếp --%>
                        <div class="staff-avatar ${s.active ? 'avatar-active' : 'avatar-inactive'}">
                          ${s.name.substring(0,1)}
                        </div>
                        <div>
                          <div class="fw-bold" style="font-size:14px;">${s.name}</div>
                          <small style="color:#8a9ab0;">
                            <c:choose>
                              <c:when test="${not empty s.phone}">
                                <i class="bi bi-phone me-1"></i>${s.phone}
                              </c:when>
                              <c:otherwise>Chưa có SĐT</c:otherwise>
                            </c:choose>
                          </small>
                        </div>
                      </div>
                    </td>
                    <td class="align-middle">
                      <%-- FIX: s.username trực tiếp --%>
                      <div style="font-size:13px;">
                        <i class="bi bi-at text-muted me-1"></i>
                        <strong>${s.username}</strong>
                      </div>
                      <small style="color:#8a9ab0;"><i class="bi bi-shield me-1"></i>Staff</small>
                    </td>
                    <td class="text-center align-middle">
                      <%-- FIX: s.active trực tiếp --%>
                      <c:choose>
                        <c:when test="${s.active}">
                          <span class="status-pill pill-active">
                            <span style="width:6px;height:6px;border-radius:50%;background:#2e7d32;display:inline-block;"></span>
                            Đang hoạt động
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="status-pill pill-inactive">
                            <span style="width:6px;height:6px;border-radius:50%;background:#c62828;display:inline-block;"></span>
                            Đã bị khóa
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td class="text-center align-middle">
                      <%-- FIX: s.userId = id trong bảng users --%>
                      <c:choose>
                        <c:when test="${s.active}">
                          <a href="/dyleeseafood/admin/staff/toggle/${s.userId}"
                             class="btn-toggle lock"
                             onclick="return confirm('Khóa tài khoản ${s.name}?\nNhân viên sẽ không thể đăng nhập.')">
                            <i class="bi bi-lock"></i>Khóa
                          </a>
                        </c:when>
                        <c:otherwise>
                          <a href="/dyleeseafood/admin/staff/toggle/${s.userId}"
                             class="btn-toggle unlock"
                             onclick="return confirm('Mở khóa tài khoản ${s.name}?')">
                            <i class="bi bi-unlock"></i>Mở khóa
                          </a>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div class="px-4 py-3 d-flex gap-3" style="border-top:1px solid #f0f2f5;font-size:12px;color:#8a9ab0;">
            <span>Tổng: <strong>${staffList.size()}</strong></span>
            <span>•</span>
            <c:set var="ac" value="0"/>
            <c:forEach var="s" items="${staffList}">
              <c:if test="${s.active}"><c:set var="ac" value="${ac+1}"/></c:if>
            </c:forEach>
            <span style="color:#2e7d32;"><i class="bi bi-circle-fill me-1" style="font-size:8px;"></i>Đang hoạt động: <strong>${ac}</strong></span>
            <span>•</span>
            <span style="color:#c62828;"><i class="bi bi-circle-fill me-1" style="font-size:8px;"></i>Đã khóa: <strong>${staffList.size()-ac}</strong></span>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="card-box p-4 mt-4">
      <h6 class="fw-bold mb-3" style="font-size:14px;">
        <i class="bi bi-question-circle text-primary me-2"></i>Hướng dẫn đăng nhập cho nhân viên
      </h6>
      <div class="row g-3">
        <div class="col-md-4">
          <div style="background:#f7f9fc;border-radius:10px;padding:14px;border:1px solid #e8edf5;">
            <div style="font-size:11px;color:#8a9ab0;font-weight:600;margin-bottom:6px;">BƯỚC 1</div>
            <div style="font-size:13px;">Truy cập <strong>/dyleeseafood/login</strong></div>
          </div>
        </div>
        <div class="col-md-4">
          <div style="background:#f7f9fc;border-radius:10px;padding:14px;border:1px solid #e8edf5;">
            <div style="font-size:11px;color:#8a9ab0;font-weight:600;margin-bottom:6px;">BƯỚC 2</div>
            <div style="font-size:13px;">Nhập <strong>username</strong> và <strong>mật khẩu</strong> được cấp</div>
          </div>
        </div>
        <div class="col-md-4">
          <div style="background:#f7f9fc;border-radius:10px;padding:14px;border:1px solid #e8edf5;">
            <div style="font-size:11px;color:#8a9ab0;font-weight:600;margin-bottom:6px;">BƯỚC 3</div>
            <div style="font-size:13px;">Hệ thống chuyển đến <strong>trang quản trị</strong></div>
          </div>
        </div>
      </div>
      <div class="mt-3 p-3" style="background:#fff8e6;border-radius:10px;border:1px solid #ffe0b2;font-size:12px;color:#e65100;">
        <i class="bi bi-exclamation-triangle me-2"></i>
        <strong>Lưu ý:</strong> Thông báo ngay username + mật khẩu cho nhân viên sau khi tạo. Hệ thống không gửi email tự động.
      </div>
    </div>
  </div>
</div>

<script>
function togglePwd() {
  var i = document.getElementById('pwdInput');
  var e = document.getElementById('eyeIcon');
  if (i.type === 'password') { i.type='text'; e.className='bi bi-eye-slash'; }
  else { i.type='password'; e.className='bi bi-eye'; }
}
</script>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>
