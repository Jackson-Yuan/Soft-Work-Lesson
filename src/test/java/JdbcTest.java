import com.yyc.dao.UserMapper;
import com.yyc.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by yyc on 2018/12/7.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/spring-dao.xml", "classpath:spring/spring-web.xml" })
public class JdbcTest {
    @Autowired
    private UserMapper userMapper;
    @Test
    public void testInsertUser(){
        User user = new User("10000","zyc","1234",3);
        userMapper.insertUser(user);
    }

    @Test
    public void testUpdateUser(){
        User user = new User("10000","zyc","1234",2);
        userMapper.updateUserInfo(user);
    }

    @Test
    public void testGetUser(){
        System.out.println(userMapper.getUser("10000"));
    }
}
