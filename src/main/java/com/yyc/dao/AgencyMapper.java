package com.yyc.dao;

import com.yyc.entity.Agency;
import com.yyc.entity.Page;

import java.util.List;

/**
 * Created by yyc on 2018/12/14.
 */
public interface AgencyMapper {
    void insertAgency(Agency agency);

    void updateAgency(Agency agency);

    List<Agency> getPageAgency(Page page);

    Agency getAgency(String id);

    Integer getCount();

    void deleteAgency(String id);

}
