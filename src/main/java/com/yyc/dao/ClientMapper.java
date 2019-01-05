package com.yyc.dao;

import com.yyc.entity.Client;
import com.yyc.entity.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by yyc on 2018/12/14.
 */
public interface ClientMapper {
    void insertClient(Client client);

    void updateClient(Client client);

    List<Client> getPageClient(@Param("page")Page page, @Param("recordId") String recordId, @Param("userId")String userId, @Param("handled") Boolean handled);

    Integer getCount(@Param("recordId") String recordId, @Param("userId")String userId, @Param("handled") Boolean handled);

    Client getClient(String id);

    void deleteClient(String id);

    void insertPersonMessage(Client client);

    void updatePersonMessage(Client client);

    Client getPersonMessage(String id);

    void insertRecord(Client client);

    void updateRecord(Client client);

    Client getRecord(String id);

    Client getComprehensiveClient(String id);
}
