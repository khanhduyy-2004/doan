package com.springmvc.controller;

import com.springmvc.dao.CategoryDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.InventoryDao;
import com.springmvc.dao.OrderDao;
import com.springmvc.dao.ProductDao;
import com.springmvc.dao.SupplierDao;
import com.springmvc.dao.UserDao;
import com.springmvc.model.Category;
import com.springmvc.model.Customer;
import com.springmvc.model.Order;
import com.springmvc.model.Product;
import com.springmvc.model.Supplier;
import com.springmvc.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private ProductDao   productDao;
    @Autowired private CategoryDao  categoryDao;
    @Autowired private OrderDao     orderDao;
    @Autowired private UserDao      userDao;
    @Autowired private CustomerDao  customerDao;
    @Autowired private SupplierDao  supplierDao;
    @Autowired private InventoryDao inventoryDao;

    private boolean isAdmin(HttpSession s) {
        User u = (User) s.getAttribute("loggedUser");
        return u != null && u.getRoleId() == 1;
    }
    private boolean isStaff(HttpSession s) {
        User u = (User) s.getAttribute("loggedUser");
        return u != null && u.getRoleId() == 2;
    }
    private boolean isAdminOrStaff(HttpSession s) {
        User u = (User) s.getAttribute("loggedUser");
        return u != null && (u.getRoleId() == 1 || u.getRoleId() == 2);
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";

        // Thống kê cơ bản
        model.addAttribute("totalProducts",  productDao.findAll().size());
        model.addAttribute("totalOrders",    orderDao.countAll());
        model.addAttribute("totalCustomers", customerDao.findAllWithTier().size());

        // Tổng doanh thu
        double totalRevenue = 0;
        List<Order> allOrders = orderDao.findAll();
        for (Order o : allOrders) {
            if ("Delivered".equals(o.getStatus())) totalRevenue += o.getTotal();
        }
        model.addAttribute("totalRevenue", totalRevenue);

        // Thống kê theo kỳ — tất cả bọc try/catch an toàn
        try { model.addAttribute("todayRevenue",     orderDao.getRevenueToday()); }
        catch (Exception e) { model.addAttribute("todayRevenue", 0.0); }
        try { model.addAttribute("todayOrders",      orderDao.getOrderCountToday()); }
        catch (Exception e) { model.addAttribute("todayOrders", 0); }
        try { model.addAttribute("thisMonthRevenue", orderDao.getRevenueThisMonth()); }
        catch (Exception e) { model.addAttribute("thisMonthRevenue", 0.0); }
        try { model.addAttribute("thisMonthOrders",  orderDao.getOrderCountThisMonth()); }
        catch (Exception e) { model.addAttribute("thisMonthOrders", 0); }
        try { model.addAttribute("lastMonthRevenue", orderDao.getRevenueLastMonth()); }
        catch (Exception e) { model.addAttribute("lastMonthRevenue", 0.0); }
        try { model.addAttribute("lastMonthOrders",  orderDao.getOrderCountLastMonth()); }
        catch (Exception e) { model.addAttribute("lastMonthOrders", 0); }

        // Đơn theo trạng thái
        model.addAttribute("pendingOrders",   orderDao.countByStatus("Pending"));
        model.addAttribute("confirmedOrders", orderDao.countByStatus("Confirmed"));
        model.addAttribute("shippingOrders",  orderDao.countByStatus("Shipping"));
        model.addAttribute("deliveredOrders", orderDao.countByStatus("Delivered"));

        // Đơn gần đây
        model.addAttribute("recentOrders", orderDao.findRecent(10));

        // Danh mục + số SP
        model.addAttribute("categories", categoryDao.findAll());

        // Khác
        model.addAttribute("lowStockList",         inventoryDao.findLowStock());
        model.addAttribute("featuredProductsList", productDao.findFeatured());

        // Biểu đồ doanh thu tháng
        try { model.addAttribute("monthlyRevenue", orderDao.getMonthlyRevenue(12)); }
        catch (Exception e) { model.addAttribute("monthlyRevenue", java.util.Collections.emptyList()); }

        model.addAttribute("isAdmin", isAdmin(session));
        model.addAttribute("isStaff", isStaff(session));
        return "admin/dashboard";
    }

    @GetMapping("/products")
    public String products(HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        model.addAttribute("products",   productDao.findAll());
        model.addAttribute("categories", categoryDao.findAll());
        model.addAttribute("suppliers",  supplierDao.findAll());
        model.addAttribute("isAdmin",    isAdmin(session));
        return "admin/products";
    }

    @GetMapping("/products/add")
    public String addForm(HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        model.addAttribute("product",    new Product());
        model.addAttribute("categories", categoryDao.findAll());
        model.addAttribute("suppliers",  supplierDao.findAll());
        return "admin/product-add";
    }

    @PostMapping("/products/add")
    public String addProduct(
            @ModelAttribute Product product,
            @RequestParam(name = "supplierId", required = false) Integer supplierId,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(name = "imageUrl", required = false) String imageUrl,
            HttpServletRequest request, HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        try {
            if (supplierId != null && supplierId > 0) product.setSupplierId(supplierId);
            int newId = productDao.saveAndGetId(product);
            String savedUrl = null;
            if (imageFile != null && !imageFile.isEmpty())
                savedUrl = uploadImage(imageFile, request, newId);
            else if (imageUrl != null && !imageUrl.trim().isEmpty())
                savedUrl = imageUrl.trim();
            if (savedUrl != null) productDao.saveImage(newId, savedUrl, 1);
            return "redirect:/admin/products";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi: " + e.getMessage());
            model.addAttribute("categories", categoryDao.findAll());
            model.addAttribute("suppliers",  supplierDao.findAll());
            model.addAttribute("product",    product);
            return "admin/product-add";
        }
    }

    @GetMapping("/products/edit/{id}")
    public String editForm(@PathVariable int id, HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        Product p = productDao.findById(id);
        if (p == null) return "redirect:/admin/products";
        if (p.getImageUrl() == null || p.getImageUrl().isEmpty())
            p.setImageUrl(productDao.findImageByProductId(id));
        model.addAttribute("product",       p);
        model.addAttribute("productImages", productDao.findImagesByProductId(id));
        model.addAttribute("categories",    categoryDao.findAll());
        model.addAttribute("suppliers",     supplierDao.findAll());
        return "admin/product-edit";
    }

    @PostMapping("/products/edit/{id}")
    public String editProduct(
            @PathVariable int id, @ModelAttribute Product product,
            @RequestParam(name = "supplierId", required = false) Integer supplierId,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(name = "imageUrl", required = false) String imageUrl,
            HttpServletRequest request, HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        try {
            product.setId(id);
            if (supplierId != null && supplierId > 0) product.setSupplierId(supplierId);
            productDao.update(product);
            String savedUrl = null;
            if (imageFile != null && !imageFile.isEmpty())
                savedUrl = uploadImage(imageFile, request, id);
            else if (imageUrl != null && !imageUrl.trim().isEmpty())
                savedUrl = imageUrl.trim();
            if (savedUrl != null) { productDao.deleteImages(id); productDao.saveImage(id, savedUrl, 1); }
            return "redirect:/admin/products";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi: " + e.getMessage());
            model.addAttribute("categories", categoryDao.findAll());
            model.addAttribute("suppliers",  supplierDao.findAll());
            model.addAttribute("product",    product);
            return "admin/product-edit";
        }
    }

    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable int id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/products";
        productDao.delete(id);
        return "redirect:/admin/products";
    }

    @GetMapping("/categories")
    public String categories(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        model.addAttribute("categories", categoryDao.findAll());
        return "admin/categories";
    }

    @PostMapping("/categories/add")
    public String addCategory(@ModelAttribute Category cat, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        categoryDao.save(cat);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/edit/{id}")
    public String editCategoryForm(@PathVariable int id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        model.addAttribute("editCategory", categoryDao.findById(id));
        model.addAttribute("categories",   categoryDao.findAll());
        return "admin/categories";
    }

    @PostMapping("/categories/edit/{id}")
    public String editCategory(@PathVariable int id, @ModelAttribute Category cat, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        cat.setId(id);
        categoryDao.update(cat);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String deleteCategory(@PathVariable int id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        try { categoryDao.delete(id); } catch (Exception ignored) {}
        return "redirect:/admin/categories";
    }

    @GetMapping("/orders")
    public String orders(
            @RequestParam(name = "status", required = false) String status,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "dateFrom", required = false) String dateFrom,
            @RequestParam(name = "dateTo", required = false) String dateTo,
            @RequestParam(name = "page", defaultValue = "1") int page,
            HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";

        int pageSize = 20;
        List<Order> orders = orderDao.search(keyword, status, dateFrom, dateTo, page, pageSize);
        int total = orderDao.countSearch(keyword, status, dateFrom, dateTo);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        model.addAttribute("orders",         orders);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("keyword",        keyword);
        model.addAttribute("dateFrom",       dateFrom);
        model.addAttribute("dateTo",         dateTo);
        model.addAttribute("currentPage",    page);
        model.addAttribute("totalPages",     totalPages);
        model.addAttribute("countPending",   orderDao.countByStatus("Pending"));
        model.addAttribute("countConfirmed", orderDao.countByStatus("Confirmed"));
        model.addAttribute("countShipping",  orderDao.countByStatus("Shipping"));
        model.addAttribute("countDelivered", orderDao.countByStatus("Delivered"));
        model.addAttribute("totalOrders",    orderDao.countAll());
        return "admin/orders";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable int id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        model.addAttribute("order", orderDao.findById(id));
        model.addAttribute("items", orderDao.findItems(id));
        return "admin/order-detail";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(@PathVariable int id, @RequestParam(name = "status") String status,
                                    HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        orderDao.updateStatus(id, status);
        if ("Delivered".equals(status)) {
            Order o = orderDao.findById(id);
            if (o != null) {
                customerDao.addSpent(o.getCustomerId(), o.getTotal());
                customerDao.autoUpgradeTier(o.getCustomerId());
                orderDao.updatePaymentStatus(id, "Paid"); // ← cập nhật payments
            }
        }
        return "redirect:/admin/orders/" + id;
    }

    @GetMapping("/customers")
    public String customers(
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "tier", required = false) Integer tier,
            @RequestParam(name = "page", defaultValue = "1") int page,
            HttpSession session, Model model) {
        if (!isAdminOrStaff(session)) return "redirect:/login";

        int pageSize = 15;
        List<com.springmvc.model.Customer> customers =
            customerDao.search(keyword, tier, page, pageSize);
        int total = customerDao.countSearch(keyword, tier);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        model.addAttribute("customers",    customers);
        model.addAttribute("tiers",        customerDao.findAllTiers());
        model.addAttribute("topCustomers", customerDao.findTop3());
        model.addAttribute("keyword",      keyword);
        model.addAttribute("tier",         tier);
        model.addAttribute("currentPage",  page);
        model.addAttribute("totalPages",   totalPages);
        model.addAttribute("totalCustomers", total);
        model.addAttribute("isAdmin",      isAdmin(session));
        return "admin/customers";
    }

    @PostMapping("/customers/tier/{id}")
    public String updateTier(@PathVariable int id, @RequestParam(name = "tierId") int tierId, HttpSession session) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        customerDao.updateTier(id, tierId);
        return "redirect:/admin/customers";
    }

    @PostMapping("/customers/reset-password/{userId}")
    public String resetPassword(@PathVariable int userId,
                                HttpSession session,
                                org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {
        if (!isAdminOrStaff(session)) return "redirect:/login";
        User u = userDao.findById(userId);
        if (u != null) {
            String hashed = BCrypt.hashpw("123456", BCrypt.gensalt());
            userDao.updatePassword(u.getId(), hashed);
            // Lấy tên khách hàng để hiển thị trong thông báo
            com.springmvc.model.Customer c = customerDao.findByUserId(u.getId());
            String name = (c != null) ? c.getName() : "khách hàng";
            ra.addFlashAttribute("resetSuccess",
                "Đã reset mật khẩu của <strong>" + name + "</strong> về <code>123456</code>. " +
                "Vui lòng thông báo cho khách hàng đổi mật khẩu sau khi đăng nhập.");
        } else {
            ra.addFlashAttribute("resetError", "Không tìm thấy tài khoản.");
        }
        return "redirect:/admin/customers";
    }

    @GetMapping("/staff")
    public String staff(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        model.addAttribute("staffList", customerDao.findStaff());
        return "admin/staff";
    }

    @PostMapping("/staff/add")
    public String addStaff(@RequestParam(name = "username") String username, @RequestParam(name = "password") String password,
                           @RequestParam(name = "name") String name, @RequestParam(name = "phone", required = false) String phone,
                           HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        try {
            User u = new User();
            u.setUsername(username);
            u.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
            u.setRoleId(2); u.setActive(true);
            int userId = userDao.saveAndGetId(u);
            Customer c = new Customer();
            c.setName(name); c.setPhone(phone); c.setUserId(userId); c.setTierId(1);
            customerDao.save(c);
        } catch (Exception ignored) {}
        return "redirect:/admin/staff";
    }

    @GetMapping("/staff/toggle/{userId}")
    public String toggleStaff(@PathVariable int userId, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        userDao.toggleActive(userId);
        return "redirect:/admin/staff";
    }

    @GetMapping("/suppliers")
    public String suppliers(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        model.addAttribute("suppliers",     supplierDao.findAllWithStats());
        model.addAttribute("products",      productDao.findAll());
        model.addAttribute("inventoryList", inventoryDao.findAll());
        model.addAttribute("lowStockList",  inventoryDao.findLowStock());
        model.addAttribute("isAdmin",       true);
        return "admin/suppliers";
    }

    @PostMapping("/suppliers/add")
    public String addSupplier(@RequestParam(name = "name") String name,
                              @RequestParam(name = "phone", required = false) String phone,
                              @RequestParam(name = "email", required = false) String email,
                              @RequestParam(name = "address", required = false) String address,
                              HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        Supplier s = new Supplier();
        s.setName(name); s.setPhone(phone); s.setEmail(email); s.setAddress(address);
        supplierDao.save(s);
        return "redirect:/admin/suppliers";
    }

    @PostMapping("/suppliers/edit/{id}")
    public String editSupplier(@PathVariable int id, @RequestParam(name = "name") String name,
                               @RequestParam(name = "phone", required = false) String phone,
                               @RequestParam(name = "email", required = false) String email,
                               @RequestParam(name = "address", required = false) String address,
                               HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        Supplier s = new Supplier();
        s.setId(id); s.setName(name); s.setPhone(phone); s.setEmail(email); s.setAddress(address);
        supplierDao.update(s);
        return "redirect:/admin/suppliers";
    }

    @GetMapping("/suppliers/delete/{id}")
    public String deleteSupplier(@PathVariable int id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        try { supplierDao.delete(id); } catch (Exception ignored) {}
        return "redirect:/admin/suppliers";
    }

    @PostMapping("/inventory/import")
    public String importStock(@RequestParam(name = "productId") int productId, @RequestParam(name = "supplierId") int supplierId,
                              @RequestParam(name = "quantity") double quantity,
                              @RequestParam(name = "importPrice", defaultValue = "0") double importPrice,
                              @RequestParam(name = "note", required = false) String note,
                              HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/dashboard";
        inventoryDao.importStock(productId, supplierId, quantity, importPrice, note);
        return "redirect:/admin/suppliers";
    }

    private String uploadImage(MultipartFile file, HttpServletRequest request, int productId) throws IOException {
        String dir = request.getServletContext().getRealPath("/uploads/products/");
        File folder = new File(dir);
        if (!folder.exists()) folder.mkdirs();
        String orig = file.getOriginalFilename();
        String ext  = (orig != null && orig.contains(".")) ? orig.substring(orig.lastIndexOf(".")) : ".jpg";
        String name = "product_" + productId + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
        file.transferTo(new File(dir + name));
        return request.getContextPath() + "/uploads/products/" + name;
    }
}
