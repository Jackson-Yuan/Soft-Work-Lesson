package com.yyc.exception;

/**
 * Created by yyc on 2018/12/7.
 */
public class ServiceException extends RuntimeException {
    public ServiceException(String message) {
        super(message);
    }
}
