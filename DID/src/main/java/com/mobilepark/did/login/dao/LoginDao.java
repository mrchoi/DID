package com.mobilepark.did.login.dao;


import com.mobilepark.did.user.model.User;

public interface LoginDao {

	public abstract User loginCheck(User user);
}