package com.yyc.dao;

import com.yyc.entity.Medicine;
import com.yyc.entity.Page;

import java.util.List;

/**
 * Created by yyc on 2018/12/14.
 */
public interface MedicineMapper {
    void insertMedicine(Medicine medicine);

    void insertPurchaseMedicine(Medicine medicine);

    void updateMedicine(Medicine medicine);

    Medicine getMedicine(String id);

    List<Medicine> getAllMedicine();

    List<Medicine> getPageMedicine(Page page);

    Integer getCount();

    void deleteMedicine(String id);

    /**获取批号所有的记录*/
    List<Medicine> getBatchMedicine(String id);
}
