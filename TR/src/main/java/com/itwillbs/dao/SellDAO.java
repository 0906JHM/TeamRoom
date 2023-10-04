package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;


@Repository
public class SellDAO {
	//마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.sellMapper";

	public int getSellCount() {
		System.out.println("SellDAO getSellCount()");

		return sqlSession.selectOne(namespace+".getSellCount");
	}
	public List<SellDTO> getSellList(SellPageDTO sellPageDTO) {
		System.out.println("SellDAO getSellList()");

		return sqlSession.selectList(namespace+".getSellList", sellPageDTO);
	}

	
	

}//클래스
