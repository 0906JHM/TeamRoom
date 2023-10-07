package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;



@Repository
public class ProdDAOImpl implements ProdDAO2 {
 @Inject
 private SqlSession sqlSession;
 
 private static final String namespace = "com.itwillbs.mappers.proMapper.";

 @Override
	public boolean productDelete(List<Map<String, String>> codeAndTypeList) {
		
		
		return sqlSession.delete(namespace+"productDelete", codeAndTypeList) > 0;
	}
}


