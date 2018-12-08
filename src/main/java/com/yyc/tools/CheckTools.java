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
}
