package com.springmvc.model;

public class Category {
    private int    id;
    private String name;
    private String description;
    private String icon;
    private String imageUrl;
    private int    sortOrder;
    private int    productCount; // ← THÊM MỚI để đếm SP trong biểu đồ

    public int    getId()               { return id; }
    public void   setId(int id)         { this.id = id; }

    public String getName()             { return name; }
    public void   setName(String v)     { this.name = v; }

    public String getDescription()      { return description; }
    public void   setDescription(String v) { this.description = v; }

    public String getIcon()             { return icon; }
    public void   setIcon(String v)     { this.icon = v; }

    public String getImageUrl()         { return imageUrl; }
    public void   setImageUrl(String v) { this.imageUrl = v; }

    public int    getSortOrder()        { return sortOrder; }
    public void   setSortOrder(int v)   { this.sortOrder = v; }

    public int    getProductCount()     { return productCount; } // ← THÊM
    public void   setProductCount(int v){ this.productCount = v; } // ← THÊM
}
