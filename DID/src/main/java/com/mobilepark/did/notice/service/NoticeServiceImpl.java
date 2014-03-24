package com.mobilepark.did.notice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;
import com.mobilepark.did.framework.service.GenericServiceImpl;
import com.mobilepark.did.notice.dao.NoticeDao;
import com.mobilepark.did.notice.model.Notice;

@Service
@Transactional
public class NoticeServiceImpl extends GenericServiceImpl<Notice> implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	protected GenericDao<Notice> getGenericDao() {
		return noticeDao;
	}

}
