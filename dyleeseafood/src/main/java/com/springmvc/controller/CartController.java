package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.CartItem;
import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired private ProductDao  productDao;
    @Autowired private CategoryDao categoryDao;

    // ── XEM GIỎ HÀNG ─────────────────────────────────────────────────────────
    @GetMapping("")
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = getCart(session);
        double total = 0;
        for (CartItem item : cart) total += item.getTotalPrice();
        model.addAttribute("cart",       cart);
        model.addAttribute("total",      total);
        model.addAttribute("categories", categoryDao.findAll());
        return "cart";
    }

    // ── TRANG CHỌN SỐ LƯỢNG  →  GET /cart/select/{id} ────────────────────────
    @GetMapping("/select/{id}")
    public String selectPage(@PathVariable int id, Model model) {
        Product p = productDao.findById(id);
        if (p == null) return "redirect:/products";
        model.addAttribute("product",    p);
        model.addAttribute("images",     productDao.findImagesByProductId(id));
        model.addAttribute("related",    productDao.findByCategoryExclude(p.getCategoryId(), id, 4));
        model.addAttribute("categories", categoryDao.findAll());
        return "cart/select";
    }

    // ── THÊM VÀO GIỎ (thường) ────────────────────────────────────────────────
    @GetMapping("/add/{productId}")
    public String addToCart(@PathVariable int productId, HttpSession session) {
        Product p = productDao.findById(productId);
        if (p == null) return "redirect:/products";
        List<CartItem> cart = getCart(session);
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(item.getQuantity() + 1);
                found = true; break;
            }
        }
        if (!found) cart.add(new CartItem(p, 1));
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // ── THÊM VÀO GIỎ AJAX  →  POST /cart/add-ajax/{id}?qty=&note= ───────────
    @PostMapping("/add-ajax/{productId}")
    @ResponseBody
    public Map<String, Object> addAjax(
            @PathVariable int productId,
            @RequestParam(name = "qty",  defaultValue = "1")  double qty,
            @RequestParam(name = "note", defaultValue = "")    String note,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        try {
            Product p = productDao.findById(productId);
            if (p == null) {
                result.put("success", false);
                result.put("message", "Sản phẩm không tồn tại");
                return result;
            }
            List<CartItem> cart = getCart(session);
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + qty);
                    if (!note.isEmpty()) item.setNote(note);
                    found = true; break;
                }
            }
            if (!found) {
                CartItem ci = new CartItem(p, qty);
                if (!note.isEmpty()) ci.setNote(note);
                cart.add(ci);
            }
            session.setAttribute("cart", cart);
            result.put("success",     true);
            result.put("message",     "Đã thêm vào giỏ hàng!");
            result.put("cartCount",   cart.size());
            result.put("productName", p.getName());
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Có lỗi xảy ra: " + e.getMessage());
        }
        return result;
    }

    // ── CẬP NHẬT SỐ LƯỢNG ────────────────────────────────────────────────────
    @PostMapping("/update/{productId}")
    public String update(@PathVariable int productId,
                         @RequestParam(name = "quantity") double quantity,
                         HttpSession session) {
        List<CartItem> cart = getCart(session);
        if (quantity <= 0) {
            cart.removeIf(i -> i.getProductId() == productId);
        } else {
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity); break;
                }
            }
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // ── TĂNG / GIẢM SỐ LƯỢNG ─────────────────────────────────────────────────
    @GetMapping("/increase/{productId}")
    public String increase(@PathVariable int productId, HttpSession session) {
        List<CartItem> cart = getCart(session);
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(item.getQuantity() + 0.5); break;
            }
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    @GetMapping("/decrease/{productId}")
    public String decrease(@PathVariable int productId, HttpSession session) {
        List<CartItem> cart = getCart(session);
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                double newQty = item.getQuantity() - 0.5;
                if (newQty <= 0) cart.remove(item);
                else item.setQuantity(newQty);
                break;
            }
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // ── XÓA / XÓA TẤT CẢ ────────────────────────────────────────────────────
    @GetMapping("/remove/{productId}")
    public String remove(@PathVariable int productId, HttpSession session) {
        List<CartItem> cart = getCart(session);
        cart.removeIf(i -> i.getProductId() == productId);
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    @GetMapping("/clear")
    public String clear(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/cart";
    }

    // ── HELPER ────────────────────────────────────────────────────────────────
    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();
        return cart;
    }
}
