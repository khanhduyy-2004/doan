package com.springmvc.model;

public class Address {
    private int     id;
    private int     customerId;
    private String  fullName;
    private String  phone;
    private String  address;
    private String  ward;
    private String  district;
    private String  city;
    private boolean isDefault;

    // Getters & Setters
    public int     getId()                   { return id; }
    public void    setId(int id)             { this.id = id; }
    public int     getCustomerId()           { return customerId; }
    public void    setCustomerId(int v)      { this.customerId = v; }
    public String  getFullName()             { return fullName; }
    public void    setFullName(String v)     { this.fullName = v; }
    public String  getPhone()                { return phone; }
    public void    setPhone(String v)        { this.phone = v; }
    public String  getAddress()              { return address; }
    public void    setAddress(String v)      { this.address = v; }
    public String  getWard()                 { return ward; }
    public void    setWard(String v)         { this.ward = v; }
    public String  getDistrict()             { return district; }
    public void    setDistrict(String v)     { this.district = v; }
    public String  getCity()                 { return city; }
    public void    setCity(String v)         { this.city = v; }
    public boolean isDefaultAddr()           { return isDefault; }
    public void    setDefault(boolean v)     { this.isDefault = v; }

    // Địa chỉ đầy đủ (dùng trong JSP)
    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();
        if (address  != null && !address.isEmpty())  sb.append(address);
        if (ward     != null && !ward.isEmpty())     sb.append(", ").append(ward);
        if (district != null && !district.isEmpty()) sb.append(", ").append(district);
        if (city     != null && !city.isEmpty())     sb.append(", ").append(city);
        return sb.toString();
    }
}
