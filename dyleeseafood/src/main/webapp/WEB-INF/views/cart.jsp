<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="layout/header.jsp" %>

<div class="container mt-4">
  <h3 class="fw-bold mb-4">🛒 Giỏ hàng của bạn</h3>

  <c:choose>
    <c:when test="${empty cart}">
      <div class="text-center py-5">
        <i class="bi bi-cart-x text-muted" style="font-size:5rem;"></i>
        <h4 class="text-muted mt-3">Giỏ hàng trống!</h4>
        <a href="/dyleeseafood/products" class="btn btn-primary mt-3 px-4">
          <i class="bi bi-arrow-left"></i> Tiếp tục mua hàng
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row">
        <!-- Danh sách sản phẩm -->
        <div class="col-md-8">
          <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
              <table class="table table-hover mb-0">
                <thead style="background:#0077b6; color:white;">
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
                      <td class="ps-3">
                        <div class="d-flex align-items-center gap-2">
                          <img src="https://via.placeholder.com/60x60/0077b6/white?text=SP"
                               class="rounded" width="60" height="60" style="object-fit:cover;">
                          <div>
                            <div class="fw-bold">${item.product.name}</div>
                            <small class="text-muted">${item.product.unit}</small>
                          </div>
                        </div>
                      </td>
                      <td class="text-center align-middle price">
                        <fmt:formatNumber value="${item.product.price}" pattern="#,###"/>đ
                      </td>
                      <td class="text-center align-middle">
                        <form method="post" action="/dyleeseafood/cart/update/${item.product.id}"
                              class="d-flex align-items-center justify-content-center gap-1">
                          <input type="number" name="quantity" value="${item.quantity}"
                                 min="1" max="99" class="form-control text-center"
                                 style="width:70px;" onchange="this.form.submit()">
                        </form>
                      </td>
                      <td class="text-center align-middle fw-bold text-danger">
                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>đ
                      </td>
                      <td class="align-middle">
                        <a href="/dyleeseafood/cart/remove/${item.product.id}"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Xóa sản phẩm này?')">
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
            <a href="/dyleeseafood/products" class="btn btn-outline-primary">
              ← Tiếp tục mua hàng
            </a>
            <a href="/dyleeseafood/cart/clear" class="btn btn-outline-danger"
               onclick="return confirm('Xóa toàn bộ giỏ hàng?')">
              <i class="bi bi-trash"></i> Xóa tất cả
            </a>
          </div>
        </div>

        <!-- Tổng tiền -->
        <div class="col-md-4">
          <div class="card border-0 shadow-sm">
            <div class="card-body">
              <h5 class="fw-bold mb-3">Tóm tắt đơn hàng</h5>
              <div class="d-flex justify-content-between mb-2">
                <span>Tạm tính:</span>
                <span><fmt:formatNumber value="${total}" pattern="#,###"/>đ</span>
              </div>
              <div class="d-flex justify-content-between mb-2">
                <span>Phí vận chuyển:</span>
                <span class="text-success">Miễn phí</span>
              </div>
              <hr>
              <div class="d-flex justify-content-between fw-bold fs-5 mb-3">
                <span>Tổng cộng:</span>
                <span class="text-danger">
                  <fmt:formatNumber value="${total}" pattern="#,###"/>đ
                </span>
              </div>
              <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                  <a href="/dyleeseafood/order/checkout" class="btn btn-primary w-100 py-2 fw-bold">
                    <i class="bi bi-credit-card"></i> Đặt hàng ngay
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="/dyleeseafood/login" class="btn btn-warning w-100 py-2 fw-bold">
                    <i class="bi bi-person"></i> Đăng nhập để đặt hàng
                  </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%@ include file="layout/footer.jsp" %>