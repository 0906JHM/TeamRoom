package com.itwillbs.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ProdDTO;

@Repository
public class ProdDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.proMapper";
//	---------------------------------------------------------------------------
	
	public List<ProdDTO> getProdList() {
		System.out.println("3");
		System.out.println("ProdDAO getProdList()");
		
		return sqlSession.selectList(namespace+".getProdList");
	}
	
	 public void productDelete(List<String> checked) throws Exception {
			

			Iterator<String> it = checked.iterator();
			int result = 0;

			while (it.hasNext()) {
				String prodCode = it.next();
				result += sqlSession.delete(namespace + ".productDelete", prodCode);
			}


		}
	
	public void insert(ProdDTO prodDTO) {
		System.out.println("ProdDAO insert()");
		
		sqlSession.insert(namespace+".insert", prodDTO);
	}//insertBoard()
	
	public List<ProdDTO> getSearch(ProdDTO prodDTO) {
		System.out.println("ProdDAO getSearch()");
		return sqlSession.selectList(namespace+".getSearch", prodDTO);
	}
//	
//	//품목관리 리스트 불러오기
//	public List<ProdDTO> getProdList(ProdDTO prodDTO) {
//		return sqlSession.selectList(namespace+".getProdList", prodDTO);
//	}

	public ProdDTO getProd(String prodCode) {
		
		return sqlSession.selectOne(namespace+".getProd", prodCode);
	}

	public void updateProd(ProdDTO prodDTO) {
		sqlSession.update(namespace+".updateProd",prodDTO);
	}


}


