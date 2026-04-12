<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Nhân viên" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .perm-item {
    display:flex; align-items:center; gap:10px;
    padding:8px 10px; border-radius:8px;
    font-size:13px; margin-bottom:4px;
  }
  .perm-item.yes { background:#e8f5e9; color:#2e7d32; }
  .perm-item.no  { background:#fef0f0; color:#c62828; }
  .badge-on {
    display:inline-flex; align-items:center; gap:5px;
    padding:5px 12px; background:#e8f5e9; color:#2e7d32;
    border-radius:20px; font-size:11px; font-weight:600;
  }
  .badge-off {
    display:inline-flex; align-items:center; gap:5px;
    padding:5px 12px; background:#f5f5f5; color:#757575;
    border-radius:20px; font-size:11px; font-weight:600;
  }
  .status-dot {
    width:6px; height:6px; border-radius:50%;
  }
  .btn-lock {
    display:inline-flex; align-items:center; gap:5px;
    padding:6px 12px; border-radius:8px; font-size:12px;
    font-weight:500; text-decoration:none; transition:0.15s;
    cursor:pointer;
  }
  .btn-lock.danger {
    background:#fef0f0; color:#c62828;
    border:1px solid #ffcdd2;
  }
  .btn-lock.danger:hover { background:#ffcdd2; }
  .btn-lock.success {
    background:#e8f5e9; color:#2e7d32;
    border:1px solid #c8e6c9;
  }
  .btn-lock.success:hover { background:#c8e6c9; }
  .input-group-text {
    border-radius:9px 0 0 9px;
    border:1.5px solid #e0e7ef; border-right:none;
    background:#f7f9fc; color:#8a9ab0;
  }
  .input-group .form-control {
    border-radius:0 9px 9px 0;
  }
  .btn-primary-custom {
    background:#023e8a; color:white; border:none;
    border-radius:10px; padding:12px; font-size:14px;
    font-weight:600; width:100%; cursor:pointer;
    transition:0.2s;
  }
  .btn-primary-custom:hover { background:#0077b6; }
  .staff-avatar {
    width:40px; height:40px; border-radius:50%;
    display:flex; align-items:center;
    justify-content:center; font-weight:700;
    font-size:15px; background:#e8f5e9;
    color:#28a745; flex-shrink:0;
  }
</style>

  <!-- HEADER -->
  <div class="d-flex justify-content-between
              align-items-center mb-4">
    <div>
      <h4 class="fw-bold mb-1" style="font-size:20px;">
        <i class="bi bi-person-badge text-primary me-2"></i>
        Quản lý nhân viên
      </h4>
      <p class="mb-0" style="color:#8a9ab0;font-size:13px;">
        Thêm, xem và quản lý tài khoản nhân viên
      </p>
    </div>
    <span class="badge px-3 py-2"
          style="background:#e8f4fd;color:#0077b6;
                 font-size:13px;border-radius:20px;">
      ${staffList.size()} nhân viên
    </span>
  </div>

  <div class="row g-4">

    <!-- CỘT TRÁI: FORM + QUYỀN -->
    <div class="col-md-4">

      <!-- FORM THÊM -->
      <div class="card-box p-4 mb-4">
        <h6 class="fw-bold mb-1" style="font-size:15px;">
          <i class="bi bi-person-plus text-primary me-2"></i>
          Thêm nhân viên mới
        </h6>
        <p class="text-muted mb-4" style="font-size:12px;">
          Tài khoản sẽ có quyền Staff
        </p>

        <form method="post"
              action="/dyleeseafood/admin/staff/add">
          <div class="mb-3">
            <label class="form-label">
              Họ và tên <span class="text-danger">*</span>
            </label>
            <input type="text" name="name"
                   class="form-control"
                   placeholder="Nguyễn Văn A" required>
          </div>
          <div class="mb-3">
            <label class="form-label">
              Tên đăng nhập
              <span class="text-danger">*</span>
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-at"
                   style="font-size:13px;"></i>
              </span>
              <input type="text" name="username"
                     class="form-control"
                     placeholder="nhanvien01" required>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-phone"
                   style="font-size:13px;"></i>
              </span>
              <input type="text" name="phone"
                     class="form-control"
                     placeholder="0912 345 678">
            </div>
          </div>
          <div class="mb-4">
            <label class="form-label">
              Mật khẩu <span class="text-danger">*</span>
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-lock"
                   style="font-size:13px;"></i>
              </span>
              <input type="password" name="password"
                     id="pwdInput" class="form-control"
                     placeholder="Tối thiểu 6 ký tự"
                     required>
              <button type="button"
                      class="btn btn-outline-secondary"
                      style="border-radius:0 9px 9px 0;
                             border:1.5px solid #e0e7ef;
                             border-left:none;"
                      onclick="togglePwd()">
                <i class="bi bi-eye" id="eyeIcon"></i>
              </button>
            </div>
          </div>
          <button type="submit" class="btn-primary-custom">
            <i class="bi bi-person-plus me-2"></i>
            Thêm nhân viên
          </button>
        </form>
      </div>

      <!-- PHÂN QUYỀN -->
      <div class="card-box p-4">
        <h6 class="fw-bold mb-1" style="font-size:15px;">
          <i class="bi bi-shield-half text-primary me-2"></i>
          Quyền của nhân viên
        </h6>
        <p class="text-muted mb-3" style="font-size:12px;">
          Role: Staff (role_id = 2)
        </p>
        <p style="font-size:11px;font-weight:600;
                  color:#8a9ab0;text-transform:uppercase;
                  letter-spacing:0.06em;margin-bottom:6px;">
          Được phép
        </p>
        <div class="perm-item yes">
          <i class="bi bi-check-circle-fill"
             style="font-size:14px;"></i>
          Xem Dashboard
        </div>
        <div class="perm-item yes">
          <i class="bi bi-check-circle-fill"
             style="font-size:14px;"></i>
          Thêm / Sửa sản phẩm
        </div>
        <div class="perm-item yes">
          <i class="bi bi-check-circle-fill"
             style="font-size:14px;"></i>
          Xem danh sách khách hàng
        </div>
        <div class="perm-item yes">
          <i class="bi bi-check-circle-fill"
             style="font-size:14px;"></i>
          Đổi hạng thành viên
        </div>
        <p style="font-size:11px;font-weight:600;
                  color:#8a9ab0;text-transform:uppercase;
                  letter-spacing:0.06em;
                  margin:12px 0 6px;">
          Không được phép
        </p>
        <div class="perm-item no">
          <i class="bi bi-x-circle-fill"
             style="font-size:14px;"></i>
          Xóa sản phẩm
        </div>
        <div class="perm-item no">
          <i class="bi bi-x-circle-fill"
             style="font-size:14px;"></i>
          Quản lý danh mục
        </div>
        <div class="perm-item no">
          <i class="bi bi-x-circle-fill"
             style="font-size:14px;"></i>
          Quản lý đơn hàng
        </div>
        <div class="perm-item no">
          <i class="bi bi-x-circle-fill"
             style="font-size:14px;"></i>
          Quản lý nhân viên
        </div>
      </div>
    </div>

    <!-- CỘT PHẢI: DANH SÁCH -->
    <div class="col-md-8">
      <div class="card-box">
        <div class="d-flex justify-content-between
                    align-items-center p-4 pb-0">
          <h6 class="fw-bold mb-0" style="font-size:15px;">
            <i class="bi bi-list-ul text-primary me-2"></i>
            Danh sách nhân viên
          </h6>
        </div>
        <div class="mt-3">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th class="ps-4" style="width:50px;">#</th>
                <th>Nhân viên</th>
                <th>Tài khoản</th>