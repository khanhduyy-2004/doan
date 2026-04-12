<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .order-row:hover { background:#f8f9fa; }
</style>

  <div class="d-flex justify-content-between
              align-items-center mb-4">
    <div>
      <h4 class="fw-bold mb-0">
        <i class="bi bi-cart-check text-primary"></i>
        Quản lý đơn hàng
      </h4>
      <small class="text-muted">
        Tổng: ${orders.size()} đơn hàng
      </small>
    </div>
  </div>

  <!-- Thống kê nhanh -->
  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <a href="/dyleeseafood/admin/orders?status=Pending"
         class="text-decoration-none">
        <div class="card border-0 shadow-sm p-3"
             style="border-left:4px solid #ffc107;
                    border-radius:0 12px 12px 0;">
          <div class="d-flex align-items-center gap-3">
            <div style="background:#fff8e1;border-radius:10px;
                        width:44px;height:44px;display:flex;
                        align-items:center;justify-content:center;">
              <i class="bi bi-clock text-warning"
                 style="font-size:1.3rem;"></i>
            </div>
            <div>
              <h4 class="fw-bold mb-0">${countPending}</h4>
              <small class="text-muted">Chờ xác nhận</small>
            </div>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-3">
      <a href="/dyleeseafood/admin/orders?status=Confirmed"
         class="text-decoration-none">
        <div class="card border-0 shadow-sm p-3"
             style="border-left:4px solid #0077b6;
                    border-radius:0 12px 12px 0;">
          <div class="d-flex align-items-center gap-3">
            <div style="background:#e3f2fd;border-radius:10px;
                        width:44px;height:44px;display:flex;
                        align-items:center;justify-content:center;">
              <i class="bi bi-check-circle text-primary"
                 style="font-size:1.3rem;"></i>
            </div>
            <div>
              <h4 class="fw-bold mb-0">${countConfirmed}</h4>
              <small class="text-muted">Đã xác nhận</small>
            </div>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-3">
      <a href="/dyleeseafood/admin/orders?status=Shipping"
         class="text-decoration-none">
        <div class="card border-0 shadow-sm p-3"
             style="border-left:4px solid #17a2b8;
                    border-radius:0 12px 12px 0;">
          <div class="d-flex align-items-center gap-3">
            <div style="background:#e0f7fa;border-radius:10px;
                        width:44px;height:44px;display:flex;
                        align-items:center;justify-content:center;">
              <i class="bi bi-truck text-info"
                 style="font-size:1.3rem;"></i>
            </div>
            <div>
              <h4 class="fw-bold mb-0">${countShipping}</h4>
              <small class="text-muted">Đang giao</small>
            </div>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-3">
      <a href="/dyleeseafood/admin/orders?status=Delivered"
         class="text-decoration-none">
        <div class="card border-0 shadow-sm p-3"
             style="border-left:4px solid #28a745;
                    border-radius:0 12px 12px 0;">
          <div class="d-flex align-items-center gap-3">
            <div style="background:#e8f5e9;border-radius:10px;
                        width:44px;height:44px;display:flex;
                        align-items:center;justify-content:center;">
              <i class="bi bi-bag-check text-success"
                 style="font-size:1.3rem;"></i>
            </div>
            <div>
              <h4 class="fw-bold mb-0">${countDelivered}</h4>
              <small class="text-muted">Đã giao</small>
            </div>
          </div>
        </div>
      </a>
    </div>
  </div>

  <!-- Bộ lọc -->
  <div class="d-flex gap-2 mb-3 flex-wrap">
    <a href="/dyleeseafood/admin/orders"
       class="btn btn-sm
         ${empty selectedStatus?'btn-dark':'btn-outline-secondary'}">
      Tất cả
    </a>
    <a href="/dyleeseafood/admin/orders?status=Pending"
       class="btn btn-sm
         ${selectedStatus=='Pending'?'btn-warning':'btn-outline-warning'}">
      ⏳ Chờ xác nhận
    </a>
    <a href="/dyleeseafood/admin/orders?status=Confirmed"
       class="btn btn-sm
         ${selectedStatus=='Confirmed'?'btn-primary':'btn-outline-primary'}">
      ✅ Đã xác nhận
    </a>
    <a href="/dyleeseafood/admin/orders?status=Processing"
       class="btn btn-sm
         ${selectedStatus=='Processing'?'btn-info':'btn-outline-info'}">
      ⚙️ Đang xử lý
    </a>
    <a href="/dyleeseafood/admin/orders?status=Shipping"
       class="btn btn-sm
         ${selectedStatus=='Shipping'?'btn-info':'btn-outline-info'}">
      🚚 Đang giao
    </a>
    <a href="/dyleeseafood/admin/orders?status=Delivered"
       class="btn btn-sm
         ${selectedStatus=='Delivered'?'btn-success':'btn-outline-success'}">
      ✔️ Đã giao
    </a>
    <a href="/dyleeseafood/admin/orders?status=Cancelled"
       class="btn btn-sm
         ${selectedStatus=='Cancelled'?'btn-danger':'btn-outline-danger'}">
      ❌ Đã hủy
    </a>
  </div>

  <!-- Bảng đơn hàng -->
  <div class="card border-0 shadow-sm"
       style="border-radius:12px;">
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead style="background:#f8f9fa;">
          <tr>
            <th class="ps-4">Mã đơn</th>
            <th>Khách hàng</th>
            <th>Ngày đặt</th>
            <th>Thanh toán</th>
            <th class="text-end">Tổng tiền</th>
            <th class="text-center">Trạng thái</th>
            <th class="text-center">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="o" items="${orders}">
            <tr class="order-row">
              <td class="ps-4 align-middle">
                <span class="fw-bold text-primary">
                  #DL${o.id}
                </span>
              </td>
              <td class="align-middle">
                <div class="fw-bold">${o.customerName}</div>
                <small class="text-muted">
                  ${o.customerPhone}
                </small>
              </td>
              <td class="align-middle">
                <small>${o.orderDate}</small>
              </td>
              <td class="align-middle">
                <c:choose>
                  <c:when test="${o.paymentMethod=='COD'}">
                    <span class="badge bg-light text-dark border">
                      💵 COD
                    </span>
                  </c:when>
                  <c:when test="${o.paymentMethod=='bank_transfer'}">
                    <span class="badge bg-light text-dark border">
                      🏦 Chuyển khoản
                    </span>
                  </c:when>
                  <c:when test="${o.paymentMethod=='momo'}">
                    <span class="badge bg-light text-dark border">
                      💜 MoMo
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-light text-dark border">
                      📱 ${o.paymentMethod}
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="align-middle text-end fw-bold"
                  style="color:#0077b6;">
                <fmt:formatNumber value="${o.total}"
                                  pattern="#,###"/>đ
              </td>
              <td class="align-middle text-center">
                <c:choose>
                  <c:when test="${o.status=='Pending'}">
                    <span class="badge bg-warning text-dark">
                      ⏳ Chờ xác nhận
                    </span>
                  </c:when>
                  <c:when test="${o.status=='Confirmed'}">
                    <span class="badge bg-primary">
                      ✅ Đã xác nhận
                    </span>
                  </c:when>
                  <c:when test="${o.status=='Processing'}">
                    <span class="badge bg-info">
                      ⚙️ Đang xử lý
                    </span>
                  </c:when>
                  <c:when test="${o.status=='Shipping'}">
                    <span class="badge bg-info">
                      🚚 Đang giao
                    </span>
                  </c:when>
                  <c:when test="${o.status=='Delivered'}">
                    <span class="badge bg-success">
                      ✔️ Đã giao
                    </span>
                  </c:when>
                  <c:when test="${o.status=='Cancelled'}">
                    <span class="badge bg-danger">
                      ❌ Đã hủy
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-secondary">
                      ${o.status}
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="align-middle text-center">
                <a href="/dyleeseafood/admin/orders/${o.id}"
                   class="btn btn-sm btn-outline-primary">
                  <i class="bi bi-eye"></i> Chi tiết
                </a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty orders}">
            <tr>
              <td colspan="7"
                  class="text-center py-5 text-muted">
                <i class="bi bi-inbox"
                   style="font-size:3rem;"></i>
                <p class="mt-2 mb-0">Chưa có đơn hàng nào</p>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>