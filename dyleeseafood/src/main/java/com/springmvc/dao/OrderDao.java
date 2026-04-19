package com.springmvc.dao;

import com.springmvc.model.Order;
import com.springmvc.model.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import java.sql.*;
import java.util.List;

@Repository
public class OrderDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Order> orderRowMapper = (rs, row) -> {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setCustomerId(rs.getInt("customer_id"));
        try { o.setAddressId(rs.getInt("address_id")); }  catch (Exception e) {}
        try { o.setOrderDate(rs.getString("order_date")); } catch (Exception e) {}
        try { o.setStatus(rs.getString("status")); }       catch (Exception e) {}
        try { o.setSubtotal(rs.getDouble("subtotal")); }   catch (Exception e) {}
        try { o.setShippingFee(rs.getDouble("shipping_fee")); } catch (Exception e) {}
        try { o.setTotal(rs.getDouble("total")); }         catch (Exception e) {}
        try { o.setNote(rs.getString("note")); }           catch (Exception e) {}
        try { o.setCustomerName(rs.getString("customer_name")); }  catch (Exception e) {}
        try { o.setCustomerPhone(rs.getString("customer_phone")); } catch (Exception e) {}
        try { o.setPaymentMethod(rs.getString("payment_method")); }  catch (Exception e) {}
        try { o.setPaymentStatus(rs.getString("payment_status")); }  catch (Exception e) {}
        return o;
    };

    private RowMapper<OrderItem> itemRowMapper = (rs, row) -> {
        OrderItem i = new OrderItem();
        i.setId(rs.getInt("id"));
        i.setOrderId(rs.getInt("order_id"));
        i.setProductId(rs.getInt("product_id"));
        i.setQuantity(rs.getDouble("quantity"));
        i.setPrice(rs.getDouble("price"));
        try { i.setProductName(rs.getString("product_name")); } catch (Exception e) {}
        try { i.setProductUnit(rs.getString("product_unit")); } catch (Exception e) {}
        try { i.setImageUrl(rs.getString("image_url")); }       catch (Exception e) {}
        return i;
    };

    private static final String ORDER_SELECT =
        "SELECT o.*, c.name as customer_name, " +
        "c.phone as customer_phone, " +
        "p.method as payment_method, " +
        "p.status as payment_status " +
        "FROM orders o " +
        "LEFT JOIN customers c ON o.customer_id = c.id " +
        "LEFT JOIN payments p ON p.order_id = o.id ";

    // ── SEARCH VỚI KEYWORD + DATE + PAGINATION ────────────────────────────────

    public List<Order> search(String keyword, String status, String dateFrom, String dateTo,
                               int page, int pageSize) {
        StringBuilder sql = new StringBuilder(ORDER_SELECT + "WHERE 1=1 ");
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (status != null && !status.isEmpty()) { sql.append("AND o.status=? "); params.add(status); }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (CAST(o.id AS CHAR) LIKE ? OR c.name LIKE ?) ");
            params.add("%" + keyword + "%"); params.add("%" + keyword + "%");
        }
        if (dateFrom != null && !dateFrom.isEmpty()) { sql.append("AND DATE(o.order_date)>=? "); params.add(dateFrom); }
        if (dateTo   != null && !dateTo.isEmpty())   { sql.append("AND DATE(o.order_date)<=? "); params.add(dateTo); }
        sql.append("ORDER BY o.order_date DESC LIMIT ? OFFSET ?");
        params.add(pageSize); params.add((page - 1) * pageSize);
        return jdbcTemplate.query(sql.toString(), orderRowMapper, params.toArray());
    }

    public int countSearch(String keyword, String status, String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM orders o LEFT JOIN customers c ON o.customer_id=c.id WHERE 1=1 ");
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (status != null && !status.isEmpty()) { sql.append("AND o.status=? "); params.add(status); }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (CAST(o.id AS CHAR) LIKE ? OR c.name LIKE ?) ");
            params.add("%" + keyword + "%"); params.add("%" + keyword + "%");
        }
        if (dateFrom != null && !dateFrom.isEmpty()) { sql.append("AND DATE(o.order_date)>=? "); params.add(dateFrom); }
        if (dateTo   != null && !dateTo.isEmpty())   { sql.append("AND DATE(o.order_date)<=? "); params.add(dateTo); }
        return jdbcTemplate.queryForObject(sql.toString(), Integer.class, params.toArray());
    }

    // ── CÁC METHOD GỐC ────────────────────────────────────────────────────────

    public List<Order> findAll() {
        return jdbcTemplate.query(
            ORDER_SELECT + "ORDER BY o.order_date DESC",
            orderRowMapper);
    }

    public List<Order> findByStatus(String status) {
        return jdbcTemplate.query(
            ORDER_SELECT + "WHERE o.status = ? ORDER BY o.order_date DESC",
            orderRowMapper, status);
    }

    public Order findById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                ORDER_SELECT + "WHERE o.id = ?",
                orderRowMapper, id);
        } catch (Exception e) { return null; }
    }

    public List<Order> findByCustomerId(int customerId) {
        return jdbcTemplate.query(
            ORDER_SELECT + "WHERE o.customer_id = ? ORDER BY o.order_date DESC",
            orderRowMapper, customerId);
    }

    public List<Order> findByCustomerAndStatus(int customerId, String status) {
        return jdbcTemplate.query(
            ORDER_SELECT + "WHERE o.customer_id = ? AND o.status = ? ORDER BY o.order_date DESC",
            orderRowMapper, customerId, status);
    }

    public List<OrderItem> findItems(int orderId) {
        return jdbcTemplate.query(
            "SELECT oi.*, p.name as product_name, " +
            "p.unit as product_unit, pi.image_url " +
            "FROM order_items oi " +
            "LEFT JOIN products p ON oi.product_id = p.id " +
            "LEFT JOIN product_images pi ON pi.product_id = p.id AND pi.is_primary = 1 " +
            "WHERE oi.order_id = ?",
            itemRowMapper, orderId);
    }

    public int countByStatus(String status) {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders WHERE status = ?",
            Integer.class, status);
        return count != null ? count : 0;
    }

    public void updateStatus(int orderId, String status) {
        jdbcTemplate.update(
            "UPDATE orders SET status = ? WHERE id = ?",
            status, orderId);
    }

    public int saveAddress(String fullName, String phone,
                           String address, String ward,
                           String district, String city,
                           int customerId) {
        KeyHolder key = new GeneratedKeyHolder();
        jdbcTemplate.update(conn -> {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO addresses (customer_id, full_name, phone, address, ward, district, city) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customerId);
            ps.setString(2, fullName);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, ward);
            ps.setString(6, district);
            ps.setString(7, city);
            return ps;
        }, key);
        return key.getKey().intValue();
    }

    public int createOrder(int customerId, int addressId,
                           double subtotal, double total,
                           String note) {
        KeyHolder key = new GeneratedKeyHolder();
        jdbcTemplate.update(conn -> {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO orders (customer_id, address_id, subtotal, shipping_fee, total, note, status) " +
                "VALUES (?, ?, ?, 0, ?, ?, 'Pending')",
                Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customerId);
            ps.setInt(2, addressId);
            ps.setDouble(3, subtotal);
            ps.setDouble(4, total);
            ps.setString(5, note);
            return ps;
        }, key);
        return key.getKey().intValue();
    }

    public void addOrderItem(int orderId, int productId,
                             double quantity, double price) {
        jdbcTemplate.update(
            "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)",
            orderId, productId, quantity, price);
    }

    public void createPayment(int orderId, String method, double amount) {
        jdbcTemplate.update(
            "INSERT INTO payments (order_id, method, status, amount) VALUES (?, ?, 'Unpaid', ?)",
            orderId, method, amount);
    }

    // ── METHOD MỚI: THỐNG KÊ DOANH THU ───────────────────────────────────────

    public double getRevenueToday() {
        Double r = jdbcTemplate.queryForObject(
            "SELECT COALESCE(SUM(total),0) FROM orders " +
            "WHERE status='Delivered' AND DATE(order_date)=CURDATE()",
            Double.class);
        return r != null ? r : 0;
    }

    public int getOrderCountToday() {
        Integer n = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders WHERE DATE(order_date)=CURDATE()",
            Integer.class);
        return n != null ? n : 0;
    }

    public double getRevenueThisMonth() {
        Double r = jdbcTemplate.queryForObject(
            "SELECT COALESCE(SUM(total),0) FROM orders WHERE status='Delivered' " +
            "AND MONTH(order_date)=MONTH(CURDATE()) AND YEAR(order_date)=YEAR(CURDATE())",
            Double.class);
        return r != null ? r : 0;
    }

    public int getOrderCountThisMonth() {
        Integer n = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders " +
            "WHERE MONTH(order_date)=MONTH(CURDATE()) AND YEAR(order_date)=YEAR(CURDATE())",
            Integer.class);
        return n != null ? n : 0;
    }

    public double getRevenueLastMonth() {
        Double r = jdbcTemplate.queryForObject(
            "SELECT COALESCE(SUM(total),0) FROM orders WHERE status='Delivered' " +
            "AND MONTH(order_date)=MONTH(DATE_SUB(CURDATE(),INTERVAL 1 MONTH)) " +
            "AND YEAR(order_date)=YEAR(DATE_SUB(CURDATE(),INTERVAL 1 MONTH))",
            Double.class);
        return r != null ? r : 0;
    }

    public int getOrderCountLastMonth() {
        Integer n = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders " +
            "WHERE MONTH(order_date)=MONTH(DATE_SUB(CURDATE(),INTERVAL 1 MONTH)) " +
            "AND YEAR(order_date)=YEAR(DATE_SUB(CURDATE(),INTERVAL 1 MONTH))",
            Integer.class);
        return n != null ? n : 0;
    }

    public List<com.springmvc.model.MonthlyRevenue> getMonthlyRevenue(int months) {
        String sql =
            "SELECT DATE_FORMAT(order_date,'%m/%Y') AS month, " +
            "       COALESCE(SUM(total),0) AS revenue, " +
            "       COUNT(id) AS orderCount " +
            "FROM orders WHERE status='Delivered' " +
            "AND order_date >= DATE_SUB(CURDATE(), INTERVAL ? MONTH) " +
            "GROUP BY DATE_FORMAT(order_date,'%m/%Y') " +
            "ORDER BY MIN(order_date) ASC";
        return jdbcTemplate.query(sql, (rs, i) -> {
            com.springmvc.model.MonthlyRevenue r = new com.springmvc.model.MonthlyRevenue();
            r.setMonth(rs.getString("month"));
            r.setRevenue(rs.getDouble("revenue"));
            r.setOrderCount(rs.getInt("orderCount"));
            return r;
        }, months);
    }

    public int countAll() {
        Integer n = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM orders", Integer.class);
        return n != null ? n : 0;
    }

    public List<Order> findRecent(int limit) {
        return jdbcTemplate.query(
            ORDER_SELECT + "ORDER BY o.order_date DESC LIMIT ?",
            orderRowMapper, limit);
    }


    // ── PAYMENT STATUS ──────────────────────────────────────────────────────
    public void updatePaymentStatus(int orderId, String status) {
        jdbcTemplate.update(
            "UPDATE payments SET status=?, paid_at=NOW() WHERE order_id=?",
            status, orderId);
    }

    public void updatePaymentTransaction(int orderId, String transactionId) {
        jdbcTemplate.update(
            "UPDATE payments SET transaction_id=?, status='Paid', paid_at=NOW() WHERE order_id=?",
            transactionId, orderId);
    }


} // ← đóng class OrderDao
