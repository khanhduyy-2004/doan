package com.springmvc.dao;

import com.springmvc.model.Customer;
import com.springmvc.model.CustomerTier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CustomerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // ── RowMapper cơ bản ──────────────────────────────────────────────────────
    private RowMapper<Customer> rowMapper = new RowMapper<Customer>() {
        public Customer mapRow(ResultSet rs, int row) throws SQLException {
            Customer c = new Customer();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            try { c.setEmail(rs.getString("email")); }      catch (SQLException e) {}
            try { c.setPhone(rs.getString("phone")); }      catch (SQLException e) {}
            c.setUserId(rs.getInt("user_id"));
            c.setTierId(rs.getInt("tier_id"));
            try { c.setTotalSpent(rs.getDouble("total_spent")); } catch (SQLException e) {}
            return c;
        }
    };

    // ── RowMapper đầy đủ (JOIN tier + user) ──────────────────────────────────
    private RowMapper<Customer> fullMapper = new RowMapper<Customer>() {
        public Customer mapRow(ResultSet rs, int row) throws SQLException {
            Customer c = new Customer();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            try { c.setEmail(rs.getString("email")); }      catch (SQLException e) {}
            try { c.setPhone(rs.getString("phone")); }      catch (SQLException e) {}
            c.setUserId(rs.getInt("user_id"));
            c.setTierId(rs.getInt("tier_id"));
            try { c.setTotalSpent(rs.getDouble("total_spent")); } catch (SQLException e) {}
            try { c.setTierName(rs.getString("tier_name")); }     catch (SQLException e) {}
            try { c.setUsername(rs.getString("username")); }      catch (SQLException e) {}
            return c;
        }
    };

    // ── CRUD cơ bản ───────────────────────────────────────────────────────────

    public void save(Customer c) {
        jdbcTemplate.update(
            "INSERT INTO customers (name, email, phone, user_id, tier_id) VALUES (?,?,?,?,?)",
            c.getName(), c.getEmail(), c.getPhone(), c.getUserId(), c.getTierId());
    }

    public void updateInfo(Customer c) {
        jdbcTemplate.update(
            "UPDATE customers SET name=?, email=?, phone=? WHERE id=?",
            c.getName(), c.getEmail(), c.getPhone(), c.getId());
    }

    public Customer findByUserId(int userId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM customers WHERE user_id=?", rowMapper, userId);
        } catch (Exception e) { return null; }
    }

    // ── Danh sách đầy đủ ──────────────────────────────────────────────────────

    public List<Customer> findAllWithTier() {
        return jdbcTemplate.query(
            "SELECT c.*, ct.name as tier_name, u.username " +
            "FROM customers c " +
            "LEFT JOIN customer_tiers ct ON c.tier_id = ct.id " +
            "LEFT JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 3 ORDER BY c.total_spent DESC",
            fullMapper);
    }

    public List<Customer> findStaff() {
        return jdbcTemplate.query(
            "SELECT c.*, u.username, u.is_active " +
            "FROM customers c JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 2 ORDER BY c.id DESC",
            new RowMapper<Customer>() {
                public Customer mapRow(ResultSet rs, int row) throws SQLException {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                    try { c.setPhone(rs.getString("phone")); } catch (SQLException e) {}
                    c.setUserId(rs.getInt("user_id"));
                    c.setUsername(rs.getString("username"));
                    c.setActive(rs.getInt("is_active") == 1);
                    return c;
                }
            });
    }

    public List<Customer> findTop3() {
        return jdbcTemplate.query(
            "SELECT c.*, ct.name as tier_name " +
            "FROM customers c LEFT JOIN customer_tiers ct ON c.tier_id=ct.id " +
            "ORDER BY c.total_spent DESC LIMIT 3",
            new RowMapper<Customer>() {
                public Customer mapRow(ResultSet rs, int row) throws SQLException {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                    c.setTierId(rs.getInt("tier_id"));
                    c.setTotalSpent(rs.getDouble("total_spent"));
                    try { c.setTierName(rs.getString("tier_name")); } catch (SQLException e) {}
                    return c;
                }
            });
    }

    // ── TÌM KIẾM + PHÂN TRANG ─────────────────────────────────────────────────

    public List<Customer> search(String keyword, Integer tierId,
                                  int page, int pageSize) {
        StringBuilder sql = new StringBuilder(
            "SELECT c.*, ct.name as tier_name, u.username " +
            "FROM customers c " +
            "LEFT JOIN customer_tiers ct ON c.tier_id = ct.id " +
            "LEFT JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 3 ");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (c.name LIKE ? OR c.email LIKE ? OR c.phone LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (tierId != null && tierId > 0) {
            sql.append("AND c.tier_id = ? ");
            params.add(tierId);
        }
        sql.append("ORDER BY c.total_spent DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);
        return jdbcTemplate.query(sql.toString(), fullMapper, params.toArray());
    }

    public int countSearch(String keyword, Integer tierId) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM customers c " +
            "LEFT JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 3 ");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (c.name LIKE ? OR c.email LIKE ? OR c.phone LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (tierId != null && tierId > 0) {
            sql.append("AND c.tier_id = ? ");
            params.add(tierId);
        }
        Integer count = jdbcTemplate.queryForObject(
            sql.toString(), Integer.class, params.toArray());
        return count != null ? count : 0;
    }

    // ── HẠNG THÀNH VIÊN ───────────────────────────────────────────────────────

    public List<CustomerTier> findAllTiers() {
        return jdbcTemplate.query(
            "SELECT * FROM customer_tiers ORDER BY id",
            new RowMapper<CustomerTier>() {
                public CustomerTier mapRow(ResultSet rs, int row) throws SQLException {
                    CustomerTier t = new CustomerTier();
                    t.setId(rs.getInt("id"));
                    t.setName(rs.getString("name"));
                    t.setDiscountPercent(rs.getDouble("discount_percent"));
                    t.setMinSpent(rs.getDouble("min_spent"));
                    return t;
                }
            });
    }

    public void updateTier(int customerId, int tierId) {
        jdbcTemplate.update(
            "UPDATE customers SET tier_id=? WHERE id=?", tierId, customerId);
    }

    public void addSpent(int customerId, double amount) {
        jdbcTemplate.update(
            "UPDATE customers SET total_spent = total_spent + ? WHERE id=?",
            amount, customerId);
    }

    public void autoUpgradeTier(int customerId) {
        Double spent = jdbcTemplate.queryForObject(
            "SELECT total_spent FROM customers WHERE id=?", Double.class, customerId);
        if (spent == null) return;
        int newTierId = spent >= 20000000 ? 3 : spent >= 5000000 ? 2 : 1;
        jdbcTemplate.update(
            "UPDATE customers SET tier_id=? WHERE id=?", newTierId, customerId);
    }

    // ── TIỆN ÍCH ──────────────────────────────────────────────────────────────

    public double getDiscountPercent(int tierId) {
        try {
            Double d = jdbcTemplate.queryForObject(
                "SELECT discount_percent FROM customer_tiers WHERE id=?",
                Double.class, tierId);
            return d != null ? d : 0.0;
        } catch (Exception e) { return 0.0; }
    }

    public void updateAvatar(int customerId, String avatarUrl) {
        jdbcTemplate.update(
            "UPDATE customers SET avatar_url=? WHERE id=?", avatarUrl, customerId);
    }
}
