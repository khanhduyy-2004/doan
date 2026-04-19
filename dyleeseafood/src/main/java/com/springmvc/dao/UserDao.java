package com.springmvc.dao;

import com.springmvc.model.User;
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

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<User> rowMapper =
        new RowMapper<User>() {
        public User mapRow(ResultSet rs, int row)
                throws SQLException {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setRoleId(rs.getInt("role_id"));
            u.setActive(rs.getInt("is_active") == 1);
            return u;
        }
    };

    // Tìm theo username → dùng khi login
    public User findByUsername(String username) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM users WHERE username = ?",
                rowMapper, username);
        } catch (Exception e) { return null; }
    }

    // Tìm theo ID
    public User findById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM users WHERE id = ?",
                rowMapper, id);
        } catch (Exception e) { return null; }
    }

    // Lưu user mới → trả về ID
    public int saveAndGetId(User u) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps =
                connection.prepareStatement(
                "INSERT INTO users " +
                "(username, password, " +
                " role_id, is_active) " +
                "VALUES (?, ?, ?, 1)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setInt(3, u.getRoleId());
            return ps;
        }, keyHolder);
        return keyHolder.getKey().intValue();
    }

    // Đổi mật khẩu — nhận password đã hash BCrypt
    public void updatePassword(int userId,
                                String hashedPassword) {
        jdbcTemplate.update(
            "UPDATE users SET password = ? " +
            "WHERE id = ?",
            hashedPassword, userId);
    }

    // Khóa / Mở khóa tài khoản
    public void toggleActive(int userId) {
        jdbcTemplate.update(
            "UPDATE users SET is_active = " +
            "CASE WHEN is_active = 1 " +
            "     THEN 0 ELSE 1 END " +
            "WHERE id = ?", userId);
    }
}
