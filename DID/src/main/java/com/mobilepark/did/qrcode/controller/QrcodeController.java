package com.mobilepark.did.qrcode.controller;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.mobilepark.did.common.Env;
import com.mobilepark.did.framework.web.PageHandler;
import com.mobilepark.did.qrcode.model.Qrcode;
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
		mv.addObject("url", Env.get("did.file_url"));
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
	
	@RequestMapping(value = "admin/qrcode/insert.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String insert(Model model,@ModelAttribute("qrcode") Qrcode qrcode,			
			@RequestParam(value = "curPage", defaultValue = "") String curPage,
			MultipartHttpServletRequest req) throws Exception

	{
		
		MultipartFile imgFile = req.getFile("imgFile");
		MultipartFile qrcodeFile = req.getFile("qrcodeFile");
		
		String msg = "";
		String fileName = "";
		String qrcodeName = "";
		int ret = 0;   
		
		try{
						
				if (imgFile!=null) {
					
					fileName = imgFile.getOriginalFilename().trim();
					String path = Env.get("did.fileupload") + "/" + fileName;
					imgFile.transferTo(new File(path));
					
					qrcode.setFile_url(fileName);
				}
				
				if (qrcodeFile!=null) {
					
					qrcodeName = qrcodeFile.getOriginalFilename().trim();
					String qrcode_path = Env.get("did.fileupload") + "/" + qrcodeName;
					qrcodeFile.transferTo(new File(qrcode_path));
					
					qrcode.setQrcode_url(qrcodeName);
				}
				
				ret = qrcodeService.insert(qrcode);
				
				if (ret == 1)
					msg = Env.get("msg.qrcode.insert.succ");
				else
					msg = Env.get("msg.qrcode.insert.fail");
			
		}catch(Exception e){
			msg = Env.get("msg.user.exception");
		}finally{
			
		}
		return msg;
	}
	
	@RequestMapping(value ="admin/qrcode/updateForm.htm" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateForm(Model model,@ModelAttribute("qrcode") Qrcode qrcode,
			@RequestParam(value = "curPage", defaultValue = "") String curPage) {
	
		HashMap<String, Object> hash = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("admin/qrcode/view");
		
		mv.addObject("qrcode", qrcodeService.view(qrcode));
		mv.addObject("list", qrcodeService.festivalList(hash));
		

		return mv;
	}
	
	@RequestMapping(value = "admin/qrcode/update.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String update(Model model,
			@ModelAttribute("qrcode") Qrcode qrcode,
			@RequestParam(value = "curPage", defaultValue = "") String curPage,
			MultipartHttpServletRequest req) throws Exception
	{
		String msg = "";
		String fileName = "";
		String qrcodeName = "";
		int ret = 0;
		
		MultipartFile imgFile = req.getFile("imgFile");
		MultipartFile qrcodeFile = req.getFile("qrcodeFile");
				
		try{
			
			if (imgFile!=null && imgFile.getSize() > 0) {
				
				fileName = imgFile.getOriginalFilename().trim();
				String path1 = Env.get("did.fileupload") + "/" + fileName;
				imgFile.transferTo(new File(path1));
				
				qrcode.setFile_url(fileName);
			}
			
			if (qrcodeFile!=null && qrcodeFile.getSize() > 0 ) {
				
				qrcodeName = qrcodeFile.getOriginalFilename().trim();
				String qrcode_path = Env.get("did.fileupload") + "/" + qrcodeName;
				qrcodeFile.transferTo(new File(qrcode_path));
				
				qrcode.setQrcode_url(qrcodeName);
			}
			
			ret = qrcodeService.update(qrcode);
			
			if (ret == 1)
				msg = Env.get("msg.qrcode.update.succ");
			else
				msg = Env.get("msg.qrcode.update.fail");
			
		}catch(Exception e){
			e.printStackTrace();
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}
	
	@RequestMapping(value = "admin/qrcode/delete.htm", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String delete(Model model,@ModelAttribute("qrcode") Qrcode qrcode,
			@RequestParam(value = "curPage", defaultValue = "") String curPage
			) throws Exception

	{
		String msg = "";
		int ret = 0;
		
		try{
			
			ret = qrcodeService.delete(qrcode);
			
			if (ret == 1)
				msg = Env.get("msg.qrcode.delete.succ");
			else
				msg = Env.get("msg.qrcode.delete.fail");
		}catch(Exception e){
			e.printStackTrace();
			msg = Env.get("msg.user.exception");
		}finally{
		}
		return msg;
	}

}
