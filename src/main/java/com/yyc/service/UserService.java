package com.yyc.service;

import com.yyc.dao.UserMapper;
import com.yyc.entity.User;
import com.yyc.exception.ServiceException;
import com.yyc.tools.CheckTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by yyc on 2018/12/7.
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public User loginService(User user) {
        CheckTools.checkName(user.getName());
        User queryUser = userMapper.getUser(user.getId());
        if (queryUser == null) throw new ServiceException("该账户不存在");
        if (!queryUser.getPassword().equals(user.getPassword())) throw new ServiceException("账户名或密码错误");
        return queryUser;
    }

    public void updateService(User user){
        CheckTools.checkName(user.getName());
        userMapper.updateUserInfo(user);
    }
}
