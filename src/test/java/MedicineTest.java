import com.yyc.dao.MedicineMapper;
import com.yyc.entity.Medicine;
import com.yyc.entity.Page;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * Created by yyc on 2018/12/16.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/spring-dao.xml", "classpath:spring/spring-web.xml" })
public class MedicineTest {
    @Autowired
    private MedicineMapper medicineMapper;

    @org.junit.Test
    public void testGetAll(){
        System.out.println(medicineMapper.getAllMedicine().size());
    }

    @org.junit.Test
    public void testPage(){
        Page page = new Page();
        page.setPage(2);
        page.setRecord(2);
        System.out.println(medicineMapper.getPageMedicine(page));
    }

    @org.junit.Test
    public void testInsert(){
        Medicine medicine = new Medicine();
        medicine.setUserId("10000");
        medicine.setQuantity(50);
        medicine.setId("300000");
        medicine.setBatchId("6");
        medicine.setStartTime(new Date(1998,6,21));
        medicine.setEndTime(new Date(2010,6,21));
        medicine.setPrice(12.6);
        medicine.setResource("1000000");
        medicineMapper.insertPurchaseMedicine(medicine);
    }

    @org.junit.Test
    public void testBatchMedicine(){
        System.out.println(medicineMapper.getBatchMedicine("1000562256"));
    }
}
