<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Khách hàng" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layout/sidebar.jsp" %>

<style>
  .tier-vvip { background:#fef0f0; color:#c62828; border:1px solid #ffcdd2; }
  .tier-vip  { background:#fff8e6; color:#e65100; border:1px solid #ffe0b2; }
  .tier-norm { background:#f5f5f5; color:#616161; border:1px solid #e0e0e0; }
  .tier-badge { display:inline-flex; align-items:center; gap:4px;
                padding:4px 10px; border-radius:20px;
                font-size:11px; font-weight:600; }
  .spend-bar  { height:4px; background:#edf0f5; border-radius:2px;
                margin-top:4px; max-width:100px; }
  .spend-fill { height:4px; border-radius:2px; }
  .tier-select { font-size:12px; padding:4px 8px; border-radius:8px;
                 border:1px solid #dde3ed; background:#f7f9fc; cursor:pointer; }
  .btn-save { font-size:12px; padding:4px 12px; border-radius:8px;
              background:#0077b6; color:white; border:none;
              cursor:pointer; font-weight:500; transition:0.15s; }
  .btn-save:hover { background:#023e8a; }
</style>

  <div class="d-flex justify-content-between
              align-items-center mb-4">
    <div>
      <h4 class="fw-bold mb-1" style="font-size:20px;">
        <i class="bi bi-people text-primary me-2"></i>
        Quản lý khách hàng
      </h4>
      <p class="mb-0" style="color:#8a9ab0;font-size:13px;">
        Quản lý thông tin và hạng thành viên khách hàng
      </p>
    </div>
  </div>

  <!-- STATS -->
  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <div class="card-box p-3"
           style="border-left:4px solid #0077b6;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div style="font-size:12px;color:#8a9ab0;
                        text-transform:uppercase;">Tổng khách</div>
            <div style="font-size:28px;font-weight:500;">
              ${customers.size()}
            </div>
          </div>
          <div style="background:#e8f4fd;border-radius:10px;
                      width:44px;height:44px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-people"
               style="color:#0077b6;font-size:1.3rem;"></i>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card-box p-3"
           style="border-left:4px solid #e63946;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div style="font-size:12px;color:#8a9ab0;
                        text-transform:uppercase;">Hạng VVIP</div>
            <div style="font-size:28px;font-weight:500;">
              <c:set var="vvipCount" value="0"/>
              <c:forEach var="c" items="${customers}">
                <c:if test="${c.tierId==3}">
                  <c:set var="vvipCount" value="${vvipCount+1}"/>
                </c:if>
              </c:forEach>
              ${vvipCount}
            </div>
          </div>
          <div style="background:#fef0f0;border-radius:10px;
                      width:44px;height:44px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-trophy"
               style="color:#e63946;font-size:1.3rem;"></i>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card-box p-3"
           style="border-left:4px solid #f4a261;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div style="font-size:12px;color:#8a9ab0;
                        text-transform:uppercase;">Hạng VIP</div>
            <div style="font-size:28px;font-weight:500;">
              <c:set var="vipCount" value="0"/>
              <c:forEach var="c" items="${customers}">
                <c:if test="${c.tierId==2}">
                  <c:set var="vipCount" value="${vipCount+1}"/>
                </c:if>
              </c:forEach>
              ${vipCount}
            </div>
          </div>
          <div style="background:#fff8e6;border-radius:10px;
                      width:44px;height:44px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-star"
               style="color:#f4a261;font-size:1.3rem;"></i>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card-box p-3"
           style="border-left:4px solid #28a745;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div style="font-size:12px;color:#8a9ab0;
                        text-transform:uppercase;">Top 3 chi tiêu</div>
            <div style="font-size:28px;font-weight:500;">
              ${topCustomers.size()}
            </div>
          </div>
          <div style="background:#e8f5e9;border-radius:10px;
                      width:44px;height:44px;display:flex;
                      align-items:center;justify-content:center;">
            <i class="bi bi-bar-chart"
               style="color:#28a745;font-size:1.3rem;"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- TOP 3 -->
  <div class="card-box mb-4">
    <div class="p-4 pb-3"
         style="border-bottom:1px solid #f0f2f5;">
      <h6 class="fw-bold mb-0">
        🏆 Top khách hàng chi tiêu nhiều nhất
      </h6>
    </div>
    <div class="p-4">
      <div class="row g-3">
        <c:forEach var="c" items="${topCustomers}"
                   varStatus="i">
          <div class="col-md-4">
            <div style="background:${i.index==0?'#fffbeb':
                          i.index==1?'#f8f9fa':'#fff5f5'};
                        border-radius:12px;padding:20px;
                        text-align:center;
                        border-top:3px solid
                          ${i.index==0?'#f4a261':
                            i.index==1?'#adb5bd':'#cd7f32'};">
              <div style="font-size:24px;">
                ${i.index==0?'🥇':i.index==1?'🥈':'🥉'}
              </div>
              <div style="width:48px;height:48px;
                          border-radius:50%;margin:8px auto;
                          display:flex;align-items:center;
                          justify-content:center;
                          font-weight:700;font-size:20px;
                          background:${i.index==0?'#fff3cd':
                            i.index==1?'#e9ecef':'#ffe5d0'};
                          color:${i.index==0?'#856404':
                            i.index==1?'#495057':'#7c3c0a'};">
                ${c.name.substring(0,1)}
              </div>
              <div class="fw-bold mb-1">${c.name}</div>
              <div style="color:#0077b6;font-weight:700;
                          font-size:15px;">
                <fmt:formatNumber value="${c.totalSpent}"
                                  pattern="#,###"/>đ
              </div>
              <c:choose>
                <c:when test="${c.tierId==3}">
                  <span class="tier-badge tier-vvip mt-1">
                    👑 VVIP
                  </span>
                </c:when>
                <c:when test="${c.tierId==2}">
                  <span class="tier-badge tier-vip mt-1">
                    ⭐ VIP
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="tier-badge tier-norm mt-1">
                    Thường
                  </span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </c:forEach>
        <c:if test="${empty topCustomers}">
          <div class="col-12 text-center py-3"
               style="color:#8a9ab0;">
            Chưa có dữ liệu chi tiêu
          </div>
        </c:if>
      </div>
    </div>
  </div>

  <!-- BẢNG KHÁCH HÀNG -->
  <div class="card-box">
    <div class="d-flex justify-content-between
                align-items-center p-4 pb-0">
      <h6 class="fw-bold mb-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách khách hàng
      </h6>
      <span class="badge bg-primary px-3">
        ${customers.size()} khách
      </span>
    </div>
    <div class="mt-3">
      <table class="table table-hover mb-0">
        <thead>
          <tr>
            <th class="ps-4">#</th>
            <th>Khách hàng</th>
            <th>Liên hệ</th>
            <th>Tổng chi tiêu</th>
            <th class="text-center">Hạng</th>
            <th class="text-center">Đổi hạng</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="c" items="${customers}"
                     varStatus="i">
            <tr>
              <td class="ps-4 text-muted">${i.count}</td>
              <td>
                <div class="d-flex align-items-center gap-2">
                  <div style="width:36px;height:36px;
                              border-radius:50%;display:flex;
                              align-items:center;
                              justify-content:center;
                              font-weight:700;font-size:14px;
                              background:${c.tierId==3?'#fef0f0':
                                c.tierId==2?'#fff8e6':'#e8f4fd'};
                              color:${c.tierId==3?'#c62828':
                                c.tierId==2?'#e65100':'#0077b6'};">
                    ${c.name.substring(0,1)}
                  </div>
                  <div>
                    <div style="font-weight:600;font-size:13.5px;">
                      ${c.name}
                    </div>
                    <small style="color:#8a9ab0;">
                      @${c.username}
                    </small>
                  </div>
                </div>
              </td>
              <td>
                <div style="font-size:13px;">${c.email}</div>
                <small style="color:#8a9ab0;">${c.phone}</small>
              </td>
              <td>
                <span style="font-weight:700;color:#0077b6;
                             font-size:13.5px;">
                  <fmt:formatNumber value="${c.totalSpent}"
                                    pattern="#,###"/>đ
                </span>
                <div class="spend-bar">
                  <div class="spend-fill"
                       style="background:${c.tierId==3?'#e63946':
                                c.tierId==2?'#f4a261':'#0077b6'};
                              width:${c.totalSpent>=20000000?100:
                                c.totalSpent>=5000000?
                                  c.totalSpent/200000:
                                  c.totalSpent>0?
                                    c.totalSpent/50000:0}%;
                              max-width:100%;"></div>
                </div>
              </td>
              <td class="text-center">
                <c:choose>
                  <c:when test="${c.tierId==3}">
                    <span class="tier-badge tier-vvip">
                      👑 VVIP
                    </span>
                  </c:when>
                  <c:when test="${c.tierId==2}">
                    <span class="tier-badge tier-vip">
                      ⭐ VIP
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="tier-badge tier-norm">
                      Thường
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <form method="post"
                      action="/dyleeseafood/admin/customers/tier/${c.id}"
                      class="d-flex gap-1 justify-content-center">
                  <select name="tierId" class="tier-select">
                    <c:forEach var="tier" items="${tiers}">
                      <option value="${tier.id}"
                        ${c.tierId==tier.id?'selected':''}>
                        ${tier.name}
                      </option>
                    </c:forEach>
                  </select>
                  <button type="submit" class="btn-save">
                    Lưu
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty customers}">
            <tr>
              <td colspan="6"
                  class="text-center py-5"
                  style="color:#8a9ab0;">
                <i class="bi bi-people"
                   style="font-size:3rem;color:#dde3ed;"></i>
                <p class="mt-2 mb-0">Chưa có khách hàng nào</p>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

<%@ include file="/WEB-INF/views/admin/layout/sidebar-end.jsp" %>