package com.yyc.entity;

/**
 * Created by yyc on 2018/12/15.
 */
public class Page {
    private Integer page;

    private Integer sumPage;

    private Integer record;

    public Page() {
    }

    public Integer getPage() {
        return page;
    }

    public Integer getSumPage() {
        return sumPage;
    }

    public Integer getRecord() {
        return record;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public void setSumPage(Integer sumPage) {
        this.sumPage = sumPage;
    }

    public void setRecord(Integer record) {
        this.record = record;
    }

    @Override
    public String toString() {
        return "Page{" +
                "page=" + page +
                ", sumPage=" + sumPage +
                ", record=" + record +
                '}';
    }
}
