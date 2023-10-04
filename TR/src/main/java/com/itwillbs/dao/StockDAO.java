package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

@Repository
public class StockDAO {
	
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.Mappers.StockMapper";

	public Integer getMaxNum() {
		System.out.println("StockDAO getMaxNum()");
		
		return sqlSession.selectOne(namespace+".getMaxNum");
	} // getMaxNum()

	public void insertBoard(StockDTO stockDTO) {
		System.out.println("StockDAO insertBoard()");
		
		sqlSession.insert(namespace+".insertBoard", stockDTO);
	} // insertBoard()

	public List<StockDTO> getBoardList(PageDTO pageDTO) {
		System.out.println("StockDAO getBoardList()");
		
		return sqlSession.selectList(namespace+".getBoardList",pageDTO);
	} // getBoardList()

	public int getBoardCount() {
		System.out.println("StockDAO getBoardCount()");
		
		return sqlSession.selectOne(namespace+".getBoardCount");
	} // getBoardCount()

	public StockDTO getBoard(String prodCode) {
		System.out.println("StockDAO getBoard()");
		
		return sqlSession.selectOne(namespace+".getBoard", prodCode);
	} // getBoard

	public void updateBoard(StockDTO stockDTO) {
		System.out.println("StockDAO updateBoard()");
		
		sqlSession.update(namespace+".updateBoard", stockDTO);
	} // updateBoard

	public void deleteBoard(String prodCode) {
		System.out.println("StockDAO deleteBoard()");
		
		sqlSession.delete(namespace+".deleteBoard", prodCode);
	}

}
