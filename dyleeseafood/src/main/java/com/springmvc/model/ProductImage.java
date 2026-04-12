package com.springmvc.model;

public class ProductImage {
    private int id;
    private int productId;
    private String imageUrl;
    private boolean primary;
    private int sortOrder;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int v) { this.productId = v; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String v) { this.imageUrl = v; }
    public boolean isPrimary() { return primary; }
    public void setPrimary(boolean v) { this.primary = v; }
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int v) { this.sortOrder = v; }
}