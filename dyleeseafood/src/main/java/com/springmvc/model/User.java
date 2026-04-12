package com.springmvc.model;

public class User {
    private int id;
    private String username;
    private String password;
    private int roleId;
    private boolean active;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String v) { this.username = v; }
    public String getPassword() { return password; }
    public void setPassword(String v) { this.password = v; }
    public int getRoleId() { return roleId; }
    public void setRoleId(int v) { this.roleId = v; }
    public boolean isActive() { return active; }
    public void setActive(boolean v) { this.active = v; }
}