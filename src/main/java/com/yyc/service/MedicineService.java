package com.yyc.service;

import com.yyc.dao.AgencyMapper;
import com.yyc.dao.MedicineMapper;
import com.yyc.entity.Medicine;
import com.yyc.entity.Page;
import com.yyc.exception.ServiceException;
import com.yyc.tools.CheckTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by yyc on 2018/12/16.
 */
@Service
public class MedicineService {
    @Autowired
    private MedicineMapper medicineMapper;

    @Autowired
    private AgencyMapper agencyMapper;

    public void addMedicineService(Medicine medicine){
        if (agencyMapper.getAgency(medicine.getResource()) == null) throw new ServiceException("不存在此代理商请重新填写");
        Medicine queryMedicine = medicineMapper.getMedicine(medicine.getId());
        medicineMapper.insertPurchaseMedicine(medicine);
        if (queryMedicine == null){
            medicineMapper.insertMedicine(medicine);
            return;
        }
        medicine.setQuantity(queryMedicine.getQuantity() + medicine.getQuantity());
        medicineMapper.updateMedicine(medicine);
    }

    public Medicine getMedicineService(String id){
        return medicineMapper.getMedicine(id);
    }

    public void updateMedicineService(Medicine medicine){
        CheckTools.checkNumber(medicine.getId());
        medicineMapper.updateMedicine(medicine);
    }

    public void deleteMedicineService(String id){
        medicineMapper.deleteMedicine(id);
    }

    public List<Medicine> getPageQueryService(Page page){
        if (page.getPage() == null){
            page.setPage(1);
            page.setRecord(5);
            int sumCount = medicineMapper.getCount();
            int sumPage = sumCount / page.getRecord();
            if (sumCount % page.getRecord() != 0) sumPage++;
            page.setSumPage(sumPage);
        }
        return medicineMapper.getPageMedicine(page);
    }
}
