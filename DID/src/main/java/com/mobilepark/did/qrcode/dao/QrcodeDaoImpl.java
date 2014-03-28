package com.mobilepark.did.qrcode.dao;

import org.springframework.stereotype.Repository;

import com.mobilepark.did.framework.dao.GenericDaoImpl;
import com.mobilepark.did.qrcode.model.Qrcode;

@Repository
public class QrcodeDaoImpl extends GenericDaoImpl<Qrcode> implements QrcodeDao {
	
	@Override
	public String setSqlMdel() {
		return "qrcode";
	}

}
