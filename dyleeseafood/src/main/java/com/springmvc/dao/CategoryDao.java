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

    private RowMapper<Category> rowMapper = new RowMapper<Category>() {
        public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
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
            "SELECT * FROM categories ORDER BY sort_order", rowMapper);
    }

    public Category findById(int id) {
        return jdbcTemplate.queryForObject(
            "SELECT * FROM categories WHERE id = ?", rowMapper, id);
    }
}