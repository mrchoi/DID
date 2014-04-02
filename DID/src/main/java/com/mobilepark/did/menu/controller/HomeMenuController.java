package com.mobilepark.did.menu.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeMenuController {

	@RequestMapping(value = "/goMenu.htm", method = RequestMethod.POST)
	public String goMenu(@RequestParam(value = "menuId", defaultValue = "menu_1") String menuId) {


		return "user/menu/"+menuId;
	}
}
