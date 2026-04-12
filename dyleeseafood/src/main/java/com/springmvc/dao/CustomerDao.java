package com.springmvc.dao;

import com.springmvc.model.Customer;
import com.springmvc.model.CustomerTier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CustomerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // RowMapper cơ bản - chỉ map đúng bảng customers
    private RowMapper<Customer> rowMapper =
        new RowMapper<Customer>() {
        public Customer mapRow(ResultSet rs, int row)
                throws SQLException {
            Customer c = new Customer();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            try { c.setEmail(rs.getString("email")); }
            catch (SQLException e) {}
            try { c.setPhone(rs.getString("phone")); }
            catch (SQLException e) {}
            c.setUserId(rs.getInt("user_id"));
            c.setTierId(rs.getInt("tier_id"));
            try {
                c.setTotalSpent(rs.getDouble("total_spent"));
            } catch (SQLException e) {}
            return c;
        }
    };

    // ===== KHÁCH HÀNG =====

    // Lưu khách hàng mới
    public void save(Customer c) {
        jdbcTemplate.update(
            "INSERT INTO customers " +
            "(name, email, phone, user_id, tier_id) " +
            "VALUES (?, ?, ?, ?, ?)",
            c.getName(), c.getEmail(), c.getPhone(),
            c.getUserId(), c.getTierId());
    }

    // Tìm theo user_id → dùng sau khi login
    public Customer findByUserId(int userId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM customers WHERE user_id = ?",
                rowMapper, userId);
        } catch (Exception e) { return null; }
    }

    // Lấy tất cả khách hàng (role_id = 3)
    // JOIN để lấy tier_name + username
    public List<Customer> findAllWithTier() {
        return jdbcTemplate.query(
            "SELECT c.*, ct.name as tier_name, " +
            "u.username " +
            "FROM customers c " +
            "LEFT JOIN customer_tiers ct " +
            "  ON c.tier_id = ct.id " +
            "LEFT JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 3 " +
            "ORDER BY c.total_spent DESC",
            new RowMapper<Customer>() {
                public Customer mapRow(ResultSet rs, int row)
                        throws SQLException {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                    try { c.setEmail(rs.getString("email")); }
                    catch (SQLException e) {}
                    try { c.setPhone(rs.getString("phone")); }
                    catch (SQLException e) {}
                    c.setTierId(rs.getInt("tier_id"));
                    c.setTotalSpent(rs.getDouble("total_spent"));
                    try {
                        c.setTierName(rs.getString("tier_name"));
                    } catch (SQLException e) {}
                    try {
                        c.setUsername(rs.getString("username"));
                    } catch (SQLException e) {}
                    return c;
                }
            });
    }

    // Lấy nhân viên (role_id = 2)
    // JOIN để lấy username + is_active từ users
    public List<Customer> findStaff() {
        return jdbcTemplate.query(
            "SELECT c.*, u.username, u.is_active " +
            "FROM customers c " +
            "JOIN users u ON c.user_id = u.id " +
            "WHERE u.role_id = 2 " +
            "ORDER BY c.id DESC",
            new RowMapper<Customer>() {
                public Customer mapRow(ResultSet rs, int row)
                        throws SQLException {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                    try { c.setPhone(rs.getString("phone")); }
                    catch (SQLException e) {}
                    c.setUserId(rs.getInt("user_id"));
                    c.setUsername(rs.getString("username"));
                    c.setActive(rs.getInt("is_active") == 1);
                    return c;
                }
            });
    }

    // Top 3 chi tiêu nhiều nhất
    public List<Customer> findTop3() {
        return jdbcTemplate.query(
            "SELECT c.*, ct.name as tier_name " +
            "FROM customers c " +
            "LEFT JOIN customer_tiers ct " +
            "  ON c.tier_id = ct.id " +
            "ORDER BY c.total_spent DESC LIMIT 3",
            new RowMapper<Customer>() {
                public Customer mapRow(ResultSet rs, int row)
                        throws SQLException {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                    c.setTierId(rs.getInt("tier_id"));
                    c.setTotalSpent(rs.getDouble("total_spent"));
                    try {
                        c.setTierName(rs.getString("tier_name"));
                    } catch (SQLException e) {}
                    return c;
                }
            });
    }

    // ===== HẠNG THÀNH VIÊN =====

    // Lấy tất cả hạng
    public List<CustomerTier> findAllTiers() {
        return jdbcTemplate.query(
            "SELECT * FROM customer_tiers ORDER BY id",
            new RowMapper<CustomerTier>() {
                public CustomerTier mapRow(ResultSet rs, int row)
                        throws SQLException {
                    CustomerTier t = new CustomerTier();
                    t.setId(rs.getInt("id"));
                    t.setName(rs.getString("name"));
                    t.setDiscountPercent(
                        rs.getDouble("discount_percent"));
                    t.setMinSpent(rs.getDouble("min_spent"));
                    return t;
                }
            });
    }

    // Đổi hạng thủ công
    public void updateTier(int customerId, int tierId) {
        jdbcTemplate.update(
            "UPDATE customers SET tier_id = ? WHERE id = ?",
            tierId, customerId);
    }

    // Cộng tiền khi đơn giao thành công
    public void addSpent(int customerId, double amount) {
        jdbcTemplate.update(
            "UPDATE customers " +
            "SET total_spent = total_spent + ? " +
            "WHERE id = ?",
            amount, customerId);
    }

    // Tự động nâng hạng dựa trên total_spent
    public void autoUpgradeTier(int customerId) {
        Double spent = jdbcTemplate.queryForObject(
            "SELECT total_spent FROM customers WHERE id = ?",
            Double.class, customerId);
        if (spent == null) return;

        int newTierId;
        if (spent >= 20000000)     newTierId = 3; // VVIP
        else if (spent >= 5000000) newTierId = 2; // VIP
        else                       newTierId = 1; // Thường

        jdbcTemplate.update(
            "UPDATE customers SET tier_id = ? WHERE id = ?",
            newTierId, customerId);
    }
}