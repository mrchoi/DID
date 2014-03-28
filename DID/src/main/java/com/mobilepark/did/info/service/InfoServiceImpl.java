package com.mobilepark.did.info.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;
import com.mobilepark.did.framework.service.GenericServiceImpl;
import com.mobilepark.did.info.dao.InfoDao;
import com.mobilepark.did.info.model.Info;

@Service
@Transactional
public class InfoServiceImpl extends GenericServiceImpl<Info> implements InfoService {
	
	@Autowired
	private InfoDao infoDao;

	@Override
	protected GenericDao<Info> getGenericDao() {
		return infoDao;
	}

}
