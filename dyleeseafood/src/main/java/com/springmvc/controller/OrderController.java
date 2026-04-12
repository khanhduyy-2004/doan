package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.OrderDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.CartItem;
import com.springmvc.model.Customer;
import com.springmvc.model.Order;
import com.springmvc.model.OrderItem;
import com.springmvc.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired private OrderDao orderDao;
    @Autowired private CustomerDao customerDao;
    @Autowired private ProductDao productDao;
    @Autowired private CategoryDao categoryDao;

    // ===== TRANG CHECKOUT =====
    @GetMapping("/checkout")
    public String checkout(HttpSession session,
                           Model model) {
        User user = (User)
            session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = (List<CartItem>)
            session.getAttribute("cart");
        if (cart == null || cart.isEmpty())
            return "redirect:/cart";

        // LẤY THÔNG TIN CUSTOMER ← ĐÃ THÊM
        Customer customer =
            customerDao.findByUserId(user.getId());
        model.addAttribute("customer", customer);

        double total = 0;
        for (CartItem item : cart)
            total += item.getTotalPrice();

        model.addAttribute("cart", cart);
        model.addAttribute("total", total);
        model.addAttribute("categories",
                           categoryDao.findAll());
        return "order/checkout";
    }

    // ===== ĐẶT HÀNG =====
    @PostMapping("/place")
    public String placeOrder(
            @RequestParam String fullName,
            @RequestParam String phone,
            @RequestParam String address,
            @RequestParam(required=false,
                          defaultValue="")
                String ward,
            @RequestParam(required=false,
                          defaultValue="")
                String district,
            @RequestParam String city,
            @RequestParam String paymentMethod,
            @RequestParam(required=false) String note,
            HttpSession session, Model model) {

        User user = (User)
            session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = (List<CartItem>)
            session.getAttribute("cart");
        if (cart == null || cart.isEmpty())
            return "redirect:/cart";

        try {
            Customer customer =
                customerDao.findByUserId(user.getId());

            double total = 0;
            for (CartItem item : cart)
                total += item.getTotalPrice();

            int addressId = orderDao.saveAddress(
                fullName, phone, address,
                ward, district, city,
                customer.getId());

            int orderId = orderDao.createOrder(
                customer.getId(), addressId,
                total, total, note);

            for (CartItem item : cart) {
                orderDao.addOrderItem(
                    orderId,
                    item.getProductId(),
                    item.getQuantity(),
                    item.getPrice());
            }

            orderDao.createPayment(
                orderId, paymentMethod, total);

            session.removeAttribute("cart");
            return "redirect:/order/success/" + orderId;

        } catch (Exception e) {
            // Trả lại trang checkout với lỗi
            Customer customer =
                customerDao.findByUserId(user.getId());
            double total = 0;
            for (CartItem item : cart)
                total += item.getTotalPrice();
            model.addAttribute("customer", customer);
            model.addAttribute("cart", cart);
            model.addAttribute("total", total);
            model.addAttribute("categories",
                               categoryDao.findAll());
            model.addAttribute("error",
                "Có lỗi xảy ra: " + e.getMessage());
            return "order/checkout";
        }
    }

    // ===== TRANG THÀNH CÔNG =====
    @GetMapping("/success/{orderId}")
    public String success(@PathVariable int orderId,
                          HttpSession session,
                          Model model) {
        User user = (User)
            session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Order order = orderDao.findById(orderId);
        List<OrderItem> items =
            orderDao.findItems(orderId);

        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("categories",
                           categoryDao.findAll());
        return "order/success";
    }

    // ===== LỊCH SỬ MUA HÀNG =====
    @GetMapping("/history")
    public String history(
            @RequestParam(required=false) String status,
            HttpSession session, Model model) {

        User user = (User)
            session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Customer customer =
            customerDao.findByUserId(user.getId());
        if (customer == null) return "redirect:/home";

        List<Order> orders;
        if (status != null && !status.isEmpty()) {
            orders = orderDao.findByCustomerAndStatus(
                customer.getId(), status);
        } else {
            orders = orderDao.findByCustomerId(
                customer.getId());
        }

        for (Order order : orders) {
            order.setItems(
                orderDao.findItems(order.getId()));
        }

        model.addAttribute("orders", orders);
        model.addAttribute("statusFilter", status);
        model.addAttribute("categories",
                           categoryDao.findAll());
        return "order/history";
    }

    // ===== THEO DÕI ĐƠN HÀNG =====
    @GetMapping("/tracking/{orderId}")
    public String tracking(
            @PathVariable int orderId,
            HttpSession session, Model model) {

        User user = (User)
            session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Order order = orderDao.findById(orderId);
        if (order == null)
            return "redirect:/order/history";

        if (user.getRoleId() == 3) {
            Customer customer =
                customerDao.findByUserId(user.getId());
            if (customer != null
                && order.getCustomerId()
                   != customer.getId()) {
                return "redirect:/order/history";
            }
        }

        List<OrderItem> items =
            orderDao.findItems(orderId);

        model.addAttribute("order", order);
        model.addAttribute("items", items);
        model.addAttribute("categories",
                           categoryDao.findAll());
        return "order/tracking";
    }
}