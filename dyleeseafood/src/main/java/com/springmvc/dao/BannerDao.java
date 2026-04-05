package com.springmvc.dao;

import com.springmvc.model.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class BannerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Banner> rowMapper = new RowMapper<Banner>() {
        public Banner mapRow(ResultSet rs, int rowNum) throws SQLException {
            Banner b = new Banner();
            b.setId(rs.getInt("id"));
            b.setTitle(rs.getString("title"));
            b.setImageUrl(rs.getString("image_url"));
            b.setLinkUrl(rs.getString("link_url"));
            b.setSortOrder(rs.getInt("sort_order"));
            b.setActive(rs.getInt("is_active") == 1);
            return b;
        }
    };

    public List<Banner> findActive() {
        return jdbcTemplate.query(
            "SELECT * FROM banners WHERE is_active = 1 ORDER BY sort_order",
            rowMapper);
    }
}