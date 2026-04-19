<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
:root{--primary:#0077b6;--dark:#023e8a;}
.page-bg{background:#f5f6fa;padding:24px 0 60px;}
.page-hero{background:linear-gradient(135deg,var(--dark),var(--primary));padding:14px 0;}

/* CARD 2 CỘT */
.select-card{background:white;border-radius:18px;box-shadow:0 4px 24px rgba(0,0,0,0.08);overflow:hidden;}

/* CỘT ẢNH */
.img-col{position:relative;background:#f0f4f8;min-height:460px;overflow:hidden;}
.img-main{width:100%;height:100%;min-height:460px;object-fit:cover;display:block;transition:transform .4s;}
.img-col:hover .img-main{transform:scale(1.04);}
.badge-feat{position:absolute;top:14px;left:14px;background:#ffc107;color:#333;
  border-radius:20px;padding:5px 13px;font-size:11px;font-weight:700;z-index:2;}
.badge-stk{position:absolute;bottom:14px;left:14px;border-radius:10px;
  padding:6px 13px;font-size:11px;font-weight:600;z-index:2;}
.thumb-row{position:absolute;bottom:14px;right:14px;display:flex;gap:6px;flex-wrap:wrap;z-index:2;}
.thumb{width:50px;height:50px;object-fit:cover;border-radius:8px;cursor:pointer;
  border:2.5px solid white;opacity:.75;transition:all .15s;}
.thumb:hover,.thumb.on{opacity:1;border-color:#ffc107;}

/* CỘT PHẢI */
.form-col{padding:28px 28px 24px;}
.cat-pill{background:#e3f2fd;color:var(--primary);border-radius:20px;
  padding:4px 13px;font-size:12px;font-weight:600;display:inline-flex;
  align-items:center;gap:5px;margin-bottom:10px;}
.prod-name{font-size:1.45rem;font-weight:800;color:#0f172a;line-height:1.3;margin-bottom:8px;}
.prod-desc{font-size:13px;color:#64748b;line-height:1.7;margin-bottom:14px;}

/* PRICE */
.price-box{background:linear-gradient(135deg,var(--dark),var(--primary));
  border-radius:12px;padding:14px 18px;margin-bottom:16px;}
.price-num{font-size:2rem;font-weight:800;color:white;line-height:1;}
.price-unit{font-size:11px;color:rgba(255,255,255,.7);margin-top:3px;}

/* INFO TABLE */
.info-tbl{border:1px solid #f1f5f9;border-radius:12px;overflow:hidden;margin-bottom:16px;}
.info-row-item{display:flex;padding:8px 14px;font-size:13px;border-bottom:1px solid #f1f5f9;}
.info-row-item:last-child{border:none;}
.info-row-item:nth-child(even){background:#fafbfc;}
.i-lbl{color:#64748b;width:120px;flex-shrink:0;}
.i-val{color:#0f172a;font-weight:600;}

/* SECTION LABEL */
.sec{font-size:12px;font-weight:700;color:#475569;margin-bottom:7px;
  display:flex;align-items:center;gap:5px;text-transform:uppercase;letter-spacing:.04em;}

/* STEPPER */
.stepper{display:flex;align-items:center;border:2px solid #e2e8f0;border-radius:10px;overflow:hidden;width:fit-content;}
.s-btn{width:44px;height:44px;border:none;background:white;font-size:1.3rem;
  cursor:pointer;color:var(--primary);font-weight:700;transition:all .15s;
  display:flex;align-items:center;justify-content:center;}
.s-btn:hover{background:#e3f2fd;}
.s-btn:active{transform:scale(.88);}
.s-inp{width:62px;height:44px;border:none;border-left:2px solid #e2e8f0;
  border-right:2px solid #e2e8f0;text-align:center;font-size:16px;
  font-weight:700;color:#0f172a;outline:none;}

/* FORM INPUTS */
.f-sel,.f-txt{width:100%;border:1.5px solid #e2e8f0;border-radius:9px;
  padding:10px 13px;font-size:13px;font-family:inherit;outline:none;
  color:#334155;transition:border .15s;background:white;}
.f-sel:focus,.f-txt:focus{border-color:var(--primary);}
.f-txt{resize:none;}

/* TOTAL */
.tot-box{background:#f8fafc;border:1px solid #e2e8f0;border-radius:11px;
  padding:13px 15px;margin:14px 0 13px;}
.tot-row{display:flex;justify-content:space-between;align-items:center;font-size:13px;}
.tot-row+.tot-row{margin-top:6px;padding-top:6px;border-top:1px dashed #e2e8f0;}
.tot-big{font-size:1.35rem;font-weight:800;color:var(--primary);}

/* BUTTONS */
.btn-add{width:100%;padding:13px;font-size:14px;font-weight:700;border-radius:11px;
  background:linear-gradient(135deg,var(--dark),var(--primary));color:white;
  border:none;cursor:pointer;transition:all .2s;margin-bottom:9px;
  display:flex;align-items:center;justify-content:center;gap:7px;}
.btn-add:hover{transform:translateY(-2px);box-shadow:0 8px 26px rgba(0,119,182,.35);}
.btn-add.done{background:linear-gradient(135deg,#16a34a,#22c55e);pointer-events:none;}
.btn-back{width:100%;padding:10px;font-size:13px;font-weight:600;border-radius:11px;
  background:white;color:#64748b;border:1.5px solid #e2e8f0;cursor:pointer;
  transition:all .15s;text-decoration:none;display:block;text-align:center;}
.btn-back:hover{border-color:var(--primary);color:var(--primary);}

/* CAM KẾT */
.pledge{display:flex;gap:6px;justify-content:space-around;margin-top:13px;
  padding-top:13px;border-top:1px solid #f1f5f9;}
.p-item{text-align:center;font-size:11px;color:#94a3b8;line-height:1.5;}
.p-item i{font-size:1.15rem;display:block;margin-bottom:2px;}

/* RELATED */
.related{margin-top:26px;}
.related h5{font-size:15px;font-weight:700;color:#0f172a;margin-bottom:14px;
  padding-bottom:9px;border-bottom:2px solid #f1f5f9;}
.r-card{background:white;border-radius:13px;box-shadow:0 2px 12px rgba(0,0,0,.06);
  overflow:hidden;transition:all .2s;display:block;text-decoration:none;color:inherit;}
.r-card:hover{transform:translateY(-4px);box-shadow:0 6px 20px rgba(0,0,0,.1);}
.r-img{width:100%;height:140px;object-fit:cover;}
.r-body{padding:11px 12px;}
.r-name{font-size:13px;font-weight:700;color:#1e293b;white-space:nowrap;
  overflow:hidden;text-overflow:ellipsis;margin-bottom:4px;}
.r-price{font-size:13px;font-weight:800;color:var(--primary);margin-bottom:7px;}
.r-btn{width:100%;padding:7px;font-size:12px;font-weight:700;border-radius:8px;
  background:var(--primary);color:white;border:none;cursor:pointer;transition:.15s;}
.r-btn:hover{background:var(--dark);}

/* FLY */
.fly{position:fixed;z-index:99999;border-radius:50%;object-fit:cover;
  pointer-events:none;box-shadow:0 6px 20px rgba(0,0,0,.25);}
@keyframes cbounce{0%{transform:scale(1)}40%{transform:scale(1.6)rotate(-15deg)}
  70%{transform:scale(1.3)rotate(10deg)}100%{transform:scale(1)}}
.cbounce{animation:cbounce .5s ease;}

/* TOAST */
#toast{position:fixed;bottom:22px;right:22px;background:white;border-radius:15px;
  box-shadow:0 8px 30px rgba(0,0,0,.14);padding:16px 17px;z-index:99998;width:305px;
  transform:translateX(130%);transition:transform .35s ease;pointer-events:none;}
#toast.show{transform:translateX(0);pointer-events:auto;}
.t-bar{height:3px;background:#e2e8f0;border-radius:3px;margin-top:10px;}
.t-fill{height:3px;background:var(--primary);border-radius:3px;width:100%;transition:width linear;}
</style>

<!-- BREADCRUMB -->
<div class="page-hero">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mb-0" style="--bs-breadcrumb-divider-color:rgba(255,255,255,.5);">
        <li class="breadcrumb-item"><a href="/dyleeseafood/home"   style="color:rgba(255,255,255,.75);">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="/dyleeseafood/products" style="color:rgba(255,255,255,.75);">Sản phẩm</a></li>
        <li class="breadcrumb-item"><a href="/dyleeseafood/product/${product.id}" style="color:rgba(255,255,255,.75);">${product.name}</a></li>
        <li class="breadcrumb-item active" style="color:white;">Thêm vào giỏ hàng</li>
      </ol>
    </nav>
  </div>
</div>

<div class="page-bg">
 <div class="container">
  <div class="select-card">
   <div class="row g-0">

    <!-- ====== ẢNH ====== -->
    <div class="col-lg-5 img-col">
      <img id="mainImg" class="img-main"
           src="${not empty images ? images[0] : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=700&q=80'}"
           onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=700&q=80'"
           alt="${product.name}">

      <c:if test="${product.featured}">
        <span class="badge-feat">⭐ Nổi bật</span>
      </c:if>

      <c:choose>
        <c:when test="${product.stock > 10}">
          <span class="badge-stk" style="background:rgba(22,163,74,.9);color:white;">
            <i class="bi bi-check-circle-fill me-1"></i>Còn hàng (${product.stock} ${product.unit})
          </span>
        </c:when>
        <c:when test="${product.stock > 0}">
          <span class="badge-stk" style="background:rgba(245,158,11,.9);color:white;">
            <i class="bi bi-exclamation-circle-fill me-1"></i>Sắp hết — còn ${product.stock} ${product.unit}
          </span>
        </c:when>
        <c:otherwise>
          <span class="badge-stk" style="background:rgba(220,38,38,.9);color:white;">
            <i class="bi bi-x-circle-fill me-1"></i>Hết hàng
          </span>
        </c:otherwise>
      </c:choose>

      <c:if test="${not empty images and images.size() > 1}">
        <div class="thumb-row">
          <c:forEach var="img" items="${images}" varStatus="s">
            <c:if test="${s.index < 5}">
              <img class="thumb ${s.first ? 'on' : ''}"
                   src="${img}"
                   onclick="switchImg(this,'${img}')" alt="">
            </c:if>
          </c:forEach>
        </div>
      </c:if>
    </div>

    <!-- ====== FORM ====== -->
    <div class="col-lg-7 form-col">

      <span class="cat-pill"><i class="bi bi-grid-fill"></i>${product.categoryName}</span>
      <h2 class="prod-name">${product.name}</h2>

      <c:if test="${not empty product.description}">
        <p class="prod-desc">${product.description}</p>
      </c:if>

      <!-- Giá -->
      <div class="price-box">
        <div class="price-num"><fmt:formatNumber value="${product.price}" pattern="#,###"/>đ</div>
        <div class="price-unit">/ ${product.unit}</div>
      </div>

      <!-- Thông tin nhanh -->
      <div class="info-tbl">
        <div class="info-row-item">
          <span class="i-lbl"><i class="bi bi-boxes me-2 text-primary"></i>Tồn kho</span>
          <span class="i-val">${product.stock} ${product.unit}</span>
        </div>
        <div class="info-row-item">
          <span class="i-lbl"><i class="bi bi-tag me-2 text-primary"></i>Danh mục</span>
          <span class="i-val">${product.categoryName}</span>
        </div>
        <div class="info-row-item">
          <span class="i-lbl"><i class="bi bi-truck me-2 text-success"></i>Giao hàng</span>
          <span class="i-val" style="color:#16a34a;">Miễn phí tại Hải Phòng</span>
        </div>
      </div>

      <c:choose>
       <c:when test="${product.stock > 0}">

        <!-- 1. SỐ LƯỢNG -->
        <div class="mb-3">
          <div class="sec"><i class="bi bi-boxes text-primary"></i>Số lượng</div>
          <div class="d-flex align-items-center gap-3">
            <div class="stepper">
              <button class="s-btn" onclick="changeQty(-1)">−</button>
              <input  class="s-inp" id="qtyInput" type="number"
                      value="1" min="1" max="${product.stock}"
                      oninput="clamp();refresh()">
              <button class="s-btn" onclick="changeQty(1)">+</button>
            </div>
            <span style="font-size:13px;color:#94a3b8;">
              Tối đa <strong>${product.stock}</strong> ${product.unit}
            </span>
          </div>
        </div>

        <!-- 2. NGÀY GIAO -->
        <div class="mb-3">
          <div class="sec"><i class="bi bi-calendar3 text-primary"></i>Ngày giao hàng</div>
          <select class="f-sel" id="daySel" onchange="toggleDate()">
            <option value="today">Hôm nay — giao trong 2 giờ</option>
            <option value="tomorrow">Ngày mai (7:00 – 10:00 sáng)</option>
            <option value="2days">Sau 2 ngày</option>
            <option value="pick">Chọn ngày cụ thể...</option>
          </select>
          <input type="date" id="datePick"
                 style="display:none;margin-top:7px;" class="f-sel">
        </div>

        <!-- 3. GHI CHÚ -->
        <div class="mb-3">
          <div class="sec"><i class="bi bi-chat-left-text text-primary"></i>Ghi chú / Yêu cầu đặc biệt</div>
          <textarea class="f-txt" id="noteInput" rows="2"
                    placeholder="Ví dụ: Cắt sơ, làm sạch sẵn, giao buổi sáng..."></textarea>
        </div>

        <!-- 4. TỔNG TIỀN -->
        <div class="tot-box">
          <div class="tot-row">
            <span style="color:#64748b;">Đơn giá</span>
            <span style="font-weight:600;color:#334155;">
              <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ / ${product.unit}
            </span>
          </div>
          <div class="tot-row">
            <span style="color:#64748b;">Số lượng</span>
            <span id="qtyShow" style="font-weight:600;color:#334155;">1 ${product.unit}</span>
          </div>
          <div class="tot-row">
            <span style="color:#64748b;">Phí giao hàng</span>
            <span style="color:#16a34a;font-weight:700;">Miễn phí</span>
          </div>
          <div class="tot-row" style="padding-top:9px;border-top:1.5px solid #e2e8f0;margin-top:3px;">
            <span style="font-size:14px;font-weight:700;color:#334155;">Tạm tính</span>
            <span id="totPrice" class="tot-big">
              <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ
            </span>
          </div>
        </div>

        <!-- 5. NÚT THÊM GIỎ -->
        <button class="btn-add" id="addBtn" onclick="doAdd()">
          <i class="bi bi-cart-plus" style="font-size:1.1rem;"></i>
          Thêm vào giỏ hàng
        </button>

        <!-- 6. NÚT QUAY LẠI -->
        <a href="/dyleeseafood/product/${product.id}" class="btn-back">
          <i class="bi bi-arrow-left me-1"></i>Quay lại chi tiết sản phẩm
        </a>

        <!-- 7. CAM KẾT -->
        <div class="pledge">
          <div class="p-item"><i class="bi bi-shield-check text-success"></i>Tươi 100%</div>
          <div class="p-item"><i class="bi bi-truck text-primary"></i>Giao 2h</div>
          <div class="p-item"><i class="bi bi-arrow-repeat text-warning"></i>Đổi trả 24h</div>
          <div class="p-item"><i class="bi bi-headset text-info"></i>Hỗ trợ 24/7</div>
        </div>

       </c:when>
       <c:otherwise>
        <div class="text-center py-4" style="background:#fef2f2;border-radius:12px;">
          <i class="bi bi-x-circle-fill text-danger" style="font-size:3rem;"></i>
          <p class="fw-bold mt-2 mb-1" style="color:#dc2626;">Sản phẩm tạm hết hàng</p>
          <a href="/dyleeseafood/products?category=${product.categoryId}"
             class="btn btn-primary px-4 mt-1" style="border-radius:9px;">
            Xem sản phẩm tương tự
          </a>
        </div>
       </c:otherwise>
      </c:choose>

    </div>
   </div>
  </div>

  <!-- ====== SẢN PHẨM GỢI Ý ====== -->
  <c:if test="${not empty related}">
    <div class="related">
      <h5><i class="bi bi-grid me-2 text-primary"></i>Sản phẩm liên quan</h5>
      <div class="row g-3">
        <c:forEach var="r" items="${related}">
          <div class="col-6 col-sm-4 col-md-3">
            <div class="r-card">
              <a href="/dyleeseafood/cart/select/${r.id}">
                <img class="r-img"
                     src="${not empty r.imageUrl ? r.imageUrl
                          : 'https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'}"
                     onerror="this.src='https://images.unsplash.com/photo-1510130387422-82bed34b37e9?w=400&q=80'"
                     alt="${r.name}">
                <div class="r-body">
                  <div class="r-name">${r.name}</div>
                  <div class="r-price"><fmt:formatNumber value="${r.price}" pattern="#,###"/>đ / ${r.unit}</div>
                </div>
              </a>
              <div class="r-body" style="padding-top:0;">
                <button class="r-btn"
                        onclick="location.href='/dyleeseafood/cart/select/${r.id}'">
                  <i class="bi bi-cart-plus me-1"></i>Chọn mua
                </button>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

 </div>
</div>

<!-- ====== TOAST ====== -->
<div id="toast">
  <div class="d-flex align-items-start gap-3 mb-2">
    <img id="tImg"
         src="${not empty images ? images[0] : ''}"
         style="width:50px;height:50px;object-fit:cover;border-radius:9px;flex-shrink:0;" alt="">
    <div style="flex:1;min-width:0;">
      <div class="fw-bold" style="font-size:13px;color:#0f172a;">
        <i class="bi bi-cart-check-fill text-success me-1"></i>Đã thêm vào giỏ!
      </div>
      <div class="text-muted text-truncate" style="font-size:12px;">${product.name}</div>
      <div id="tNote" style="font-size:11px;color:#94a3b8;display:none;"></div>
    </div>
    <button onclick="closeToast()"
            style="background:none;border:none;color:#aaa;font-size:18px;cursor:pointer;line-height:1;">&times;</button>
  </div>
  <div class="d-flex gap-2">
    <button onclick="closeToast()"
            class="btn btn-outline-secondary btn-sm flex-fill" style="border-radius:8px;font-size:12px;">
      <i class="bi bi-arrow-left me-1"></i>Tiếp tục mua
    </button>
    <a href="/dyleeseafood/cart"
       class="btn btn-primary btn-sm flex-fill" style="border-radius:8px;font-size:12px;">
      <i class="bi bi-cart3 me-1"></i>Xem giỏ hàng
      <span id="tCount" class="badge bg-warning text-dark ms-1" style="font-size:10px;"></span>
    </a>
  </div>
  <div class="t-bar"><div class="t-fill" id="tBar"></div></div>
</div>

<script>
var PRICE = ${product.price};
var MAX   = ${product.stock};
var PID   = ${product.id};
var UNIT  = '${product.unit}';

/* ---- THUMBNAILS ---- */
function switchImg(el, src) {
  document.getElementById('mainImg').src = src;
  document.querySelectorAll('.thumb').forEach(function(t){t.classList.remove('on');});
  el.classList.add('on');
}

/* ---- STEPPER ---- */
function changeQty(d) {
  var inp = document.getElementById('qtyInput');
  var v = (parseInt(inp.value)||1) + d;
  if(v<1) v=1; if(v>MAX) v=MAX;
  inp.value = v; refresh();
}
function clamp() {
  var inp = document.getElementById('qtyInput');
  var v = parseInt(inp.value)||1;
  if(v<1) v=1; if(v>MAX) v=MAX; inp.value=v;
}
function refresh() {
  var q = parseInt(document.getElementById('qtyInput').value)||1;
  document.getElementById('qtyShow').textContent = q+' '+UNIT;
  document.getElementById('totPrice').textContent = (PRICE*q).toLocaleString('vi-VN')+'đ';
}

/* ---- DELIVERY DATE ---- */
function toggleDate() {
  var v = document.getElementById('daySel').value;
  var dp = document.getElementById('datePick');
  if(v==='pick'){
    dp.style.display='block';
    var d=new Date(); d.setDate(d.getDate()+1);
    dp.min=d.toISOString().split('T')[0];
  } else dp.style.display='none';
}

/* ---- FLY ANIMATION ---- */
function flyToCart() {
  var img = document.getElementById('mainImg');
  var r   = img.getBoundingClientRect();
  var ce  = document.getElementById('cartBadge') || document.querySelector('a[href*="/cart"]');
  var ex  = ce ? ce.getBoundingClientRect().left+14 : window.innerWidth-60;
  var ey  = ce ? ce.getBoundingClientRect().top+14  : 24;
  var fly = document.createElement('img');
  fly.src = img.src; fly.className='fly';
  Object.assign(fly.style,{
    width:'76px',height:'76px',
    left:(r.left+r.width/2-38)+'px',top:(r.top+r.height/2-38)+'px',
    opacity:'1',transform:'scale(1)'
  });
  document.body.appendChild(fly);
  requestAnimationFrame(function(){requestAnimationFrame(function(){
    fly.style.transition='left .75s cubic-bezier(.25,.46,.45,.94),top .75s cubic-bezier(.55,0,1,.45),width .75s,height .75s,opacity .75s,transform .75s';
    fly.style.left=(ex-14)+'px'; fly.style.top=(ey-14)+'px';
    fly.style.width='28px'; fly.style.height='28px';
    fly.style.opacity='0'; fly.style.transform='scale(0)rotate(720deg)';
  });});
  setTimeout(function(){
    if(fly.parentNode) document.body.removeChild(fly);
    var b=document.getElementById('cartBadge');
    if(b){b.classList.add('cbounce');setTimeout(function(){b.classList.remove('cbounce');},500);}
  },760);
}

/* ---- ADD TO CART → chuyển về Home, badge nảy ---- */
function doAdd(){
  var qty  = parseInt(document.getElementById('qtyInput').value)||1;
  var note = document.getElementById('noteInput').value.trim();
  var btn  = document.getElementById('addBtn');

  /* Đổi nút sang trạng thái loading */
  btn.innerHTML='<i class="bi bi-hourglass-split"></i> Đang thêm...';
  btn.style.opacity='.8'; btn.style.pointerEvents='none';

  /* Animation ném ảnh lên icon giỏ */
  flyToCart();

  /* Sau khi animation xong (~800ms) mới gọi API */
  setTimeout(function(){
    fetch('/dyleeseafood/cart/add-ajax/'+PID+'?qty='+qty+'&note='+encodeURIComponent(note))
      .then(function(r){ return r.json(); })
      .then(function(d){
        if(d.success || d.cartCount){
          /* Lưu cartCount vào sessionStorage để home đọc và bounce */
          sessionStorage.setItem('cartAdded',      '1');
          sessionStorage.setItem('cartCount',      d.cartCount || '');
          sessionStorage.setItem('addedProduct',   '${product.name}');
          /* Chuyển về trang Home */
          window.location.href = '/dyleeseafood/home';
        } else {
          btn.innerHTML='<i class="bi bi-cart-plus"></i> Thêm vào giỏ hàng';
          btn.style.opacity='1'; btn.style.pointerEvents='auto';
          alert(d.message || 'Có lỗi xảy ra, vui lòng thử lại.');
        }
      })
      .catch(function(){
        /* Fallback: redirect luôn về home kèm param */
        window.location.href = '/dyleeseafood/cart/add/'+PID+'?qty='+qty+'&redirect=home';
      });
  }, 820);
}

refresh();
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
