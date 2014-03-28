package com.mobilepark.did.framework.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface GenericService<M extends Serializable> {
	
	List<M> list(Map<String, Object> paramMap);

	int count(Map<String, Object> paramMap);
	
	int insert(M model);
	
	int update(M model);
	
	int updateHit(Map<String, Object> paramMap);
	
	int delete(M model);
	
	List<M> festivalList(Map<String, Object> paramMap);
	
	M view(M model);
}
