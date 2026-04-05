package com.springmvc.model;

public class CustomerTier {
    private int id;
    private String name;
    private double discountPercent;
    private double minSpent;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(double d) { this.discountPercent = d; }
    public double getMinSpent() { return minSpent; }
    public void setMinSpent(double m) { this.minSpent = m; }
}