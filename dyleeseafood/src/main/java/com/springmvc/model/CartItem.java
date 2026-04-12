package com.springmvc.model;

public class CartItem {
    private int productId;
    private String name;
    private double price;
    private double quantity;
    private String unit;
    private String imageUrl;

    public CartItem() {}

    // Constructor từ Product object
    public CartItem(Product product, int quantity) {
        this.productId = product.getId();
        this.name      = product.getName();
        this.price     = product.getPrice();
        this.unit      = product.getUnit();
        this.imageUrl  = product.getImageUrl();
        this.quantity  = quantity;
    }

    public int getProductId() { return productId; }
    public void setProductId(int v) { this.productId = v; }
    public String getName() { return name; }
    public void setName(String v) { this.name = v; }
    public double getPrice() { return price; }
    public void setPrice(double v) { this.price = v; }
    public double getQuantity() { return quantity; }
    public void setQuantity(double v) { this.quantity = v; }
    public String getUnit() { return unit; }
    public void setUnit(String v) { this.unit = v; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String v) { this.imageUrl = v; }
    public double getTotalPrice() { return price * quantity; }
}