package com.mobilepark.did.framework.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public abstract class GenericDaoImpl<M extends Serializable> extends SqlSessionDaoSupport 
	implements GenericDao<M>{
	
	public String sqlModel = setSqlMdel();
	
	public abstract String setSqlMdel();

	public List<M> list(Map<String, Object> paramMap) {
		return super.getSqlSession().selectList(sqlModel+".list", paramMap);
	}

	public int count(Map<String, Object> paramMap) {
		return super.getSqlSession().selectOne(sqlModel+".count", paramMap);
	}

	public int insert(M model) {
		return super.getSqlSession().insert(sqlModel+".insert", model);
	}

	public int update(M model) {
		return super.getSqlSession().update(sqlModel+".update", model);
	}
	
	public int updateHit(Map<String, Object> paramMap){
		return super.getSqlSession().update(sqlModel+".updateHit", paramMap);
	}

	public int delete(M model) {
		return super.getSqlSession().delete(sqlModel+".delete", model);
	}

	public M view(M model) {
		return super.getSqlSession().selectOne(sqlModel+".view", model);
	}
}
