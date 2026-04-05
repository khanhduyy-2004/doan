package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private CategoryDao categoryDao;

    // Danh sách sản phẩm + lọc danh mục + tìm kiếm
    @GetMapping("")
    public String list(@RequestParam(required = false) Integer category,
                       @RequestParam(required = false) String keyword,
                       Model model) {
        List<Product> products;

        if (keyword != null && !keyword.isEmpty()) {
            products = productDao.search(keyword);
            model.addAttribute("keyword", keyword);
        } else if (category != null) {
            products = productDao.findByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else {
            products = productDao.findAll();
        }

        model.addAttribute("products", products);
        model.addAttribute("categories", categoryDao.findAll());
        return "product/list";
    }

    // Chi tiết sản phẩm
    @GetMapping("/{id}")
    public String detail(@PathVariable int id, Model model) {
        model.addAttribute("product", productDao.findById(id));
        model.addAttribute("categories", categoryDao.findAll());
        return "product/detail";
    }
}