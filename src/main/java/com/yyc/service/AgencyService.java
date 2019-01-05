package com.yyc.service;

import com.yyc.dao.AgencyMapper;
import com.yyc.entity.Agency;
import com.yyc.entity.Page;
import com.yyc.tools.CheckTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by yyc on 2018/12/16.
 */
@Service
public class AgencyService {
    @Autowired
    private AgencyMapper agencyMapper;

    public void insertAgencyService(Agency agency){
        CheckTools.checkPhone(agency.getPhone());
        agencyMapper.insertAgency(agency);
    }

    public Agency getAgency(String id){
        return agencyMapper.getAgency(id);
    }

    public void updateAgency(Agency agency){
        CheckTools.checkPhone(agency.getPhone());
        agencyMapper.updateAgency(agency);
    }

    public void deleteAgency(String id){
        agencyMapper.deleteAgency(id);
    }

    public List<Agency> getPageQueryService(Page page){
        if (page.getPage() == null){
            page.setPage(1);
            page.setRecord(5);
            int sumCount = agencyMapper.getCount();
            int sumPage = sumCount / page.getRecord();
            if (sumCount % page.getRecord() != 0) sumPage++;
            page.setSumPage(sumPage);
        }
        return agencyMapper.getPageAgency(page);
    }
}
