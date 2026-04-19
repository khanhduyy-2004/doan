package com.springmvc.model;

public class Supplier {
    private int    id;
    private String name;
    private String phone;
    private String email;
    private String address;

    // ===== THỐNG KÊ (JOIN) =====
    private int    productCount;   // số SP đang cung cấp
    private int    importCount;    // tổng lần nhập kho
    private double totalQuantity;  // tổng số lượng đã nhập
    private String lastImportDate; // ngày nhập gần nhất

    public int    getId()             { return id; }
    public void   setId(int v)        { this.id = v; }
    public String getName()           { return name; }
    public void   setName(String v)   { this.name = v; }
    public String getPhone()          { return phone; }
    public void   setPhone(String v)  { this.phone = v; }
    public String getEmail()          { return email; }
    public void   setEmail(String v)  { this.email = v; }
    public String getAddress()        { return address; }
    public void   setAddress(String v){ this.address = v; }

    public int    getProductCount()          { return productCount; }
    public void   setProductCount(int v)     { this.productCount = v; }
    public int    getImportCount()           { return importCount; }
    public void   setImportCount(int v)      { this.importCount = v; }
    public double getTotalQuantity()         { return totalQuantity; }
    public void   setTotalQuantity(double v) { this.totalQuantity = v; }
    public String getLastImportDate()        { return lastImportDate; }
    public void   setLastImportDate(String v){ this.lastImportDate = v; }
}