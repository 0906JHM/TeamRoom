package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ProdDAO;
import com.itwillbs.domain.ProdDTO;
	
	
@Service
public class ProdService {
	
	@Inject
	private ProdDAO prodDAO;
	
//-----------------------------------------------------------------
	
	public List<ProdDTO> getProdList() {
		System.out.println("2");
		System.out.println("ProdService getProdList()");
		
		return prodDAO.getProdList();
	}
	
	public void productDelete(List<String> checked) throws Exception {
		prodDAO.productDelete(checked);
	}

	
	public void insert(ProdDTO prodDTO) {
		System.out.println("ProdDAO insert()");
		
		prodDAO.insert(prodDTO);
	}//insertBoard()

	public List<ProdDTO> getSearch(ProdDTO prodDTO) {
	System.out.println("ProService getSearch()");
	return prodDAO.getSearch(prodDTO);
	
	
}


	
//	@Inject
//	private ProdDAO prodDAO;
//
//	public List<ProdDTO> getProdSearch(ProdDTO prodDTO) {
//		System.out.println("ProService getProdSearch()");
//		return prodDAO.getProdSearch(prodDTO);
//	}
//	
//	// 품목관리 총 갯수
////	@Override
////	public int countProd() {
////		return prodDAO.countProd();
////	}
//
//	// 품목관리 목록 불러오기
//public List<ProdDTO> getProdList(ProdDTO prodDTO) throws Exception {
//	return prodDAO.getProdList(prodDTO);
//}
//
//// 품목관리 검색리스트 갯수 불러오기
////	@Override
////	public int countProd(ProdDTO prodDTO) {
////		return prodDAO.countProd(prodDTO);
////	}

}
