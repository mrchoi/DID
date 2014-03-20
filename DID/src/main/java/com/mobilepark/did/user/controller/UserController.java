package com.mobilepark.did.user.controller;

import java.util.HashMap;

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
import com.mobilepark.did.user.model.User;
import com.mobilepark.did.user.service.UserService;
/**
 * Handles requests for the application home page.
 */
@Controller
public class UserController {

	private static final Logger logger = LoggerFactory
			.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@RequestMapping(value = "admin/user/list.htm")
	public ModelAndView list(
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {

		HashMap<String, Object> hash = new HashMap<String, Object>();

		int currentPage = 1;
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		int totalRecord = userService.count(hash);
		PageHandler pg = new PageHandler(currentPage, totalRecord, 10, 10);

		hash.put("pg", pg);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/user/list");
		mv.addObject("list", userService.list(hash));
		mv.addObject("pageHandler", pg);

		return mv;
	}
	
	@RequestMapping(value ="/user/insertForm.htm" , method = RequestMethod.POST)
	public String insertForm(Model model,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		model.addAttribute("curPage", curPage);
		
		return "user/insert";
	}
	
	@RequestMapping(value = "/user/insert.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String insert(Model model,@ModelAttribute("user") User user,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = userService.insert(user);
			
			if (ret == 1)
				msg = Env.get("msg.user.insert.succ");
			else
				msg = Env.get("msg.user.insert.fail");
		}catch(Exception e){
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}
	
	@RequestMapping(value = "/user/updateForm.htm")
	public ModelAndView updateForm(
			@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "curPage", required = false) String curPage) {

		User user = new User();
		user.setId(id);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/view");
		mv.addObject("user", userService.view(user));
		mv.addObject("curPage", curPage);

		return mv;
	}
	
	@RequestMapping(value = "/user/update.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String update(Model model,@ModelAttribute("user") User user,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = userService.update(user);
			
			if (ret == 1)
				msg = Env.get("msg.user.update.succ");
			else
				msg = Env.get("msg.user.update.fail");
		}catch(Exception e){
			e.printStackTrace();
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}
	
}
