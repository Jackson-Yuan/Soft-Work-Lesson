package com.yyc.entity;

/**
 * Created by yyc on 2018/12/7.
 */
public class Medicine {
    private String id;

    private String name;

    private String introduction;

    private String method;

    private String resource;

    private Integer quantity;

    public Medicine() {
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

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Medicine{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", introduction='" + introduction + '\'' +
                ", method='" + method + '\'' +
                ", resource='" + resource + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}
