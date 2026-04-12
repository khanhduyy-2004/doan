package com.springmvc.controller;

import com.springmvc.dao.BannerDao;
import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.OrderDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.Customer;
import com.springmvc.model.Order;
import com.springmvc.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {

    @Autowired private ProductDao  productDao;
    @Autowired private CategoryDao categoryDao;
    @Autowired private BannerDao   bannerDao;
    @Autowired private CustomerDao customerDao;
    @Autowired private OrderDao    orderDao;

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        model.addAttribute("banners",
            bannerDao.findActive());
        model.addAttribute("categories",
            categoryDao.findAll());
        model.addAttribute("featuredProducts",
            productDao.findFeatured());

        // Lịch sử mua hàng — chỉ khi đã đăng nhập
        User user = (User)
            session.getAttribute("loggedUser");
        if (user != null) {
            Customer customer =
                customerDao.findByUserId(user.getId());
            if (customer != null) {
                List<Order> orders =
                    orderDao.findByCustomerId(
                        customer.getId());
                // Lấy 3 đơn gần nhất
                model.addAttribute("recentOrders",
                    orders.size() > 3
                    ? orders.subList(0, 3)
                    : orders);
                model.addAttribute("customer", customer);
            }
        }

        return "index";
    }
}