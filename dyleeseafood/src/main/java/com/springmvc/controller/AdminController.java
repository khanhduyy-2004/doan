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

    @Autowired private ProductDao  productDao;
    @Autowired private CategoryDao categoryDao;
    @Autowired private OrderDao    orderDao;
    @Autowired private UserDao     userDao;
    @Autowired private CustomerDao customerDao;
    @Autowired private SupplierDao  supplierDao;
    @Autowired private InventoryDao inventoryDao;

    // ===== PHÂN QUYỀN =====

    private boolean isAdmin(HttpSession session) {
        User u = (User) session.getAttribute("loggedUser");
        return u != null && u.getRoleId() == 1;
    }

    private boolean isStaff(HttpSession session) {
        User u = (User) session.getAttribute("loggedUser");
        return u != null && u.getRoleId() == 2;
    }

    private boolean isAdminOrStaff(HttpSession session) {
        User u = (User) session.getAttribute("loggedUser");
        return u != null &&
               (u.getRoleId() == 1 || u.getRoleId() == 2);
    }

    // ===== DASHBOARD =====

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session,
                             Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";

        List<Order> allOrders = orderDao.findAll();

        // Thống kê cơ bản
        model.addAttribute("totalProducts",
            productDao.findAll().size());
        model.addAttribute("totalCategories",
            categoryDao.findAll().size());
        model.addAttribute("totalOrders",
            allOrders.size());
        model.addAttribute("totalCustomers",
            customerDao.findAllWithTier().size());

        // Thống kê đơn hàng theo trạng thái
        model.addAttribute("pendingOrders",
            orderDao.countByStatus("Pending"));
        model.addAttribute("confirmedOrders",
            orderDao.countByStatus("Confirmed"));
        model.addAttribute("shippingOrders",
            orderDao.countByStatus("Shipping"));
        model.addAttribute("deliveredOrders",
            orderDao.countByStatus("Delivered"));

        // Doanh thu từ đơn Delivered
        double totalRevenue = 0;
        for (Order o : allOrders) {
            if ("Delivered".equals(o.getStatus()))
                totalRevenue += o.getTotal();
        }
        model.addAttribute("totalRevenue", totalRevenue);

        // Đơn hàng gần nhất
        model.addAttribute("recentOrders",
            allOrders.size() > 5
            ? allOrders.subList(0, 5)
            : allOrders);

        // SP nổi bật & danh mục
        model.addAttribute("featuredProductsList",
            productDao.findFeatured());
        model.addAttribute("categories",
            categoryDao.findAll());

        // SP sắp hết hàng
        model.addAttribute("lowStockList",
            inventoryDao.findLowStock());

        model.addAttribute("isAdmin", isAdmin(session));
        model.addAttribute("isStaff", isStaff(session));
        return "admin/dashboard";
    }

    // ===== SẢN PHẨM =====

    @GetMapping("/products")
    public String products(HttpSession session,
                            Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        model.addAttribute("products",
            productDao.findAll());
        model.addAttribute("categories",
            categoryDao.findAll());
        model.addAttribute("isAdmin", isAdmin(session));
        return "admin/products";
    }

    @GetMapping("/products/add")
    public String addForm(HttpSession session,
                           Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        model.addAttribute("product", new Product());
        model.addAttribute("categories",
            categoryDao.findAll());
        model.addAttribute("suppliers",
            supplierDao.findAll());
        return "admin/product-add";
    }

    @PostMapping("/products/add")
    public String addProduct(
            @ModelAttribute Product product,
            @RequestParam(required=false) Integer supplierId,
            @RequestParam(value="imageFile",required=false)
                MultipartFile imageFile,
            @RequestParam(required=false) String imageUrl,
            HttpServletRequest request,
            HttpSession session, Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        try {
            if (supplierId != null && supplierId > 0)
                product.setSupplierId(supplierId);

            int newId = productDao.saveAndGetId(product);

            // Ưu tiên file upload
            String savedUrl = null;
            if (imageFile != null && !imageFile.isEmpty())
                savedUrl = uploadImage(imageFile, request, newId);
            else if (imageUrl != null && !imageUrl.trim().isEmpty())
                savedUrl = imageUrl.trim();

            if (savedUrl != null)
                productDao.saveImage(newId, savedUrl, 1);

            return "redirect:/admin/products";
        } catch (Exception e) {
            model.addAttribute("error",
                "Lỗi: " + e.getMessage());
            model.addAttribute("categories",
                categoryDao.findAll());
            model.addAttribute("suppliers",
                supplierDao.findAll());
            model.addAttribute("product", product);
            return "admin/product-add";
        }
    }

    @GetMapping("/products/edit/{id}")
    public String editForm(@PathVariable int id,
                            HttpSession session,
                            Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        Product p = productDao.findById(id);
        if (p == null)
            return "redirect:/admin/products";
        if (p.getImageUrl() == null ||
            p.getImageUrl().isEmpty())
            p.setImageUrl(productDao.findImageByProductId(id));
        model.addAttribute("product", p);
        model.addAttribute("categories",
            categoryDao.findAll());
        model.addAttribute("suppliers",
            supplierDao.findAll());
        return "admin/product-edit";
    }

    @PostMapping("/products/edit/{id}")
    public String editProduct(
            @PathVariable int id,
            @ModelAttribute Product product,
            @RequestParam(required=false) Integer supplierId,
            @RequestParam(value="imageFile",required=false)
                MultipartFile imageFile,
            @RequestParam(required=false) String imageUrl,
            HttpServletRequest request,
            HttpSession session, Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        try {
            product.setId(id);
            if (supplierId != null && supplierId > 0)
                product.setSupplierId(supplierId);
            productDao.update(product);

            String savedUrl = null;
            if (imageFile != null && !imageFile.isEmpty())
                savedUrl = uploadImage(imageFile, request, id);
            else if (imageUrl != null && !imageUrl.trim().isEmpty())
                savedUrl = imageUrl.trim();

            if (savedUrl != null) {
                productDao.deleteImages(id);
                productDao.saveImage(id, savedUrl, 1);
            }
            return "redirect:/admin/products";
        } catch (Exception e) {
            model.addAttribute("error",
                "Lỗi: " + e.getMessage());
            model.addAttribute("categories",
                categoryDao.findAll());
            model.addAttribute("suppliers",
                supplierDao.findAll());
            model.addAttribute("product", product);
            return "admin/product-edit";
        }
    }

    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable int id,
                                 HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/products";
        productDao.delete(id);
        return "redirect:/admin/products";
    }

    // ===== DANH MỤC =====

    @GetMapping("/categories")
    public String categories(HttpSession session,
                              Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        model.addAttribute("categories",
            categoryDao.findAll());
        return "admin/categories";
    }

    @PostMapping("/categories/add")
    public String addCategory(
            @ModelAttribute Category category,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        categoryDao.save(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/edit/{id}")
    public String editCategoryForm(
            @PathVariable int id,
            HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        model.addAttribute("editCategory",
            categoryDao.findById(id));
        model.addAttribute("categories",
            categoryDao.findAll());
        return "admin/categories";
    }

    @PostMapping("/categories/edit/{id}")
    public String editCategory(
            @PathVariable int id,
            @ModelAttribute Category category,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        category.setId(id);
        categoryDao.update(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String deleteCategory(@PathVariable int id,
                                  HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        try { categoryDao.delete(id); } catch (Exception e) {}
        return "redirect:/admin/categories";
    }

    // ===== ĐƠN HÀNG =====

    @GetMapping("/orders")
    public String orders(
            @RequestParam(required=false) String status,
            HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        List<Order> orders =
            (status != null && !status.isEmpty())
            ? orderDao.findByStatus(status)
            : orderDao.findAll();
        model.addAttribute("orders", orders);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("countPending",
            orderDao.countByStatus("Pending"));
        model.addAttribute("countConfirmed",
            orderDao.countByStatus("Confirmed"));
        model.addAttribute("countShipping",
            orderDao.countByStatus("Shipping"));
        model.addAttribute("countDelivered",
            orderDao.countByStatus("Delivered"));
        return "admin/orders";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable int id,
                               HttpSession session,
                               Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        model.addAttribute("order",
            orderDao.findById(id));
        model.addAttribute("items",
            orderDao.findItems(id));
        return "admin/order-detail";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(
            @PathVariable int id,
            @RequestParam String status,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        orderDao.updateStatus(id, status);
        if ("Delivered".equals(status)) {
            Order order = orderDao.findById(id);
            if (order != null) {
                customerDao.addSpent(
                    order.getCustomerId(),
                    order.getTotal());
                customerDao.autoUpgradeTier(
                    order.getCustomerId());
            }
        }
        return "redirect:/admin/orders/" + id;
    }

    // ===== KHÁCH HÀNG =====

    @GetMapping("/customers")
    public String customers(HttpSession session,
                             Model model) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        model.addAttribute("customers",
            customerDao.findAllWithTier());
        model.addAttribute("tiers",
            customerDao.findAllTiers());
        model.addAttribute("topCustomers",
            customerDao.findTop3());
        model.addAttribute("isAdmin", isAdmin(session));
        return "admin/customers";
    }

    @PostMapping("/customers/tier/{id}")
    public String updateTier(
            @PathVariable int id,
            @RequestParam int tierId,
            HttpSession session) {
        if (!isAdminOrStaff(session))
            return "redirect:/login";
        customerDao.updateTier(id, tierId);
        return "redirect:/admin/customers";
    }

    // ===== NHÂN VIÊN =====

    @GetMapping("/staff")
    public String staff(HttpSession session,
                         Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        model.addAttribute("staffList",
            customerDao.findStaff());
        return "admin/staff";
    }

    @PostMapping("/staff/add")
    public String addStaff(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String name,
            @RequestParam(required=false) String phone,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        try {
            User user = new User();
            user.setUsername(username);
            user.setPassword(BCrypt.hashpw(
                password, BCrypt.gensalt()));
            user.setRoleId(2);
            user.setActive(true);
            int userId = userDao.saveAndGetId(user);

            Customer c = new Customer();
            c.setName(name);
            c.setPhone(phone);
            c.setUserId(userId);
            c.setTierId(1);
            customerDao.save(c);
        } catch (Exception e) {}
        return "redirect:/admin/staff";
    }

    @GetMapping("/staff/toggle/{userId}")
    public String toggleStaff(@PathVariable int userId,
                               HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        userDao.toggleActive(userId);
        return "redirect:/admin/staff";
    }

    // ===== NHÀ CUNG CẤP =====

    @GetMapping("/suppliers")
    public String suppliers(HttpSession session,
                             Model model) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        model.addAttribute("suppliers",
            supplierDao.findAll());
        model.addAttribute("products",
            productDao.findAll());
        model.addAttribute("inventoryList",
            inventoryDao.findAll());
        model.addAttribute("lowStockList",
            inventoryDao.findLowStock());
        model.addAttribute("isAdmin", true);
        return "admin/suppliers";
    }

    @PostMapping("/suppliers/add")
    public String addSupplier(
            @RequestParam String name,
            @RequestParam(required=false) String phone,
            @RequestParam(required=false) String email,
            @RequestParam(required=false) String address,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        Supplier s = new Supplier();
        s.setName(name);
        s.setPhone(phone);
        s.setEmail(email);
        s.setAddress(address);
        supplierDao.save(s);
        return "redirect:/admin/suppliers";
    }

    @PostMapping("/suppliers/edit/{id}")
    public String editSupplier(
            @PathVariable int id,
            @RequestParam String name,
            @RequestParam(required=false) String phone,
            @RequestParam(required=false) String email,
            @RequestParam(required=false) String address,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        Supplier s = new Supplier();
        s.setId(id);
        s.setName(name);
        s.setPhone(phone);
        s.setEmail(email);
        s.setAddress(address);
        supplierDao.update(s);
        return "redirect:/admin/suppliers";
    }

    @GetMapping("/suppliers/delete/{id}")
    public String deleteSupplier(@PathVariable int id,
                                  HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        try { supplierDao.delete(id); }
        catch (Exception e) {}
        return "redirect:/admin/suppliers";
    }

    // ===== NHẬP HÀNG VÀO KHO =====

    @PostMapping("/inventory/import")
    public String importStock(
            @RequestParam int    productId,
            @RequestParam int    supplierId,
            @RequestParam double quantity,
            @RequestParam(defaultValue="0")
                double importPrice,
            @RequestParam(required=false) String note,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/admin/dashboard";
        inventoryDao.importStock(
            productId, supplierId,
            quantity, importPrice, note);
        return "redirect:/admin/suppliers";
    }

    // ===== HELPER: UPLOAD ẢNH =====

    private String uploadImage(
            MultipartFile file,
            HttpServletRequest request,
            int productId) throws IOException {
        String uploadDir =
            request.getServletContext()
                   .getRealPath("/uploads/products/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String original = file.getOriginalFilename();
        String ext = original != null
            && original.contains(".")
            ? original.substring(original.lastIndexOf("."))
            : ".jpg";
        String fileName = "product_" + productId + "_"
            + UUID.randomUUID().toString().substring(0, 8)
            + ext;
        file.transferTo(new File(uploadDir + fileName));
        return request.getContextPath()
               + "/uploads/products/" + fileName;
    }
}