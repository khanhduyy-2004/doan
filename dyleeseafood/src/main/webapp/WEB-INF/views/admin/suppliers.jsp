<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Nhà cung cấp" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .tab-btn {
    padding:10px 20px; border:none; background:transparent;
    font-size:14px; font-weight:500; color:#8a9ab0;
    border-bottom:2px solid transparent;
    cursor:pointer; transition:0.2s;
  }
  .tab-btn.active { color:#023e8a; border-bottom-color:#023e8a; }
  .tab-content-panel { display:none; }
  .tab-content-panel.active { display:block; }
  .low-stock-badge {
    background:#fef2f2; color:#dc2626;
    border:1px solid #fecaca; font-size:11px;
    padding:4px 10px; border-radius:20px; font-weight:600;
  }
  .ok-stock-badge {
    background:#f0fdf4; color:#16a34a;
    border:1px solid #bbf7d0; font-size:11px;
    padding:4px 10px; border-radius:20px; font-weight:600;
  }
  .supplier-avatar {
    width:38px; height:38px; border-radius:50%;
    background:#e8f4fd; color:#0077b6;
    display:flex; align-items:center;
    justify-content:center; font-weight:700;
    font-size:16px; flex-shrink:0;
  }
  .stat-pill {
    display:inline-flex; align-items:center; gap:4px;
    padding:4px 10px; border-radius:20px;
    font-size:11px; font-weight:600;
  }
</style>

<!-- HEADER -->
<div class="d-flex justify-content-between
            align-items-center mb-4">
  <div>
    <h4 class="fw-bold mb-1" style="font-size:20px;">
      <i class="bi bi-truck text-primary me-2"></i>
      Nhà cung cấp & Kho hàng
    </h4>
    <p class="mb-0" style="color:#8a9ab0;font-size:13px;">
      Quản lý nhà cung cấp, nhập hàng và theo dõi tồn kho
    </p>
  </div>
  <button class="btn btn-primary px-4"
          style="border-radius:10px;"
          data-bs-toggle="modal"
          data-bs-target="#modalAddSupplier">
    <i class="bi bi-plus-lg me-2"></i>Thêm nhà cung cấp
  </button>
</div>

<!-- STAT CARDS -->
<div class="row g-3 mb-4">
  <div class="col-md-3">
    <div class="card-box p-3"
         style="border-left:4px solid #0077b6;">
      <div class="d-flex justify-content-between">
        <div>
          <div style="font-size:11px;color:#8a9ab0;
                      text-transform:uppercase;">
            Nhà cung cấp
          </div>
          <div style="font-size:28px;font-weight:500;">
            ${suppliers.size()}
          </div>
        </div>
        <div style="background:#e8f4fd;border-radius:10px;
                    width:44px;height:44px;display:flex;
                    align-items:center;justify-content:center;">
          <i class="bi bi-building"
             style="color:#0077b6;font-size:1.3rem;"></i>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card-box p-3"
         style="border-left:4px solid #28a745;">
      <div class="d-flex justify-content-between">
        <div>
          <div style="font-size:11px;color:#8a9ab0;
                      text-transform:uppercase;">
            Tổng lần nhập
          </div>
          <div style="font-size:28px;font-weight:500;">
            ${inventoryList.size()}
          </div>
        </div>
        <div style="background:#e8f5e9;border-radius:10px;
                    width:44px;height:44px;display:flex;
                    align-items:center;justify-content:center;">
          <i class="bi bi-box-arrow-in-down"
             style="color:#28a745;font-size:1.3rem;"></i>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card-box p-3"
         style="border-left:4px solid #f4a261;">
      <div class="d-flex justify-content-between">
        <div>
          <div style="font-size:11px;color:#8a9ab0;
                      text-transform:uppercase;">
            Sắp hết hàng
          </div>
          <div style="font-size:28px;font-weight:500;
                      color:${lowStockList.size()>0
                              ?'#e63946':'#1a2035'};">
            ${lowStockList.size()}
          </div>
        </div>
        <div style="background:#fff8e6;border-radius:10px;
                    width:44px;height:44px;display:flex;
                    align-items:center;justify-content:center;">
          <i class="bi bi-exclamation-triangle"
             style="color:#f4a261;font-size:1.3rem;"></i>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card-box p-3"
         style="border-left:4px solid #e63946;">
      <div class="d-flex justify-content-between">
        <div>
          <div style="font-size:11px;color:#8a9ab0;
                      text-transform:uppercase;">
            Tổng sản phẩm
          </div>
          <div style="font-size:28px;font-weight:500;">
            ${products.size()}
          </div>
        </div>
        <div style="background:#fef0f0;border-radius:10px;
                    width:44px;height:44px;display:flex;
                    align-items:center;justify-content:center;">
          <i class="bi bi-box-seam"
             style="color:#e63946;font-size:1.3rem;"></i>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- CẢNH BÁO -->
<c:if test="${not empty lowStockList}">
  <div class="card-box p-3 mb-4"
       style="border-left:4px solid #e63946;">
    <div class="d-flex align-items-center gap-2 mb-2">
      <i class="bi bi-exclamation-triangle-fill"
         style="color:#e63946;font-size:1.2rem;"></i>
      <span class="fw-bold" style="color:#e63946;">
        Cảnh báo: Sản phẩm sắp hết hàng!
      </span>
    </div>
    <div class="d-flex flex-wrap gap-2">
      <c:forEach var="low" items="${lowStockList}">
        <span class="low-stock-badge">
          ${low.productName}
          (còn <fmt:formatNumber value="${low.quantity}"
                                  pattern="#.##"/>
          ${low.productUnit})
        </span>
      </c:forEach>
    </div>
  </div>
</c:if>

<!-- TABS -->
<div class="card-box">
  <div class="px-4 pt-3"
       style="border-bottom:1px solid #f0f2f5;">
    <button class="tab-btn active"
            onclick="showTab('tab-suppliers',this)">
      <i class="bi bi-building me-2"></i>
      Nhà cung cấp
      <span class="badge bg-primary ms-1">
        ${suppliers.size()}
      </span>
    </button>
    <button class="tab-btn"
            onclick="showTab('tab-import',this)">
      <i class="bi bi-box-arrow-in-down me-2"></i>
      Nhập hàng vào kho
    </button>
    <button class="tab-btn"
            onclick="showTab('tab-history',this)">
      <i class="bi bi-clock-history me-2"></i>
      Lịch sử nhập
      <span class="badge bg-secondary ms-1">
        ${inventoryList.size()}
      </span>
    </button>
  </div>

  <!-- TAB 1: DANH SÁCH NCC -->
  <div id="tab-suppliers" class="tab-content-panel active">
    <c:choose>
      <c:when test="${empty suppliers}">
        <div class="text-center py-5"
             style="color:#8a9ab0;">
          <i class="bi bi-building"
             style="font-size:3.5rem;color:#dde3ed;"></i>
          <h6 class="mt-3 fw-bold">Chưa có nhà cung cấp</h6>
          <button class="btn btn-primary mt-2"
                  data-bs-toggle="modal"
                  data-bs-target="#modalAddSupplier">
            Thêm ngay
          </button>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th class="ps-4">#</th>
                <th>Nhà cung cấp</th>
                <th>Liên hệ</th>
                <th>Địa chỉ</th>
                <th class="text-center">SP cung cấp</th>
                <th class="text-center">Lần nhập</th>
                <th class="text-center">Tổng đã nhập</th>
                <th class="text-center">Nhập gần nhất</th>
                <th class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="s" items="${suppliers}"
                         varStatus="i">
                <tr>
                  <td class="ps-4 text-muted">${i.count}</td>

                  <td>
                    <div class="d-flex align-items-center gap-2">
                      <div class="supplier-avatar">
                        ${s.name.substring(0,1)}
                      </div>
                      <div>
                        <div class="fw-bold"
                             style="font-size:14px;">
                          ${s.name}
                        </div>
                        <small style="color:#8a9ab0;">
                          #NCC${s.id}
                        </small>
                      </div>
                    </div>
                  </td>

                  <td>
                    <div style="font-size:13px;">
                      <i class="bi bi-telephone me-1 text-muted"></i>
                      ${not empty s.phone ? s.phone : '—'}
                    </div>
                    <small style="color:#8a9ab0;">
                      <i class="bi bi-envelope me-1"></i>
                      ${not empty s.email ? s.email : '—'}
                    </small>
                  </td>

                  <td style="font-size:13px;color:#4a5568;
                             max-width:160px;">
                    ${not empty s.address ? s.address : '—'}
                  </td>

                  <!-- SP cung cấp -->
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${s.productCount > 0}">
                        <span class="ok-stock-badge">
                          <i class="bi bi-box-seam me-1"></i>
                          ${s.productCount} SP
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span style="color:#9ca3af;
                                     font-size:12px;">
                          Chưa có
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>

                  <!-- Lần nhập -->
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${s.importCount > 0}">
                        <span class="stat-pill"
                              style="background:#e8f4fd;
                                     color:#0077b6;">
                          <i class="bi bi-arrow-down-circle"></i>
                          ${s.importCount} lần
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span style="color:#9ca3af;
                                     font-size:12px;">
                          Chưa nhập
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>

                  <!-- Tổng đã nhập -->
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${s.totalQuantity > 0}">
                        <span class="fw-bold"
                              style="color:#28a745;
                                     font-size:13px;">
                          <fmt:formatNumber
                             value="${s.totalQuantity}"
                             pattern="#.##"/> kg
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span style="color:#9ca3af;">—</span>
                      </c:otherwise>
                    </c:choose>
                  </td>

                  <!-- Nhập gần nhất -->
                  <td class="text-center"
                      style="font-size:12px;color:#6b7280;">
                    <c:choose>
                      <c:when test="${not empty s.lastImportDate}">
                        <i class="bi bi-calendar3 me-1"
                           style="color:#0077b6;"></i>
                        ${s.lastImportDate}
                      </c:when>
                      <c:otherwise>
                        <span style="color:#9ca3af;">—</span>
                      </c:otherwise>
                    </c:choose>
                  </td>

                  <!-- Thao tác -->
                  <td class="text-center">
                    <button class="btn btn-sm btn-outline-primary"
                            style="border-radius:8px;"
                            onclick="editSupplier(
                              ${s.id},'${s.name}',
                              '${s.phone}','${s.email}',
                              '${s.address}')">
                      <i class="bi bi-pencil"></i>
                    </button>
                    <a href="/dyleeseafood/admin/suppliers/delete/${s.id}"
                       class="btn btn-sm btn-outline-danger ms-1"
                       style="border-radius:8px;"
                       onclick="return confirm(
                         'Xóa nhà cung cấp ${s.name}?')">
                      <i class="bi bi-trash"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- TAB 2: NHẬP HÀNG -->
  <div id="tab-import" class="tab-content-panel p-4">
    <div class="row g-4">
      <div class="col-md-5">
        <h6 class="fw-bold mb-3" style="color:#1a2035;">
          <i class="bi bi-box-arrow-in-down text-primary me-2"></i>
          Nhập hàng vào kho
        </h6>
        <form method="post"
              action="/dyleeseafood/admin/inventory/import">
          <div class="mb-3">
            <label class="form-label">
              Sản phẩm <span class="text-danger">*</span>
            </label>
            <select name="productId" class="form-select"
                    id="selectProduct"
                    onchange="updateSupplier()" required>
              <option value="">-- Chọn sản phẩm --</option>
              <c:forEach var="p" items="${products}">
                <option value="${p.id}"
                        data-supplier="${p.supplierId}"
                        data-unit="${p.unit}">
                  ${p.name} (Tồn:
                  <fmt:formatNumber value="${p.stock}"
                                    pattern="#.##"/>
                  ${p.unit})
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">
              Nhà cung cấp <span class="text-danger">*</span>
            </label>
            <select name="supplierId" id="selectSupplier"
                    class="form-select" required>
              <option value="">-- Chọn NCC --</option>
              <c:forEach var="s" items="${suppliers}">
                <option value="${s.id}">${s.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="row g-3 mb-3">
            <div class="col-6">
              <label class="form-label">
                Số lượng <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <input type="number" name="quantity"
                       id="inputQty" class="form-control"
                       placeholder="0" min="0.5"
                       step="0.5" required>
                <span class="input-group-text" id="unitLabel"
                      style="font-size:12px;background:#f7f9fc;">
                  kg
                </span>
              </div>
            </div>
            <div class="col-6">
              <label class="form-label">Giá nhập (đ/đv)</label>
              <input type="number" name="importPrice"
                     class="form-control"
                     placeholder="0" min="0">
            </div>
          </div>
          <div class="mb-4">
            <label class="form-label">Ghi chú</label>
            <input type="text" name="note"
                   class="form-control"
                   placeholder="Nhập hàng tháng 4...">
          </div>
          <button type="submit"
                  class="btn btn-success w-100 py-2"
                  style="border-radius:10px;font-weight:600;">
            <i class="bi bi-box-arrow-in-down me-2"></i>
            Xác nhận nhập hàng
          </button>
        </form>
      </div>

      <!-- Tình trạng tồn kho -->
      <div class="col-md-7">
        <h6 class="fw-bold mb-3" style="color:#1a2035;">
          <i class="bi bi-boxes text-primary me-2"></i>
          Tình trạng tồn kho hiện tại
        </h6>
        <div class="table-responsive">
          <table class="table table-hover mb-0"
                 style="font-size:13px;">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th>Nhà cung cấp</th>
                <th class="text-center">Tồn kho</th>
                <th class="text-center">Trạng thái</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${products}">
                <tr>
                  <td class="fw-bold">${p.name}</td>
                  <td style="color:#8a9ab0;">
                    ${not empty p.supplierName
                      ? p.supplierName : '—'}
                  </td>
                  <td class="text-center fw-bold"
                      style="color:#0077b6;">
                    <fmt:formatNumber value="${p.stock}"
                                      pattern="#.##"/>
                    ${p.unit}
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${p.stock < 5}">
                        <span class="low-stock-badge">
                          ⚠️ Sắp hết
                        </span>
                      </c:when>
                      <c:when test="${p.stock < 10}">
                        <span style="background:#fff8e6;
                                     color:#e65100;
                                     border:1px solid #ffe0b2;
                                     font-size:11px;
                                     padding:4px 10px;
                                     border-radius:20px;
                                     font-weight:600;">
                          Ít hàng
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="ok-stock-badge">
                          ✅ Đủ hàng
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty products}">
                <tr>
                  <td colspan="4"
                      class="text-center py-4"
                      style="color:#8a9ab0;">
                    Chưa có sản phẩm nào
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- TAB 3: LỊCH SỬ NHẬP -->
  <div id="tab-history" class="tab-content-panel">
    <c:choose>
      <c:when test="${empty inventoryList}">
        <div class="text-center py-5" style="color:#8a9ab0;">
          <i class="bi bi-clock-history"
             style="font-size:3.5rem;color:#dde3ed;"></i>
          <h6 class="mt-3 fw-bold">
            Chưa có lịch sử nhập hàng
          </h6>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th class="ps-4">#</th>
                <th>Sản phẩm</th>
                <th>Nhà cung cấp</th>
                <th class="text-center">Số lượng nhập</th>
                <th class="text-center">Giá nhập</th>
                <th class="text-center">Thành tiền</th>
                <th>Ghi chú</th>
                <th>Ngày nhập</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="inv" items="${inventoryList}"
                         varStatus="i">
                <tr>
                  <td class="ps-4 text-muted">${i.count}</td>
                  <td class="fw-bold">${inv.productName}</td>
                  <td>
                    <span style="background:#e8f4fd;
                                 color:#0077b6;font-size:12px;
                                 padding:4px 10px;
                                 border-radius:20px;">
                      ${inv.supplierName}
                    </span>
                  </td>
                  <td class="text-center fw-bold"
                      style="color:#28a745;">
                    +<fmt:formatNumber value="${inv.quantity}"
                                       pattern="#.##"/>
                    ${inv.productUnit}
                  </td>
                  <td class="text-center"
                      style="font-size:13px;">
                    <c:choose>
                      <c:when test="${inv.importPrice > 0}">
                        <fmt:formatNumber
                           value="${inv.importPrice}"
                           pattern="#,###"/>đ
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">—</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <!-- Thành tiền -->
                  <td class="text-center fw-bold"
                      style="color:#0077b6;font-size:13px;">
                    <c:choose>
                      <c:when test="${inv.importPrice > 0}">
                        <fmt:formatNumber
                           value="${inv.quantity * inv.importPrice}"
                           pattern="#,###"/>đ
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">—</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td style="font-size:13px;color:#4a5568;">
                    ${not empty inv.note ? inv.note : '—'}
                  </td>
                  <td style="font-size:12px;color:#8a9ab0;
                             white-space:nowrap;">
                    <i class="bi bi-calendar3 me-1"></i>
                    ${inv.lastUpdated}
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

