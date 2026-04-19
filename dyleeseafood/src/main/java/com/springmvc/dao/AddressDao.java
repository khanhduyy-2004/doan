package com.springmvc.dao;

import com.springmvc.model.Address;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AddressDao {

    @Autowired private JdbcTemplate jdbc;

    private RowMapper<Address> mapper = (rs, i) -> {
        Address a = new Address();
        a.setId(rs.getInt("id"));
        a.setCustomerId(rs.getInt("customer_id"));
        a.setFullName(rs.getString("full_name"));
        a.setPhone(rs.getString("phone"));
        a.setAddress(rs.getString("address"));
        a.setWard(rs.getString("ward"));
        a.setDistrict(rs.getString("district"));
        a.setCity(rs.getString("city"));
        a.setDefault(rs.getInt("is_default") == 1);
        return a;
    };

    // Lấy tất cả địa chỉ của khách hàng
    public List<Address> findByCustomerId(int customerId) {
        return jdbc.query(
            "SELECT * FROM addresses WHERE customer_id=? ORDER BY is_default DESC, id DESC",
            mapper, customerId);
    }

    // Lấy 1 địa chỉ theo id
    public Address findById(int id) {
        try {
            return jdbc.queryForObject(
                "SELECT * FROM addresses WHERE id=?", mapper, id);
        } catch (Exception e) { return null; }
    }

    // Lấy địa chỉ mặc định
    public Address findDefaultByCustomerId(int customerId) {
        try {
            return jdbc.queryForObject(
                "SELECT * FROM addresses WHERE customer_id=? AND is_default=1 LIMIT 1",
                mapper, customerId);
        } catch (Exception e) {
            // Không có mặc định → lấy địa chỉ đầu tiên
            try {
                return jdbc.queryForObject(
                    "SELECT * FROM addresses WHERE customer_id=? ORDER BY id DESC LIMIT 1",
                    mapper, customerId);
            } catch (Exception ex) { return null; }
        }
    }

    // Thêm địa chỉ mới
    public int save(Address a) {
        jdbc.update(
            "INSERT INTO addresses(customer_id,full_name,phone,address,ward,district,city,is_default)" +
            " VALUES(?,?,?,?,?,?,?,?)",
            a.getCustomerId(), a.getFullName(), a.getPhone(),
            a.getAddress(), a.getWard(), a.getDistrict(), a.getCity(),
            a.isDefaultAddr() ? 1 : 0);
        return jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }

    // Cập nhật địa chỉ
    public void update(Address a) {
        jdbc.update(
            "UPDATE addresses SET full_name=?,phone=?,address=?,ward=?,district=?,city=? WHERE id=?",
            a.getFullName(), a.getPhone(), a.getAddress(),
            a.getWard(), a.getDistrict(), a.getCity(), a.getId());
    }

    // Xoá địa chỉ (chỉ xoá nếu chưa được dùng trong orders)
    public boolean delete(int id, int customerId) {
        // Chỉ chặn nếu có đơn hàng ĐANG XỬ LÝ (Pending/Confirmed/Shipping)
        Integer active = jdbc.queryForObject(
            "SELECT COUNT(*) FROM orders WHERE address_id=? " +
            "AND status IN ('Pending','Confirmed','Processing','Shipping')",
            Integer.class, id);
        if (active != null && active > 0) return false;

        // Đơn đã hoàn thành/hủy → set address_id = NULL rồi xóa
        jdbc.update("UPDATE orders SET address_id=NULL WHERE address_id=?", id);
        jdbc.update("DELETE FROM addresses WHERE id=? AND customer_id=?", id, customerId);
        return true;
    }

    // Đặt địa chỉ mặc định
    public void setDefault(int id, int customerId) {
        jdbc.update("UPDATE addresses SET is_default=0 WHERE customer_id=?", customerId);
        jdbc.update("UPDATE addresses SET is_default=1 WHERE id=? AND customer_id=?", id, customerId);
    }

    // Đếm số địa chỉ
    public int countByCustomerId(int customerId) {
        return jdbc.queryForObject(
            "SELECT COUNT(*) FROM addresses WHERE customer_id=?", Integer.class, customerId);
    }
}
