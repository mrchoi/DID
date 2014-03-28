package com.mobilepark.did.framework.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;

@Transactional
public abstract class GenericServiceImpl<M extends Serializable> implements GenericService<M> {
	
	protected abstract GenericDao<M> getGenericDao();

	public List<M> list(Map<String, Object> paramMap) {
		return this.getGenericDao().list(paramMap);
	}

	public int count(Map<String, Object> paramMap) {
		return this.getGenericDao().count(paramMap);
	}

	public int insert(M model) {
		return this.getGenericDao().insert(model);
	}

	public int update(M model) {
		return this.getGenericDao().update(model);
	}
	
	public int updateHit(Map<String, Object> paramMap) {
		return this.getGenericDao().updateHit(paramMap);
	}

	public int delete(M model) {
		
		return this.getGenericDao().delete(model);
	}
	
	public List<M> festivalList(Map<String, Object> paramMap) {
		return this.getGenericDao().festivalList(paramMap);
	}

	public M view(M model) {
		return this.getGenericDao().view(model);
	}

}
