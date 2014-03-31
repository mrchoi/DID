package com.mobilepark.kiosk.server;

import org.apache.log4j.Logger;

import com.mobilepark.kiosk.common.DateUtil;
import com.mobilepark.kiosk.model.Message;

public class KioskServiceImpl implements KioskService
{
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String process(String cmd)
	{
		String result = Message.FAIL;
		try
		{
			Process process = Runtime.getRuntime().exec(cmd);
			logger.info(cmd + " -> " + process.toString());
			
			result = Message.SUCCESS;
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		
		return result;
	}
	
	private String onOff(String body)
	{
		if (body == null) return Message.FAIL;
		if (body.equals("ON")) return Message.FAIL;
		
		String cmd = "shutdown -s -t 0";
		return this.process(cmd);
	}
	
	private String clock(String body)
	{
		if (body == null) return Message.FAIL;
		
		long dateTime = DateUtil.getTimeMillis(body, "yyyy-MM-dd HH:mm:ss.SSS");
		if (dateTime == 0) return Message.FAIL;
		
		String date = DateUtil.getTimeMillis(dateTime, "yyyy-MM-dd");
		String time = DateUtil.getTimeMillis(dateTime, "HH:mm:ss.SS");
		
		String cmd = "cmd.exe /C date " + date;
		String result = this.process(cmd);
		
		if (result.equals(Message.FAIL)) return result;
		
		cmd = "cmd.exe /C time " + time;
		return this.process(cmd);
	}
	
	private String popup(String body)
	{
		if (body == null) return Message.FAIL;
		
		String cmd = "explorer.exe " + body;
		//String cmd = "\"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\"" + body;
		//String cmd = "\"C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\"" + body;
		return this.process(cmd);
	}
	
	public Message getResponse(Message request)
	{
		Message response = new Message();
		
		response.setMessageCode(Message.KIOSK_RSP);
		response.setSubMessageCode(request.getSubMessageCode());
		
		String result = "";
		
		switch(request.getSubMessageCode())
		{
		case Message.ON_OFF :
			result = this.onOff(request.getBody());
			break;
			
		case Message.CLOCK :
			result = this.clock(request.getBody());
			break;
			
		case Message.POPUP :
			result = this.popup(request.getBody());
			break;
			
		case Message.HEARTBEAT :
			result = Message.SUCCESS;
			break;
		}
		
		response.setLength(result.getBytes().length);
		response.setBody(result);

		return response;
	}
}
