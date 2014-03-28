package com.mobilepark.did.info.dao;

import org.springframework.stereotype.Repository;

import com.mobilepark.did.framework.dao.GenericDaoImpl;
import com.mobilepark.did.info.model.Info;

@Repository
public class InfoDaoImpl extends GenericDaoImpl<Info> implements InfoDao {
	
	@Override
	public String setSqlMdel() {
		return "info";
	}

}
