package com.yyc.controller;

import com.yyc.entity.Result;
import com.yyc.entity.User;
import com.yyc.exception.IllegalCharacterException;
import com.yyc.exception.ServiceException;
import com.yyc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by yyc on 2018/12/7.
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    /**登录*/
    @RequestMapping("/login")
    public String login(User user, Model model, HttpSession httpSession){
        try {
            User loginUser = userService.loginService(user);
            httpSession.setAttribute("loginUser",loginUser);
        }catch (IllegalCharacterException | ServiceException e){
            model.addAttribute("error",e.getMessage());
            return "login";
        }
        return "index";
    }

    /**更新*/
    public Result<String> updateUser(User user){
        return null;
    }
}
