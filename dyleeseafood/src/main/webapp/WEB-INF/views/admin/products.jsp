<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Sản phẩm" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

  <div class="d-flex justify-content-between
              align-items-center mb-4">
    <h4 class="fw-bold">📦 Quản lý sản phẩm</h4>
    <a href="/dyleeseafood/admin/products/add"
       class="btn btn-primary">
      <i class="bi bi-plus-circle"></i> Thêm sản phẩm
    </a>
  </div>

  <div class="card border-0 shadow-sm"
       style="border-radius:12px;">
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead style="background:#f8f9fa;">
          <tr>
            <th class="ps-3">#</th>
            <th>Ảnh</th>
            <th>Tên sản phẩm</th>
            <th>Danh mục</th>
            <th>Giá</th>
            <th>Tồn kho</th>
            <th>Nổi bật</th>
            <th class="text-center">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="p" items="${products}"
                     varStatus="i">
            <tr>
              <td class="ps-3 align-middle">
                ${i.count}
              </td>
              <td class="align-middle">
                <img src="${not empty p.imageUrl
                     ? p.imageUrl
                     : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=60&q=80'}"
                     style="width:50px;height:50px;
                            object-fit:cover;
                            border-radius:8px;"
                     onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=60&q=80'"
                     alt="${p.name}">
              </td>
              <td class="align-middle fw-bold">
                ${p.name}
                <c:if test="${not empty p.supplierName}">
                  <br>
                  <small style="color:#8a9ab0;
                                font-weight:400;">
                    ${p.supplierName}
                  </small>
                </c:if>
              </td>
              <td class="align-middle">
                <span class="badge bg-info text-dark">
                  ${p.categoryName}
                </span>
              </td>
              <td class="align-middle fw-bold"
                  style="color:#0077b6;">
                <fmt:formatNumber value="${p.price}"
                                  pattern="#,###"/>đ
              </td>
              <td class="align-middle">
                <span class="${p.stock < 5
                              ? 'text-danger fw-bold'
                              : p.stock < 10
                              ? 'text-warning fw-bold'
                              : ''}">
                  <fmt:formatNumber value="${p.stock}"
                                    pattern="#.##"/>
                  ${p.unit}
                </span>
              </td>
              <td class="align-middle">
                <c:choose>
                  <c:when test="${p.featured}">
                    <span class="badge bg-warning text-dark">
                      ⭐ Có
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-secondary">
                      Không
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="align-middle text-center">
                <div class="d-flex gap-1
                            justify-content-center">
                  <a href="/dyleeseafood/products/${p.id}"
                     class="btn btn-sm btn-outline-info"
                     target="_blank">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="/dyleeseafood/admin/products/edit/${p.id}"
                     class="btn btn-sm btn-outline-warning">
                    <i class="bi bi-pencil"></i>
                  </a>
                  <c:if test="${sessionScope.loggedUser.roleId == 1}">
                    <a href="/dyleeseafood/admin/products/delete/${p.id}"
                       class="btn btn-sm btn-outline-danger"
                       onclick="return confirm(
                         'Xóa sản phẩm ${p.name}?')">
                      <i class="bi bi-trash"></i>
                    </a>
                  </c:if>
                </div>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty products}">
            <tr>
              <td colspan="8"
                  class="text-center py-5 text-muted">
                <i class="bi bi-box-seam"
                   style="font-size:3rem;
                          color:#dde3ed;"></i>
                <p class="mt-2 mb-0">
                  Chưa có sản phẩm nào
                </p>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>