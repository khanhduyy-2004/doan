package com.springmvc.model;

public class ProductImage {
    private int id;
    private int productId;
    private String imageUrl;
    private boolean isPrimary;
    private int sortOrder;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isPrimary() { return isPrimary; }
    public void setPrimary(boolean primary) { this.isPrimary = primary; }
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
}