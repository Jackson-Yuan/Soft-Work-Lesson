import com.yyc.exception.IllegalCharacterException;
import com.yyc.tools.CheckTools;

/**
 * Created by yyc on 2018/12/7.
 */
public class Test {
    @org.junit.Test
    public void testCheckNumber(){
        try {
            CheckTools.checkNumber("1a243");
        }catch (IllegalCharacterException e){
            System.out.println(e.getMessage());
        }
    }
}
