package com.itwillbs.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mysql.cj.Session;

@Repository
public class InMaterialDAO {

	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.inMaterialMapper";
}
