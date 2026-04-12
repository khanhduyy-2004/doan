<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Danh mục" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .icon-grid {
    display:grid; grid-template-columns:repeat(6,1fr); gap:8px;
  }
  .icon-item {
    text-align:center; padding:10px 6px;
    border:2px solid transparent;
    border-radius:8px; cursor:pointer; transition:0.15s;
  }
  .icon-item:hover { border-color:#0077b6; background:#e3f2fd; }
  .icon-item.selected { border-color:#0077b6; background:#bbdefb; }
  .icon-item i { font-size:1.4rem; color:#0077b6; display:block; }
  .icon-item small { font-size:10px; color:#666; }
  .cat-row:hover { background:#f8f9fa; }
</style>

  <!-- Header -->
  <div class="d-flex justify-content-between
              align-items-center mb-4">
    <div>
      <h4 class="fw-bold mb-0">🗂 Quản lý danh mục</h4>
      <small class="text-muted">
        Tổng: ${categories.size()} danh mục
      </small>
    </div>
    <button class="btn btn-primary"
            onclick="showAddForm()">
      <i class="bi bi-plus-circle"></i> Thêm danh mục
    </button>
  </div>

  <c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show">
      <i class="bi bi-check-circle"></i> ${success}
      <button type="button" class="btn-close"
              data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <div class="row g-3">

    <!-- BẢNG DANH MỤC -->
    <div class="col-md-7">
      <div class="card border-0 shadow-sm"
           style="border-radius:12px;">
        <div class="card-body p-0">
          <table class="table mb-0">
            <thead style="background:#f8f9fa;">
              <tr>
                <th class="ps-4" style="width:50px;">#</th>
                <th style="width:70px;">Icon</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th style="width:80px;">Thứ tự</th>
                <th class="text-center" style="width:120px;">
                  Thao tác
                </th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="cat" items="${categories}"
                         varStatus="i">
                <tr class="cat-row">
                  <td class="ps-4 align-middle text-muted">
                    ${i.count}
                  </td>
                  <td class="align-middle">
                    <div style="width:40px;height:40px;
                                background:#e3f2fd;
                                border-radius:10px;
                                display:flex;align-items:center;
                                justify-content:center;">
                      <i class="bi ${cat.icon} text-primary"
                         style="font-size:1.3rem;"></i>
                    </div>
                  </td>
                  <td class="align-middle fw-bold">
                    ${cat.name}
                  </td>
                  <td class="align-middle text-muted"
                      style="font-size:13px;">
                    ${cat.description}
                  </td>
                  <td class="align-middle text-center">
                    <span class="badge bg-secondary">
                      ${cat.sortOrder}
                    </span>
                  </td>
                  <td class="align-middle text-center">
                    <div class="d-flex gap-1 justify-content-center">
                      <button class="btn btn-sm btn-outline-warning"
                              onclick="editCategory(
                                '${cat.id}','${cat.name}',
                                '${cat.description}',
                                '${cat.icon}','${cat.sortOrder}')">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <a href="/dyleeseafood/admin/categories/delete/${cat.id}"
                         class="btn btn-sm btn-outline-danger"
                         onclick="return confirm(
                           'Xóa danh mục ${cat.name}?')">
                        <i class="bi bi-trash"></i>
                      </a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty categories}">
                <tr>
                  <td colspan="6"
                      class="text-center py-5 text-muted">
                    <i class="bi bi-inbox"
                       style="font-size:3rem;"></i>
                    <p class="mt-2 mb-0">Chưa có danh mục nào</p>
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- FORM THÊM / SỬA -->
    <div class="col-md-5">
      <div class="card border-0 shadow-sm"
           style="border-radius:12px;">
        <div class="card-header bg-white border-0 pt-3">
          <h6 class="fw-bold mb-0" id="formTitle">
            ➕ Thêm danh mục mới
          </h6>
        </div>
        <div class="card-body">

          <!-- Form thêm -->
          <form id="addForm" method="post"
                action="/dyleeseafood/admin/categories/add">
            <div class="mb-3">
              <label class="form-label fw-bold">
                Tên danh mục *
              </label>
              <input type="text" name="name"
                     class="form-control"
                     placeholder="vd: Tôm, Cua & Ghẹ..."
                     required>
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Mô tả</label>
              <input type="text" name="description"
                     class="form-control"
                     placeholder="Mô tả ngắn...">
            </div>
            <input type="hidden" name="sortOrder" value="0">
            <div class="mb-3">
              <label class="form-label fw-bold">Chọn icon</label>
              <div class="d-flex align-items-center gap-3 mb-2
                          p-3 bg-light rounded-3">
                <div style="width:44px;height:44px;
                            background:#e3f2fd;border-radius:10px;
                            display:flex;align-items:center;
                            justify-content:center;">
                  <i id="addIconPreview"
                     class="bi bi-fish text-primary"
                     style="font-size:1.5rem;"></i>
                </div>
                <div>
                  <div class="fw-bold" style="font-size:13px;">
                    Icon đã chọn
                  </div>
                  <small class="text-muted"
                         id="addIconName">bi-fish</small>
                </div>
              </div>
              <input type="hidden" name="icon"
                     id="addIcon" value="bi-fish">
              <div class="icon-grid">
                <div class="icon-item selected"
                     onclick="selectIcon('add','bi-fish',this)">
                  <i class="bi bi-fish"></i><small>Cá</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-bug-fill',this)">
                  <i class="bi bi-bug-fill"></i><small>Tôm</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-award-fill',this)">
                  <i class="bi bi-award-fill"></i><small>Cua</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-circle-fill',this)">
                  <i class="bi bi-circle-fill"></i><small>Ốc</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-water',this)">
                  <i class="bi bi-water"></i><small>Biển</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-star-fill',this)">
                  <i class="bi bi-star-fill"></i><small>Đặc sản</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-droplet-fill',this)">
                  <i class="bi bi-droplet-fill"></i><small>Mực</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-box-seam',this)">
                  <i class="bi bi-box-seam"></i><small>Khô</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-gift-fill',this)">
                  <i class="bi bi-gift-fill"></i><small>Quà</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-basket-fill',this)">
                  <i class="bi bi-basket-fill"></i><small>Combo</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-lightning-fill',this)">
                  <i class="bi bi-lightning-fill"></i><small>Hot</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('add','bi-heart-fill',this)">
                  <i class="bi bi-heart-fill"></i><small>Yêu thích</small>
                </div>
              </div>
            </div>
            <div class="d-flex gap-2">
              <button type="submit"
                      class="btn btn-primary flex-fill">
                <i class="bi bi-plus-circle"></i> Thêm
              </button>
              <button type="button"
                      class="btn btn-outline-secondary"
                      onclick="resetForm()">Đặt lại</button>
            </div>
          </form>

          <!-- Form sửa -->
          <form id="editForm" method="post"
                action="" style="display:none;">
            <div class="mb-3">
              <label class="form-label fw-bold">
                Tên danh mục *
              </label>
              <input type="text" name="name"
                     id="editName"
                     class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Mô tả</label>
              <input type="text" name="description"
                     id="editDesc" class="form-control">
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Thứ tự</label>
              <input type="number" name="sortOrder"
                     id="editSort"
                     class="form-control" min="0">
            </div>
            <div class="mb-3">
              <label class="form-label fw-bold">Chọn icon</label>
              <div class="d-flex align-items-center gap-3 mb-2
                          p-3 bg-light rounded-3">
                <div style="width:44px;height:44px;
                            background:#e3f2fd;border-radius:10px;
                            display:flex;align-items:center;
                            justify-content:center;">
                  <i id="editIconPreview"
                     class="bi bi-fish text-primary"
                     style="font-size:1.5rem;"></i>
                </div>
                <div>
                  <div class="fw-bold" style="font-size:13px;">
                    Icon đã chọn
                  </div>
                  <small class="text-muted"
                         id="editIconName">bi-fish</small>
                </div>
              </div>
              <input type="hidden" name="icon"
                     id="editIcon" value="bi-fish">
              <div class="icon-grid" id="editIconGrid">
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-fish',this)">
                  <i class="bi bi-fish"></i><small>Cá</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-bug-fill',this)">
                  <i class="bi bi-bug-fill"></i><small>Tôm</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-award-fill',this)">
                  <i class="bi bi-award-fill"></i><small>Cua</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-circle-fill',this)">
                  <i class="bi bi-circle-fill"></i><small>Ốc</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-water',this)">
                  <i class="bi bi-water"></i><small>Biển</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-star-fill',this)">
                  <i class="bi bi-star-fill"></i><small>Đặc sản</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-droplet-fill',this)">
                  <i class="bi bi-droplet-fill"></i><small>Mực</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-box-seam',this)">
                  <i class="bi bi-box-seam"></i><small>Khô</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-gift-fill',this)">
                  <i class="bi bi-gift-fill"></i><small>Quà</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-basket-fill',this)">
                  <i class="bi bi-basket-fill"></i><small>Combo</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-lightning-fill',this)">
                  <i class="bi bi-lightning-fill"></i><small>Hot</small>
                </div>
                <div class="icon-item"
                     onclick="selectIcon('edit','bi-heart-fill',this)">
                  <i class="bi bi-heart-fill"></i><small>Yêu thích</small>
                </div>
              </div>
            </div>
            <div class="d-flex gap-2">
              <button type="submit"
                      class="btn btn-warning flex-fill">
                <i class="bi bi-save"></i> Cập nhật
              </button>
              <button type="button"
                      class="btn btn-outline-secondary"
                      onclick="showAddForm()">Hủy</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

<script>
function selectIcon(formType, iconClass, el) {
  document.getElementById(formType+'Icon').value = iconClass;
  document.getElementById(formType+'IconPreview').className =
    'bi '+iconClass+' text-primary';
  document.getElementById(formType+'IconName').textContent = iconClass;
  var grid = formType==='add'
    ? document.querySelectorAll('#addForm .icon-item')
    : document.querySelectorAll('#editIconGrid .icon-item');
  grid.forEach(function(i){ i.classList.remove('selected'); });
  el.classList.add('selected');
}
function showAddForm() {
  document.getElementById('addForm').style.display='block';
  document.getElementById('editForm').style.display='none';
  document.getElementById('formTitle').textContent='➕ Thêm danh mục mới';
}
function editCategory(id,name,desc,icon,sort) {
  document.getElementById('addForm').style.display='none';
  document.getElementById('editForm').style.display='block';
  document.getElementById('formTitle').textContent='✏️ Sửa: '+name;
  document.getElementById('editName').value=name;
  document.getElementById('editDesc').value=desc;
  document.getElementById('editSort').value=sort;
  document.getElementById('editIcon').value=icon;
  document.getElementById('editIconPreview').className=
    'bi '+icon+' text-primary';
  document.getElementById('editIconName').textContent=icon;
  document.getElementById('editForm').action=
    '/dyleeseafood/admin/categories/edit/'+id;
  window.scrollTo(0,0);
}
function resetForm() {
  document.getElementById('addForm').reset();
  document.getElementById('addIcon').value='bi-fish';
  document.getElementById('addIconPreview').className=
    'bi bi-fish text-primary';
  document.getElementById('addIconName').textContent='bi-fish';
  document.querySelectorAll('#addForm .icon-item')
    .forEach(function(i){ i.classList.remove('selected'); });
  document.querySelector('#addForm .icon-item').classList.add('selected');
}
</script>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>