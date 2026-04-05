package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.dao.UserDao;
import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private ProductDao productDao;
    @Autowired private CategoryDao categoryDao;
    @Autowired private UserDao userDao;
    @Autowired private CustomerDao customerDao;

    private boolean isAdmin(HttpSession session) {
        var user = (com.springmvc.model.User)
                   session.getAttribute("loggedUser");
        return user != null &&
               (user.getRoleId() == 1 || user.getRoleId() == 2);
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("totalProducts",
                           productDao.findAll().size());
        model.addAttribute("totalCategories",
                           categoryDao.findAll().size());
        return "admin/dashboard";
    }

    @GetMapping("/products")
    public String products(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("products", productDao.findAll());
        model.addAttribute("categories", categoryDao.findAll());
        return "admin/products";
    }

    @GetMapping("/products/add")
    public String addForm(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryDao.findAll());
        return "admin/product-form";
    }

    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute Product product,
                             HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productDao.save(product);
        return "redirect:/admin/products";
    }

    @GetMapping("/products/edit/{id}")
    public String editForm(@PathVariable int id,
                           HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", productDao.findById(id));
        model.addAttribute("categories", categoryDao.findAll());
        return "admin/product-form";
    }

    @PostMapping("/products/edit/{id}")
    public String editProduct(@PathVariable int id,
                              @ModelAttribute Product product,
                              HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        product.setId(id);
        productDao.update(product);
        return "redirect:/admin/products";
    }

    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable int id,
                                HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productDao.delete(id);
        return "redirect:/admin/products";
    }
}