</div>

<!-- MODAL THÊM NCC -->
<div class="modal fade" id="modalAddSupplier" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">
          <i class="bi bi-plus-circle me-2"></i>
          Thêm nhà cung cấp mới
        </h5>
        <button type="button" class="btn-close"
                data-bs-dismiss="modal"></button>
      </div>
      <form method="post"
            action="/dyleeseafood/admin/suppliers/add">
        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label">
              Tên NCC <span class="text-danger">*</span>
            </label>
            <input type="text" name="name"
                   class="form-control"
                   placeholder="Vua Hải Sản Miền Bắc"
                   required>
          </div>
          <div class="row g-3 mb-3">
            <div class="col-6">
              <label class="form-label">Điện thoại</label>
              <input type="text" name="phone"
                     class="form-control"
                     placeholder="0909 123 456">
            </div>
            <div class="col-6">
              <label class="form-label">Email</label>
              <input type="email" name="email"
                     class="form-control"
                     placeholder="ncc@email.com">
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="address"
                   class="form-control"
                   placeholder="TP. Hồ Chí Minh">
          </div>
        </div>
        <div class="modal-footer border-0 px-4 pb-4">
          <button type="button"
                  class="btn btn-outline-secondary"
                  style="border-radius:9px;"
                  data-bs-dismiss="modal">Hủy</button>
          <button type="submit"
                  class="btn btn-primary px-4"
                  style="border-radius:9px;">
            <i class="bi bi-plus-lg me-2"></i>Thêm
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL SỬA NCC -->
<div class="modal fade" id="modalEditSupplier" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">
          <i class="bi bi-pencil me-2"></i>Sửa nhà cung cấp
        </h5>
        <button type="button" class="btn-close"
                data-bs-dismiss="modal"></button>
      </div>
      <form method="post" id="formEditSupplier" action="">
        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label">
              Tên NCC <span class="text-danger">*</span>
            </label>
            <input type="text" name="name" id="editName"
                   class="form-control" required>
          </div>
          <div class="row g-3 mb-3">
            <div class="col-6">
              <label class="form-label">Điện thoại</label>
              <input type="text" name="phone" id="editPhone"
                     class="form-control">
            </div>
            <div class="col-6">
              <label class="form-label">Email</label>
              <input type="email" name="email" id="editEmail"
                     class="form-control">
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="address" id="editAddress"
                   class="form-control">
          </div>
        </div>
        <div class="modal-footer border-0 px-4 pb-4">
          <button type="button"
                  class="btn btn-outline-secondary"
                  style="border-radius:9px;"
                  data-bs-dismiss="modal">Hủy</button>
          <button type="submit"
                  class="btn btn-warning px-4"
                  style="border-radius:9px;">
            <i class="bi bi-check-lg me-2"></i>Lưu
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function showTab(tabId, btn) {
  document.querySelectorAll('.tab-content-panel')
    .forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.tab-btn')
    .forEach(b => b.classList.remove('active'));
  document.getElementById(tabId).classList.add('active');
  btn.classList.add('active');
}
function updateSupplier() {
  var sel = document.getElementById('selectProduct');
  var opt = sel.options[sel.selectedIndex];
  var suppId = opt.getAttribute('data-supplier');
  var unit   = opt.getAttribute('data-unit') || 'kg';
  document.getElementById('unitLabel').textContent = unit;
  var supSel = document.getElementById('selectSupplier');
  for (var i = 0; i < supSel.options.length; i++) {
    if (supSel.options[i].value == suppId) {
      supSel.selectedIndex = i; break;
    }
  }
}
function editSupplier(id, name, phone, email, address) {
  document.getElementById('editName').value    = name;
  document.getElementById('editPhone').value   = phone;
  document.getElementById('editEmail').value   = email;
  document.getElementById('editAddress').value = address;
  document.getElementById('formEditSupplier').action =
    '/dyleeseafood/admin/suppliers/edit/' + id;
  new bootstrap.Modal(
    document.getElementById('modalEditSupplier')).show();
}
</script>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>
