package com.mobilepark.did.kiosk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;
import com.mobilepark.did.framework.service.GenericServiceImpl;
import com.mobilepark.did.kiosk.dao.KioskDao;
import com.mobilepark.did.kiosk.model.Kiosk;

@Service
@Transactional
public class KioskServiceImpl extends GenericServiceImpl<Kiosk> implements KioskService {
	
	@Autowired
	private KioskDao kioskDao;

	@Override
	protected GenericDao<Kiosk> getGenericDao() {
		return kioskDao;
	}

}
