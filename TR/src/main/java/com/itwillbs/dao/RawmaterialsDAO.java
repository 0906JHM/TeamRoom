package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.WarehouseDTO;

@Repository  
public class RawmaterialsDAO implements RawmaterialsDAO2 {
	
	// mybatis 객체생성
	@Inject
	private SqlSession sqlSession;
		
	// 이름이 너무 기니까 변수로 저장
	private static final String namespace = "com.itwillbs.mappers.RawmaterialsMapper";

	public Integer getMaxNum() {
		System.out.println("RawmaterialsDAO getMaxNum()");
		return sqlSession.selectOne(namespace+".getMaxNum");
	}
	
	public void insertRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsDAO insertRawmaterials()");
		sqlSession.insert(namespace+".insertRawmaterials", rawmaterialsDTO);
	}

	// home 페이징처리, 검색기능
	public List<RawmaterialsDTO> getRawmaterialsList(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getRawmaterialsList()");		
		return sqlSession.selectList(namespace+".getRawmaterialsList", pageDTO);
	}
	
	// home 페이징처리, 검색기능
	public int getRawmaterialsCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getRawmaterialsCount()");
		return sqlSession.selectOne(namespace+".getRawmaterialsCount",pageDTO);
    }

	// 체크박스로 선택삭제
	@Override
	public void delete(String rawCode){
		sqlSession.delete(namespace + ".delete", rawCode); 
	}

	public RawmaterialsDTO getDetail(String rawCode) {
		System.out.println("RawmaterialsDAO getDetail()");
		return sqlSession.selectOne(namespace+".getDetail", rawCode);
	}

	public void updateRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsDAO updateRawmaterials()");
		sqlSession.update(namespace+".updateRawmaterials", rawmaterialsDTO);
	}

	// selectclient 페이징처리, 검색기능
	public List<ClientDTO> getClientList(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getClientList()");		
		return sqlSession.selectList(namespace+".getClientList", pageDTO);
	}

	// selectclient 페이징처리, 검색기능
	public int getClientCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getClientCount()");
		return sqlSession.selectOne(namespace+".getClientCount",pageDTO);
    }

	// selectwarehouse 페이징처리, 검색기능
	public List<WarehouseDTO> getWarehouseList(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getWarehouseList()");		
		return sqlSession.selectList(namespace+".getWarehouseList", pageDTO);
	}

	// selectwarehouse 페이징처리, 검색기능
	public int getWarehouseCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getWarehouseCount()");
		return sqlSession.selectOne(namespace+".getWarehouseCount",pageDTO);
	}

	// 여기서부터 비고코드 수정하기
	public RawmaterialsDTO getSellMemo(String rawCode) {
		System.out.println("SellDAO getSellMemo()");
		return sqlSession.selectOne(namespace+".getSellMemo", rawCode);
	}

	public void updateSellMemo(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellDAO updateSellMemo()");
		sqlSession.update(namespace + ".updateSellMemo", rawmaterialsDTO);
	}

	public void insertSellMemo(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellDAO insertSellMemo()");
		System.out.println(rawmaterialsDTO);
		sqlSession.insert(namespace + ".insertSellMemo", rawmaterialsDTO);
	}
			
	public void deleteSell(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellDAO deleteSell()");
		sqlSession.update(namespace+".deleteSell",rawmaterialsDTO);
	}
	
}