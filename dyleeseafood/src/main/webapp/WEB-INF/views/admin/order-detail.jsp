<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chi tiết đơn hàng — Dylee Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    /* ── TOKENS ── */
    :root{--p:#0077b6;--dk:#023e8a;--dkr:#011f4b;--ac:#ffc107;--bg:#eef2f7;--bd:#e5eaf2;--tx:#0f172a;--tx2:#475569;--tx3:#94a3b8;}

    body { background:var(--bg); }

    /* ── SIDEBAR ── */
    .sidebar{background:linear-gradient(180deg,var(--dkr) 0%,var(--dk) 55%,#0353a4 100%);min-height:100vh;width:240px;position:fixed;top:0;left:0;z-index:100;box-shadow:4px 0 18px rgba(2,62,138,.2);}
    .sidebar-brand{padding:20px 18px 16px;border-bottom:1px solid rgba(255,255,255,.1);margin-bottom:8px;}
    .sidebar-brand .lw{width:40px;height:40px;border-radius:10px;background:rgba(255,193,7,.18);display:flex;align-items:center;justify-content:center;font-size:1.4rem;margin-bottom:8px;}
    .sidebar-brand span{color:var(--ac);font-weight:800;font-size:15px;}
    .sidebar-brand small{display:block;color:rgba(255,255,255,.4);font-size:11px;margin-top:2px;}
    .ngl{padding:8px 18px 3px;font-size:10px;font-weight:700;color:rgba(255,255,255,.3);text-transform:uppercase;letter-spacing:.08em;}
    .ni{display:flex;align-items:center;gap:9px;padding:9px 18px;color:rgba(255,255,255,.65);text-decoration:none;font-size:13px;font-weight:500;transition:all .15s;border-left:2.5px solid transparent;margin:1px 8px 1px 0;border-radius:0 7px 7px 0;}
    .ni:hover{background:rgba(255,255,255,.09);color:white;border-left-color:rgba(255,255,255,.25);}
    .ni.on{background:rgba(0,119,182,.28);color:white;border-left-color:var(--ac);font-weight:600;}
    .ni.red{color:rgba(255,120,120,.85)!important;}.ni.red:hover{background:rgba(248,81,73,.1);}
    .ni i{font-size:.92rem;width:17px;text-align:center;}
    .sidebar hr{border-color:rgba(255,255,255,.12);margin:6px 16px;}

    /* ── MAIN ── */
    .main-content{margin-left:240px;padding:24px;min-height:100vh;}

    /* ── PAGE HEADER ── */
    .back-btn{background:#f1f5f9;color:var(--tx2);border:1.5px solid var(--bd);border-radius:8px;padding:7px 14px;font-size:13px;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:6px;transition:.15s;}
    .back-btn:hover{border-color:var(--p);color:var(--p);}

    /* ── CARDS ── */
    .acard{background:white;border-radius:14px;border:1px solid var(--bd);box-shadow:0 1px 8px rgba(2,62,138,.07);}
    .acard-header{padding:14px 20px;border-bottom:1px solid #f1f5f9;font-size:14px;font-weight:700;color:var(--tx);}
    .acard-body{padding:20px;}
    .acard-footer{padding:14px 20px;border-top:1px solid #f1f5f9;background:#fafbfc;border-radius:0 0 14px 14px;}

    /* ── TIMELINE ── */
    .step-node{width:38px;height:38px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;border:2.5px solid transparent;}
    .step-node.done{background:var(--p);color:white;border-color:var(--p);}
    .step-node.current{background:var(--ac);color:#333;border-color:var(--ac);box-shadow:0 0 0 4px rgba(255,193,7,.25);}
    .step-node.todo{background:#f1f5f9;color:var(--tx3);border-color:var(--bd);}
    .step-line{flex:1;height:3px;border-radius:2px;}
    .step-line.done{background:var(--p);}
    .step-line.todo{background:var(--bd);}
    .step-lbl{font-size:11px;color:var(--tx3);margin-top:5px;font-weight:500;}
    .step-lbl.active-lbl{color:var(--p);font-weight:700;}

    /* ── ACTION BUTTONS ── */
    .btn-primary{background:var(--p);border-color:var(--p);border-radius:8px;}
    .btn-primary:hover{background:var(--dk);border-color:var(--dk);}
    .btn-success{border-radius:8px;}.btn-info{border-radius:8px;}
    .btn-danger{border-radius:8px;}.btn-outline-secondary{border-radius:8px;}

    /* ── ORDER ITEM ROW ── */
    .order-item{display:flex;align-items:center;gap:14px;padding:14px 20px;border-bottom:1px solid #f8fafc;}
    .order-item:last-child{border:none;}
    .order-item img{width:62px;height:62px;object-fit:cover;border-radius:10px;border:1px solid var(--bd);flex-shrink:0;}
    .item-name{font-weight:700;color:var(--tx);font-size:14px;}
    .item-meta{font-size:12px;color:var(--tx3);margin-top:2px;}
    .item-price{font-weight:800;color:var(--p);white-space:nowrap;}

    /* ── INFO ROWS ── */
    .info-lbl{font-size:11px;color:var(--tx3);font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin-bottom:2px;}
    .info-val{font-size:14px;font-weight:600;color:var(--tx);}

    /* ── STATUS BOX ── */
    .status-box{text-align:center;padding:24px 16px;}
    .status-icon{font-size:2.8rem;display:block;margin-bottom:8px;}
    .status-label{font-size:15px;font-weight:800;}
    .bs-refunded{background:#f3e8ff;color:#7c3aed;}
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
  <div class="sidebar-brand">
    <div class="lw">🐟</div>
    <span>DyleeAdmin</span>
    <small>${sessionScope.loggedUser.roleId==1?'Quản trị viên':'Nhân viên'}</small>
  </div>
  <div class="ngl">Tổng quan</div>
  <a href="/dyleeseafood/admin/dashboard" class="ni"><i class="bi bi-speedometer2"></i>Dashboard</a>
  <div class="ngl">Hàng hoá</div>
  <a href="/dyleeseafood/admin/products"   class="ni"><i class="bi bi-fish"></i>Sản phẩm</a>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/categories" class="ni"><i class="bi bi-grid"></i>Danh mục</a>
  </c:if>
  <div class="ngl">Bán hàng</div>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/orders"    class="ni on"><i class="bi bi-bag-check"></i>Đơn hàng</a>
  </c:if>
  <a href="/dyleeseafood/admin/customers"  class="ni"><i class="bi bi-people"></i>Khách hàng</a>
  <div class="ngl">Hệ thống</div>
  <c:if test="${sessionScope.loggedUser.roleId==1}">
    <a href="/dyleeseafood/admin/staff"     class="ni"><i class="bi bi-person-badge"></i>Nhân viên</a>
    <a href="/dyleeseafood/admin/suppliers" class="ni"><i class="bi bi-truck"></i>Nhà cung cấp</a>
  </c:if>
  <hr/>
  <a href="/dyleeseafood/home"   class="ni"><i class="bi bi-house"></i>Về trang chủ</a>
  <a href="/dyleeseafood/logout" class="ni red"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a>
</div>

<!-- MAIN -->
<div class="main-content">

  <!-- Header -->
  <div class="d-flex align-items-center gap-3 mb-4">
    <a href="/dyleeseafood/admin/orders" class="back-btn">
      <i class="bi bi-arrow-left"></i> Quay lại
    </a>
    <div>
      <h4 class="fw-bold mb-0" style="color:var(--tx);">
        Chi tiết đơn hàng <span style="color:var(--p);">#DL${order.id}</span>
      </h4>
      <small class="text-muted"><i class="bi bi-calendar3 me-1"></i>${order.orderDate}</small>
    </div>
  </div>

  <!-- TIMELINE TRẠNG THÁI -->
  <div class="acard mb-3">
    <div class="acard-header"><i class="bi bi-diagram-3 me-2" style="color:var(--p);"></i>Trạng thái đơn hàng</div>
    <div class="acard-body">
      <div class="d-flex align-items-center mb-4">
        <!-- Đặt hàng -->
        <div class="text-center" style="min-width:80px;">
          <div class="step-node done mx-auto"><i class="bi bi-receipt"></i></div>
          <div class="step-lbl active-lbl">Đặt hàng</div>
        </div>
        <div class="step-line ${order.status=='Confirmed'||order.status=='Processing'||order.status=='Shipping'||order.status=='Delivered'?'done':'todo'}"></div>
        <!-- Xác nhận -->
        <div class="text-center" style="min-width:80px;">
          <div class="step-node ${order.status=='Confirmed'||order.status=='Processing'||order.status=='Shipping'||order.status=='Delivered'?'done':order.status=='Pending'?'current':'todo'} mx-auto">
            <i class="bi bi-check"></i>
          </div>
          <div class="step-lbl ${order.status=='Pending'?'active-lbl':''}">Xác nhận</div>
        </div>
        <div class="step-line ${order.status=='Processing'||order.status=='Shipping'||order.status=='Delivered'?'done':'todo'}"></div>
        <!-- Xử lý -->
        <div class="text-center" style="min-width:80px;">
          <div class="step-node ${order.status=='Processing'||order.status=='Shipping'||order.status=='Delivered'?'done':order.status=='Confirmed'?'current':'todo'} mx-auto">
            <i class="bi bi-gear"></i>
          </div>
          <div class="step-lbl ${order.status=='Confirmed'?'active-lbl':''}">Xử lý</div>
        </div>
        <div class="step-line ${order.status=='Shipping'||order.status=='Delivered'?'done':'todo'}"></div>
        <!-- Đang giao -->
        <div class="text-center" style="min-width:80px;">
          <div class="step-node ${order.status=='Shipping'||order.status=='Delivered'?'done':order.status=='Processing'?'current':'todo'} mx-auto">
            <i class="bi bi-truck"></i>
          </div>
          <div class="step-lbl ${order.status=='Processing'?'active-lbl':''}">Đang giao</div>
        </div>
        <div class="step-line ${order.status=='Delivered'?'done':'todo'}"></div>
        <!-- Hoàn thành -->
        <div class="text-center" style="min-width:80px;">
          <div class="step-node ${order.status=='Delivered'?'done':order.status=='Shipping'?'current':'todo'} mx-auto">
            <i class="bi bi-bag-check"></i>
          </div>
          <div class="step-lbl ${order.status=='Shipping'?'active-lbl':''}">Hoàn thành</div>
        </div>
      </div>

      <!-- Nút cập nhật -->
      <div class="d-flex gap-2 flex-wrap">
        <c:if test="${order.status=='Pending'}">
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Confirmed">
            <button type="submit" class="btn btn-primary btn-sm px-3">
              <i class="bi bi-check-circle me-1"></i>Xác nhận đơn
            </button>
          </form>
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Cancelled">
            <button type="submit" class="btn btn-danger btn-sm px-3"
                    onclick="return confirm('Hủy đơn hàng này?')">
              <i class="bi bi-x-circle me-1"></i>Hủy đơn
            </button>
          </form>
        </c:if>
        <c:if test="${order.status=='Confirmed'}">
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Processing">
            <button type="submit" class="btn btn-info btn-sm px-3">
              <i class="bi bi-gear me-1"></i>Chuyển xử lý
            </button>
          </form>
        </c:if>
        <c:if test="${order.status=='Processing'}">
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Shipping">
            <button type="submit" class="btn btn-info btn-sm px-3">
              <i class="bi bi-truck me-1"></i>Bắt đầu giao
            </button>
          </form>
        </c:if>
        <c:if test="${order.status=='Shipping'}">
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Delivered">
            <button type="submit" class="btn btn-success btn-sm px-3">
              <i class="bi bi-bag-check me-1"></i>Đã giao xong
            </button>
          </form>
        </c:if>
        <c:if test="${order.status=='Delivered'}">
          <form method="post" action="/dyleeseafood/admin/orders/${order.id}/status">
            <input type="hidden" name="status" value="Refunded">
            <button type="submit" class="btn btn-sm px-3"
                    style="background:#f3e8ff;color:#7c3aed;border:1px solid #e9d5ff;"
                    onclick="return confirm('Xác nhận hoàn tiền đơn hàng này?')">
              <i class="bi bi-arrow-return-left me-1"></i>Hoàn tiền
            </button>
          </form>
        </c:if>
      </div>
    </div>
  </div>

  <div class="row g-3">

    <!-- SẢN PHẨM TRONG ĐƠN -->
    <div class="col-md-8">
      <div class="acard">
        <div class="acard-header">
          <i class="bi bi-box-seam me-2" style="color:var(--p);"></i>Sản phẩm đặt hàng
        </div>
        <c:forEach var="item" items="${items}">
          <div class="order-item">
            <img src="${not empty item.imageUrl ? item.imageUrl
                        : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'}"
                 onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=80&q=80'"
                 alt="">
            <div style="flex:1;min-width:0;">
              <div class="item-name">${item.productName}</div>
              <div class="item-meta">
                ${item.quantity} ${item.productUnit} ×
                <fmt:formatNumber value="${item.price}" pattern="#,###"/>đ
              </div>
            </div>
            <div class="item-price">
              <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>đ
            </div>
          </div>
        </c:forEach>
        <div class="acard-footer">
          <div class="d-flex justify-content-between mb-2" style="font-size:13px;">
            <span style="color:var(--tx3);">Phí vận chuyển</span>
            <span style="color:#16a34a;font-weight:700;">Miễn phí</span>
          </div>
          <div class="d-flex justify-content-between" style="font-size:1.05rem;">
            <span style="font-weight:700;color:var(--tx);">Tổng cộng</span>
            <span style="font-weight:800;color:#dc2626;font-size:1.2rem;">
              <fmt:formatNumber value="${order.total}" pattern="#,###"/>đ
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- THÔNG TIN KHÁCH HÀNG -->
    <div class="col-md-4">
      <div class="acard mb-3">
        <div class="acard-header">
          <i class="bi bi-person-circle me-2" style="color:var(--p);"></i>Thông tin khách hàng
        </div>
        <div class="acard-body" style="display:flex;flex-direction:column;gap:14px;">
          <div>
            <div class="info-lbl">Họ tên</div>
            <div class="info-val">${order.customerName}</div>
          </div>
          <div>
            <div class="info-lbl">Điện thoại</div>
            <div class="info-val">${order.customerPhone}</div>
          </div>
          <div>
            <div class="info-lbl">Phương thức thanh toán</div>
            <div class="info-val">
              <c:choose>
                <c:when test="${order.paymentMethod=='COD'}">💵 Tiền mặt (COD)</c:when>
                <c:when test="${order.paymentMethod=='bank_transfer'}">🏦 Chuyển khoản</c:when>
                <c:when test="${order.paymentMethod=='momo'}">💜 MoMo</c:when>
                <c:when test="${order.paymentMethod=='vnpay'}">📱 VNPay</c:when>
                <c:otherwise>${order.paymentMethod}</c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:if test="${not empty order.note}">
            <div>
              <div class="info-lbl">Ghi chú</div>
              <div style="background:#f8fafc;border-radius:8px;padding:10px 12px;font-size:13px;color:var(--tx2);border:1px solid var(--bd);">${order.note}</div>
            </div>
          </c:if>
        </div>
      </div>

      <!-- TRẠNG THÁI HIỆN TẠI -->
      <div class="acard">
        <div class="status-box">
          <c:choose>
            <c:when test="${order.status=='Pending'}">
              <i class="bi bi-clock status-icon" style="color:#f59e0b;"></i>
              <div class="status-label" style="color:#f59e0b;">Chờ xác nhận</div>
            </c:when>
            <c:when test="${order.status=='Confirmed'}">
              <i class="bi bi-check-circle status-icon" style="color:var(--p);"></i>
              <div class="status-label" style="color:var(--p);">Đã xác nhận</div>
            </c:when>
            <c:when test="${order.status=='Processing'}">
              <i class="bi bi-gear status-icon" style="color:#0891b2;"></i>
              <div class="status-label" style="color:#0891b2;">Đang xử lý</div>
            </c:when>
            <c:when test="${order.status=='Shipping'}">
              <i class="bi bi-truck status-icon" style="color:#7c3aed;"></i>
              <div class="status-label" style="color:#7c3aed;">Đang giao hàng</div>
            </c:when>
            <c:when test="${order.status=='Delivered'}">
              <i class="bi bi-bag-check status-icon" style="color:#16a34a;"></i>
              <div class="status-label" style="color:#16a34a;">Đã giao thành công</div>
            </c:when>
            <c:when test="${order.status=='Cancelled'}">
              <i class="bi bi-x-circle status-icon" style="color:#dc2626;"></i>
              <div class="status-label" style="color:#dc2626;">Đã hủy</div>
            </c:when>
            <c:when test="${order.status=='Refunded'}">
              <i class="bi bi-arrow-return-left status-icon" style="color:#7c3aed;"></i>
              <div class="status-label" style="color:#7c3aed;">Đã hoàn tiền</div>
            </c:when>
          </c:choose>
          <small style="color:var(--tx3);margin-top:6px;display:block;">#DL${order.id}</small>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
