package com.yyc.controller;

import com.yyc.entity.Medicine;
import com.yyc.entity.Page;
import com.yyc.entity.Result;
import com.yyc.entity.User;
import com.yyc.exception.IllegalCharacterException;
import com.yyc.exception.ServiceException;
import com.yyc.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by yyc on 2018/12/16.
 */
@Controller
public class MedicineController {
    @Autowired
    private MedicineService medicineService;

    @RequestMapping("/addMedicine")
    @ResponseBody
    public Result<String> addMedicine(Medicine medicine, HttpSession session){
        try {
            User user = (User)session.getAttribute("loginUser");
            medicine.setUserId(user.getId());
            medicineService.addMedicineService(medicine);
            return new Result<>("添加成功",true);
        }catch (ServiceException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常，请稍后重试",false);
        }
    }

    @RequestMapping("/getMedicineInfo")
    @ResponseBody
    public Result<Medicine> getMedicineInfo(@RequestParam String id){
        try {
            Medicine medicine = medicineService.getMedicineService(id);
            return new Result<>(medicine,true);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }

    @ModelAttribute
    public void getEditMedicine(@RequestParam(value = "editMedicine",required = false) String id, Model model){
        if (id != null){
            model.addAttribute("editMedicine",medicineService.getMedicineService(id));
        }
    }

    @RequestMapping("/updateMedicine")
    @ResponseBody
    public Result<String> updateMedicineInfo(@ModelAttribute("editMedicine") Medicine medicine){
        try {
            medicineService.updateMedicineService(medicine);
            return new Result<>("修改成功",true);
        }catch (IllegalCharacterException | ServiceException e){
            return new Result<>(e.getMessage(),false);
        } catch (Exception e){
            return new Result<>("系统异常，请稍后重试",false);
        }
    }

    @RequestMapping("/deleteMedicine")
    public String deleteMedicine(@RequestParam("deleteId") String id, Model model){
        try {
            medicineService.deleteMedicineService(id);
            return "redirect:/medicinePageQuery";
        }catch (Exception e){
            model.addAttribute("error","系统异常，请稍后重试");
            return "pages/back/medicine/medicine_list";
        }
    }

    @RequestMapping("/medicinePageQuery")
    public String pageQuery(Page page, Model model){
        try {
            List<Medicine> pageMedicine = medicineService.getPageQueryService(page);
            model.addAttribute("pageMessage",page);
            model.addAttribute("pageMedicine",pageMedicine);
        }catch (Exception e){
            model.addAttribute("error","系统异常");
        }
        return "pages/back/medicine/medicine_list";
    }
}
