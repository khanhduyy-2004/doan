package com.springmvc.controller;

import com.springmvc.dao.AddressDao;
import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.OrderDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.Address;
import com.springmvc.model.CartItem;
import com.springmvc.model.Customer;
import com.springmvc.model.Order;
import com.springmvc.model.OrderItem;
import com.springmvc.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired private OrderDao     orderDao;
    @Autowired private CustomerDao  customerDao;
    @Autowired private ProductDao   productDao;
    @Autowired private CategoryDao  categoryDao;
    @Autowired private AddressDao   addressDao;

    // ═══ CHECKOUT ═══
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) return "redirect:/cart";

        Customer customer = customerDao.findByUserId(user.getId());
        double subtotal = 0;
        for (CartItem item : cart) subtotal += item.getTotalPrice();

        // Chiết khấu theo hạng thành viên
        double discountPct = customerDao.getDiscountPercent(customer.getTierId());
        double discount    = subtotal * discountPct / 100.0;
        double total       = subtotal - discount;

        model.addAttribute("customer",     customer);
        model.addAttribute("cart",         cart);
        model.addAttribute("subtotal",     subtotal);
        model.addAttribute("discountPct",  discountPct);
        model.addAttribute("discount",     discount);
        model.addAttribute("total",        total);
        model.addAttribute("savedAddresses", addressDao.findByCustomerId(customer.getId()));
        model.addAttribute("categories",   categoryDao.findAll());
        return "order/checkout";
    }

    // ═══ ĐẶT HÀNG ═══
    @PostMapping("/place")
    public String placeOrder(
            @RequestParam(required = false) Integer savedAddressId,
            @RequestParam(required = false) String fullName,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address,
            @RequestParam(required = false, defaultValue = "") String ward,
            @RequestParam(required = false, defaultValue = "") String district,
            @RequestParam(required = false) String city,
            @RequestParam String paymentMethod,
            @RequestParam(required = false) String note,
            HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) return "redirect:/cart";

        try {
            Customer customer = customerDao.findByUserId(user.getId());

            double subtotal = 0;
            for (CartItem item : cart) subtotal += item.getTotalPrice();

            // Chiết khấu VIP
            double discountPct = customerDao.getDiscountPercent(customer.getTierId());
            double discount    = subtotal * discountPct / 100.0;
            double total       = subtotal - discount;

            // Địa chỉ: dùng địa chỉ đã lưu hoặc nhập mới
            int addressId;
            if (savedAddressId != null && savedAddressId > 0) {
                addressId = savedAddressId;
            } else {
                addressId = orderDao.saveAddress(
                    fullName, phone, address, ward, district, city, customer.getId());
            }

            int orderId = orderDao.createOrder(
                customer.getId(), addressId, subtotal, total, note);

            for (CartItem item : cart)
                orderDao.addOrderItem(orderId, item.getProductId(),
                                      item.getQuantity(), item.getPrice());

            orderDao.createPayment(orderId, paymentMethod, total);
            session.removeAttribute("cart");
            return "redirect:/order/success/" + orderId;

        } catch (Exception e) {
            Customer customer = customerDao.findByUserId(user.getId());
            double subtotal = 0;
            for (CartItem item : cart) subtotal += item.getTotalPrice();
            double discountPct = customerDao.getDiscountPercent(customer.getTierId());
            double discount    = subtotal * discountPct / 100.0;
            model.addAttribute("customer",      customer);
            model.addAttribute("cart",          cart);
            model.addAttribute("subtotal",      subtotal);
            model.addAttribute("discountPct",   discountPct);
            model.addAttribute("discount",      discount);
            model.addAttribute("total",         subtotal - discount);
            model.addAttribute("savedAddresses",addressDao.findByCustomerId(customer.getId()));
            model.addAttribute("categories",    categoryDao.findAll());
            model.addAttribute("error",         "Có lỗi xảy ra: " + e.getMessage());
            return "order/checkout";
        }
    }

    // ═══ THÀNH CÔNG ═══
    @GetMapping("/success/{orderId}")
    public String success(@PathVariable int orderId,
                          HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("order",      orderDao.findById(orderId));
        model.addAttribute("items",      orderDao.findItems(orderId));
        model.addAttribute("categories", categoryDao.findAll());
        return "order/success";
    }

    // ═══ LỊCH SỬ ═══
    @GetMapping("/history")
    public String history(
            @RequestParam(required = false) String status,
            HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Customer customer = customerDao.findByUserId(user.getId());
        if (customer == null) return "redirect:/home";

        List<Order> orders = (status != null && !status.isEmpty())
            ? orderDao.findByCustomerAndStatus(customer.getId(), status)
            : orderDao.findByCustomerId(customer.getId());

        for (Order order : orders)
            order.setItems(orderDao.findItems(order.getId()));

        model.addAttribute("orders",       orders);
        model.addAttribute("statusFilter", status);
        model.addAttribute("categories",   categoryDao.findAll());
        return "order/history";
    }

    // ═══ THEO DÕI ═══
    @GetMapping("/tracking/{orderId}")
    public String tracking(@PathVariable int orderId,
                           HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Order order = orderDao.findById(orderId);
        if (order == null) return "redirect:/order/history";

        if (user.getRoleId() == 3) {
            Customer customer = customerDao.findByUserId(user.getId());
            if (customer != null && order.getCustomerId() != customer.getId())
                return "redirect:/order/history";
        }

        model.addAttribute("order",      order);
        model.addAttribute("items",      orderDao.findItems(orderId));
        model.addAttribute("categories", categoryDao.findAll());
        return "order/tracking";
    }

    // ═══ HỦY ĐƠN ═══
    @PostMapping("/cancel/{id}")
    public String cancelOrder(@PathVariable int id,
                              HttpSession session,
                              RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Order order = orderDao.findById(id);
        if (order == null) {
            ra.addFlashAttribute("cancelError", "Không tìm thấy đơn hàng.");
            return "redirect:/order/history";
        }
        Customer customer = customerDao.findByUserId(user.getId());
        if (customer == null || order.getCustomerId() != customer.getId()) {
            ra.addFlashAttribute("cancelError", "Bạn không có quyền hủy đơn này.");
            return "redirect:/order/history";
        }
        if (!"Pending".equals(order.getStatus())) {
            ra.addFlashAttribute("cancelError",
                "Không thể hủy đơn ở trạng thái \"" + order.getStatus() + "\".");
            return "redirect:/order/tracking/" + id;
        }
        orderDao.updateStatus(id, "Cancelled");
        ra.addFlashAttribute("cancelSuccess", "Đơn hàng #DL" + id + " đã được hủy thành công.");
        return "redirect:/order/history";
    }
}
