package com.mobilepark.did.notice.dao;

import org.springframework.stereotype.Repository;

import com.mobilepark.did.framework.dao.GenericDaoImpl;
import com.mobilepark.did.notice.model.Notice;

@Repository
public class NoticeDaoImpl extends GenericDaoImpl<Notice> implements NoticeDao {
	
	@Override
	public String setSqlMdel() {
		return "notice";
	}

}
