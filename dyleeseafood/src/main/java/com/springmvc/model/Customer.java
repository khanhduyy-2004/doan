package com.springmvc.model;

public class Customer {
    // Bảng customers
    private int id;
    private String name;
    private String email;
    private String phone;
    private String avatarUrl;
    private int userId;
    private int tierId;
    private double totalSpent;

    // JOIN fields
    private String tierName;
    private String username;
    private boolean active;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String v) { this.name = v; }
    public String getEmail() { return email; }
    public void setEmail(String v) { this.email = v; }
    public String getPhone() { return phone; }
    public void setPhone(String v) { this.phone = v; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String v) { this.avatarUrl = v; }
    public int getUserId() { return userId; }
    public void setUserId(int v) { this.userId = v; }
    public int getTierId() { return tierId; }
    public void setTierId(int v) { this.tierId = v; }
    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double v) { this.totalSpent = v; }
    public String getTierName() { return tierName; }
    public void setTierName(String v) { this.tierName = v; }
    public String getUsername() { return username; }
    public void setUsername(String v) { this.username = v; }
    public boolean isActive() { return active; }
    public void setActive(boolean v) { this.active = v; }
}