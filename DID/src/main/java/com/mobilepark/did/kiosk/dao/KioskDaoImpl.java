package com.mobilepark.did.kiosk.dao;

import org.springframework.stereotype.Repository;

import com.mobilepark.did.framework.dao.GenericDaoImpl;
import com.mobilepark.did.kiosk.dao.KioskDao;
import com.mobilepark.did.kiosk.model.Kiosk;

@Repository
public class KioskDaoImpl extends GenericDaoImpl<Kiosk> implements KioskDao {
	
	@Override
	public String setSqlMdel() {
		return "kiosk";
	}

}
