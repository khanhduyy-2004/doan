package com.springmvc.dao;

import com.springmvc.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<User> rowMapper = new RowMapper<User>() {
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setRoleId(rs.getInt("role_id"));
            u.setActive(rs.getInt("is_active") == 1);
            u.setCreatedAt(rs.getString("created_at"));
            return u;
        }
    };

    public User findByUsername(String username) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM users WHERE username = ?",
                rowMapper, username);
        } catch (Exception e) {
            return null;
        }
    }

    public void save(User user) {
        jdbcTemplate.update(
            "INSERT INTO users (username, password, role_id) VALUES (?,?,?)",
            user.getUsername(), user.getPassword(), 3); // role 3 = Customer
    }
}