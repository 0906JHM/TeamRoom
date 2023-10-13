package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;

@Repository
public class SellDAO {
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.sellMapper";

//----------------------------------------------------- getSellList --------------------------------------------------------	
	public List<SellDTO> getSellList(SellPageDTO sellPageDTO) {
		System.out.println("SellDAO getSellList()");

		return sqlSession.selectList(namespace + ".getSellList", sellPageDTO);
	}// getSellList

//----------------------------------------------------- getSellCount --------------------------------------------------------
	public int getSellCount() {
		System.out.println("SellDAO getSellCount()");

		return sqlSession.selectOne(namespace + ".getSellCount");
	}// getSellCount
 
//----------------------------------------------------- insertSell --------------------------------------------------------
	public void insertSell(SellDTO sellDTO) {
		System.out.println("SellDAO insertSell()");

		sqlSession.insert(namespace + ".insertSell", sellDTO);
	}// insertSell

//----------------------------------------------------- getSellMemo --------------------------------------------------------		
		public SellDTO getSellMemo(String sellCode) {
			System.out.println("SellDAO getSellMemo()");
			
			return sqlSession.selectOne(namespace+".getSellMemo", sellCode);
	
		}//getSellMemo
		
//----------------------------------------------------- sellMemoUpdate ---------------------------------------
		public void updateSellMemo(SellDTO sellDTO) {
			System.out.println("SellDAO updateSellMemo()");

			sqlSession.update(namespace + ".updateSellMemo", sellDTO);
		}// updateSellMemo

//----------------------------------------------------- insertSellMemo --------------------------------------------------------
		public void insertSellMemo(SellDTO sellDTO) {
			System.out.println("SellDAO insertSellMemo()");
			System.out.println(sellDTO);
			

			sqlSession.insert(namespace + ".insertSellMemo", sellDTO);
		}// insertSellMemo
		
//----------------------------------------------------- deleteSell --------------------------------------------------------
		public void deleteSell(SellDTO sellDTO) {
			System.out.println("SellDAO deleteSell()");
			
			sqlSession.update(namespace+".deleteSell",sellDTO);
		}//deleteSell





}// class
