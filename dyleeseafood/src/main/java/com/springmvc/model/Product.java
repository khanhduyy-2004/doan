package com.springmvc.model;

public class Product {
    private int    id;
    private String name;
    private String description;
    private String slug;
    private double price;
    private double stock;
    private String unit;
    private int    categoryId;
    private int    supplierId;   // ← THÊM
    private boolean active;
    private boolean featured;
    private String createdAt;

    // JOIN fields
    private String categoryName;
    private String supplierName;  // ← THÊM
    private String imageUrl;

    public int     getId()          { return id; }
    public void    setId(int v)     { this.id = v; }

    public String  getName()          { return name; }
    public void    setName(String v)  { this.name = v; }

    public String  getDescription()          { return description; }
    public void    setDescription(String v)  { this.description = v; }

    public String  getSlug()          { return slug; }
    public void    setSlug(String v)  { this.slug = v; }

    public double  getPrice()          { return price; }
    public void    setPrice(double v)  { this.price = v; }

    public double  getStock()          { return stock; }
    public void    setStock(double v)  { this.stock = v; }

    public String  getUnit()          { return unit; }
    public void    setUnit(String v)  { this.unit = v; }

    public int     getCategoryId()       { return categoryId; }
    public void    setCategoryId(int v)  { this.categoryId = v; }

    public int     getSupplierId()       { return supplierId; }  // ← THÊM
    public void    setSupplierId(int v)  { this.supplierId = v; } // ← THÊM

    public boolean isActive()          { return active; }
    public void    setActive(boolean v){ this.active = v; }

    public boolean isFeatured()          { return featured; }
    public void    setFeatured(boolean v){ this.featured = v; }

    public String  getCreatedAt()          { return createdAt; }
    public void    setCreatedAt(String v)  { this.createdAt = v; }

    public String  getCategoryName()          { return categoryName; }
    public void    setCategoryName(String v)  { this.categoryName = v; }

    public String  getSupplierName()          { return supplierName; }  // ← THÊM
    public void    setSupplierName(String v)  { this.supplierName = v; } // ← THÊM

    public String  getImageUrl()          { return imageUrl; }
    public void    setImageUrl(String v)  { this.imageUrl = v; }
}