package com.yyc.entity;

/**
 * Created by yyc on 2018/12/7.
 */
public class Agency {
    private String id;

    private String name;

    private String chargePerson;

    private Integer sex;

    private String phone;

    public Agency() {
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

    public String getChargePerson() {
        return chargePerson;
    }

    public void setChargePerson(String chargePerson) {
        this.chargePerson = chargePerson;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Agency{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", chargePerson='" + chargePerson + '\'' +
                ", sex=" + sex +
                ", phone='" + phone + '\'' +
                '}';
    }
}
