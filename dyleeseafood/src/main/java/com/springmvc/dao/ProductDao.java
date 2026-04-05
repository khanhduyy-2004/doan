package com.springmvc.dao;

import com.springmvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Product> rowMapper = new RowMapper<Product>() {
        public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
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
            try { p.setCategoryName(rs.getString("category_name")); }
            catch (SQLException e) { p.setCategoryName(""); }
            try { p.setImageUrl(rs.getString("image_url")); }
            catch (SQLException e) { p.setImageUrl(""); }
            return p;
        }
    };

    private static final String IMAGE_SQL =
        "(SELECT image_url FROM product_images " +
        " WHERE product_id = p.id AND is_primary = 1 LIMIT 1) as image_url ";

    public List<Product> findAll() {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper);
    }

    public List<Product> findFeatured() {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 AND p.is_featured = 1 " +
                     "ORDER BY p.id DESC LIMIT 6";
        return jdbcTemplate.query(sql, rowMapper);
    }

    public List<Product> findByCategory(int categoryId) {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 AND p.category_id = ? " +
                     "ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper, categoryId);
    }

    public List<Product> search(String keyword) {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 AND p.name LIKE ? " +
                     "ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, rowMapper, "%" + keyword + "%");
    }

    public Product findById(int id) {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id = ?";
        return jdbcTemplate.queryForObject(sql, rowMapper, id);
    }

    public Product findBySlug(String slug) {
        String sql = "SELECT p.*, c.name as category_name, " + IMAGE_SQL +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.slug = ?";
        return jdbcTemplate.queryForObject(sql, rowMapper, slug);
    }

    public void save(Product p) {
        String slug = (p.getSlug() != null && !p.getSlug().isEmpty())
            ? p.getSlug()
            : p.getName().toLowerCase()
               .replaceAll("đ", "d")
               .replaceAll("[^a-z0-9]", "-")
               .replaceAll("-+", "-");
        jdbcTemplate.update(
            "INSERT INTO products (name, description, slug, price, stock, " +
            "unit, category_id, is_active, is_featured) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?)",
            p.getName(),
            p.getDescription(),
            slug,
            p.getPrice(),
            p.getStock(),
            p.getUnit(),
            p.getCategoryId(),
            p.isFeatured() ? 1 : 0);
    }

    public void update(Product p) {
        jdbcTemplate.update(
            "UPDATE products SET name=?, description=?, price=?, " +
            "stock=?, unit=?, category_id=?, is_featured=? WHERE id=?",
            p.getName(),
            p.getDescription(),
            p.getPrice(),
            p.getStock(),
            p.getUnit(),
            p.getCategoryId(),
            p.isFeatured() ? 1 : 0,
            p.getId());
    }

    public void delete(int id) {
        jdbcTemplate.update(
            "DELETE FROM product_images WHERE product_id = ?", id);
        jdbcTemplate.update(
            "DELETE FROM products WHERE id = ?", id);
    }
}