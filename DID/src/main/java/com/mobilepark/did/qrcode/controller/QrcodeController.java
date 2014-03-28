package com.mobilepark.did.qrcode.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobilepark.did.common.Env;
import com.mobilepark.did.framework.web.PageHandler;
import com.mobilepark.did.qrcode.service.QrcodeService;

@Controller
public class QrcodeController {
	
	private static final Logger logger = LoggerFactory
			.getLogger(QrcodeController.class);

	@Autowired
	private QrcodeService qrcodeService;
	
	@RequestMapping(value = "admin/qrcode/list.htm")
	public ModelAndView list(HttpSession session,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {

		HashMap<String, Object> hash = new HashMap<String, Object>();
	
		int currentPage = 1;
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		int totalRecord = qrcodeService.count(hash);
		PageHandler pg = new PageHandler(currentPage, totalRecord, 10, 10);

		hash.put("pg", pg);
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("admin/qrcode/list");
		
		mv.addObject("list", qrcodeService.list(hash));
		mv.addObject("pageHandler", pg);
		mv.addObject("ADMIN_ID", session.getAttribute("ADMIN_ID"));
				
		return mv;
	}
	
	@RequestMapping(value ="admin/qrcode/insertForm.htm" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView insertForm(Model model,@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		model.addAttribute("curPage", curPage);
				
		HashMap<String, Object> hash = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("admin/qrcode/insert");
		mv.addObject("list", qrcodeService.festivalList(hash));
		
		return mv;
	}

}
