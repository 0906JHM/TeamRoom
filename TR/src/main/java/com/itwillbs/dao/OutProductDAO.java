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

	public void updateSellState(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateSellState",outProductDTO);
	}

	public void updateOutDate(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutDate",outProductDTO);		
	}

	public void updateOutRedate(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutRedate",outProductDTO);		
	}

	public void updateWhseCount(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateWhseCount",outProductDTO);		
	}

	public void updateOutProductContent(OutProductDTO outProductDTO) {
		sqlSession.update(namespace + "updateOutProductContent",outProductDTO);		
	}
	
	
}
