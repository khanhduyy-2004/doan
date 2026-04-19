<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<%@ include file="layout/sidebar.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
  body { background:#f0f4f8; }
  .main-content { padding:24px; }

  .stat-card {
    border-radius:14px; border:none;
    box-shadow:0 2px 12px rgba(2,62,138,.08);
    transition:transform .2s,box-shadow .2s;
  }
  .stat-card:hover { transform:translateY(-3px); box-shadow:0 6px 20px rgba(2,62,138,.14); }

  .dash-card {
    background:white; border-radius:14px;
    border:1px solid #e8edf5;
    box-shadow:0 1px 8px rgba(2,62,138,.06);
  }
  .dash-head {
    padding:15px 20px; border-bottom:1px solid #f1f5f9;
    display:flex; align-items:center; justify-content:space-between;
  }
  .dash-head h6 { font-size:14px; font-weight:700; color:#0f172a; margin:0; }

  /* Revenue mini cards */
  .rev-card {
    background:white; border-radius:12px;
    border:1px solid #e8edf5;
    box-shadow:0 1px 6px rgba(2,62,138,.06);
    padding:16px 18px;
  }
  .rev-lbl { font-size:11px; font-weight:700; color:#94a3b8;
    text-transform:uppercase; letter-spacing:.05em; }
  .rev-num { font-size:1.3rem; font-weight:800; color:#0f172a;
    line-height:1; margin:6px 0 4px; }
  .rev-sub { font-size:11px; color:#64748b; }
  .trend-up { color:#16a34a; font-weight:700; }
  .trend-dn { color:#dc2626; font-weight:700; }
  .trend-eq { color:#64748b; }

  /* Table */
  .order-row:hover { background:#f5f8fc !important; cursor:pointer; }
  .table thead th {
    font-size:11px; font-weight:700; color:#64748b;
    text-transform:uppercase; letter-spacing:.05em;
    background:#f8fafc; padding:11px 16px;
    border-bottom:1px solid #e8edf5; border-top:none;
  }
  .table tbody td { padding:12px 16px; vertical-align:middle; font-size:13px; }
  .table tbody tr { border-bottom:1px solid #f1f5f9; }
  .table tbody tr:last-child { border:none; }

  /* Badges */
  .badge-status { display:inline-flex; align-items:center;
    padding:4px 10px; border-radius:20px;
    font-size:11px; font-weight:700; white-space:nowrap; }
  .bs-pending   { background:#fef9c3; color:#a16207; }
  .bs-confirmed { background:#e3f2fd; color:#0369a1; }
  .bs-processing{ background:#e0f2fe; color:#0891b2; }
  .bs-shipping  { background:#f3e8ff; color:#7c3aed; }
  .bs-delivered { background:#dcfce7; color:#16a34a; }
  .bs-cancelled { background:#fee2e2; color:#dc2626; }
  .bs-refunded  { background:#f3e8ff; color:#7c3aed; }

  /* Quick buttons */
  .qbtn { border-radius:10px !important; font-size:13px !important;
    font-weight:600 !important; transition:transform .15s,box-shadow .15s !important; }
  .qbtn:hover { transform:translateY(-2px) !important;
    box-shadow:0 4px 12px rgba(0,0,0,.1) !important; }

  /* Category rows */
  .cat-row { display:flex; align-items:center; justify-content:space-between;
    padding:10px 20px; border-bottom:1px solid #f8fafc; transition:background .1s; }
  .cat-row:last-child { border:none; }
  .cat-row:hover { background:#f8fafc; }
  .cat-ic { width:32px; height:32px; border-radius:8px; background:#e3f2fd;
    display:flex; align-items:center; justify-content:center; flex-shrink:0; }
  .cat-cnt { font-size:11px; font-weight:700; background:#f1f5f9;
    color:#475569; padding:3px 10px; border-radius:20px; }

  /* Override Bootstrap */
  .btn { border-radius:9px; }
  .btn-primary { background:#0077b6; border-color:#0077b6; }
  .btn-primary:hover { background:#023e8a; border-color:#023e8a; }
  .btn-outline-primary { color:#0077b6; border-color:#0077b6; }
  .btn-outline-primary:hover { background:#0077b6; }
  .period-btn { background:white;border:1.5px solid #e5eaf2;border-radius:6px;
    padding:4px 10px;font-size:11px;font-weight:600;color:#64748b;cursor:pointer;transition:.15s; }
  .period-btn:hover,.period-btn.on { background:#0077b6;border-color:#0077b6;color:white; }
  .status-legend-row { display:flex;align-items:center;gap:8px;padding:4px 0;font-size:12px; }
  .sl-dot { width:8px;height:8px;border-radius:50%;flex-shrink:0; }
  .sl-label { flex:1;color:#475569; }
  .sl-val { font-weight:700;color:#0f172a; }
  .btn-sm { border-radius:7px !important; }
</style>

<!-- ══ HEADER ══ -->
<div class="d-flex justify-content-between align-items-center mb-4">
  <div>
    <h4 class="fw-bold mb-1" style="color:#0f172a;letter-spacing:-.3px;">Dashboard</h4>
    <small class="text-muted" style="font-size:12px;">
      <i class="bi bi-calendar3 me-1"></i>
      <%= new java.text.SimpleDateFormat("EEEE, dd/MM/yyyy HH:mm",
          new java.util.Locale("vi","VN")).format(new java.util.Date()) %>
    </small>
  </div>
  <div class="d-flex gap-2">
    <a href="/dyleeseafood/admin/products/add" class="btn btn-primary btn-sm px-3">
      <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm
    </a>
    <a href="/dyleeseafood/home" class="btn btn-outline-secondary btn-sm px-3" target="_blank">
      <i class="bi bi-eye me-1"></i>Xem web
    </a>
  </div>
</div>

<!-- ══ STAT CARDS ══ -->
<div class="row g-3 mb-4">
  <div class="col-6 col-md-3">
    <div class="card stat-card p-3"
         style="border-left:4px solid #0077b6;border-radius:0 14px 14px 0 !important;">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <div style="font-size:12px;color:#64748b;font-weight:600;
                      text-transform:uppercase;letter-spacing:.04em;">Sản phẩm</div>
          <h2 class="fw-bold mb-0 mt-2" style="color:#0f172a;">${totalProducts}</h2>
          <small class="text-success" style="font-size:11px;">
            <i class="bi bi-star-fill me-1"></i>${featuredProductsList.size()} nổi bật
          </small>
        </div>
        <div style="background:#e3f2fd;border-radius:11px;width:46px;height:46px;
                    display:flex;align-items:center;justify-content:center;">
          <i class="bi bi-box-seam" style="font-size:1.3rem;color:#0077b6;"></i>
        </div>
      </div>
    </div>
  </div>
  <div class="col-6 col-md-3">
    <div class="card stat-card p-3"
         style="border-left:4px solid #16a34a;border-radius:0 14px 14px 0 !important;">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <div style="font-size:12px;color:#64748b;font-weight:600;
                      text-transform:uppercase;letter-spacing:.04em;">Danh mục</div>
          <h2 class="fw-bold mb-0 mt-2" style="color:#0f172a;">${categories.size()}</h2>
          <small style="font-size:11px;color:#16a34a;">
            <i class="bi bi-check-circle me-1"></i>Đang hoạt động
          </small>
        </div>
        <div style="background:#dcfce7;border-radius:11px;width:46px;height:46px;
                    display:flex;align-items:center;justify-content:center;">
          <i class="bi bi-grid" style="font-size:1.3rem;color:#16a34a;"></i>
        </div>
      </div>
    </div>
  </div>
  <c:if test="${sessionScope.loggedUser.roleId == 1}">
  <div class="col-6 col-md-3">
    <a href="/dyleeseafood/admin/orders" class="text-decoration-none">
      <div class="card stat-card p-3"
           style="border-left:4px solid #f59e0b;border-radius:0 14px 14px 0 !important;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div style="font-size:12px;color:#64748b;font-weight:600;
                        text-transform:uppercase;letter-spacing:.04em;">Đơn hàng</div>
            <h2 class="fw-bold mb-0 mt-2" style="color:#0f172a;">${totalOrders}</h2>
            <small style="font-size:11px;color:#dc2626;">
              <i class="bi bi-clock me-1"></i>${pendingOrders} chờ xử lý
            </small>
          </div>
          <div style="position:relative;background:#fef9c3;border-radius:11px;
                      width:46px;height:46px;display:flex;align-items:center;justify-content:center;">
            <i class="bi bi-bag-check" style="font-size:1.3rem;color:#f59e0b;"></i>
            <c:if test="${pendingOrders > 0}">
              <span class="badge bg-danger"
                    style="position:absolute;top:-5px;right:-5px;font-size:9px;padding:2px 5px;">
                ${pendingOrders}
              </span>
            </c:if>
          </div>
        </div>
      </div>
    </a>
  </div>
  </c:if>
  <div class="col-6 col-md-3">
    <div class="card stat-card p-3"
         style="border-left:4px solid #dc2626;border-radius:0 14px 14px 0 !important;">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <div style="font-size:12px;color:#64748b;font-weight:600;
                      text-transform:uppercase;letter-spacing:.04em;">Doanh thu</div>
          <h2 class="fw-bold mb-0 mt-2" style="color:#0f172a;font-size:1.15rem;">
            <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>đ
          </h2>
          <small style="font-size:11px;color:#64748b;">
            <i class="bi bi-graph-up me-1"></i>Đơn đã giao
          </small>
        </div>
        <div style="background:#fce4ec;border-radius:11px;width:46px;height:46px;
                    display:flex;align-items:center;justify-content:center;">
          <i class="bi bi-cash-stack" style="font-size:1.3rem;color:#dc2626;"></i>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ══ THỐNG KÊ DOANH THU (chỉ Admin) ══ -->
<c:if test="${sessionScope.loggedUser.roleId == 1}">

  <!-- Mini revenue cards -->
  <div class="row g-3 mb-3">
    <div class="col-6 col-md-3">
      <div class="rev-card">
        <div class="rev-lbl"><i class="bi bi-calendar-day me-1"></i>Hôm nay</div>
        <div class="rev-num">
          <fmt:formatNumber value="${todayRevenue != null ? todayRevenue : 0}" pattern="#,###"/>đ
        </div>
        <div class="rev-sub">${todayOrders != null ? todayOrders : 0} đơn hàng</div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="rev-card">
        <div class="rev-lbl"><i class="bi bi-calendar-month me-1"></i>Tháng này</div>
        <div class="rev-num" style="color:#16a34a;">
          <fmt:formatNumber value="${thisMonthRevenue != null ? thisMonthRevenue : 0}" pattern="#,###"/>đ
        </div>
        <div class="rev-sub">${thisMonthOrders != null ? thisMonthOrders : 0} đơn hàng</div>
        <div class="mt-1" style="font-size:11px;">
          <c:choose>
            <c:when test="${thisMonthRevenue > lastMonthRevenue}">
              <span class="trend-up">↑ Tăng so với tháng trước</span>
            </c:when>
            <c:when test="${thisMonthRevenue < lastMonthRevenue}">
              <span class="trend-dn">↓ Giảm so với tháng trước</span>
            </c:when>
            <c:otherwise><span class="trend-eq">→ Bằng tháng trước</span></c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="rev-card">
        <div class="rev-lbl"><i class="bi bi-calendar2 me-1"></i>Tháng trước</div>
        <div class="rev-num" style="color:#f59e0b;">
          <fmt:formatNumber value="${lastMonthRevenue != null ? lastMonthRevenue : 0}" pattern="#,###"/>đ
        </div>
        <div class="rev-sub">${lastMonthOrders != null ? lastMonthOrders : 0} đơn hàng</div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="rev-card">
        <div class="rev-lbl"><i class="bi bi-hourglass-split me-1"></i>Đang xử lý</div>
        <div class="rev-num" style="color:#7c3aed;">
          ${(pendingOrders + confirmedOrders + shippingOrders)}
        </div>
        <div class="rev-sub" style="line-height:1.8;">
          <span style="color:#a16207;">⏳${pendingOrders}</span> ·
          <span style="color:#0369a1;">✅${confirmedOrders}</span> ·
          <span style="color:#7c3aed;">🚚${shippingOrders}</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Biểu đồ doanh thu nâng cấp -->
  <div class="row g-3 mb-3">
    <div class="col-md-8">
      <div class="dash-card h-100">
        <div class="dash-head">
          <h6><i class="bi bi-bar-chart-line me-2" style="color:#0077b6;"></i>Doanh thu theo tháng</h6>
          <div class="d-flex gap-2 align-items-center">
            <button class="period-btn on" onclick="setPeriod(12,this)">12 tháng</button>
            <button class="period-btn"   onclick="setPeriod(6,this)">6 tháng</button>
            <button class="period-btn"   onclick="setPeriod(3,this)">3 tháng</button>
          </div>
        </div>
        <!-- Summary strip -->
        <div style="display:flex;gap:0;border-bottom:1px solid #f1f5f9;">
          <div id="stripRevenue" style="flex:1;padding:12px 20px;border-right:1px solid #f1f5f9;">
            <div style="font-size:10px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:.06em;">Tổng doanh thu</div>
            <div id="stripRevVal" style="font-size:17px;font-weight:800;color:#0077b6;margin-top:2px;">—</div>
          </div>
          <div style="flex:1;padding:12px 20px;border-right:1px solid #f1f5f9;">
            <div style="font-size:10px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:.06em;">Tổng đơn</div>
            <div id="stripOrdVal" style="font-size:17px;font-weight:800;color:#16a34a;margin-top:2px;">—</div>
          </div>
          <div style="flex:1;padding:12px 20px;">
            <div style="font-size:10px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:.06em;">TB / đơn</div>
            <div id="stripAvgVal" style="font-size:17px;font-weight:800;color:#7c3aed;margin-top:2px;">—</div>
          </div>
        </div>
        <div style="padding:16px 20px 20px;position:relative;height:240px;">
          <canvas id="revenueChart"></canvas>
        </div>
        <!-- Legend -->
        <div style="padding:0 20px 14px;display:flex;gap:16px;">
          <span style="display:flex;align-items:center;gap:6px;font-size:12px;color:#64748b;">
            <span style="width:14px;height:14px;background:#0077b6;border-radius:4px;display:inline-block;"></span>Doanh thu
          </span>
          <span style="display:flex;align-items:center;gap:6px;font-size:12px;color:#64748b;">
            <span style="width:18px;height:3px;background:#16a34a;border-radius:2px;display:inline-block;"></span>Số đơn
          </span>
        </div>
      </div>
    </div>

    <!-- Biểu đồ tròn trạng thái đơn -->
    <div class="col-md-4">
      <div class="dash-card h-100">
        <div class="dash-head">
          <h6><i class="bi bi-pie-chart me-2" style="color:#7c3aed;"></i>Trạng thái đơn hàng</h6>
        </div>
        <div style="padding:12px 20px;position:relative;height:200px;">
          <canvas id="statusChart"></canvas>
        </div>
        <div style="padding:0 20px 16px;">
          <div class="status-legend-row">
            <span class="sl-dot" style="background:#f59e0b;"></span>
            <span class="sl-label">Chờ xác nhận</span>
            <span class="sl-val">${pendingOrders}</span>
          </div>
          <div class="status-legend-row">
            <span class="sl-dot" style="background:#0077b6;"></span>
            <span class="sl-label">Đã xác nhận</span>
            <span class="sl-val">${confirmedOrders}</span>
          </div>
          <div class="status-legend-row">
            <span class="sl-dot" style="background:#7c3aed;"></span>
            <span class="sl-label">Đang giao</span>
            <span class="sl-val">${shippingOrders}</span>
          </div>
          <div class="status-legend-row">
            <span class="sl-dot" style="background:#16a34a;"></span>
            <span class="sl-label">Đã giao</span>
            <span class="sl-val">${deliveredOrders}</span>
          </div>
        </div>
      </div>
    </div>
  </div>

</c:if><!-- end admin revenue section -->

<!-- ══ BIỂU ĐỒ + TRUY CẬP NHANH ══ -->
<div class="row g-3 mb-3">
  <div class="col-md-7">
    <div class="dash-card h-100">
      <div class="dash-head"><h6><i class="bi bi-lightning me-2" style="color:#f59e0b;"></i>Truy cập nhanh</h6></div>
      <div style="padding:16px;">
        <div class="row g-2">
          <div class="col-6">
            <a href="/dyleeseafood/admin/products/add" class="btn btn-primary w-100 py-3 text-start qbtn">
              <i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm
            </a>
          </div>
          <div class="col-6">
            <a href="/dyleeseafood/admin/products" class="btn btn-outline-primary w-100 py-3 text-start qbtn">
              <i class="bi bi-box-seam me-2"></i>Quản lý sản phẩm
            </a>
          </div>
          <c:if test="${sessionScope.loggedUser.roleId == 1}">
            <div class="col-6">
              <a href="/dyleeseafood/admin/categories" class="btn btn-outline-success w-100 py-3 text-start qbtn">
                <i class="bi bi-grid me-2"></i>Quản lý danh mục
              </a>
            </div>
            <div class="col-6">
              <a href="/dyleeseafood/admin/orders"
                 class="btn btn-outline-warning w-100 py-3 text-start position-relative qbtn"
                 style="color:#a16207;">
                <i class="bi bi-bag-check me-2"></i>Quản lý đơn hàng
                <c:if test="${pendingOrders > 0}">
                  <span class="badge bg-danger" style="position:absolute;top:8px;right:8px;">${pendingOrders}</span>
                </c:if>
              </a>
            </div>
          </c:if>
          <div class="col-6">
            <a href="/dyleeseafood/admin/customers"
               class="btn btn-outline-info w-100 py-3 text-start qbtn" style="color:#0e7490;">
              <i class="bi bi-people me-2"></i>Quản lý khách hàng
            </a>
          </div>
          <c:if test="${sessionScope.loggedUser.roleId == 1}">
            <div class="col-6">
              <a href="/dyleeseafood/admin/staff" class="btn btn-outline-secondary w-100 py-3 text-start qbtn">
                <i class="bi bi-person-badge me-2"></i>Quản lý nhân viên
              </a>
            </div>
            <div class="col-6">
              <a href="/dyleeseafood/admin/suppliers" class="btn btn-outline-danger w-100 py-3 text-start qbtn">
                <i class="bi bi-truck me-2"></i>NCC &amp; Kho hàng
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-5">
    <div class="dash-card h-100">
      <div class="dash-head">
        <h6><i class="bi bi-grid me-2" style="color:#16a34a;"></i>Danh mục sản phẩm</h6>
        <a href="/dyleeseafood/admin/categories" class="btn btn-sm btn-outline-success">Quản lý</a>
      </div>
      <c:forEach var="cat" items="${categories}">
        <div class="cat-row">
          <div class="d-flex align-items-center gap-2">
            <div class="cat-ic">
              <i class="bi ${cat.icon}" style="color:#0077b6;font-size:.9rem;"></i>
            </div>
            <span style="font-size:13px;font-weight:500;color:#334155;">${cat.name}</span>
          </div>
          <span class="cat-cnt">${cat.productCount != null ? cat.productCount : 0} SP</span>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

<!-- ══ ĐƠN HÀNG GẦN ĐÂY ══ -->
<c:if test="${sessionScope.loggedUser.roleId == 1}">
  <div class="row g-3">
    <div class="col-12">
      <div class="dash-card">
        <div class="dash-head">
          <h6><i class="bi bi-clock-history me-2" style="color:#0077b6;"></i>Đơn hàng gần đây</h6>
          <a href="/dyleeseafood/admin/orders" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
        </div>
        <div style="overflow-x:auto;">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th class="ps-4">Mã đơn</th>
                <th>Khách hàng</th>
                <th>Tổng tiền</th>
                <th class="text-center">Trạng thái</th>
                <th class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="o" items="${recentOrders}">
                <tr class="order-row"
                    onclick="location.href='/dyleeseafood/admin/orders/${o.id}'">
                  <td class="ps-4">
                    <span class="fw-bold" style="color:#0077b6;">#DL${o.id}</span>
                  </td>
                  <td>
                    <div class="fw-bold" style="font-size:13px;">${o.customerName}</div>
                    <small class="text-muted">${o.customerPhone}</small>
                  </td>
                  <td class="fw-bold" style="color:#0077b6;font-size:13px;">
                    <fmt:formatNumber value="${o.total}" pattern="#,###"/>đ
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${o.status=='Pending'}">
                        <span class="badge-status bs-pending">⏳ Chờ xác nhận</span>
                      </c:when>
                      <c:when test="${o.status=='Confirmed'}">
                        <span class="badge-status bs-confirmed">✅ Đã xác nhận</span>
                      </c:when>
                      <c:when test="${o.status=='Processing'}">
                        <span class="badge-status bs-processing">⚙️ Đang xử lý</span>
                      </c:when>
                      <c:when test="${o.status=='Shipping'}">
                        <span class="badge-status bs-shipping">🚚 Đang giao</span>
                      </c:when>
                      <c:when test="${o.status=='Delivered'}">
                        <span class="badge-status bs-delivered">✔️ Đã giao</span>
                      </c:when>
                      <c:when test="${o.status=='Cancelled'}">
                        <span class="badge-status bs-cancelled">❌ Đã hủy</span>
                      </c:when>
                      <c:when test="${o.status=='Refunded'}">
                        <span class="badge-status bs-refunded">💰 Hoàn tiền</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-secondary" style="font-size:11px;">${o.status}</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <a href="/dyleeseafood/admin/orders/${o.id}"
                       class="btn btn-sm btn-outline-primary"
                       onclick="event.stopPropagation()">
                      <i class="bi bi-eye"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty recentOrders}">
                <tr>
                  <td colspan="5" class="text-center py-5 text-muted">
                    <i class="bi bi-inbox" style="font-size:2.5rem;display:block;margin-bottom:8px;opacity:.25;"></i>
                    Chưa có đơn hàng nào
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</c:if>

<script>
/* ══ DỮ LIỆU TỪ SERVER ══ */
var ALL_MONTHS = [], ALL_REV = [], ALL_ORD = [];
<c:forEach var="r" items="${monthlyRevenue}">
  ALL_MONTHS.push('${r.month}');
  ALL_REV.push(${r.revenue != null ? r.revenue : 0});
  ALL_ORD.push(${r.orderCount != null ? r.orderCount : 0});
</c:forEach>

/* Fallback 12 tháng rỗng nếu chưa có dữ liệu */
if (ALL_MONTHS.length === 0) {
  var now = new Date();
  for (var i = 11; i >= 0; i--) {
    var d = new Date(now.getFullYear(), now.getMonth() - i, 1);
    ALL_MONTHS.push((d.getMonth()+1) + '/' + d.getFullYear());
    ALL_REV.push(0); ALL_ORD.push(0);
  }
}

/* ══ BIỂU ĐỒ DOANH THU BAR + LINE ══ */
var revCtx = document.getElementById('revenueChart');
var revenueChart = null;

function fmtMoney(v) {
  if (v >= 1000000) return (v/1000000).toFixed(1) + 'M';
  if (v >= 1000)    return (v/1000).toFixed(0) + 'K';
  return v;
}
function fmtFull(v) {
  return Number(v).toLocaleString('vi-VN') + 'đ';
}

function updateStrip(months, revs, ords) {
  var totRev = revs.reduce(function(a,b){return a+b;},0);
  var totOrd = ords.reduce(function(a,b){return a+b;},0);
  var avg    = totOrd > 0 ? totRev / totOrd : 0;
  document.getElementById('stripRevVal').textContent = fmtFull(Math.round(totRev));
  document.getElementById('stripOrdVal').textContent = totOrd + ' đơn';
  document.getElementById('stripAvgVal').textContent = fmtFull(Math.round(avg));
}

function buildChart(months, revs, ords) {
  if (revenueChart) revenueChart.destroy();
  var c2d = revCtx.getContext('2d');
  var grad = c2d.createLinearGradient(0, 0, 0, 220);
  grad.addColorStop(0, 'rgba(0,119,182,0.88)');
  grad.addColorStop(1, 'rgba(0,119,182,0.18)');

  revenueChart = new Chart(revCtx, {
    type: 'bar',
    data: {
      labels: months,
      datasets: [
        {
          label: 'Doanh thu',
          data: revs,
          backgroundColor: grad,
          borderColor: '#0077b6',
          borderWidth: 0,
          borderRadius: 6,
          borderSkipped: false,
          yAxisID: 'y'
        },
        {
          label: 'Số đơn',
          data: ords,
          type: 'line',
          borderColor: '#16a34a',
          backgroundColor: 'rgba(22,163,74,0.06)',
          borderWidth: 2.5,
          pointRadius: 4,
          pointHoverRadius: 6,
          pointBackgroundColor: '#16a34a',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          tension: 0.45,
          fill: true,
          yAxisID: 'y2'
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      interaction: { mode: 'index', intersect: false },
      animation: { duration: 600, easing: 'easeInOutQuart' },
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: 'rgba(15,23,42,0.92)',
          titleFont: { size: 12, weight: '600' },
          bodyFont: { size: 12 },
          padding: 14,
          cornerRadius: 10,
          callbacks: {
            title: function(items) { return '📅 ' + items[0].label; },
            label: function(c) {
              if (c.datasetIndex === 0)
                return '  💰 Doanh thu: ' + fmtFull(c.raw);
              return '  📦 Số đơn: ' + c.raw + ' đơn';
            }
          }
        }
      },
      scales: {
        x: {
          grid: { display: false },
          ticks: { font: { size: 11 }, color: '#94a3b8', maxRotation: 0 }
        },
        y: {
          position: 'left',
          grid: { color: 'rgba(0,0,0,0.04)', drawBorder: false },
          ticks: {
            font: { size: 10 }, color: '#94a3b8',
            callback: function(v) { return fmtMoney(v); }
          }
        },
        y2: {
          position: 'right',
          grid: { drawOnChartArea: false },
          ticks: { font: { size: 10 }, color: '#16a34a' }
        }
      }
    }
  });
  updateStrip(months, revs, ords);
}

function setPeriod(n, btn) {
  document.querySelectorAll('.period-btn').forEach(function(b){ b.classList.remove('on'); });
  btn.classList.add('on');
  var m = ALL_MONTHS.slice(-n);
  var r = ALL_REV.slice(-n);
  var o = ALL_ORD.slice(-n);
  buildChart(m, r, o);
}

if (revCtx) buildChart(ALL_MONTHS, ALL_REV, ALL_ORD);

/* ══ BIỂU ĐỒ TRÒN TRẠNG THÁI ══ */
var sCtx = document.getElementById('statusChart');
if (sCtx) {
  var pending   = parseInt('${pendingOrders}')   || 0;
  var confirmed = parseInt('${confirmedOrders}') || 0;
  var shipping  = parseInt('${shippingOrders}')  || 0;
  var delivered = parseInt('${deliveredOrders}') || 0;
  var total     = pending + confirmed + shipping + delivered;

  new Chart(sCtx, {
    type: 'doughnut',
    data: {
      labels: ['Chờ XN', 'Đã XN', 'Đang giao', 'Đã giao'],
      datasets: [{
        data: total > 0 ? [pending, confirmed, shipping, delivered] : [1, 0, 0, 0],
        backgroundColor: ['#f59e0b', '#0077b6', '#7c3aed', '#16a34a'],
        borderWidth: 3,
        borderColor: '#fff',
        hoverOffset: 8
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      cutout: '65%',
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: 'rgba(15,23,42,0.9)',
          padding: 12,
          cornerRadius: 8,
          callbacks: {
            label: function(c) {
              var pct = total > 0 ? ((c.raw/total)*100).toFixed(1) : 0;
              return '  ' + c.label + ': ' + c.raw + ' (' + pct + '%)';
            }
          }
        }
      }
    },
    plugins: [{
      id: 'centerText',
      afterDraw: function(chart) {
        var ctx2 = chart.ctx;
        var cx = chart.chartArea.left + (chart.chartArea.right - chart.chartArea.left) / 2;
        var cy = chart.chartArea.top  + (chart.chartArea.bottom - chart.chartArea.top) / 2;
        ctx2.save();
        ctx2.textAlign = 'center';
        ctx2.textBaseline = 'middle';
        ctx2.font = 'bold 22px sans-serif';
        ctx2.fillStyle = '#0f172a';
        ctx2.fillText(total, cx, cy - 8);
        ctx2.font = '11px sans-serif';
        ctx2.fillStyle = '#94a3b8';
        ctx2.fillText('đơn', cx, cy + 12);
        ctx2.restore();
      }
    }]
  });
}
</script>

<%@ include file="layout/sidebar-end.jsp" %>
