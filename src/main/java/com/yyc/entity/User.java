package com.yyc.entity;

/**
 * Created by yyc on 2018/12/7.
 */
public class User {
    private String id;

    private String name;

    private String password;

    private Integer authority;

    public User() {
    }

    public User(String id, String name, String password, Integer authority) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.authority = authority;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAuthority() {
        return authority;
    }

    public void setAuthority(Integer authority) {
        this.authority = authority;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", authority=" + authority +
                '}';
    }
}
