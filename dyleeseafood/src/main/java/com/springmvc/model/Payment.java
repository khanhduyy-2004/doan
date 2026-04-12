package com.springmvc.model;

public class Payment {
    private int id;
    private int orderId;
    private String method;
    private String status;
    private double amount;
    private String transactionId;
    private String paidAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int v) { this.orderId = v; }
    public String getMethod() { return method; }
    public void setMethod(String v) { this.method = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public double getAmount() { return amount; }
    public void setAmount(double v) { this.amount = v; }
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String v) { this.transactionId = v; }
    public String getPaidAt() { return paidAt; }
    public void setPaidAt(String v) { this.paidAt = v; }
}