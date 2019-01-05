package com.yyc.service;

import com.yyc.dao.ClientMapper;
import com.yyc.dao.MedicineMapper;
import com.yyc.entity.Client;
import com.yyc.entity.Medicine;
import com.yyc.entity.Page;
import com.yyc.entity.User;
import com.yyc.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by yyc on 2018/12/16.
 */
@Service
public class ClientService {
    @Autowired
    private ClientMapper clientMapper;

    @Autowired
    private MedicineMapper medicineMapper;

    public void insertClient(Client client, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        client.setUserId(loginUser.getId());
        client.setRecordId(getKey(session));
        Client queryClient = clientMapper.getPersonMessage(client.getId());
        if (queryClient == null) clientMapper.insertPersonMessage(client);
        clientMapper.insertRecord(client);
    }

    public Client getClientService(String id){
        return clientMapper.getComprehensiveClient(id);
    }

    public void updateClientService(Client client){
        if (medicineMapper.getMedicine(client.getMedicineId()) == null) throw new ServiceException("药品不存在");
        clientMapper.updateClient(client);
    }

    public List<Client> getPageQueryService(Page page, String recordId, String userId, Boolean handled){
        if (page.getPage() == null){
            page.setPage(1);
            page.setRecord(5);
            int sumCount = clientMapper.getCount(recordId,userId,handled);
            int sumPage = sumCount / page.getRecord();
            if (sumCount % page.getRecord() != 0) sumPage++;
            page.setSumPage(sumPage);
        }
        return clientMapper.getPageClient(page,recordId,userId,handled);

    }

    public void deleteService(String id){
        clientMapper.deleteClient(id);
    }


    public void approvalService(Client client) {
        Medicine medicine = medicineMapper.getMedicine(client.getMedicineId());
        if (medicine == null) throw new ServiceException("药品不存在");
        if (medicine.getQuantity() <= 0) throw new ServiceException("药品库存不足");
        List<Medicine> medicineList = medicineMapper.getBatchMedicine(medicine.getId());
        checkOutTime(medicineList);
        clientMapper.updateRecord(client);
    }

    public Client getComprehensiveMedicineService(String id){
        Client client = clientMapper.getComprehensiveClient(id);
        if (client == null) throw new ServiceException("没有此记录");
        return client;
    }

    public Client getPersonService(String id){
        return clientMapper.getPersonMessage(id);
    }

    private String getKey(HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        Random random = new Random();
        String id = loginUser.getId() + random.nextInt() + LocalDate.now();
        id = id.replaceAll("-","");
        return id;
    }

    private void checkOutTime(List<Medicine> medicineList){
        int count = 0;
        LocalDate localDate = LocalDate.now();
        for (Medicine temp : medicineList){

            Date date = temp.getEndTime();
            Instant instant = date.toInstant();
            ZoneId zoneId = ZoneId.systemDefault();

            LocalDate endDate = instant.atZone(zoneId).toLocalDate();

            System.out.println(localDate.getYear() + " " + localDate.getMonthValue() + " " + localDate.getDayOfMonth());
            if (!(endDate.getYear() >= localDate.getYear() && endDate.getMonthValue() >= localDate.getMonthValue() && endDate.getDayOfMonth() >= localDate.getDayOfMonth())) count++;
        }
        if (count == medicineList.size()) throw new ServiceException("库存药品已过期");
    }
}
