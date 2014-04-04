package com.mobilepark.did.kiosk.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobilepark.did.common.Env;
import com.mobilepark.did.framework.web.PageHandler;
import com.mobilepark.did.kiosk.model.Kiosk;
import com.mobilepark.did.kiosk.service.KioskService;

@Controller
public class KioskController {
	
	private static final Logger logger = LoggerFactory
			.getLogger(KioskController.class);

	@Autowired
	private KioskService kioskService;
	
	@RequestMapping(value = "admin/kiosk/list.htm")
	public ModelAndView list(HttpSession session,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {

		HashMap<String, Object> hash = new HashMap<String, Object>();

		int currentPage = 1;
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		int totalRecord = kioskService.count(hash);
		PageHandler pg = new PageHandler(currentPage, totalRecord, 10, 10);

		hash.put("pg", pg);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/kiosk/list");
		mv.addObject("list", kioskService.list(hash));
		mv.addObject("pageHandler", pg);
		mv.addObject("ADMIN_ID", session.getAttribute("ADMIN_ID"));
		
		return mv;
	}
	
	@RequestMapping(value ="admin/kiosk/insertForm.htm" , method = RequestMethod.POST)
	public String insertForm(Model model,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		model.addAttribute("curPage", curPage);
		
		return "admin/kiosk/insert";
	}
	
	@RequestMapping(value = "admin/kiosk/insert.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String insert(Model model,@ModelAttribute("kiosk") Kiosk kiosk,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;   
		
		try{
			
			ret = kioskService.insert(kiosk);
			
			if (ret == 1)
				msg = Env.get("msg.kiosk.insert.succ");
			else
				msg = Env.get("msg.kiosk.insert.fail");
		}catch(Exception e){
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}
	
	@RequestMapping(value ="admin/kiosk/updateForm.htm" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateForm(Model model,@ModelAttribute("kiosk") Kiosk kiosk,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("kiosk", kioskService.view(kiosk));
		mv.setViewName("admin/kiosk/view");

		return mv;
	}
	
	@RequestMapping(value = "admin/kiosk/update.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String update(Model model,@ModelAttribute("kiosk") Kiosk kiosk,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = kioskService.update(kiosk);
			
			if (ret == 1)
				msg = Env.get("msg.info.update.succ");
			else
				msg = Env.get("msg.info.update.fail");
		}catch(Exception e){
			e.printStackTrace();
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}
	
	@RequestMapping(value = "admin/kiosk/delete.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String delete(Model model,@ModelAttribute("kiosk") Kiosk kiosk,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = kioskService.delete(kiosk);
			
			if (ret == 1)
				msg = Env.get("msg.info.delete.succ");
			else
				msg = Env.get("msg.info.delete.fail");
		}catch(Exception e){
			e.printStackTrace();
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}

}
