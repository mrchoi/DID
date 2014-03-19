package com.mobilepark.did.user.dao;

import org.springframework.stereotype.Repository;

import com.mobilepark.did.framework.dao.GenericDaoImpl;
import com.mobilepark.did.user.model.User;

@Repository
public class UserDaoImpl extends GenericDaoImpl<User> implements
		UserDao {

	@Override
	public String setSqlMdel() {
		return "user";
	}

}
