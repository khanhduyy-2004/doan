package com.springmvc.model;

public class MonthlyRevenue {
    private String month;
    private double revenue;
    private int    orderCount;

    public String getMonth()            { return month; }
    public void   setMonth(String v)    { this.month = v; }
    public double getRevenue()          { return revenue; }
    public void   setRevenue(double v)  { this.revenue = v; }
    public int    getOrderCount()       { return orderCount; }
    public void   setOrderCount(int v)  { this.orderCount = v; }
}
