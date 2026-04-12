package com.springmvc.model;

public class CustomerTier {
    private int id;
    private String name;
    private double discountPercent;
    private double minSpent;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String v) { this.name = v; }
    public double getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(double v) { this.discountPercent = v; }
    public double getMinSpent() { return minSpent; }
    public void setMinSpent(double v) { this.minSpent = v; }
}