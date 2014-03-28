package com.mobilepark.did.qrcode.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;
import com.mobilepark.did.framework.service.GenericServiceImpl;
import com.mobilepark.did.qrcode.dao.QrcodeDao;
import com.mobilepark.did.qrcode.model.Qrcode;

@Service
@Transactional
public class QrcodeServiceImpl extends GenericServiceImpl<Qrcode> implements QrcodeService {
	
	@Autowired
	private QrcodeDao qrcodeDao;

	@Override
	protected GenericDao<Qrcode> getGenericDao() {
		return qrcodeDao;
	}

}