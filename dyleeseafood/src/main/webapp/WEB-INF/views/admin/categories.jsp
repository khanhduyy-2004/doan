<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Danh mục" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .icon-grid {
    display:grid;
    grid-template-columns:repeat(6,1fr);
    gap:6px;
    max-height:260px;
    overflow-y:auto;
    padding-right:4px;
  }
  .icon-grid::-webkit-scrollbar { width:4px; }
  .icon-grid::-webkit-scrollbar-track { background:#f0f2f5; border-radius:2px; }
  .icon-grid::-webkit-scrollbar-thumb { background:#b0c4de; border-radius:2px; }
  .icon-item {
    text-align:center; padding:8px 4px;
    border:2px solid #f0f2f5;
    border-radius:8px; cursor:pointer;
    transition:0.15s; background:white;
  }
  .icon-item:hover { border-color:#0077b6; background:#e8f4fd; }
  .icon-item.selected { border-color:#0077b6; background:#bbdefb; }
  .icon-item i { font-size:1.3rem; color:#0077b6; display:block; margin-bottom:2px; }
  .icon-item small { font-size:9px; color:#666; line-height:1.2; display:block; }
  .cat-row:hover { background:#f8f9fa; }
  .preview-box {
    width:44px; height:44px;
    background:#e8f4fd; border-radius:10px;
    display:flex; align-items:center;
    justify-content:center; flex-shrink:0;
  }
</style>

<!-- Header -->
<div class="d-flex justify-content-between align-items-center mb-4">
  <div>
    <h4 class="fw-bold mb-0">
      <i class="bi bi-grid-fill text-primary me-2"></i>Quản lý danh mục
    </h4>
    <small class="text-muted">Tổng: ${categories.size()} danh mục</small>
  </div>
  <button class="btn btn-primary" onclick="showAddForm()">
    <i class="bi bi-plus-circle me-2"></i>Thêm danh mục
  </button>
</div>

<c:if test="${not empty success}">
  <div class="alert alert-success alert-dismissible fade show" style="border-radius:10px;">
    <i class="bi bi-check-circle me-2"></i>${success}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<div class="row g-3">

  <!-- BẢNG DANH MỤC -->
  <div class="col-md-7">
    <div class="card border-0 shadow-sm" style="border-radius:12px;">
      <div class="card-body p-0">
        <table class="table mb-0">
          <thead style="background:#f8f9fa;">
            <tr>
              <th class="ps-4" style="width:50px;">#</th>
              <th style="width:70px;">Icon</th>
              <th>Tên danh mục</th>
              <th>Mô tả</th>
              <th style="width:80px;">Thứ tự</th>
              <th class="text-center" style="width:120px;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="cat" items="${categories}" varStatus="i">
              <tr class="cat-row">
                <td class="ps-4 align-middle text-muted">${i.count}</td>
                <td class="align-middle">
                  <div class="preview-box">
                    <i class="bi ${cat.icon} text-primary" style="font-size:1.3rem;"></i>
                  </div>
                </td>
                <td class="align-middle fw-bold">${cat.name}</td>
                <td class="align-middle text-muted" style="font-size:13px;">${cat.description}</td>
                <td class="align-middle text-center">
                  <span class="badge bg-secondary">${cat.sortOrder}</span>
                </td>
                <td class="align-middle text-center">
                  <div class="d-flex gap-1 justify-content-center">
                    <button class="btn btn-sm btn-outline-warning"
                            onclick="editCategory('${cat.id}','${cat.name}','${cat.description}','${cat.icon}','${cat.sortOrder}')">
                      <i class="bi bi-pencil"></i>
                    </button>
                    <a href="/dyleeseafood/admin/categories/delete/${cat.id}"
                       class="btn btn-sm btn-outline-danger"
                       onclick="return confirm('Xóa danh mục ${cat.name}?')">
                      <i class="bi bi-trash"></i>
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty categories}">
              <tr>
                <td colspan="6" class="text-center py-5 text-muted">
                  <i class="bi bi-inbox" style="font-size:3rem;"></i>
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
    <div class="card border-0 shadow-sm" style="border-radius:12px;">
      <div class="card-header bg-white border-0 pt-3 pb-0">
        <h6 class="fw-bold mb-0" id="formTitle">
          <i class="bi bi-plus-circle text-primary me-2"></i>Thêm danh mục mới
        </h6>
      </div>
      <div class="card-body">

        <!-- FORM THÊM -->
        <form id="addForm" method="post" action="/dyleeseafood/admin/categories/add">
          <div class="mb-3">
            <label class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
            <input type="text" name="name" class="form-control" placeholder="vd: Tôm, Cua & Ghẹ..." required>
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">Mô tả</label>
            <input type="text" name="description" class="form-control" placeholder="Mô tả ngắn...">
          </div>
          <input type="hidden" name="sortOrder" value="0">
          <div class="mb-3">
            <label class="form-label fw-bold">Chọn icon</label>
            <!-- Preview -->
            <div class="d-flex align-items-center gap-3 mb-2 p-3 bg-light rounded-3">
              <div class="preview-box">
                <i id="addIconPreview" class="bi bi-fish text-primary" style="font-size:1.5rem;"></i>
              </div>
              <div>
                <div class="fw-bold" style="font-size:13px;">Icon đã chọn</div>
                <small class="text-muted" id="addIconName">bi-fish</small>
              </div>
            </div>
            <input type="hidden" name="icon" id="addIcon" value="bi-fish">
            <!-- Grid 24 icon -->
            <div class="icon-grid" id="addIconGrid">
              <!-- Hải sản chính -->
              <div class="icon-item selected" onclick="selectIcon('add','bi-fish',this)" title="Cá">
                <i class="bi bi-fish"></i><small>Cá</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-tsunami',this)" title="Tôm">
                <i class="bi bi-tsunami"></i><small>Tôm</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-asterisk',this)" title="Cua/Ghẹ">
                <i class="bi bi-asterisk"></i><small>Cua/Ghẹ</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-record-circle-fill',this)" title="Ốc/Ngao">
                <i class="bi bi-record-circle-fill"></i><small>Ốc/Ngao</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-cloud-fill',this)" title="Mực">
                <i class="bi bi-cloud-fill"></i><small>Mực</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-diagram-3-fill',this)" title="Hải sản hỗn hợp">
                <i class="bi bi-diagram-3-fill"></i><small>Hỗn hợp</small>
              </div>
              <!-- Phân loại theo tình trạng -->
              <div class="icon-item" onclick="selectIcon('add','bi-droplet-fill',this)" title="Tươi sống">
                <i class="bi bi-droplet-fill"></i><small>Tươi sống</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-snow3',this)" title="Đông lạnh">
                <i class="bi bi-snow3"></i><small>Đông lạnh</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-sun-fill',this)" title="Hải sản khô">
                <i class="bi bi-sun-fill"></i><small>Hàng khô</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-box-seam',this)" title="Đóng hộp">
                <i class="bi bi-box-seam"></i><small>Đóng hộp</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-fire',this)" title="Chế biến sẵn">
                <i class="bi bi-fire"></i><small>Chế biến</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-tree-fill',this)" title="Rong biển">
                <i class="bi bi-tree-fill"></i><small>Rong biển</small>
              </div>
              <!-- Phân loại đặc biệt -->
              <div class="icon-item" onclick="selectIcon('add','bi-gem',this)" title="Cao cấp">
                <i class="bi bi-gem"></i><small>Cao cấp</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-star-fill',this)" title="Đặc sản">
                <i class="bi bi-star-fill"></i><small>Đặc sản</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-award-fill',this)" title="Chất lượng cao">
                <i class="bi bi-award-fill"></i><small>Chất lượng</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-lightning-fill',this)" title="Hàng Hot">
                <i class="bi bi-lightning-fill"></i><small>Hot</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-heart-fill',this)" title="Yêu thích">
                <i class="bi bi-heart-fill"></i><small>Yêu thích</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-shield-fill-check',this)" title="An toàn">
                <i class="bi bi-shield-fill-check"></i><small>An toàn</small>
              </div>
              <!-- Dịch vụ / Combo -->
              <div class="icon-item" onclick="selectIcon('add','bi-basket-fill',this)" title="Combo">
                <i class="bi bi-basket-fill"></i><small>Combo</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-gift-fill',this)" title="Quà tặng">
                <i class="bi bi-gift-fill"></i><small>Quà tặng</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-bag-fill',this)" title="Mua sắm">
                <i class="bi bi-bag-fill"></i><small>Mua sắm</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-collection-fill',this)" title="Bộ sưu tập">
                <i class="bi bi-collection-fill"></i><small>Bộ sưu tập</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-tag-fill',this)" title="Khuyến mãi">
                <i class="bi bi-tag-fill"></i><small>Khuyến mãi</small>
              </div>
              <div class="icon-item" onclick="selectIcon('add','bi-water',this)" title="Biển">
                <i class="bi bi-water"></i><small>Biển</small>
              </div>
            </div>
          </div>
          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary flex-fill">
              <i class="bi bi-plus-circle me-1"></i>Thêm
            </button>
            <button type="button" class="btn btn-outline-secondary" onclick="resetForm()">
              Đặt lại
            </button>
          </div>
        </form>

        <!-- FORM SỬA -->
        <form id="editForm" method="post" action="" style="display:none;">
          <div class="mb-3">
            <label class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
            <input type="text" name="name" id="editName" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">Mô tả</label>
            <input type="text" name="description" id="editDesc" class="form-control">
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">Thứ tự</label>
            <input type="number" name="sortOrder" id="editSort" class="form-control" min="0">
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">Chọn icon</label>
            <!-- Preview -->
            <div class="d-flex align-items-center gap-3 mb-2 p-3 bg-light rounded-3">
              <div class="preview-box">
                <i id="editIconPreview" class="bi bi-fish text-primary" style="font-size:1.5rem;"></i>
              </div>
              <div>
                <div class="fw-bold" style="font-size:13px;">Icon đã chọn</div>
                <small class="text-muted" id="editIconName">bi-fish</small>
              </div>
            </div>
            <input type="hidden" name="icon" id="editIcon" value="bi-fish">
            <!-- Grid 24 icon (giống form thêm) -->
            <div class="icon-grid" id="editIconGrid">
              <div class="icon-item" onclick="selectIcon('edit','bi-fish',this)" title="Cá">
                <i class="bi bi-fish"></i><small>Cá</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-tsunami',this)" title="Tôm">
                <i class="bi bi-tsunami"></i><small>Tôm</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-asterisk',this)" title="Cua/Ghẹ">
                <i class="bi bi-asterisk"></i><small>Cua/Ghẹ</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-record-circle-fill',this)" title="Ốc/Ngao">
                <i class="bi bi-record-circle-fill"></i><small>Ốc/Ngao</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-cloud-fill',this)" title="Mực">
                <i class="bi bi-cloud-fill"></i><small>Mực</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-diagram-3-fill',this)" title="Hỗn hợp">
                <i class="bi bi-diagram-3-fill"></i><small>Hỗn hợp</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-droplet-fill',this)" title="Tươi sống">
                <i class="bi bi-droplet-fill"></i><small>Tươi sống</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-snow3',this)" title="Đông lạnh">
                <i class="bi bi-snow3"></i><small>Đông lạnh</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-sun-fill',this)" title="Hàng khô">
                <i class="bi bi-sun-fill"></i><small>Hàng khô</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-box-seam',this)" title="Đóng hộp">
                <i class="bi bi-box-seam"></i><small>Đóng hộp</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-fire',this)" title="Chế biến">
                <i class="bi bi-fire"></i><small>Chế biến</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-tree-fill',this)" title="Rong biển">
                <i class="bi bi-tree-fill"></i><small>Rong biển</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-gem',this)" title="Cao cấp">
                <i class="bi bi-gem"></i><small>Cao cấp</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-star-fill',this)" title="Đặc sản">
                <i class="bi bi-star-fill"></i><small>Đặc sản</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-award-fill',this)" title="Chất lượng">
                <i class="bi bi-award-fill"></i><small>Chất lượng</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-lightning-fill',this)" title="Hot">
                <i class="bi bi-lightning-fill"></i><small>Hot</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-heart-fill',this)" title="Yêu thích">
                <i class="bi bi-heart-fill"></i><small>Yêu thích</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-shield-fill-check',this)" title="An toàn">
                <i class="bi bi-shield-fill-check"></i><small>An toàn</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-basket-fill',this)" title="Combo">
                <i class="bi bi-basket-fill"></i><small>Combo</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-gift-fill',this)" title="Quà tặng">
                <i class="bi bi-gift-fill"></i><small>Quà tặng</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-bag-fill',this)" title="Mua sắm">
                <i class="bi bi-bag-fill"></i><small>Mua sắm</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-collection-fill',this)" title="Bộ sưu tập">
                <i class="bi bi-collection-fill"></i><small>Bộ sưu tập</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-tag-fill',this)" title="Khuyến mãi">
                <i class="bi bi-tag-fill"></i><small>Khuyến mãi</small>
              </div>
              <div class="icon-item" onclick="selectIcon('edit','bi-water',this)" title="Biển">
                <i class="bi bi-water"></i><small>Biển</small>
              </div>
            </div>
          </div>
          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-warning flex-fill">
              <i class="bi bi-save me-1"></i>Cập nhật
            </button>
            <button type="button" class="btn btn-outline-secondary" onclick="showAddForm()">Hủy</button>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>

<script>
// Chọn icon
function selectIcon(formType, iconClass, el) {
  document.getElementById(formType+'Icon').value = iconClass;
  document.getElementById(formType+'IconPreview').className =
    'bi ' + iconClass + ' text-primary';
  document.getElementById(formType+'IconPreview').style.fontSize = '1.5rem';
  document.getElementById(formType+'IconName').textContent = iconClass;
  var gridId = formType === 'add' ? 'addIconGrid' : 'editIconGrid';
  document.querySelectorAll('#' + gridId + ' .icon-item')
    .forEach(function(i){ i.classList.remove('selected'); });
  el.classList.add('selected');
}

// Hiện form thêm
function showAddForm() {
  document.getElementById('addForm').style.display = 'block';
  document.getElementById('editForm').style.display = 'none';
  document.getElementById('formTitle').innerHTML =
    '<i class="bi bi-plus-circle text-primary me-2"></i>Thêm danh mục mới';
}

// Hiện form sửa + điền data
function editCategory(id, name, desc, icon, sort) {
  document.getElementById('addForm').style.display = 'none';
  document.getElementById('editForm').style.display = 'block';
  document.getElementById('formTitle').innerHTML =
    '<i class="bi bi-pencil text-warning me-2"></i>Sửa: ' + name;
  document.getElementById('editName').value  = name;
  document.getElementById('editDesc').value  = desc;
  document.getElementById('editSort').value  = sort;
  document.getElementById('editIcon').value  = icon;
  document.getElementById('editIconPreview').className =
    'bi ' + icon + ' text-primary';
  document.getElementById('editIconPreview').style.fontSize = '1.5rem';
  document.getElementById('editIconName').textContent = icon;
  document.getElementById('editForm').action =
    '/dyleeseafood/admin/categories/edit/' + id;

  // Highlight icon đang chọn trong grid sửa
  document.querySelectorAll('#editIconGrid .icon-item')
    .forEach(function(item) {
      item.classList.remove('selected');
      var itemIcon = item.getAttribute('onclick');
      if (itemIcon && itemIcon.indexOf("'" + icon + "'") !== -1) {
        item.classList.add('selected');
      }
    });

  window.scrollTo(0, 0);
}

// Reset form thêm
function resetForm() {
  document.getElementById('addForm').reset();
  document.getElementById('addIcon').value = 'bi-fish';
  document.getElementById('addIconPreview').className =
    'bi bi-fish text-primary';
  document.getElementById('addIconPreview').style.fontSize = '1.5rem';
  document.getElementById('addIconName').textContent = 'bi-fish';
  document.querySelectorAll('#addIconGrid .icon-item')
    .forEach(function(i){ i.classList.remove('selected'); });
  document.querySelector('#addIconGrid .icon-item')
    .classList.add('selected');
}
</script>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>
