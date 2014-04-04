package com.mobilepark.kiosk.model;

import java.nio.ByteBuffer;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mobilepark.did.info.controller.InfoController;
import com.mobilepark.kiosk.common.ByteUtil;

public class Packet
{
	private static final Logger logger = LoggerFactory
			.getLogger(InfoController.class);
	
	private static String getBody(byte[] buffer)
	{
		String body = "";
		try
		{
			body = new String(buffer, "UTF-8");
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return body;
	}
	
	public static ByteBuffer messageToPacket(ByteBuffer byteBuffer, Message message)
	{
		byteBuffer.putShort(message.getMessageCode());
		byteBuffer.putShort(message.getSubMessageCode());
		byteBuffer.putInt(message.getLength());
		//if (message.getSubMessageCode() != Message.HEARTBEAT)
		{
			byteBuffer.put(message.getBody().getBytes());
		}
		
		return byteBuffer;
	}
	
	public static Message packetToMessage(ByteBuffer byteBuffer)
	{
		Message message = new Message();
		
		message.setMessageCode(byteBuffer.getShort());
		message.setSubMessageCode(byteBuffer.getShort());
		message.setLength(byteBuffer.getInt());
		//if(message.getSubMessageCode() != Message.HEARTBEAT)
		{
			byte[] data = new byte[message.getLength()];
			byteBuffer.get(data);
			if (data != null && data.length > 0) message.setBody(Packet.getBody(data));
		}
		
		return message;
	}
}
