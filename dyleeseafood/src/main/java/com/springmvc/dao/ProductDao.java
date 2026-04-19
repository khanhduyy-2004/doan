package com.springmvc.dao;

import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@Repository
public class ProductDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Product> rowMapper =
        new RowMapper<Product>() {
        public Product mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            Product p = new Product();
            p.setId(rs.getInt("id"));
            p.setName(rs.getString("name"));
            p.setDescription(rs.getString("description"));
            p.setSlug(rs.getString("slug"));
            p.setPrice(rs.getDouble("price"));
            p.setStock(rs.getDouble("stock"));
            p.setUnit(rs.getString("unit"));
            p.setCategoryId(rs.getInt("category_id"));
            p.setActive(rs.getInt("is_active") == 1);
            p.setFeatured(rs.getInt("is_featured") == 1);
            p.setCreatedAt(rs.getString("created_at"));
            try { p.setCategoryName(
                rs.getString("category_name")); }
            catch (SQLException e) {
                p.setCategoryName(""); }
            // FIX: thêm supplier_id + supplier_name
            try { p.setSupplierId(
                rs.getInt("supplier_id")); }
            catch (SQLException e) {}
            try { p.setSupplierName(
                rs.getString("supplier_name")); }
            catch (SQLException e) {
                p.setSupplierName(""); }
            try { p.setImageUrl(
                rs.getString("image_url")); }
            catch (SQLException e) {
                p.setImageUrl(""); }
            return p;
        }
    };

    // Subquery lấy ảnh đại diện (is_primary=1)
    private static final String IMAGE_SQL =
        "(SELECT image_url FROM product_images " +
        " WHERE product_id = p.id " +
        " AND is_primary = 1 LIMIT 1) as image_url ";

    // ===== TRUY VẤN =====

    public List<Product> findAll() {
        String sql =
            "SELECT p.*, c.name as category_name, " +
            "  s.name as supplier_name, " + IMAGE_SQL +
            "FROM products p " +
            "LEFT JOIN categories c " +
            "  ON p.category_id = c.id " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.is_active = 1 " +
            "ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper);
    }

    public List<Product> findFeatured() {
        String sql =
            "SELECT p.*, c.name as category_name, " +
            "  s.name as supplier_name, " + IMAGE_SQL +
            "FROM products p " +
            "LEFT JOIN categories c " +
            "  ON p.category_id = c.id " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.is_active = 1 " +
            "  AND p.is_featured = 1 " +
            "ORDER BY p.id DESC LIMIT 6";
        return jdbcTemplate.query(sql, rowMapper);
    }

    public List<Product> findByCategory(int categoryId) {
        String sql =
            "SELECT p.*, c.name as category_name, " +
            "  s.name as supplier_name, " + IMAGE_SQL +
            "FROM products p " +
            "LEFT JOIN categories c " +
            "  ON p.category_id = c.id " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.is_active = 1 " +
            "  AND p.category_id = ? " +
            "ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper,
            categoryId);
    }

    public List<Product> search(String keyword) {
        String sql =
            "SELECT p.*, c.name as category_name, " +
            "  s.name as supplier_name, " + IMAGE_SQL +
            "FROM products p " +
            "LEFT JOIN categories c " +
            "  ON p.category_id = c.id " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.is_active = 1 " +
            "  AND p.name LIKE ? " +
            "ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper,
            "%" + keyword + "%");
    }

    public Product findById(int id) {
        try {
            String sql =
                "SELECT p.*, c.name as category_name, " +
                "  s.name as supplier_name, " + IMAGE_SQL +
                "FROM products p " +
                "LEFT JOIN categories c " +
                "  ON p.category_id = c.id " +
                "LEFT JOIN suppliers s " +
                "  ON p.supplier_id = s.id " +
                "WHERE p.id = ?";
            return jdbcTemplate.queryForObject(
                sql, rowMapper, id);
        } catch (Exception e) { return null; }
    }

    public Product findBySlug(String slug) {
        try {
            String sql =
                "SELECT p.*, c.name as category_name, " +
                "  s.name as supplier_name, " + IMAGE_SQL +
                "FROM products p " +
                "LEFT JOIN categories c " +
                "  ON p.category_id = c.id " +
                "LEFT JOIN suppliers s " +
                "  ON p.supplier_id = s.id " +
                "WHERE p.slug = ?";
            return jdbcTemplate.queryForObject(
                sql, rowMapper, slug);
        } catch (Exception e) { return null; }
    }

    // ===== MỚI: lấy TẤT CẢ ảnh của SP =====
    // Dùng cho gallery trang chi tiết
    public List<String> findImagesByProductId(
            int productId) {
        return jdbcTemplate.queryForList(
            "SELECT image_url FROM product_images " +
            "WHERE product_id = ? " +
            "ORDER BY is_primary DESC, sort_order ASC",
            String.class, productId);
    }

    // Lấy ảnh đại diện duy nhất (giữ nguyên)
    public String findImageByProductId(int productId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT image_url FROM product_images " +
                "WHERE product_id = ? " +
                "AND is_primary = 1 LIMIT 1",
                String.class, productId);
        } catch (Exception e) { return ""; }
    }

    // ===== CRUD =====

    public int saveAndGetId(Product p) {
        String slug =
            (p.getSlug() != null && !p.getSlug().isEmpty())
            ? p.getSlug()
            : p.getName().toLowerCase()
               .replaceAll("đ", "d")
               .replaceAll("[^a-z0-9]", "-")
               .replaceAll("-+", "-") + "-"
               + System.currentTimeMillis();

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps =
                connection.prepareStatement(
                "INSERT INTO products " +
                "(name, description, slug, price, " +
                " stock, unit, category_id, " +
                " supplier_id, is_active, is_featured) " +
                "VALUES (?,?,?,?,?,?,?,?,1,?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setString(3, slug);
            ps.setDouble(4, p.getPrice());
            ps.setDouble(5, p.getStock());
            ps.setString(6, p.getUnit());
            ps.setInt(7, p.getCategoryId());
            if (p.getSupplierId() > 0)
                ps.setInt(8, p.getSupplierId());
            else
                ps.setNull(8,
                    java.sql.Types.INTEGER);
            ps.setInt(9, p.isFeatured() ? 1 : 0);
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    public void save(Product p) {
        saveAndGetId(p);
    }

    // FIX: thêm supplier_id + is_active vào UPDATE
    public void update(Product p) {
        jdbcTemplate.update(
            "UPDATE products SET " +
            "  name=?, description=?, price=?, " +
            "  stock=?, unit=?, category_id=?, " +
            "  supplier_id=?, is_active=?, " +
            "  is_featured=? " +
            "WHERE id=?",
            p.getName(),
            p.getDescription(),
            p.getPrice(),
            p.getStock(),
            p.getUnit(),
            p.getCategoryId(),
            p.getSupplierId() > 0
                ? p.getSupplierId() : null,
            p.isActive() ? 1 : 0,
            p.isFeatured() ? 1 : 0,
            p.getId());
    }

    public void delete(int id) {
        jdbcTemplate.update(
            "DELETE FROM product_images " +
            "WHERE product_id = ?", id);
        jdbcTemplate.update(
            "DELETE FROM products WHERE id = ?", id);
    }

    public void saveImage(int productId,
            String imageUrl, int isPrimary) {
        jdbcTemplate.update(
            "INSERT INTO product_images " +
            "(product_id, image_url, " +
            " is_primary, sort_order) " +
            "VALUES (?, ?, ?, 0)",
            productId, imageUrl, isPrimary);
    }

    public void deleteImages(int productId) {
        jdbcTemplate.update(
            "DELETE FROM product_images " +
            "WHERE product_id = ?", productId);
    }

    public int getLastInsertId() {
        return jdbcTemplate.queryForObject(
            "SELECT LAST_INSERT_ID()",
            Integer.class);
    }

    // Tìm sản phẩm cùng danh mục, loại trừ SP hiện tại (cho trang chi tiết)
    public List<Product> findByCategoryExclude(
            int categoryId, int excludeId, int limit) {
        String sql =
            "SELECT p.*, c.name as category_name, " +
            "  s.name as supplier_name, " + IMAGE_SQL +
            "FROM products p " +
            "LEFT JOIN categories c " +
            "  ON p.category_id = c.id " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.is_active = 1 " +
            "  AND p.category_id = ? " +
            "  AND p.id != ? " +
            "ORDER BY RAND() LIMIT ?";
        return jdbcTemplate.query(
            sql, rowMapper, categoryId, excludeId, limit);
    }
}
