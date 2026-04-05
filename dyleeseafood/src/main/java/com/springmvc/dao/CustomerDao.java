package com.springmvc.dao;

import com.springmvc.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class CustomerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Customer> rowMapper = new RowMapper<Customer>() {
        public Customer mapRow(ResultSet rs, int rowNum) throws SQLException {
            Customer c = new Customer();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setEmail(rs.getString("email"));
            c.setPhone(rs.getString("phone"));
            c.setUserId(rs.getInt("user_id"));
            c.setTierId(rs.getInt("tier_id"));
            c.setTotalSpent(rs.getDouble("total_spent"));
            return c;
        }
    };

    public Customer findByUserId(int userId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM customers WHERE user_id = ?",
                rowMapper, userId);
        } catch (Exception e) {
            return null;
        }
    }

    public void save(Customer customer) {
        jdbcTemplate.update(
            "INSERT INTO customers (name, email, phone, user_id, tier_id) VALUES (?,?,?,?,?)",
            customer.getName(), customer.getEmail(),
            customer.getPhone(), customer.getUserId(), 1);
    }
}