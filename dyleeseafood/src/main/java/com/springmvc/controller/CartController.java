package com.springmvc.controller;

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

    @Autowired
    private ProductDao productDao;

    // Xem giỏ hàng
    @GetMapping("")
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = getCart(session);
        double total = cart.stream()
            .mapToDouble(CartItem::getTotalPrice).sum();
        model.addAttribute("cart", cart);
        model.addAttribute("total", total);
        return "cart";
    }

    // Thêm vào giỏ
    @GetMapping("/add/{id}")
    public String addToCart(@PathVariable int id,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session) {
        List<CartItem> cart = getCart(session);
        Product product = productDao.findById(id);

        for (CartItem item : cart) {
            if (item.getProduct().getId() == id) {
                item.setQuantity(item.getQuantity() + quantity);
                session.setAttribute("cart", cart);
                return "redirect:/cart";
            }
        }
        cart.add(new CartItem(product, quantity));
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // Cập nhật số lượng
    @PostMapping("/update/{id}")
    public String update(@PathVariable int id,
                         @RequestParam int quantity,
                         HttpSession session) {
        List<CartItem> cart = getCart(session);
        for (CartItem item : cart) {
            if (item.getProduct().getId() == id) {
                if (quantity <= 0)
                    cart.remove(item);
                else
                    item.setQuantity(quantity);
                break;
            }
        }
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // Xóa 1 sản phẩm
    @GetMapping("/remove/{id}")
    public String remove(@PathVariable int id, HttpSession session) {
        List<CartItem> cart = getCart(session);
        cart.removeIf(item -> item.getProduct().getId() == id);
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    // Xóa toàn bộ
    @GetMapping("/clear")
    public String clear(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/cart";
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }
}