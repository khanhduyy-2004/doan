package com.springmvc.model;

public class Supplier {
    private int    id;
    private String name;
    private String phone;
    private String email;
    private String address;

    public int    getId()      { return id; }
    public void   setId(int v) { this.id = v; }

    public String getName()       { return name; }
    public void   setName(String v) { this.name = v; }

    public String getPhone()        { return phone; }
    public void   setPhone(String v){ this.phone = v; }

    public String getEmail()        { return email; }
    public void   setEmail(String v){ this.email = v; }

    public String getAddress()        { return address; }
    public void   setAddress(String v){ this.address = v; }
}