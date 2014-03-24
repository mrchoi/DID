package com.mobilepark.did.notice.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mobilepark.did.framework.web.PageHandler;
import com.mobilepark.did.notice.service.NoticeService;

@Controller
public class NoticeController {
	
	private static final Logger logger = LoggerFactory
			.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping(value = "admin/notice/list.htm")
	public ModelAndView list(
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {

		HashMap<String, Object> hash = new HashMap<String, Object>();

		int currentPage = 1;
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		int totalRecord = noticeService.count(hash);
		PageHandler pg = new PageHandler(currentPage, totalRecord, 10, 10);

		hash.put("pg", pg);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/notice/list");
		mv.addObject("list", noticeService.list(hash));
		mv.addObject("pageHandler", pg);

		return mv;
	}
	
	@RequestMapping(value ="/notice/insertForm.htm" , method = RequestMethod.POST)
	public String insertForm(Model model,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		model.addAttribute("curPage", curPage);
		
		return "notice/insert";
	}

}
