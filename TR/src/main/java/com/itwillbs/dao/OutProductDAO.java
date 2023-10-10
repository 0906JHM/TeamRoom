package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.OutProductDTO;

@Repository
public class OutProductDAO {


	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.outProductMapper.";

	public List<OutProductDTO> getOutProductList(OutProductDTO outProductDTO) {
		if("전체".equals(outProductDTO.getSellState())) {
			System.out.println("전체용");
			return sqlSession.selectList(namespace+"getOutProductList");
		}else {
			System.out.println("나머지용");
			return sqlSession.selectList(namespace+"getOutProductListSearch", outProductDTO);
		}
	}

	public OutProductDTO outProductContent(String outCode) {
		return sqlSession.selectOne(namespace + "outProductContent",outCode);
	}
	
	
}
