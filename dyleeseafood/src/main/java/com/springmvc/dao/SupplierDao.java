package com.springmvc.dao;

import com.springmvc.model.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class SupplierDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // RowMapper cơ bản
    private RowMapper<Supplier> rowMapper =
        new RowMapper<Supplier>() {
        public Supplier mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            Supplier s = new Supplier();
            s.setId(rs.getInt("id"));
            s.setName(rs.getString("name"));
            try { s.setPhone(rs.getString("phone")); }
            catch (Exception e) {}
            try { s.setEmail(rs.getString("email")); }
            catch (Exception e) {}
            try { s.setAddress(rs.getString("address")); }
            catch (Exception e) {}
            return s;
        }
    };

    // RowMapper có thống kê
    private RowMapper<Supplier> statsRowMapper =
        new RowMapper<Supplier>() {
        public Supplier mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            Supplier s = new Supplier();
            s.setId(rs.getInt("id"));
            s.setName(rs.getString("name"));
            try { s.setPhone(rs.getString("phone")); }
            catch (Exception e) {}
            try { s.setEmail(rs.getString("email")); }
            catch (Exception e) {}
            try { s.setAddress(rs.getString("address")); }
            catch (Exception e) {}
            // Thống kê
            try { s.setProductCount(
                rs.getInt("product_count")); }
            catch (Exception e) {}
            try { s.setImportCount(
                rs.getInt("import_count")); }
            catch (Exception e) {}
            try { s.setTotalQuantity(
                rs.getDouble("total_quantity")); }
            catch (Exception e) {}
            try { s.setLastImportDate(
                rs.getString("last_import")); }
            catch (Exception e) {}
            return s;
        }
    };

    // ===== Lấy tất cả NCC kèm thống kê =====
    public List<Supplier> findAllWithStats() {
        return jdbcTemplate.query(
            "SELECT s.*, " +
            "  (SELECT COUNT(*) FROM products p " +
            "   WHERE p.supplier_id = s.id " +
            "   AND p.is_active = 1) AS product_count, " +
            "  (SELECT COUNT(*) FROM inventory i " +
            "   WHERE i.supplier_id = s.id) AS import_count, " +
            "  (SELECT COALESCE(SUM(i2.quantity),0) " +
            "   FROM inventory i2 " +
            "   WHERE i2.supplier_id = s.id) AS total_quantity, " +
            "  (SELECT DATE_FORMAT(MAX(i3.last_updated)," +
            "   '%d/%m/%Y') FROM inventory i3 " +
            "   WHERE i3.supplier_id = s.id) AS last_import " +
            "FROM suppliers s " +
            "ORDER BY s.id",
            statsRowMapper);
    }

    // Lấy tất cả (không thống kê — dùng cho dropdown)
    public List<Supplier> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM suppliers ORDER BY id",
            rowMapper);
    }

    public Supplier findById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM suppliers WHERE id = ?",
                rowMapper, id);
        } catch (Exception e) { return null; }
    }

    public void save(Supplier s) {
        jdbcTemplate.update(
            "INSERT INTO suppliers " +
            "(name, phone, email, address) " +
            "VALUES (?, ?, ?, ?)",
            s.getName(), s.getPhone(),
            s.getEmail(), s.getAddress());
    }

    public void update(Supplier s) {
        jdbcTemplate.update(
            "UPDATE suppliers " +
            "SET name=?, phone=?, email=?, address=? " +
            "WHERE id=?",
            s.getName(), s.getPhone(),
            s.getEmail(), s.getAddress(),
            s.getId());
    }

    public void delete(int id) {
        jdbcTemplate.update(
            "DELETE FROM suppliers WHERE id = ?", id);
    }

    public int countProducts(int supplierId) {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM products " +
            "WHERE supplier_id = ?",
            Integer.class, supplierId);
        return count != null ? count : 0;
    }
}