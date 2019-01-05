package com.yyc.tools;

import com.yyc.exception.IllegalCharacterException;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by yyc on 2018/12/7.
 */
public class CheckTools {
    public static void checkName(String name){
        Pattern pattern = Pattern.compile("[\\u4e00-\\u9fa5]+");
        Matcher matcher = pattern.matcher(name);
        if (!matcher.matches()) throw new IllegalCharacterException("请确保名字为中文");
    }

    public static void checkNumber(String id){
        Pattern pattern = Pattern.compile("^[0-9]*$");
        Matcher matcher = pattern.matcher(id);
        if (!matcher.matches()) throw new IllegalCharacterException("账户名含有非法字符");
    }

    public static void checkPhone(String phone){
        String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(166)|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9]))\\d{8}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);
        if (!matcher.matches()) throw new IllegalCharacterException("电话号码格式有误");
    }
}
