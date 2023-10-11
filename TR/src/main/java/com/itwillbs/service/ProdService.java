package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ProdDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;

@Service
public class ProdService {

	@Inject
	private ProdDAO prodDAO;

//-----------------------------------------------------------------

	public List<ProdDTO> getProdList(PageDTO pageDTO) {
		System.out.println("2");
		System.out.println("ProdService getProdList()");

		// 10개씩 가져올때 현페이지에 대한 시작하는 행번호 구하기
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);

		return prodDAO.getProdList(pageDTO);
	}

	public void productDelete(List<String> checked) throws Exception {
		prodDAO.productDelete(checked);
	}

	public void insert(ProdDTO prodDTO) {
		System.out.println("ProdDAO insert()");

		prodDAO.insert(prodDTO);
	}// insertBoard()

	public List<ProdDTO> getSearch(ProdDTO prodDTO, PageDTO pageDTO) {
		System.out.println("ProService getSearch()");
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return prodDAO.getSearch(prodDTO, pageDTO);

	}

	public ProdDTO getProd(String prodCode) {

		return prodDAO.getProd(prodCode);
	}

	public void updateProd(ProdDTO prodDTO) {
		prodDAO.updateProd(prodDTO);

	}
	
	public int getSearchcount(ProdDTO prodDTO) {
		return prodDAO.getSearchcount(prodDTO);
	}

	public int getProdCount(PageDTO pageDTO) {
		return prodDAO.getProdCount(pageDTO);
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
