package com.springmvc.model;

import java.util.List;

public class Order {
    private int    id;
    private int    customerId;
    private int    addressId;
    private String orderDate;
    private String status;
    private double subtotal;
    private double shippingFee;
    private double total;
    private String note;

    // JOIN fields (không có cột trong bảng orders, lấy từ JOIN)
    private String customerName;
    private String customerPhone;
    private String paymentMethod;
    private String paymentStatus;  // ← THÊM MỚI (từ payments.status)

    // Danh sách sản phẩm (load thủ công sau khi query)
    private List<OrderItem> items;

    // ─── Getters & Setters ───────────────────────────────────────────────
    public int    getId()                      { return id; }
    public void   setId(int id)                { this.id = id; }
    public int    getCustomerId()              { return customerId; }
    public void   setCustomerId(int v)         { this.customerId = v; }
    public int    getAddressId()               { return addressId; }
    public void   setAddressId(int v)          { this.addressId = v; }
    public String getOrderDate()               { return orderDate; }
    public void   setOrderDate(String v)       { this.orderDate = v; }
    public String getStatus()                  { return status; }
    public void   setStatus(String v)          { this.status = v; }
    public double getSubtotal()                { return subtotal; }
    public void   setSubtotal(double v)        { this.subtotal = v; }
    public double getShippingFee()             { return shippingFee; }
    public void   setShippingFee(double v)     { this.shippingFee = v; }
    public double getTotal()                   { return total; }
    public void   setTotal(double v)           { this.total = v; }
    public String getNote()                    { return note; }
    public void   setNote(String v)            { this.note = v; }

    // JOIN fields
    public String getCustomerName()            { return customerName; }
    public void   setCustomerName(String v)    { this.customerName = v; }
    public String getCustomerPhone()           { return customerPhone; }
    public void   setCustomerPhone(String v)   { this.customerPhone = v; }
    public String getPaymentMethod()           { return paymentMethod; }
    public void   setPaymentMethod(String v)   { this.paymentMethod = v; }
    public String getPaymentStatus()           { return paymentStatus; }
    public void   setPaymentStatus(String v)   { this.paymentStatus = v; }

    // Items
    public List<OrderItem> getItems()          { return items; }
    public void   setItems(List<OrderItem> v)  { this.items = v; }
}
