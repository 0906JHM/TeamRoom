package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.InMaterialDTO;
import com.mysql.cj.Session;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class InMaterialDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.inMaterialMapper";

//------------------------------------------------------------------------------------------
	
	public List<InMaterialDTO> getInMaterialList(InMaterialDTO inMaterialDTO) {
		
		if("전체".equals(inMaterialDTO.getInState())) {
			log.debug("전체용");
			return sqlSession.selectList(namespace+".getInMaterialList", inMaterialDTO);
		}else {
			log.debug("나머지용");
			return sqlSession.selectList(namespace+".getInMaterialListSearch", inMaterialDTO);
		}
	}

	public int getInMaterialListCount(InMaterialDTO inMaterialDTO) {
		 System.out.println("outProductDTO.getSellState(): " + inMaterialDTO.getInState());
		    if (inMaterialDTO.getInState() == null) {
		    	inMaterialDTO.setInState("null");
		    }
		if("전체".equals(inMaterialDTO.getInState())) {
			System.out.println("전체용 카운트");
			return sqlSession.selectOne(namespace+".getInMaterialListCount", inMaterialDTO);
		}else {
			System.out.println("나머지용 카운트");
			return sqlSession.selectOne(namespace+".getInMaterialListSearchCount", inMaterialDTO);
		}
	}

	public Integer getMaxNum(String code) {
		return sqlSession.selectOne(namespace+".getMaxNum", code);
	}

	public void insertList(InMaterialDTO inMaterialDTO) {
		sqlSession.selectOne(namespace+".insertList", inMaterialDTO);
	}
}