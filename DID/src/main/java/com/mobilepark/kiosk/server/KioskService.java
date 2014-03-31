package com.mobilepark.kiosk.server;

import com.mobilepark.kiosk.model.Message;

public interface KioskService
{
	public abstract Message getResponse(Message request);
}
