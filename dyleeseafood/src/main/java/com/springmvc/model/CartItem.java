package com.springmvc.model;

public class CartItem {
    private int    productId;
    private String name;
    private double price;
    private double quantity;
    private String unit;
    private String imageUrl;
    private String note;      // ← thêm mới

    public CartItem() {}

    // Constructor nhận double qty (fix lỗi đỏ)
    public CartItem(Product product, double quantity) {
        this.productId = product.getId();
        this.name      = product.getName();
        this.price     = product.getPrice();
        this.unit      = product.getUnit();
        this.imageUrl  = product.getImageUrl();
        this.quantity  = quantity;
    }

    // Giữ thêm constructor int để tương thích code cũ
    public CartItem(Product product, int quantity) {
        this(product, (double) quantity);
    }

    public int    getProductId()          { return productId; }
    public void   setProductId(int v)     { this.productId = v; }
    public String getName()               { return name; }
    public void   setName(String v)       { this.name = v; }
    public double getPrice()              { return price; }
    public void   setPrice(double v)      { this.price = v; }
    public double getQuantity()           { return quantity; }
    public void   setQuantity(double v)   { this.quantity = v; }
    public String getUnit()               { return unit; }
    public void   setUnit(String v)       { this.unit = v; }
    public String getImageUrl()           { return imageUrl; }
    public void   setImageUrl(String v)   { this.imageUrl = v; }
    public String getNote()               { return note; }
    public void   setNote(String v)       { this.note = v; }
    public double getTotalPrice()         { return price * quantity; }
}
