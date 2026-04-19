<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng" scope="request"/>
<%@ include file="layout/sidebar.jsp" %>

<style>
/* ── STATUS TABS ── */
.stabs{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:16px;}
.stab{padding:6px 14px;border-radius:20px;font-size:12px;font-weight:600;
  border:1.5px solid #e5eaf2;background:white;color:#475569;
  text-decoration:none;transition:.15s;display:inline-flex;align-items:center;gap:5px;}
.stab:hover{border-color:#0077b6;color:#0077b6;}
.stab.on{background:#0077b6;border-color:#0077b6;color:white;}
.stab .cnt{border-radius:10px;padding:0 6px;font-size:10px;}
.stab.on .cnt{background:rgba(255,255,255,.25);}
.stab:not(.on) .cnt{background:#f1f5f9;color:#94a3b8;}

/* ── FILTER BAR ── */
.fbar{background:white;border-radius:12px;padding:12px 16px;
  box-shadow:0 1px 6px rgba(2,62,138,.06);border:1px solid #e5eaf2;
  margin-bottom:16px;display:flex;gap:9px;align-items:center;flex-wrap:wrap;}
.sb2{flex:1;min-width:180px;position:relative;}
.sb2 input{width:100%;border:1.5px solid #e5eaf2;border-radius:8px;
  padding:8px 12px 8px 34px;font-size:13px;outline:none;
  background:#f8fafc;transition:.15s;color:#0f172a;}
.sb2 input:focus{border-color:#0077b6;background:white;}
.sb2 i{position:absolute;left:10px;top:50%;transform:translateY(-50%);
  color:#94a3b8;font-size:.88rem;}
.fsel{border:1.5px solid #e5eaf2;border-radius:8px;padding:8px 12px;
  font-size:13px;color:#475569;background:#f8fafc;outline:none;cursor:pointer;}
.fsel:focus{border-color:#0077b6;}
.fbtn{background:#0077b6;color:white;border:none;border-radius:8px;
  padding:8px 16px;font-size:13px;font-weight:600;cursor:pointer;}
.fbtn:hover{background:#023e8a;}
.frst{background:#f1f5f9;color:#475569;border:1.5px solid #e5eaf2;
  border-radius:8px;padding:8px 13px;font-size:13px;cursor:pointer;
  text-decoration:none;display:flex;align-items:center;}

/* ── TABLE ── */
.tc{background:white;border-radius:12px;
  box-shadow:0 1px 6px rgba(2,62,138,.06);
  border:1px solid #e5eaf2;overflow:hidden;}
table.at{width:100%;border-collapse:collapse;}
.at thead tr{background:linear-gradient(135deg,#011f4b 0%,#0077b6 100%);}
.at th{padding:11px 16px;color:rgba(255,255,255,.9);font-size:11px;
  font-weight:700;text-align:left;white-space:nowrap;
  letter-spacing:.05em;text-transform:uppercase;}
.at th.c,.at td.c{text-align:center;}
.at tbody tr{border-bottom:1px solid #f1f5f9;transition:background .1s;}
.at tbody tr:last-child{border:none;}
.at tbody tr:hover{background:#f5f8fc;cursor:pointer;}
.at td{padding:11px 16px;font-size:13px;vertical-align:middle;color:#0f172a;}

/* ── BADGES ── */
.bs{padding:3px 10px;border-radius:20px;font-size:11px;font-weight:700;
  display:inline-block;white-space:nowrap;}
.bs-pend{background:#fef9c3;color:#a16207;}
.bs-conf{background:#e3f2fd;color:#0077b6;}
.bs-ship{background:#f3e8ff;color:#7c3aed;}
.bs-done{background:#f0fdf4;color:#16a34a;}
.bs-cancel{background:#fee2e2;color:#dc2626;}
.bs-refund{background:#f3e8ff;color:#7c3aed;}
.price{color:#0077b6;font-weight:800;}

/* ── STATUS SELECT ── */
.ss{border:1.5px solid #e5eaf2;border-radius:7px;padding:5px 9px;
  font-size:12px;background:#f8fafc;outline:none;cursor:pointer;color:#475569;}
.ss:focus{border-color:#0077b6;}

/* ── ACTION BTN ── */
.ab{width:30px;height:30px;border-radius:7px;border:none;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  font-size:.85rem;transition:all .15s;text-decoration:none;}
.ab-v{background:#f0fdf4;color:#16a34a;}
.ab-v:hover{background:#16a34a;color:white;}

/* ── PAGINATION ── */
.pg{display:flex;align-items:center;justify-content:space-between;
  padding:12px 16px;border-top:1px solid #f1f5f9;flex-wrap:wrap;gap:8px;}
.pg-i{font-size:12px;color:#94a3b8;}
.pg-b{display:flex;gap:4px;}
.pb{width:32px;height:32px;border-radius:7px;border:1.5px solid #e5eaf2;
  background:white;color:#475569;font-size:12px;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  text-decoration:none;transition:.15s;}
.pb:hover{border-color:#0077b6;color:#0077b6;}
.pb.on{background:#0077b6;border-color:#0077b6;color:white;}

.empty{text-align:center;padding:48px 20px;color:#94a3b8;}
.empty i{font-size:3rem;display:block;margin-bottom:12px;opacity:.2;}
</style>



  <div style="padding:24px;">
  <!-- PAGE HEADER -->
  <div class="d-flex align-items-center justify-content-between mb-4">
    <div>
      <h4 class="fw-bold mb-1" style="color:#0f172a;">Quản lý Đơn hàng</h4>
      <small style="color:#94a3b8;">
        <i class="bi bi-house me-1"></i>Admin /
        <span style="color:#0077b6;">Đơn hàng</span>
      </small>
    </div>
    <div class="d-flex gap-2">
      <span class="badge-status bs-pending px-3 py-2">
        <i class="bi bi-clock me-1"></i>${countPending} chờ xử lý
      </span>
    </div>
  </div>

  <!-- STATUS TABS -->
  <div class="stabs">
    <a href="/dyleeseafood/admin/orders"
       class="stab ${empty selectedStatus?'on':''}">
      Tất cả <span class="cnt">${totalOrders}</span>
    </a>
    <a href="/dyleeseafood/admin/orders?status=Pending"
       class="stab ${'Pending'==selectedStatus?'on':''}">
      ⏳ Chờ xác nhận <span class="cnt">${countPending}</span>
    </a>
    <a href="/dyleeseafood/admin/orders?status=Confirmed"
       class="stab ${'Confirmed'==selectedStatus?'on':''}">
      ✅ Đã xác nhận <span class="cnt">${countConfirmed}</span>
    </a>
    <a href="/dyleeseafood/admin/orders?status=Shipping"
       class="stab ${'Shipping'==selectedStatus?'on':''}">
      🚚 Đang giao <span class="cnt">${countShipping}</span>
    </a>
    <a href="/dyleeseafood/admin/orders?status=Delivered"
       class="stab ${'Delivered'==selectedStatus?'on':''}">
      📦 Đã giao <span class="cnt">${countDelivered}</span>
    </a>
    <a href="/dyleeseafood/admin/orders?status=Cancelled"
       class="stab ${'Cancelled'==selectedStatus?'on':''}">
      ❌ Đã hủy
    </a>
    <a href="/dyleeseafood/admin/orders?status=Refunded"
       class="stab ${'Refunded'==selectedStatus?'on':''}">
      💰 Hoàn tiền
    </a>
  </div>

  <!-- FILTER BAR -->
  <form method="get" action="/dyleeseafood/admin/orders" class="fbar">
    <input type="hidden" name="status" value="${selectedStatus}">
    <div class="sb2">
      <i class="bi bi-search"></i>
      <input type="text" name="keyword" value="${keyword}"
             placeholder="Tìm mã đơn, tên khách hàng...">
    </div>
    <input type="date" name="dateFrom" value="${dateFrom}"
           class="fsel" title="Từ ngày">
    <input type="date" name="dateTo"   value="${dateTo}"
           class="fsel" title="Đến ngày">
    <button type="submit" class="fbtn">
      <i class="bi bi-funnel me-1"></i>Lọc
    </button>
    <a href="/dyleeseafood/admin/orders" class="frst" title="Xóa bộ lọc">
      <i class="bi bi-arrow-counterclockwise"></i>
    </a>
  </form>

  <!-- TABLE -->
  <div class="tc">
    <table class="at">
      <thead><tr>
        <th>Mã ĐH</th>
        <th>Khách hàng</th>
        <th class="c">Tổng tiền</th>
        <th class="c">Thanh toán</th>
        <th class="c">Trạng thái</th>
        <th class="c">Ngày đặt</th>
        <th class="c">Cập nhật TT</th>
        <th class="c">Chi tiết</th>
      </tr></thead>
      <tbody>
        <c:choose>
          <c:when test="${empty orders}">
            <tr><td colspan="8">
              <div class="empty">
                <i class="bi bi-bag-x"></i>
                <p class="fw-bold mb-1">Không có đơn hàng</p>
                <small>Thử thay đổi bộ lọc hoặc tab trạng thái</small>
              </div>
            </td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="o" items="${orders}">
              <tr onclick="location.href='/dyleeseafood/admin/orders/${o.id}'">

                <!-- Mã đơn -->
                <td>
                  <a href="/dyleeseafood/admin/orders/${o.id}"
                     style="color:#0077b6;font-weight:700;text-decoration:none;"
                     onclick="event.stopPropagation()">#DL${o.id}</a>
                </td>

                <!-- Khách hàng -->
                <td>
                  <div style="font-weight:600;">${o.customerName}</div>
                  <div style="font-size:11px;color:#94a3b8;">${o.customerPhone}</div>
                </td>

                <!-- Tổng tiền -->
                <td class="c price">
                  <fmt:formatNumber value="${o.total}" pattern="#,###"/>đ
                </td>

                <!-- Thanh toán -->
                <td class="c">
                  <span class="bs ${o.paymentStatus=='Paid'?'bs-done':'bs-cancel'}">
                    ${o.paymentStatus=='Paid'?'💳 Đã TT':'💵 Chưa TT'}
                  </span>
                </td>

                <!-- Trạng thái -->
                <td class="c">
                  <c:choose>
                    <c:when test="${o.status=='Pending'}">
                      <span class="bs bs-pend">⏳ Chờ XN</span>
                    </c:when>
                    <c:when test="${o.status=='Confirmed'}">
                      <span class="bs bs-conf">✅ Xác nhận</span>
                    </c:when>
                    <c:when test="${o.status=='Processing'}">
                      <span class="bs bs-conf">⚙️ Xử lý</span>
                    </c:when>
                    <c:when test="${o.status=='Shipping'}">
                      <span class="bs bs-ship">🚚 Đang giao</span>
                    </c:when>
                    <c:when test="${o.status=='Delivered'}">
                      <span class="bs bs-done">📦 Đã giao</span>
                    </c:when>
                    <c:when test="${o.status=='Refunded'}">
                      <span class="bs bs-refund">💰 Hoàn tiền</span>
                    </c:when>
                    <c:otherwise>
                      <span class="bs bs-cancel">❌ Đã hủy</span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <!-- Ngày đặt -->
                <td class="c" style="font-size:11px;color:#94a3b8;">
                  ${o.orderDate}
                </td>

                <!-- Cập nhật trạng thái -->
                <td class="c" onclick="event.stopPropagation()">
                  <form method="post"
                        action="/dyleeseafood/admin/orders/${o.id}/status">
                    <select class="ss" name="status" onchange="this.form.submit()">
                      <option value="Pending"
                              ${o.status=='Pending'?'selected':''}>⏳ Chờ XN</option>
                      <option value="Confirmed"
                              ${o.status=='Confirmed'?'selected':''}>✅ Xác nhận</option>
                      <option value="Shipping"
                              ${o.status=='Shipping'?'selected':''}>🚚 Đang giao</option>
                      <option value="Delivered"
                              ${o.status=='Delivered'?'selected':''}>📦 Đã giao</option>
                      <option value="Cancelled"
                              ${o.status=='Cancelled'?'selected':''}>❌ Hủy</option>
                      <option value="Refunded"
                              ${o.status=='Refunded'?'selected':''}>💰 Hoàn tiền</option>
                    </select>
                  </form>
                </td>

                <!-- Xem chi tiết -->
                <td class="c" onclick="event.stopPropagation()">
                  <a href="/dyleeseafood/admin/orders/${o.id}"
                     class="ab ab-v" title="Xem chi tiết">
                    <i class="bi bi-eye"></i>
                  </a>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <!-- PAGINATION -->
    <c:if test="${totalPages > 1}">
      <div class="pg">
        <div class="pg-i">
          Trang <strong>${currentPage}</strong> / ${totalPages}
          &nbsp;·&nbsp; ${totalOrders} đơn hàng
        </div>
        <div class="pg-b">
          <c:if test="${currentPage > 1}">
            <a href="?status=${selectedStatus}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&page=${currentPage-1}"
               class="pb"><i class="bi bi-chevron-left"></i></a>
          </c:if>
          <c:forEach begin="1" end="${totalPages}" var="pg">
            <c:if test="${pg >= currentPage-2 && pg <= currentPage+2}">
              <a href="?status=${selectedStatus}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&page=${pg}"
                 class="pb ${currentPage==pg?'on':''}">${pg}</a>
            </c:if>
          </c:forEach>
          <c:if test="${currentPage < totalPages}">
            <a href="?status=${selectedStatus}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&page=${currentPage+1}"
               class="pb"><i class="bi bi-chevron-right"></i></a>
          </c:if>
        </div>
      </div>
    </c:if>
  </div>



  </div><!-- /wrapper -->

<%@ include file="layout/sidebar-end.jsp" %>
