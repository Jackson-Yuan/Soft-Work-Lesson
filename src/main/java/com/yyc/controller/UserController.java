package com.yyc.controller;

import com.yyc.entity.Page;
import com.yyc.entity.Result;
import com.yyc.entity.User;
import com.yyc.exception.IllegalCharacterException;
import com.yyc.exception.ServiceException;
import com.yyc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

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
            return "pages/back/index";
        }catch (IllegalCharacterException | ServiceException e){
            model.addAttribute("error",e.getMessage());
            return "login";
        }catch (Exception e){
            model.addAttribute("error","系统异常，请稍后再试");
            return "login";
        }

    }

    /**注册*/
    @RequestMapping("/register")
    @ResponseBody
    public Result<String> registerUser(User user){
        try {
            userService.registerService(user);
            return new Result<>("添加成功",true);
        }catch (IllegalCharacterException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常，请稍后再试",false);
        }
    }

    @ModelAttribute
    public void getEditUser(@RequestParam(value = "editUser", required = false) String id, Model model){
        if (id  != null){
            model.addAttribute("editUser",userService.getUser(id));
        }
    }

    @RequestMapping("/getInfo")
    @ResponseBody
    public Result<User> getUserInfo(@RequestParam String id){
        try {
            User user = userService.getUser(id);
            return new Result<>(user,true);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }

    /**更新*/
    @RequestMapping("/update")
    @ResponseBody
    public Result<String> updateUser(@ModelAttribute("editUser") User user, HttpSession session){
        try {
            userService.updateService(user);
            /**修改成功后 同步更新session域的消息*/
            session.setAttribute("loginUser",user);
            return new Result<>("修改成功",true);
        }catch (IllegalCharacterException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常，请稍后再试",false);
        }
    }

    @RequestMapping("/delete")
    public String  deleteUser(@RequestParam("deleteId") String id, Model model){
        try {
            userService.deleteUserService(id);
            return "redirect:/pageQuery";
        }catch (Exception e){
            model.addAttribute("error","系统异常，请稍后重试");
            return "pages/back/people/people_list";
        }
    }

    @RequestMapping("/pageQuery")
    public String pageQuery(Page page, Model model){
        try {
            List<User> pageUsers = userService.getPageQueryService(page);
            model.addAttribute("pageMessage",page);
            model.addAttribute("pageUsers",pageUsers);
        }catch (Exception e){
            model.addAttribute("error","系统异常");
        }
        return "pages/back/people/people_list";
    }

    /**注销*/
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session){
        session.invalidate();
        return "redirect:/login.jsp";
    }


}
