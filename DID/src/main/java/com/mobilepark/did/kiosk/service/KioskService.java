package com.mobilepark.did.kiosk.service;

import java.util.List;

import com.mobilepark.did.framework.service.GenericService;
import com.mobilepark.did.kiosk.model.Kiosk;

public interface KioskService extends GenericService<Kiosk> {

	void heartbeatUpdate(List<Kiosk> kioskList);

}
