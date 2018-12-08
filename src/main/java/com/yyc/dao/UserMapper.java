package com.yyc.dao;

import com.yyc.entity.User;

import java.util.List;

/**
 * Created by yyc on 2018/12/7.
 */
public interface UserMapper {
    void insertUser(User user);

    void updateUserInfo(User user);

    void deleteUser(String id);

    User getUser(String id);

    List<User> getPageUser();
}
