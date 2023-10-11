package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.InMaterialDTO;
import com.mysql.cj.Session;

@Repository
public class InMaterialDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.inMaterialMapper";

//------------------------------------------------------------------------------------------
	
	public List<InMaterialDTO> getInMaterialList() {
		return sqlSession.selectList(namespace+".getInMaterialList");
	}
}
