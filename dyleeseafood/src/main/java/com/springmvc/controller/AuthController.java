package com.springmvc.controller;

import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.UserDao;
import com.springmvc.model.Customer;
import com.springmvc.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private CustomerDao customerDao;

    // ========== TRANG CHỦ ==========
    @GetMapping("/")
    public String home() {
        return "redirect:/home";
    }

    // ========== LOGIN ==========
    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("loggedUser") != null)
            return "redirect:/home";
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session, Model model) {
        User user = userDao.findByUsername(username);
        if (user == null || !BCrypt.checkpw(password, user.getPassword())) {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            return "auth/login";
        }
        if (!user.isActive()) {
            model.addAttribute("error", "Tài khoản đã bị khóa!");
            return "auth/login";
        }
        // Lưu user vào session
        session.setAttribute("loggedUser", user);
        // Lưu customer vào session
        Customer customer = customerDao.findByUserId(user.getId());
        session.setAttribute("loggedCustomer", customer);

        // Phân quyền redirect
        if (user.getRoleId() == 1 || user.getRoleId() == 2)
            return "redirect:/admin/dashboard";
        return "redirect:/home";
    }

    // ========== REGISTER ==========
    @GetMapping("/register")
    public String registerPage() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String phone,
                           Model model) {
        if (userDao.findByUsername(username) != null) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "auth/register";
        }
        // Tạo user
        User user = new User();
        user.setUsername(username);
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        userDao.save(user);

        // Tạo customer
        User saved = userDao.findByUsername(username);
        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setUserId(saved.getId());
        customerDao.save(customer);

        model.addAttribute("success", "Đăng ký thành công! Hãy đăng nhập.");
        return "auth/login";
    }

    // ========== LOGOUT ==========
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}