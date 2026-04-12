package com.springmvc.model;

public class Banner {
    private int id;
    private String title;
    private String imageUrl;
    private String linkUrl;
    private int sortOrder;
    private boolean active;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String v) { this.title = v; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String v) { this.imageUrl = v; }
    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String v) { this.linkUrl = v; }
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int v) { this.sortOrder = v; }
    public boolean isActive() { return active; }
    public void setActive(boolean v) { this.active = v; }
}