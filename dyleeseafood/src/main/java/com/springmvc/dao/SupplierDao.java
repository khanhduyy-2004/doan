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

    // Lấy tất cả nhà cung cấp
    public List<Supplier> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM suppliers ORDER BY id",
            rowMapper);
    }

    // Tìm theo ID
    public Supplier findById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM suppliers WHERE id = ?",
                rowMapper, id);
        } catch (Exception e) { return null; }
    }

    // Thêm mới
    public void save(Supplier s) {
        jdbcTemplate.update(
            "INSERT INTO suppliers " +
            "(name, phone, email, address) " +
            "VALUES (?, ?, ?, ?)",
            s.getName(), s.getPhone(),
            s.getEmail(), s.getAddress());
    }

    // Cập nhật
    public void update(Supplier s) {
        jdbcTemplate.update(
            "UPDATE suppliers " +
            "SET name=?, phone=?, email=?, address=? " +
            "WHERE id=?",
            s.getName(), s.getPhone(),
            s.getEmail(), s.getAddress(),
            s.getId());
    }

    // Xóa
    public void delete(int id) {
        jdbcTemplate.update(
            "DELETE FROM suppliers WHERE id = ?", id);
    }

    // Đếm số sản phẩm của nhà cung cấp
    public int countProducts(int supplierId) {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM products " +
            "WHERE supplier_id = ?",
            Integer.class, supplierId);
        return count != null ? count : 0;
    }
}