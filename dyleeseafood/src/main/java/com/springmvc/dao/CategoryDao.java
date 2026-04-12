package com.springmvc.dao;

import com.springmvc.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CategoryDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Category> rowMapper =
        new RowMapper<Category>() {
        public Category mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            Category c = new Category();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setDescription(rs.getString("description"));
            c.setIcon(rs.getString("icon"));
            c.setImageUrl(rs.getString("image_url"));
            c.setSortOrder(rs.getInt("sort_order"));
            return c;
        }
    };

    public List<Category> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM categories ORDER BY sort_order ASC",
            rowMapper);
    }

    public Category findById(int id) {
        return jdbcTemplate.queryForObject(
            "SELECT * FROM categories WHERE id = ?",
            rowMapper, id);
    }

    public void save(Category c) {
        // Tự động lấy thứ tự tiếp theo
        if (c.getSortOrder() == 0) {
            Integer maxOrder = jdbcTemplate.queryForObject(
                "SELECT COALESCE(MAX(sort_order), 0) FROM categories",
                Integer.class);
            c.setSortOrder(maxOrder + 1);
        }
        jdbcTemplate.update(
            "INSERT INTO categories " +
            "(name, description, icon, sort_order) " +
            "VALUES (?, ?, ?, ?)",
            c.getName(),
            c.getDescription(),
            c.getIcon(),
            c.getSortOrder());
    }

    public void update(Category c) {
        jdbcTemplate.update(
            "UPDATE categories SET name=?, " +
            "description=?, icon=?, sort_order=? " +
            "WHERE id=?",
            c.getName(),
            c.getDescription(),
            c.getIcon(),
            c.getSortOrder(),
            c.getId());
    }

    public void delete(int id) {
        jdbcTemplate.update(
            "DELETE FROM categories WHERE id = ?", id);
    }
}