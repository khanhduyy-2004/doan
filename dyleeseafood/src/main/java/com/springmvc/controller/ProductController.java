package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Comparator;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired private ProductDao  productDao;
    @Autowired private CategoryDao categoryDao;

    private static final int PAGE_SIZE = 12;

    // ===== DANH SÁCH =====
    @GetMapping("")
    public String list(
            @RequestParam(name="category", required=false) Integer category,
            @RequestParam(name="keyword", required=false) String keyword,
            @RequestParam(name="sort", required=false) String sort,
            @RequestParam(name="page", defaultValue="1") int page,
            Model model) {

        // 1. Lấy danh sách theo điều kiện
        List<Product> all;
        if (keyword != null && !keyword.trim().isEmpty()) {
            all = productDao.search(keyword);
        } else if (category != null) {
            all = productDao.findByCategory(category);
        } else {
            all = productDao.findAll();
        }

        // 2. Sắp xếp
        if ("price-asc".equals(sort))
            all.sort(Comparator
                .comparingDouble(Product::getPrice));
        else if ("price-desc".equals(sort))
            all.sort(Comparator
                .comparingDouble(Product::getPrice)
                .reversed());
        else if ("name-asc".equals(sort))
            all.sort(Comparator
                .comparing(Product::getName,
                    String.CASE_INSENSITIVE_ORDER));
        else if ("stock-desc".equals(sort))
            all.sort(Comparator
                .comparingDouble(Product::getStock)
                .reversed());

        // 3. Phân trang
        int total      = all.size();
        int totalPages = (int) Math.ceil(
            (double) total / PAGE_SIZE);

        // Giới hạn page hợp lệ
        if (page < 1) page = 1;
        if (totalPages > 0 && page > totalPages)
            page = totalPages;

        int from = (page - 1) * PAGE_SIZE;
        int to   = Math.min(from + PAGE_SIZE, total);

        model.addAttribute("products",
            total > 0 ? all.subList(from, to) : all);
        model.addAttribute("categories",
            categoryDao.findAll());
        model.addAttribute("selectedCategory", category);
        model.addAttribute("keyword",       keyword);
        model.addAttribute("sort",          sort);
        model.addAttribute("currentPage",   page);
        model.addAttribute("totalPages",    totalPages);
        model.addAttribute("totalProducts", total);
        return "product/list";
    }

    // ===== CHI TIẾT =====
    @GetMapping("/{id}")
    public String detail(@PathVariable int id,
                          Model model) {
        Product product = productDao.findById(id);
        if (product == null)
            return "redirect:/products";

        List<String> productImages =
            productDao.findImagesByProductId(id);

        List<Product> related =
            productDao.findByCategory(
                product.getCategoryId());
        related.removeIf(
            p -> p.getId() == product.getId());
        if (related.size() > 5)
            related = related.subList(0, 5);

        model.addAttribute("product",       product);
        model.addAttribute("productImages", productImages);
        model.addAttribute("related",       related);
        model.addAttribute("categories",
            categoryDao.findAll());
        return "product/detail";
    }
}
