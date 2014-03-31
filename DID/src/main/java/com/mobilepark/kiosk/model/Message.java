package com.mobilepark.kiosk.model;

public class Message
{
	public final static short KIOSK_REQ = 11;
	public final static short KIOSK_RSP = 12;
	
	public final static short ON_OFF = 0;
	public final static short CLOCK = 1;
	public final static short POPUP = 2;
	public final static short HEARTBEAT = 255;
	
	public final static String SUCCESS = "SUCCESS";
	public final static String FAIL = "FAIL";
	
	private short messageCode;
	private short subMessageCode;
	private int length;
	private String body;
	
	public Message()
	{
	}

	public short getMessageCode() {
		return messageCode;
	}

	public short getSubMessageCode() {
		return subMessageCode;
	}

	public int getLength() {
		return length;
	}

	public String getBody() {
		return body;
	}

	public void setMessageCode(short messageCode) {
		this.messageCode = messageCode;
	}

	public void setSubMessageCode(short subMessageCode) {
		this.subMessageCode = subMessageCode;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public void setBody(String body) {
		this.body = body;
	}

	@Override
	public String toString() {
		return "Message [messageCode=" + messageCode + ", subMessageCode="
				+ subMessageCode + ", length=" + length + ", body=" + body
				+ "]";
	}
}
