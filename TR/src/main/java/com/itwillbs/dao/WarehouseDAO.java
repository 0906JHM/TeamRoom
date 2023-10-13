package com.itwillbs.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.WarehouseDTO;

@Repository
public class WarehouseDAO {
	
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.Mappers.WarehouseMapper";

	public WarehouseDTO getWarehouse(String whseCode) {
		// TODO Auto-generated method stub
		return null;
	}

}
