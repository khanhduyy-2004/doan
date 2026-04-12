<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="container mt-4">
  <h3 class="fw-bold mb-4">🛒 Giỏ hàng của bạn</h3>
  <c:choose>
    <c:when test="${empty cart}">
      <div class="text-center py-5">
        <i class="bi bi-cart-x text-muted"
           style="font-size:5rem;"></i>
        <h4 class="text-muted mt-3">Giỏ hàng trống!</h4>
        <a href="/dyleeseafood/products"
           class="btn btn-primary mt-3 px-4">
          <i class="bi bi-arrow-left"></i>
          Tiếp tục mua hàng
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row">
        <div class="col-md-8">
          <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
              <table class="table table-hover mb-0">
                <thead style="background:#0077b6;color:white;">
                  <tr>
                    <th class="ps-3">Sản phẩm</th>
                    <th class="text-center">Đơn giá</th>
                    <th class="text-center">Số lượng</th>
                    <th class="text-center">Thành tiền</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="item" items="${cart}">
                    <tr>
                      <td class="ps-3 align-middle">
                        <div class="d-flex align-items-center gap-3">
                          <img src="${not empty item.imageUrl
                                      ? item.imageUrl
                                      : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80'}"
                               style="width:65px;height:65px;
                                      object-fit:cover;
                                      border-radius:8px;
                                      border:1px solid #ddd;"
                               onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=100&q=80'"
                               alt="${item.name}">
                          <div>
                            <div class="fw-bold">${item.name}</div>
                            <small class="text-muted">
                              Đơn vị: ${item.unit}
                            </small>
                          </div>
                        </div>
                      </td>
                      <td class="text-center align-middle"
                          style="color:#0077b6;font-weight:700;">
                        <fmt:formatNumber value="${item.price}"
                                          pattern="#,###"/>đ
                      </td>
                      <td class="text-center align-middle">
                        <form method="post"
                              action="/dyleeseafood/cart/update/${item.productId}"
                              class="d-flex align-items-center
                                     justify-content-center gap-1">
                          <input type="number" name="quantity"
                                 value="${item.quantity}"
                                 min="0.5" max="999" step="0.5"
                                 class="form-control text-center"
                                 style="width:75px;"
                                 onchange="this.form.submit()">
                        </form>
                      </td>
                      <td class="text-center align-middle
                                 fw-bold text-danger">
                        <fmt:formatNumber value="${item.totalPrice}"
                                          pattern="#,###"/>đ
                      </td>
                      <td class="align-middle text-center">
                        <a href="/dyleeseafood/cart/remove/${item.productId}"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm(
                             'Xóa sản phẩm này?')">
                          <i class="bi bi-trash"></i>
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
          <div class="d-flex gap-2 mt-3">
            <a href="/dyleeseafood/products"
               class="btn btn-outline-primary">
              ← Tiếp tục mua hàng
            </a>
            <a href="/dyleeseafood/cart/clear"
               class="btn btn-outline-danger"
               onclick="return confirm('Xóa toàn bộ giỏ hàng?')">
              <i class="bi bi-trash"></i> Xóa tất cả
            </a>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card border-0 shadow-sm"
               style="border-radius:12px;">
            <div class="card-body p-4">
              <h5 class="fw-bold mb-3">Tóm tắt đơn hàng</h5>
              <div class="d-flex justify-content-between mb-2">
                <span class="text-muted">Tạm tính:</span>
                <span class="fw-bold">
                  <fmt:formatNumber value="${total}"
                                    pattern="#,###"/>đ
                </span>
              </div>
              <div class="d-flex justify-content-between mb-2">
                <span class="text-muted">Phí vận chuyển:</span>
                <span class="text-success fw-bold">
                  Miễn phí
                </span>
              </div>
              <hr>
              <div class="d-flex justify-content-between
                          fw-bold mb-4"
                   style="font-size:1.2rem;">
                <span>Tổng cộng:</span>
                <span class="text-danger">
                  <fmt:formatNumber value="${total}"
                                    pattern="#,###"/>đ
                </span>
              </div>
              <c:choose>
                <c:when test="${not empty
                                sessionScope.loggedUser}">
                  <a href="/dyleeseafood/order/checkout"
                     class="btn btn-primary w-100 py-2 fw-bold"
                     style="border-radius:8px;">
                    <i class="bi bi-credit-card"></i>
                    Đặt hàng ngay
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="/dyleeseafood/login"
                     class="btn btn-warning w-100 py-2 fw-bold"
                     style="border-radius:8px;">
                    <i class="bi bi-person"></i>
                    Đăng nhập để đặt hàng
                  </a>
                </c:otherwise>
              </c:choose>
              <div class="mt-3 p-3 bg-light rounded-3">
                <small class="text-muted d-block">
                  <i class="bi bi-shield-check text-success"></i>
                  Thanh toán an toàn & bảo mật
                </small>
                <small class="text-muted d-block">
                  <i class="bi bi-truck text-primary"></i>
                  Giao hàng miễn phí toàn quốc
                </small>
                <small class="text-muted d-block">
                  <i class="bi bi-arrow-repeat text-warning"></i>
                  Đổi trả trong vòng 24h
                </small>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>