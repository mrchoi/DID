package com.mobilepark.did.info.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mobilepark.did.common.Env;
import com.mobilepark.did.framework.web.PageHandler;
import com.mobilepark.did.info.model.Info;
import com.mobilepark.did.info.service.InfoService;

@Controller
public class InfoController {
	
	private static final Logger logger = LoggerFactory
			.getLogger(InfoController.class);

	@Autowired
	private InfoService infoService;
	
	@RequestMapping(value = "admin/info/list.htm")
	public ModelAndView list(HttpSession session,
			@RequestParam(value = "curPage", defaultValue = "") String curPage,
			@RequestParam(value = "category", defaultValue = "") String category,
			@RequestParam(value = "searchKind", defaultValue = "") String searchKind,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord) {

		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		
		String categoryName = Env.get("category."+category);
		
		hash.put("category",category);
		hash.put("searchKind",searchKind);
		hash.put("searchWord",searchWord);

		int currentPage = 1;
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		int totalRecord = infoService.count(hash);
		PageHandler pg = new PageHandler(currentPage, totalRecord, 10, 10);

		hash.put("pg", pg);
		
		ModelAndView mv = new ModelAndView();
		
		if(category.equals("200")){
			mv.setViewName("admin/festival/list");
		}else{
			mv.setViewName("admin/info/list");
		}
		
		mv.addObject("list", infoService.list(hash));
		mv.addObject("pageHandler", pg);
		mv.addObject("ADMIN_ID", session.getAttribute("ADMIN_ID"));
		mv.addObject("CategoryName", categoryName);
		mv.addObject("category", category);
		mv.addObject("searchKind", searchKind);
		mv.addObject("searchWord", searchWord);
		
		return mv;
	}
	
	@RequestMapping(value ="admin/info/insertForm.htm" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView insertForm(Model model,@RequestParam(value = "category", defaultValue = "") String category,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) throws Exception
	{
		model.addAttribute("curPage", curPage);
		
		String categoryName = Env.get("category."+category);
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();
		mv.addObject("CategoryName", categoryName);
		mv.addObject("category", category);
		
		if(category.equals("200")){
			mv.setViewName("admin/festival/insert");
		}else{
			mv.setViewName("admin/info/insert");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "admin/info/insert.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String insert(Model model,@ModelAttribute("info") Info info,			
			@RequestParam(value = "curPage", defaultValue = "") String curPage,
			MultipartHttpServletRequest req) throws Exception

	{
		
		MultipartFile imgFile = req.getFile("imgFile");
		
		String msg = "";
		String fileName = "";
		int ret = 0;   
		
		try{
						
				if (imgFile!=null) {
					
					fileName = imgFile.getOriginalFilename().trim();
					String path1 = Env.get("did.fileupload") + "/" + fileName;
					imgFile.transferTo(new File(path1));
				}
				
				info.setFile_url(fileName);
				
				ret = infoService.insert(info);
				
				if (ret == 1)
					msg = Env.get("msg.info.insert.succ");
				else
					msg = Env.get("msg.info.insert.fail");
			
		}catch(Exception e){
			msg = Env.get("msg.user.exception");
		}finally{
			
		}
		return msg;
	}
	
		
	@RequestMapping(value ="admin/info/updateForm.htm" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateForm(Model model,@ModelAttribute("info") Info info,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {
	
		String categoryName = Env.get("category."+info.getCategory());

		ModelAndView mv = new ModelAndView();
				
		if(info.getCategory().equals("200")){
			mv.setViewName("admin/festival/view");
		}else{
			mv.setViewName("admin/info/view");
		}
		
		mv.addObject("info", infoService.view(info));
		mv.addObject("CategoryName", categoryName);
		mv.addObject("category", info.getCategory());

		return mv;
	}
	
	@RequestMapping(value = "admin/info/update.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String update(Model model,
			@ModelAttribute("info") Info info,
			@RequestParam(value = "curPage", defaultValue = "") String curPage,
			MultipartHttpServletRequest req) throws Exception
	{
		String msg = "";
		String fileName = "";
		int ret = 0;
		
		MultipartFile imgFile = req.getFile("imgFile");
		
		try{
			
			if (imgFile!=null) {
				
				fileName = imgFile.getOriginalFilename().trim();
				String path1 = Env.get("did.fileupload") + "/" + fileName;
				imgFile.transferTo(new File(path1));
				info.setFile_url(fileName);
			}
				
			ret = infoService.update(info);
			
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
	
	@RequestMapping(value = "admin/info/delete.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String delete(Model model,@ModelAttribute("info") Info info,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = infoService.delete(info);
			
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
	
	@RequestMapping(value ="admin/info/popup.htm" , method = RequestMethod.POST,produces="text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView popupForm(Model model,@RequestParam(value = "location", defaultValue = "") String location,
			@RequestParam(value = "seq", defaultValue = "") String seq,
			@RequestParam(value = "category", defaultValue = "") String category) throws Exception
	{
		
		ModelAndView mv = new ModelAndView();
		if(category.equals("001"))	mv.setViewName("admin/info/tour_popup");
		else mv.setViewName("admin/info/popup");
		
		Info info = new Info();
		info.setSequence(Integer.parseInt(seq));
		mv.addObject("info", infoService.view(info));
		mv.addObject("location", location);		
		return mv;
	}
	
	@RequestMapping(value ="admin/info/imgPopupForm.htm" , method = RequestMethod.POST,produces="text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView imgPopupForm(Model model,@RequestParam(value = "url", defaultValue = "") String url) throws Exception
	{
		System.out.println(url);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/festival/popup");
		mv.addObject("url", url);		
		return mv;
	}

	
}
