package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StaticController {

    @Autowired private CategoryDao categoryDao;

    private void addCategories(Model m) {
        m.addAttribute("categories",
            categoryDao.findAll());
    }

    @GetMapping("/about")
    public String about(Model m) {
        addCategories(m); return "static/about";
    }

    @GetMapping("/contact")
    public String contact(Model m) {
        addCategories(m); return "static/contact";
    }

    @GetMapping("/news")
    public String news(Model m) {
        addCategories(m); return "static/news";
    }

    @GetMapping("/recruitment")
    public String recruitment(Model m) {
        addCategories(m); return "static/recruitment";
    }

    @GetMapping("/faq")
    public String faq(Model m) {
        addCategories(m); return "static/faq";
    }

    @GetMapping("/guide/order")
    public String guideOrder(Model m) {
        addCategories(m); return "static/guide-order";
    }

    @GetMapping("/guide/payment")
    public String guidePayment(Model m) {
        addCategories(m); return "static/guide-payment";
    }

    @GetMapping("/guide/shipping")
    public String guideShipping(Model m) {
        addCategories(m); return "static/guide-shipping";
    }

    @GetMapping("/guide/return")
    public String guideReturn(Model m) {
        addCategories(m); return "static/guide-return";
    }

    @GetMapping("/policy/privacy")
    public String privacy(Model m) {
        addCategories(m); return "static/policy-privacy";
    }
}