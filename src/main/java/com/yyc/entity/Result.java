package com.yyc.entity;

/**
 * Created by yyc on 2018/12/7.
 */
public class Result<T> {
    private T data;

    private Boolean flag;

    public Result() {
    }

    public Result(T data, Boolean flag) {
        this.data = data;
        this.flag = flag;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    @Override
    public String toString() {
        return "Result{" +
                "data=" + data +
                ", flag=" + flag +
                '}';
    }
}
