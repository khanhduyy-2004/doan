package com.springmvc.dao;

import com.springmvc.model.Inventory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class InventoryDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Inventory> rowMapper =
        new RowMapper<Inventory>() {
        public Inventory mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            Inventory inv = new Inventory();
            inv.setId(rs.getInt("id"));
            inv.setProductId(rs.getInt("product_id"));
            inv.setSupplierId(rs.getInt("supplier_id"));
            inv.setQuantity(rs.getDouble("quantity"));
            inv.setImportPrice(
                rs.getDouble("import_price"));
            try { inv.setNote(rs.getString("note")); }
            catch (Exception e) {}
            try { inv.setLastUpdated(
                rs.getString("last_updated")); }
            catch (Exception e) {}
            try { inv.setProductName(
                rs.getString("product_name")); }
            catch (Exception e) {}
            try { inv.setProductUnit(
                rs.getString("product_unit")); }
            catch (Exception e) {}
            try { inv.setSupplierName(
                rs.getString("supplier_name")); }
            catch (Exception e) {}
            return inv;
        }
    };

    // Nhập hàng → cập nhật tồn kho
    public void importStock(int productId,
                             int supplierId,
                             double quantity,
                             double importPrice,
                             String note) {
        // Lưu lịch sử
        jdbcTemplate.update(
            "INSERT INTO inventory " +
            "(product_id, supplier_id, quantity, " +
            " import_price, note) " +
            "VALUES (?, ?, ?, ?, ?)",
            productId, supplierId,
            quantity, importPrice, note);

        // Cộng vào tồn kho sản phẩm
        jdbcTemplate.update(
            "UPDATE products " +
            "SET stock = stock + ? " +
            "WHERE id = ?",
            quantity, productId);
    }

    // Tất cả lịch sử nhập hàng
    public List<Inventory> findAll() {
        return jdbcTemplate.query(
            "SELECT i.*, " +
            "p.name  AS product_name, " +
            "p.unit  AS product_unit, " +
            "s.name  AS supplier_name " +
            "FROM inventory i " +
            "LEFT JOIN products  p " +
            "  ON i.product_id  = p.id " +
            "LEFT JOIN suppliers s " +
            "  ON i.supplier_id = s.id " +
            "ORDER BY i.last_updated DESC",
            rowMapper);
    }

    // Lịch sử theo sản phẩm
    public List<Inventory> findByProduct(int productId) {
        return jdbcTemplate.query(
            "SELECT i.*, " +
            "p.name  AS product_name, " +
            "p.unit  AS product_unit, " +
            "s.name  AS supplier_name " +
            "FROM inventory i " +
            "LEFT JOIN products  p " +
            "  ON i.product_id  = p.id " +
            "LEFT JOIN suppliers s " +
            "  ON i.supplier_id = s.id " +
            "WHERE i.product_id = ? " +
            "ORDER BY i.last_updated DESC",
            rowMapper, productId);
    }

    // Lịch sử theo nhà cung cấp
    public List<Inventory> findBySupplier(
            int supplierId) {
        return jdbcTemplate.query(
            "SELECT i.*, " +
            "p.name  AS product_name, " +
            "p.unit  AS product_unit, " +
            "s.name  AS supplier_name " +
            "FROM inventory i " +
            "LEFT JOIN products  p " +
            "  ON i.product_id  = p.id " +
            "LEFT JOIN suppliers s " +
            "  ON i.supplier_id = s.id " +
            "WHERE i.supplier_id = ? " +
            "ORDER BY i.last_updated DESC",
            rowMapper, supplierId);
    }

    // Sản phẩm sắp hết hàng (stock < 10)
    public List<Inventory> findLowStock() {
        return jdbcTemplate.query(
            "SELECT " +
            "  p.id          AS product_id, " +
            "  p.name        AS product_name, " +
            "  p.unit        AS product_unit, " +
            "  p.stock       AS quantity, " +
            "  p.supplier_id AS supplier_id, " +
            "  s.name        AS supplier_name, " +
            "  0             AS id, " +
            "  0             AS import_price, " +
            "  ''            AS note, " +
            "  ''            AS last_updated " +
            "FROM products p " +
            "LEFT JOIN suppliers s " +
            "  ON p.supplier_id = s.id " +
            "WHERE p.stock < 10 " +
            "  AND p.is_active = 1 " +
            "ORDER BY p.stock ASC",
            rowMapper);
    }

    // Tổng số lần nhập của một NCC
    public int countBySupplier(int supplierId) {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM inventory " +
            "WHERE supplier_id = ?",
            Integer.class, supplierId);
        return count != null ? count : 0;
    }

    // Tổng số lượng nhập của một NCC
    public double totalQuantityBySupplier(
            int supplierId) {
        Double total = jdbcTemplate.queryForObject(
            "SELECT COALESCE(SUM(quantity),0) " +
            "FROM inventory " +
            "WHERE supplier_id = ?",
            Double.class, supplierId);
        return total != null ? total : 0;
    }
}