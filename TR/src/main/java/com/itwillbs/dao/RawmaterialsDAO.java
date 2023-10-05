package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.RawmaterialsDTO;

@Repository 
public class RawmaterialsDAO implements RawmaterialsDAO2 {
	
	// mybatis 객체생성
	@Inject
	private SqlSession sqlSession;
		
	// 이름이 너무 기니까 변수로 저장
	private static final String namespace = "com.itwillbs.mappers.RawmaterialsMapper";

	public void insertRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsDAO insertRawmaterials()");
		sqlSession.insert(namespace+".insertRawmaterials", rawmaterialsDTO);
	}

	public List<RawmaterialsDTO> getRawmaterialsList() {
		System.out.println("RawmaterialsDAO getRawmaterialsList()");		
		return sqlSession.selectList(namespace+".getRawmaterialsList");
	}

	public List<RawmaterialsDTO> getRawmaterialsSearchList(RawmaterialsDTO rawmaterialsDTO) {
		return sqlSession.selectList(namespace+".getRawmaterialsSearchList", rawmaterialsDTO);
	}

	// 체크박스로 선택삭제
	@Override
	public void delete(String a1){
		sqlSession.delete(namespace + ".delete", a1); 
	}

	public RawmaterialsDTO getDetail(String a1) {
		System.out.println("RawmaterialsDAO getDetail()");
		return sqlSession.selectOne(namespace+".getDetail", a1);
	}

	public void updateRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsDAO updateRawmaterials()");
		sqlSession.update(namespace+".updateRawmaterials", rawmaterialsDTO);
	}
	
}
