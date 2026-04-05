package com.springmvc.model;

public class Product {
    private int id;
    private String name;
    private String description;
    private String slug;
    private double price;
    private double stock;
    private String unit;
    private int categoryId;
    private boolean isActive;
    private boolean isFeatured;
    private String createdAt;
    private String categoryName;
    private String imageUrl;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public double getStock() { return stock; }
    public void setStock(double stock) { this.stock = stock; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { this.isActive = active; }
    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { this.isFeatured = featured; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}