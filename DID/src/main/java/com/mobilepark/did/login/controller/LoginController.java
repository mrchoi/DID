package com.mobilepark.did.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mobilepark.did.login.service.LoginService;
import com.mobilepark.did.user.model.User;


@Controller
public class LoginController {
	@Autowired
	private LoginService service;

	@RequestMapping(value ="admin/login.htm")
	public String login(Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		return "admin/login";
	}
	
	@RequestMapping(value = "admin/loginForm.htm", method = RequestMethod.POST)
	public String loginForm(Model model,
			@ModelAttribute("user") User user, HttpSession session) throws Exception
	{
		User detail = new User();		
		detail = service.loginCheck(user);
		
		if(detail!=null) {
			session.setAttribute("ADMIN_ID", detail.getId());
			session.setAttribute("ADMIN_NAME", detail.getName());
			
			return "redirect:/admin/user/list.htm";
		} else {
			model.addAttribute("loginCheck", "F");
			return "admin/login";
		}
	}
	
	@RequestMapping(value = "admin/logout.htm", method = RequestMethod.POST)
	public String logout(Model model, HttpSession session) throws Exception
	{
		
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:login.htm";
	}
		
	
}
