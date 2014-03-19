package com.mobilepark.did.login.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.login.dao.LoginDao;
import com.mobilepark.did.user.model.User;


@Service
@Transactional
public class LoginServiceImpl implements LoginService
{

	@Autowired
	private LoginDao dao;
	
	public User loginCheck(User user) {
		return dao.loginCheck(user);
	}
	
}