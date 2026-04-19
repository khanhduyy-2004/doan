<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer style="background:#012a5e; margin-top:60px;">

  <!-- PHẦN CHÍNH -->
  <div class="container py-5" style="max-width:1200px;">
    <div class="row g-4">

      <!-- CỘT 1: THƯƠNG HIỆU -->
      <div class="col-lg-3 col-md-6">
        <div class="mb-3">
          <h5 class="fw-bold mb-1" style="color:white;font-size:22px;">
            🐟 Dylee Seafood
          </h5>
          <div style="width:40px;height:3px;background:#0077b6;border-radius:2px;"></div>
        </div>
        <p style="color:rgba(255,255,255,0.6);font-size:13px;line-height:1.8;">
          Hải sản tươi sống đánh bắt hàng ngày, giao tận nhà trong 2 giờ.
          Cam kết chất lượng 100% — hoàn tiền nếu không hài lòng.
        </p>

        <!-- Badges -->
        <div class="d-flex flex-wrap gap-2 mb-3">
          <span style="background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:5px 10px;color:rgba(255,255,255,0.7);font-size:11px;">
            <i class="bi bi-shield-check me-1" style="color:#4caf50;"></i>Uy tín
          </span>
          <span style="background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:5px 10px;color:rgba(255,255,255,0.7);font-size:11px;">
            <i class="bi bi-truck me-1" style="color:#2196f3;"></i>Giao 2h
          </span>
          <span style="background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:5px 10px;color:rgba(255,255,255,0.7);font-size:11px;">
            <i class="bi bi-arrow-repeat me-1" style="color:#ff9800;"></i>Đổi trả 24h
          </span>
        </div>

        <!-- Liên hệ -->
        <div style="color:rgba(255,255,255,0.65);font-size:13px;line-height:2;">
          <div>
            <i class="bi bi-geo-alt-fill me-2" style="color:#0077b6;"></i>
            Hải Phòng, Việt Nam
          </div>
          <div>
            <i class="bi bi-telephone-fill me-2" style="color:#0077b6;"></i>
            0123 456 789
          </div>
          <div>
            <i class="bi bi-envelope-fill me-2" style="color:#0077b6;"></i>
            dylee@seafood.vn
          </div>
          <div>
            <i class="bi bi-clock-fill me-2" style="color:#0077b6;"></i>
            7:00 – 21:00 hàng ngày
          </div>
        </div>
      </div>

      <!-- CỘT 2: VỀ CHÚNG TÔI -->
      <div class="col-lg-2 col-md-6">
        <h6 class="fw-bold mb-3" style="color:white;font-size:14px;text-transform:uppercase;letter-spacing:0.05em;">
          Về chúng tôi
        </h6>
        <div style="width:30px;height:2px;background:#0077b6;border-radius:2px;margin-bottom:14px;"></div>
        <ul style="list-style:none;padding:0;margin:0;">
          <li class="mb-2">
            <a href="/dyleeseafood/about" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Giới thiệu
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/products" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Sản phẩm
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/contact" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Liên hệ
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/news" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Tin tức
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/recruitment" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Tuyển dụng
            </a>
          </li>
        </ul>
      </div>

      <!-- CỘT 3: HỖ TRỢ KHÁCH HÀNG -->
      <div class="col-lg-3 col-md-6">
        <h6 class="fw-bold mb-3" style="color:white;font-size:14px;text-transform:uppercase;letter-spacing:0.05em;">
          Hỗ trợ khách hàng
        </h6>
        <div style="width:30px;height:2px;background:#0077b6;border-radius:2px;margin-bottom:14px;"></div>
        <ul style="list-style:none;padding:0;margin:0;">
          <li class="mb-2">
            <a href="/dyleeseafood/guide/order" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Hướng dẫn đặt hàng
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/guide/payment" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Phương thức thanh toán
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/guide/shipping" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Chính sách vận chuyển
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/guide/return" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Đổi trả &amp; hoàn tiền
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/faq" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Câu hỏi thường gặp
            </a>
          </li>
          <li class="mb-2">
            <a href="/dyleeseafood/policy/privacy" class="footer-link">
              <i class="bi bi-chevron-right me-1" style="font-size:10px;"></i>Chính sách bảo mật
            </a>
          </li>
        </ul>

        <!-- Danh mục sản phẩm -->
        <h6 class="fw-bold mb-2 mt-3" style="color:white;font-size:14px;text-transform:uppercase;letter-spacing:0.05em;">
          Danh mục
        </h6>
        <div style="width:30px;height:2px;background:#0077b6;border-radius:2px;margin-bottom:12px;"></div>
        <c:forEach var="cat" items="${categories}">
          <a href="/dyleeseafood/products?category=${cat.id}" class="footer-link d-block mb-1">
            <i class="bi ${cat.icon} me-1" style="font-size:11px;"></i>
            ${cat.name}
          </a>
        </c:forEach>
      </div>

      <!-- CỘT 4: KẾT NỐI + ĐĂNG KÝ -->
      <div class="col-lg-4 col-md-6">
        <h6 class="fw-bold mb-3" style="color:white;font-size:14px;text-transform:uppercase;letter-spacing:0.05em;">
          Kết nối với chúng tôi
        </h6>
        <div style="width:30px;height:2px;background:#0077b6;border-radius:2px;margin-bottom:14px;"></div>

        <!-- Social icons -->
        <div class="d-flex gap-2 mb-4">
          <a href="#" class="social-btn" style="background:#1877f2;" title="Facebook">
            <i class="bi bi-facebook"></i>
          </a>
          <a href="#" class="social-btn" style="background:linear-gradient(45deg,#f09433,#e6683c,#dc2743,#cc2366,#bc1888);" title="Instagram">
            <i class="bi bi-instagram"></i>
          </a>
          <a href="#" class="social-btn" style="background:#ff0000;" title="YouTube">
            <i class="bi bi-youtube"></i>
          </a>
          <a href="#" class="social-btn" style="background:#0088cc;" title="Zalo">
            <i class="bi bi-chat-dots-fill"></i>
          </a>
          <a href="#" class="social-btn" style="background:#1da1f2;" title="Twitter/X">
            <i class="bi bi-twitter-x"></i>
          </a>
        </div>

        <!-- Đăng ký nhận tin -->
        <div style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:12px;padding:16px;">
          <div class="fw-bold mb-1" style="color:white;font-size:13px;">
            <i class="bi bi-bell-fill me-2" style="color:#ffc107;"></i>
            Đăng ký nhận tin khuyến mãi
          </div>
          <div style="color:rgba(255,255,255,0.5);font-size:11px;margin-bottom:10px;">
            Nhận ngay ưu đãi 10% cho đơn đầu tiên
          </div>
          <div class="input-group">
            <input type="email" class="form-control form-control-sm"
                   placeholder="Nhập địa chỉ email..."
                   style="border-radius:8px 0 0 8px;border:none;font-size:12px;background:rgba(255,255,255,0.9);">
            <button class="btn btn-sm" type="button"
                    style="background:#0077b6;color:white;border:none;border-radius:0 8px 8px 0;padding:0 14px;">
              <i class="bi bi-send-fill"></i>
            </button>
          </div>
        </div>

        <!-- Phương thức thanh toán -->
        <div class="mt-3">
          <div style="color:rgba(255,255,255,0.5);font-size:11px;margin-bottom:8px;text-transform:uppercase;letter-spacing:0.05em;">
            Chấp nhận thanh toán
          </div>
          <div class="d-flex flex-wrap gap-2">
            <span class="pay-badge">💵 COD</span>
            <span class="pay-badge">🏦 Bank</span>
            <span class="pay-badge" style="color:#ae2070;">MoMo</span>
            <span class="pay-badge" style="color:#0066b3;">VNPay</span>
            <span class="pay-badge" style="color:#006af5;">ZaloPay</span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ĐƯỜNG KẺ -->
  <div style="border-top:1px solid rgba(255,255,255,0.08);"></div>

  <!-- COPYRIGHT BAR -->
  <div style="background:#011e42;">
    <div class="container py-3" style="max-width:1200px;">
      <div class="row align-items-center g-2">
        <div class="col-md-6">
          <p class="mb-0" style="color:rgba(255,255,255,0.4);font-size:12px;">
            © 2026 <strong style="color:rgba(255,255,255,0.6);">Dylee Seafood</strong>
            — Lê Trần Khánh Duy
          </p>
        </div>
        <div class="col-md-6 text-md-end">
          <p class="mb-0" style="color:rgba(255,255,255,0.4);font-size:12px;">
            <i class="bi bi-heart-fill text-danger" style="font-size:10px;"></i>
            Made with Spring MVC 5.3 · MySQL · Bootstrap 5.3
          </p>
        </div>
      </div>
    </div>
  </div>

</footer>

<style>
  .footer-link {
    color: rgba(255,255,255,0.6);
    text-decoration: none;
    font-size: 13px;
    transition: all 0.15s;
  }
  .footer-link:hover {
    color: white;
    padding-left: 4px;
  }
  .social-btn {
    width: 36px; height: 36px;
    border-radius: 8px;
    display: flex; align-items: center;
    justify-content: center;
    color: white; text-decoration: none;
    font-size: 15px; transition: 0.2s;
  }
  .social-btn:hover {
    transform: translateY(-3px);
    color: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  }
  .pay-badge {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 6px;
    padding: 3px 10px;
    font-size: 11px;
    color: rgba(255,255,255,0.7);
    font-weight: 600;
  }
</style>

</body>
</html>
