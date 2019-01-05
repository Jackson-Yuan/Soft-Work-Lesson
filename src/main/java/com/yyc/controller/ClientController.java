package com.yyc.controller;

import com.yyc.entity.Client;
import com.yyc.entity.Page;
import com.yyc.entity.Result;
import com.yyc.exception.ServiceException;
import com.yyc.service.ClientService;
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
public class ClientController {
    @Autowired
    private ClientService clientService;

    @RequestMapping("/addClient")
    @ResponseBody
    public Result<String> insertClient(Client client, HttpSession session){
        try {
            clientService.insertClient(client, session);
            return new Result<>("提交成功 单号为:" + client.getRecordId(), true);
        } catch (ServiceException e) {
            return new Result<>(e.getMessage(), false);
        } catch (Exception e) {
            return new Result<>("系统异常，请稍后重试", false);
        }
    }

    @RequestMapping("/getClientInfo")
    @ResponseBody
    public Result<Client> getClientService(@RequestParam String id){
        try{
            Client client = clientService.getClientService(id);
            return new Result<>(client,true);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }

    @RequestMapping("/deleteClient")
    public String deleteMedicine(@RequestParam("deleteId") String id, Model model){
        try {
            clientService.deleteService(id);
            return "redirect:/clientPageQuery";
        }catch (Exception e){
            model.addAttribute("error","系统异常，请稍后重试");
            return "pages/back/client/client_list";
        }
    }

    @ModelAttribute
    public void getEditClient(@RequestParam(value = "editClient",required = false) String id, Model model){
        if (id  != null){
            model.addAttribute("editClient",clientService.getComprehensiveMedicineService(id));
        }
    }

    @RequestMapping("/updateClient")
    @ResponseBody
    public Result<String> updateClient(@ModelAttribute("editClient") Client client){
        try {
            clientService.updateClientService(client);
            return new Result<>("修改成功",true);
        }catch (ServiceException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常,请重试",false);
        }
    }

    @RequestMapping("/clientPageQuery")
    public String pageQuery(Page page, Model model, @RequestParam(value = "recordId",required = false) String recordId, @RequestParam(value = "userId",required = false) String userId,
                            @RequestParam(value = "handled",required = false) Boolean handled){
        try {
            if (recordId != null){
                recordId = recordId.trim();
                if (recordId.equals("")) recordId = null;
            }
            if (userId != null){
                userId = userId.trim();
                if (userId.equals("")) userId = null;
            }
            List<Client> pageClient = clientService.getPageQueryService(page,recordId,userId,handled);
            if (recordId == null) recordId = "";
            if (userId == null) userId = "";
            model.addAttribute("pageMessage",page);
            model.addAttribute("pageClient",pageClient);
            model.addAttribute("record",recordId);
            model.addAttribute("user",userId);
            model.addAttribute("handled",handled);
        }catch (Exception e){
            model.addAttribute("error","系统异常");
        }

        return "pages/back/client/client_list";
    }

    @RequestMapping("/approval")
    @ResponseBody
    public Result<String> approvalRecord(@ModelAttribute("editClient")Client client){
        try{
            clientService.approvalService(client);
            return new Result<>("审核成功",true);
        }catch (ServiceException e){
            return new Result<>(e.getMessage(),false);
        }catch (Exception e){
            return new Result<>("系统异常,请重试",false);
        }
    }

    @RequestMapping("/getComprehensiveMedicine")
    @ResponseBody
    public Result<Client> getComprehensive(@RequestParam("recordId") String id){
        try {
            Client client = clientService.getComprehensiveMedicineService(id);
            return new Result<>(client,true);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }

    @RequestMapping("/getPersonMessage")
    @ResponseBody
    public Result<Client> getPersonMessage(@RequestParam("id") String id){
        try {
            Client person = clientService.getPersonService(id);
            if (person != null) return new Result<>(person,true);
            else   return new Result<>(null,false);
        }catch (Exception e){
            return new Result<>(null,false);
        }
    }
}
