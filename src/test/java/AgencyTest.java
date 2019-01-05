import com.yyc.dao.AgencyMapper;
import com.yyc.entity.Agency;
import com.yyc.entity.Page;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by yyc on 2018/12/16.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/spring-dao.xml", "classpath:spring/spring-web.xml" })
public class AgencyTest {
    @Autowired
    private AgencyMapper agencyMapper;

    @org.junit.Test
    public void testGetAgency(){
        System.out.println(agencyMapper.getAgency("100324"));
    }

    @org.junit.Test
    public void testInsertAgency(){
        Agency agency = new Agency();
        agency.setId("100000");
        agencyMapper.insertAgency(agency);
    }

    @org.junit.Test
    public void testPage(){
        Page page = new Page();
        page.setPage(2);
        page.setRecord(2);
        System.out.println(agencyMapper.getPageAgency(page));
    }
}
