import com.yyc.dao.ClientMapper;
import com.yyc.entity.Client;
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
public class ClientTest {
    @Autowired
    private ClientMapper clientMapper;

    @org.junit.Test
    public void testInsert(){
        Client client = new Client();
        client.setId("11111");
        clientMapper.insertClient(client);
    }

    @org.junit.Test
    public void testPage(){
        Page page = new Page();
        page.setPage(1);
        page.setRecord(5);
        System.out.println(clientMapper.getPageClient(page,null,"10001",false));
    }

    @org.junit.Test
    public void testCount(){
        System.out.println(clientMapper.getCount(null,"10001",true));
    }


    @org.junit.Test
    public void testInsertPerson(){
      System.out.println(clientMapper.getPersonMessage("32120219980"));
    }

    @org.junit.Test
    public void testInsertRecord(){
        System.out.println(clientMapper.getRecord("12121313123"));
    }


    @org.junit.Test
    public void getComprehensive(){
        System.out.println(clientMapper.getComprehensiveClient("12121313123"));
    }
}
