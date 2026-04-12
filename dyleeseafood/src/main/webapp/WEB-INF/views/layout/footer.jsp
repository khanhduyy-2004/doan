<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="py-4 mt-5" style="background:#023e8a;">
  <div class="container" style="max-width:1200px;">
    <div class="row g-4">

      <!-- Logo + mô tả -->
      <div class="col-md-4">
        <h5 class="text-white fw-bold mb-2">
          🐟 Dylee Seafood
        </h5>
        <p style="color:rgba(255,255,255,0.6);
                  font-size:13px; line-height:1.6;">
          Hải sản tươi sống, giao tận nhà.
          Chất lượng đảm bảo, giá cả hợp lý.
        </p>
        <div class="d-flex gap-2 mt-2">
          <span style="background:rgba(255,255,255,0.1);
                       border-radius:6px; padding:6px 10px;
                       color:rgba(255,255,255,0.7);
                       font-size:12px;">
            <i class="bi bi-shield-check"></i> Uy tín
          </span>
          <span style="background:rgba(255,255,255,0.1);
                       border-radius:6px; padding:6px 10px;
                       color:rgba(255,255,255,0.7);
                       font-size:12px;">
            <i class="bi bi-truck"></i> Nhanh chóng
          </span>
        </div>
      </div>

      <!-- Liên hệ -->
      <div class="col-md-4">
        <h6 class="text-white fw-bold mb-3">Liên hệ</h6>
        <div style="color:rgba(255,255,255,0.7);font-size:13px;">
          <div class="mb-2">
            <i class="bi bi-telephone me-2"></i>0123 456 789
          </div>
          <div class="mb-2">
            <i class="bi bi-envelope me-2"></i>dylee@seafood.vn
          </div>
          <div>
            <i class="bi bi-geo-alt me-2"></i>Hải Phòng, Việt Nam
          </div>
        </div>
      </div>

      <!-- Danh mục -->
      <div class="col-md-4">
        <h6 class="text-white fw-bold mb-3">Danh mục</h6>
        <div style="column-count:2; column-gap:16px;">
          <c:forEach var="cat" items="${categories}">
            <div class="mb-1">
              <a href="/dyleeseafood/products?category=${cat.id}"
                 style="color:rgba(255,255,255,0.6);
                        text-decoration:none;
                        font-size:13px;
                        transition:0.15s;"
                 onmouseover="this.style.color='white'"
                 onmouseout="this.style.color='rgba(255,255,255,0.6)'">
                <i class="bi ${cat.icon} me-1"
                   style="font-size:11px;"></i>
                ${cat.name}
              </a>
            </div>
          </c:forEach>
        </div>
      </div>

    </div>

    <!-- Đường kẻ -->
    <hr style="border-color:rgba(255,255,255,0.15);margin:16px 0 12px;">

    <!-- Copyright -->
    <div class="d-flex justify-content-between align-items-center">
      <p class="mb-0"
         style="color:rgba(255,255,255,0.4);font-size:12px;">
        © 2026 Dylee Seafood. All rights reserved.
      </p>
      <div style="color:rgba(255,255,255,0.4);font-size:12px;">
        <i class="bi bi-heart-fill text-danger"
           style="font-size:10px;"></i>
        Made with Spring MVC
      </div>
    </div>

  </div>
</footer>

</body>
</html>