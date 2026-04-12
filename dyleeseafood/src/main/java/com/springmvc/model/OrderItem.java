package com.springmvc.model;

public class OrderItem {
    // Bảng order_items
    private int id;
    private int orderId;
    private int productId;
    private double quantity;
    private double price;

    // JOIN fields
    private String productName;
    private String productUnit;
    private String imageUrl;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int v) { this.orderId = v; }
    public int getProductId() { return productId; }
    public void setProductId(int v) { this.productId = v; }
    public double getQuantity() { return quantity; }
    public void setQuantity(double v) { this.quantity = v; }
    public double getPrice() { return price; }
    public void setPrice(double v) { this.price = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public String getProductUnit() { return productUnit; }
    public void setProductUnit(String v) { this.productUnit = v; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String v) { this.imageUrl = v; }
    public double getTotalPrice() { return quantity * price; }
}