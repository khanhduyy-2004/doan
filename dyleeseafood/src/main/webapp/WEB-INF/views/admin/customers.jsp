<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Khách hàng" scope="request"/>
<%@ include file="layout/sidebar.jsp" %>

<style>
/* STATS */
.sg{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:18px;}
.sc{background:white;border-radius:12px;padding:16px 18px;
  box-shadow:0 1px 6px rgba(2,62,138,.07);border:1px solid #e5eaf2;
  display:flex;align-items:center;gap:14px;transition:.2s;}
.sc:hover{transform:translateY(-2px);box-shadow:0 4px 14px rgba(2,62,138,.1);}
.si{width:44px;height:44px;border-radius:11px;display:flex;
  align-items:center;justify-content:center;font-size:1.25rem;flex-shrink:0;}
.sn{font-size:1.4rem;font-weight:800;color:#0f172a;line-height:1;}
.sl{font-size:11px;color:#94a3b8;margin-top:3px;}

/* FILTER */
.fbar{background:white;border-radius:12px;padding:12px 16px;
  box-shadow:0 1px 6px rgba(2,62,138,.06);border:1px solid #e5eaf2;
  margin-bottom:16px;display:flex;gap:9px;align-items:center;flex-wrap:wrap;}
.sb2{flex:1;min-width:200px;position:relative;}
.sb2 input{width:100%;border:1.5px solid #e5eaf2;border-radius:8px;
  padding:8px 12px 8px 34px;font-size:13px;outline:none;background:#f8fafc;}
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

/* TABLE */
.tc{background:white;border-radius:12px;
  box-shadow:0 1px 6px rgba(2,62,138,.06);border:1px solid #e5eaf2;overflow:hidden;}
table.at{width:100%;border-collapse:collapse;}
.at thead tr{background:linear-gradient(135deg,#011f4b 0%,#0077b6 100%);}
.at th{padding:11px 16px;color:rgba(255,255,255,.9);font-size:11px;
  font-weight:700;text-align:left;white-space:nowrap;
  letter-spacing:.05em;text-transform:uppercase;}
.at th.c,.at td.c{text-align:center;}
.at tbody tr{border-bottom:1px solid #f1f5f9;transition:background .1s;}
.at tbody tr:last-child{border:none;}
.at tbody tr:hover{background:#f5f8fc;}
.at td{padding:11px 16px;font-size:13px;vertical-align:middle;color:#0f172a;}

/* AVATAR */
.av{width:38px;height:38px;border-radius:50%;display:flex;align-items:center;
  justify-content:center;font-weight:700;font-size:15px;color:white;flex-shrink:0;}

/* TIER BADGE */
.tier-n{background:#f1f5f9;color:#64748b;border-radius:20px;
  padding:3px 10px;font-size:11px;font-weight:600;display:inline-block;}
.tier-v{background:#fef9c3;color:#a16207;border-radius:20px;
  padding:3px 10px;font-size:11px;font-weight:600;display:inline-block;}
.tier-vv{background:#fce7f3;color:#be185d;border-radius:20px;
  padding:3px 10px;font-size:11px;font-weight:600;display:inline-block;}

/* ACTION BTN */
.ab{width:30px;height:30px;border-radius:7px;border:none;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  font-size:.85rem;transition:all .15s;text-decoration:none;}
.ab-k{background:#fef9c3;color:#a16207;}
.ab-k:hover{background:#a16207;color:white;}
.ab-p{background:#fee2e2;color:#dc2626;}
.ab-p:hover{background:#dc2626;color:white;}

/* PAGINATION */
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

/* MODAL */
.mo{position:fixed;inset:0;background:rgba(0,0,0,.45);z-index:1000;
  display:none;align-items:center;justify-content:center;}
.mo.open{display:flex;}
.mb{background:white;border-radius:16px;width:360px;max-width:90vw;
  overflow:hidden;box-shadow:0 20px 60px rgba(0,0,0,.2);}
.mh{background:linear-gradient(135deg,#011f4b,#0077b6);
  padding:16px 20px;display:flex;justify-content:space-between;align-items:center;}
.mh h5{color:white;margin:0;font-size:15px;font-weight:700;}
.mcl{background:none;border:none;color:rgba(255,255,255,.7);
  font-size:1.3rem;cursor:pointer;line-height:1;}
.mbody{padding:22px;}
.bsave{background:#0077b6;color:white;border:none;border-radius:8px;
  padding:9px 20px;font-size:13px;font-weight:600;cursor:pointer;}
.bsave:hover{background:#023e8a;}
.bcancel{background:#f1f5f9;color:#475569;border:1.5px solid #e5eaf2;
  border-radius:8px;padding:9px 16px;font-size:13px;cursor:pointer;}

.empty{text-align:center;padding:48px 20px;color:#94a3b8;}
.empty i{font-size:3rem;display:block;margin-bottom:12px;opacity:.2;}
</style>

<div style="padding:24px;">

  <!-- HEADER -->
  <div class="d-flex align-items-center justify-content-between mb-4">
    <div>
      <h4 class="fw-bold mb-1" style="color:#0f172a;">Quản lý Khách hàng</h4>
      <small style="color:#94a3b8;">
        <i class="bi bi-house me-1"></i>Admin /
        <span style="color:#0077b6;">Khách hàng</span>
      </small>
    </div>
  </div>

  <!-- THÔNG BÁO RESET MẬT KHẨU -->
  <c:if test="${not empty resetSuccess}">
    <div class="alert d-flex align-items-center gap-3 mb-4"
         style="border-radius:12px;border:none;background:#fff8e6;
                border-left:4px solid #f59e0b;padding:14px 18px;">
      <i class="bi bi-key-fill" style="color:#f59e0b;font-size:1.3rem;flex-shrink:0;"></i>
      <div style="font-size:13.5px;color:#0f172a;">${resetSuccess}</div>
      <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
    </div>
  </c:if>
  <c:if test="${not empty resetError}">
    <div class="alert d-flex align-items-center gap-3 mb-4"
         style="border-radius:12px;border:none;background:#fef2f2;
                border-left:4px solid #dc2626;padding:14px 18px;">
      <i class="bi bi-exclamation-circle-fill" style="color:#dc2626;font-size:1.3rem;flex-shrink:0;"></i>
      <div style="font-size:13.5px;color:#0f172a;">${resetError}</div>
      <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <!-- STATS -->
  <div class="sg">
    <div class="sc">
      <div class="si" style="background:#e0f2fe;">
        <i class="bi bi-people-fill" style="color:#0077b6;"></i>
      </div>
      <div>
        <div class="sn">${totalCustomers}</div>
        <div class="sl">Tổng khách hàng</div>
      </div>
    </div>
    <div class="sc">
      <div class="si" style="background:#fef9c3;">
        <i class="bi bi-star-fill" style="color:#a16207;"></i>
      </div>
      <div>
        <div class="sn" id="vipCnt">—</div>
        <div class="sl">Khách VIP</div>
      </div>
    </div>
    <div class="sc">
      <div class="si" style="background:#fce7f3;">
        <i class="bi bi-gem" style="color:#be185d;"></i>
      </div>
      <div>
        <div class="sn" id="vvipCnt">—</div>
        <div class="sl">Khách VVIP</div>
      </div>
    </div>
  </div>

  <!-- FILTER -->
  <form method="get" action="/dyleeseafood/admin/customers" class="fbar">
    <div class="sb2">
      <i class="bi bi-search"></i>
      <input type="text" name="keyword" value="${keyword}"
             placeholder="Tìm tên, email, SĐT...">
    </div>
    <select name="tier" class="fsel">
      <option value="">Tất cả hạng</option>
      <c:forEach var="t" items="${tiers}">
        <option value="${t.id}" ${tier==t.id?'selected':''}>${t.name}</option>
      </c:forEach>
    </select>
    <button type="submit" class="fbtn">
      <i class="bi bi-funnel me-1"></i>Lọc
    </button>
    <a href="/dyleeseafood/admin/customers" class="frst" title="Xóa bộ lọc">
      <i class="bi bi-arrow-counterclockwise"></i>
    </a>
  </form>

  <!-- TABLE -->
  <div class="tc">
    <table class="at">
      <thead><tr>
        <th>#</th>
        <th>Khách hàng</th>
        <th>Liên hệ</th>
        <th class="c">Hạng thành viên</th>
        <th class="c">Chi tiêu</th>
        <th class="c">Đổi hạng</th>
        <th class="c">Thao tác</th>
      </tr></thead>
      <tbody id="custTbody">
        <c:choose>
          <c:when test="${empty customers}">
            <tr><td colspan="7">
              <div class="empty">
                <i class="bi bi-people"></i>
                <p class="fw-bold mb-1">Không tìm thấy khách hàng</p>
                <small>Thử thay đổi từ khóa tìm kiếm</small>
              </div>
            </td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="c" items="${customers}" varStatus="s">
              <tr>
                <!-- # -->
                <td style="color:#94a3b8;font-size:12px;">
                  ${(currentPage-1)*15 + s.index + 1}
                </td>

                <!-- Khách hàng -->
                <td>
                  <div class="d-flex align-items-center gap-3">
                    <div class="av"
                         style="background:${c.tierId==3?'#be185d':c.tierId==2?'#0077b6':'#64748b'};">
                      ${c.name.substring(0,1)}
                    </div>
                    <div>
                      <div style="font-weight:700;font-size:14px;">${c.name}</div>
                      <div style="font-size:11px;color:#94a3b8;">
                        #KH${c.id}
                        <c:if test="${not empty c.email}"> · ${c.email}</c:if>
                      </div>
                    </div>
                  </div>
                </td>

                <!-- Liên hệ -->
                <td>
                  <c:if test="${not empty c.phone}">
                    <div style="font-size:13px;">
                      <i class="bi bi-phone me-1" style="color:#0077b6;"></i>${c.phone}
                    </div>
                  </c:if>
                  <c:if test="${empty c.phone}">
                    <span style="color:#94a3b8;font-size:12px;">—</span>
                  </c:if>
                </td>

                <!-- Hạng -->
                <td class="c">
                  <c:choose>
                    <c:when test="${c.tierId==3}">
                      <span class="tier-vv tier-vv">💎 VVIP</span>
                    </c:when>
                    <c:when test="${c.tierId==2}">
                      <span class="tier-v">⭐ VIP</span>
                    </c:when>
                    <c:otherwise>
                      <span class="tier-n">🐟 Thường</span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <!-- Chi tiêu -->
                <td class="c" style="color:#0077b6;font-weight:700;">
                  <fmt:formatNumber value="${c.totalSpent}" pattern="#,###"/>đ
                </td>

                <!-- Đổi hạng -->
                <td class="c" onclick="event.stopPropagation()">
                  <c:if test="${isAdmin}">
                    <form method="post"
                          action="/dyleeseafood/admin/customers/tier/${c.id}">
                      <select name="tierId" class="fsel"
                              style="padding:4px 8px;font-size:12px;"
                              onchange="this.form.submit()">
                        <c:forEach var="t" items="${tiers}">
                          <option value="${t.id}"
                                  ${c.tierId==t.id?'selected':''}>${t.name}</option>
                        </c:forEach>
                      </select>
                    </form>
                  </c:if>
                  <c:if test="${!isAdmin}">
                    <span style="font-size:12px;color:#94a3b8;">${c.tierName}</span>
                  </c:if>
                </td>

                <!-- Thao tác -->
                <td class="c" onclick="event.stopPropagation()">
                  <div class="d-flex gap-1 justify-content-center">
                    <a href="/dyleeseafood/order/history?customerId=${c.id}"
                       class="ab ab-k" title="Xem đơn hàng">
                      <i class="bi bi-bag"></i>
                    </a>
                    <c:if test="${isAdmin}">
                      <button class="ab ab-p" title="Reset mật khẩu"
                              onclick="openResetPw(${c.userId},'${c.name}')">
                        <i class="bi bi-key"></i>
                      </button>
                    </c:if>
                  </div>
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
          &nbsp;·&nbsp; ${totalCustomers} khách hàng
        </div>
        <div class="pg-b">
          <c:if test="${currentPage > 1}">
            <a href="?keyword=${keyword}&tier=${tier}&page=${currentPage-1}"
               class="pb"><i class="bi bi-chevron-left"></i></a>
          </c:if>
          <c:forEach begin="1" end="${totalPages}" var="pg">
            <c:if test="${pg >= currentPage-2 && pg <= currentPage+2}">
              <a href="?keyword=${keyword}&tier=${tier}&page=${pg}"
                 class="pb ${currentPage==pg?'on':''}">${pg}</a>
            </c:if>
          </c:forEach>
          <c:if test="${currentPage < totalPages}">
            <a href="?keyword=${keyword}&tier=${tier}&page=${currentPage+1}"
               class="pb"><i class="bi bi-chevron-right"></i></a>
          </c:if>
        </div>
      </div>
    </c:if>
  </div>

</div><!-- /wrapper -->

<!-- MODAL RESET MẬT KHẨU -->
<div class="mo" id="moReset">
  <div class="mb">
    <div class="mh">
      <h5><i class="bi bi-key me-2"></i>Reset mật khẩu</h5>
      <button class="mcl" onclick="closeMo()">&times;</button>
    </div>
    <div class="mbody">
      <div style="text-align:center;margin-bottom:18px;">
        <i class="bi bi-key-fill"
           style="font-size:2.5rem;color:#ffc107;opacity:.8;"></i>
        <p style="margin-top:12px;font-size:14px;color:#0f172a;">
          Reset mật khẩu cho <strong id="rpwName"></strong>?
        </p>
        <p style="font-size:12px;color:#94a3b8;">
          Mật khẩu mặc định: <strong>123456</strong>
        </p>
      </div>
      <form id="rpwForm" method="post">
        <div style="display:flex;gap:8px;justify-content:flex-end;">
          <button type="button" class="bcancel" onclick="closeMo()">Hủy</button>
          <button type="submit" class="bsave">
            <i class="bi bi-check me-1"></i>Xác nhận
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
/* Đếm VIP / VVIP */
(function(){
  var rows = document.querySelectorAll('#custTbody tr');
  var v=0, vv=0;
  rows.forEach(function(r){
    if(r.querySelector('.tier-v'))  v++;
    if(r.querySelector('.tier-vv')) vv++;
  });
  document.getElementById('vipCnt').textContent  = v;
  document.getElementById('vvipCnt').textContent = vv;
})();

function openResetPw(uid, name){
  document.getElementById('rpwName').textContent = name;
  document.getElementById('rpwForm').action =
    '/dyleeseafood/admin/customers/reset-password/'+uid;
  document.getElementById('moReset').classList.add('open');
}
function closeMo(){
  document.getElementById('moReset').classList.remove('open');
}
document.getElementById('moReset').addEventListener('click', function(e){
  if(e.target === this) closeMo();
});
</script>

<%@ include file="layout/sidebar-end.jsp" %>
