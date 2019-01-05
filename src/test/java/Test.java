import com.yyc.exception.IllegalCharacterException;
import com.yyc.tools.CheckTools;

import java.time.LocalDate;
import java.util.Date;

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

    @org.junit.Test
    public void testDate(){
        LocalDate date = LocalDate.now();
        System.out.println(date.getYear() + " " + date.getMonthValue() + " " + date.getDayOfMonth());
        Date date1 = new Date(2019,1,3);
        System.out.println(date1.getYear() + " " + date1.getMonth() + " " + date1.getDate());
    }
}
