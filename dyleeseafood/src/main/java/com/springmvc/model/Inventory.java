package com.springmvc.model;

public class Inventory {
    private int    id;
    private int    productId;
    private int    supplierId;
    private double quantity;
    private double importPrice;
    private String note;
    private String lastUpdated;

    // JOIN fields
    private String productName;
    private String productUnit;
    private String supplierName;

    public int    getId()      { return id; }
    public void   setId(int v) { this.id = v; }

    public int    getProductId()       { return productId; }
    public void   setProductId(int v)  { this.productId = v; }

    public int    getSupplierId()       { return supplierId; }
    public void   setSupplierId(int v)  { this.supplierId = v; }

    public double getQuantity()         { return quantity; }
    public void   setQuantity(double v) { this.quantity = v; }

    public double getImportPrice()         { return importPrice; }
    public void   setImportPrice(double v) { this.importPrice = v; }

    public String getNote()        { return note; }
    public void   setNote(String v){ this.note = v; }

    public String getLastUpdated()        { return lastUpdated; }
    public void   setLastUpdated(String v){ this.lastUpdated = v; }

    public String getProductName()        { return productName; }
    public void   setProductName(String v){ this.productName = v; }

    public String getProductUnit()        { return productUnit; }
    public void   setProductUnit(String v){ this.productUnit = v; }

    public String getSupplierName()        { return supplierName; }
    public void   setSupplierName(String v){ this.supplierName = v; }
}