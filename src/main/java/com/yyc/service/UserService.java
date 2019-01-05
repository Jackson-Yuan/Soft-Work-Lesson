package com.yyc.service;

import com.yyc.dao.UserMapper;
import com.yyc.entity.Page;
import com.yyc.entity.User;
import com.yyc.exception.ServiceException;
import com.yyc.tools.CheckTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by yyc on 2018/12/7.
 */
@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public User loginService(User user) {
        CheckTools.checkNumber(user.getId());
        User queryUser = userMapper.getUser(user.getId());
        if (queryUser == null) throw new ServiceException("该账户不存在");
        if (!queryUser.getPassword().equals(user.getPassword())) throw new ServiceException("账户名或密码错误");
        return queryUser;
    }

    public void updateService(User user){
        CheckTools.checkName(user.getName());
        userMapper.updateUserInfo(user);
    }

    public void deleteUserService(String id){
        userMapper.deleteUser(id);
    }

    public User getUser(String id){
        return userMapper.getUser(id);
    }

    public void registerService(User user){
        CheckTools.checkNumber(user.getId());
        CheckTools.checkName(user.getName());
        userMapper.insertUser(user);
    }

    public List<User> getPageQueryService(Page page){
        if (page.getPage() == null){
            page.setPage(1);
            page.setRecord(5);
            int sumCount = userMapper.getCount();
            int sumPage = sumCount / page.getRecord();
            if (sumCount % page.getRecord() != 0) sumPage++;
            page.setSumPage(sumPage);
        }
        return userMapper.getPageUser(page);
    }
}
