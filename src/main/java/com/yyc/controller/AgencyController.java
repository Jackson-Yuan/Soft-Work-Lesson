package com.yyc.controller;

import com.yyc.entity.Agency;
import com.yyc.entity.Page;
import com.yyc.entity.Result;
import com.yyc.exception.IllegalCharacterException;
import com.yyc.service.AgencyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by yyc on 2018/12/16.
 */
@Controller
public class AgencyController {
    @Autowired
    private AgencyService agencyService;

    @RequestMapping("/addAgency")
    @ResponseBody
    public Result<String> addAgency(Agency agency){
        try {
            agencyService.insertAgencyService(agency);
            return new Result<>("添加成功",true);
        }catch (IllegalCharacterException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常，请请稍后重试",false);
        }
    }

    @RequestMapping("/agencyPageQuery")
    public String pageQuery(Page page, Model model){
        try {
            List<Agency> pageAgency = agencyService.getPageQueryService(page);
            model.addAttribute("pageMessage",page);
            model.addAttribute("pageAgency",pageAgency);
        }catch (Exception e){
            model.addAttribute("error","系统异常");
        }
        return "pages/back/agency/agency_list";
    }

    @RequestMapping("/getAgencyInfo")
    @ResponseBody
    public Result<Agency> getAgency(@RequestParam String id){
        try {
           Agency agency = agencyService.getAgency(id);
           return new Result<>(agency,true);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }

    @ModelAttribute
    public void getEditAgency(@RequestParam(value = "editAgency",required = false) String id, Model model){
        if (id  != null){
            model.addAttribute("editAgency" ,agencyService.getAgency(id));
        }
    }

    @RequestMapping("/updateAgency")
    @ResponseBody
    public Result<String> updateAgency(@ModelAttribute("editAgency") Agency agency){
        try {
            agencyService.updateAgency(agency);
            return new Result<>("修改成功",true);
        }catch (IllegalCharacterException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常，请稍后再试",false);
        }
    }

    @RequestMapping("/deleteAgency")
    public String deleteAgency(@RequestParam("deleteId") String id, Model model){
        try {
            agencyService.deleteAgency(id);
             return "redirect:/agencyPageQuery";
        }catch (Exception e){
            model.addAttribute("error","系统异常，请稍后重试");
            return "pages/back/agency/agency_list";
        }
    }
}
