package com.itwillbs.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OrderManagementDAO;
import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class OrderManagementService { 

	// OrderManagementDAO 객체생성
	@Inject
	private OrderManagementDAO ordermanagementDAO;
	
	public void insertOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementService insertOrderManagement()");
		
		// buyNum 자동생성
		// = rawCode + buyDate
		// = 원자재코드 + 년 + 월 + 일
		// = PER1 + 2023 + 10 + 11
		// = PER120231011
		// SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	    // String buyDateStr = sdf.format(ordermanagementDTO.getBuyDate());
	    // String buyNum = ordermanagementDTO.getRawCode() + buyDateStr;
	    // ordermanagementDTO.setBuyNum(buyNum);
		
		// buyNum 자동생성
		// = RA + yyMMddHHmmss
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
		String formattedDate = dateFormat.format(now);
	    String buyNum = "RA" + formattedDate;
		System.out.println("발주코드 : " + buyNum);
		ordermanagementDTO.setBuyNum(buyNum);
		ordermanagementDAO.insertOrderManagement(ordermanagementDTO);
	}
	
	// home 페이징처리, 검색기능
	public List<OrderManagementDTO> getOrderManagementList(PageDTO pageDTO) {
		System.out.println("OrderManagementService getOrderManagementList()");
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
        int endRow = startRow + pageDTO.getPageSize() - 1;
        pageDTO.setStartRow(startRow - 1);
        pageDTO.setEndRow(endRow);
		return ordermanagementDAO.getOrderManagementList(pageDTO);
	}
	
	// home 페이징처리, 검색기능
	public int getOrderManagementCount(PageDTO pageDTO) {
		System.out.println("OrderManagementService getOrderManagementCount()");
		return ordermanagementDAO.getOrderManagementCount(pageDTO);
	}
	
	// 체크박스로 선택삭제
	public void delete(String buyNum){
		ordermanagementDAO.delete(buyNum);
	}

	public OrderManagementDTO getDetail(String buyNum) {
		System.out.println("OrderManagementService getDetail()");
		return ordermanagementDAO.getDetail(buyNum);
	}

	public void updateOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementService updateOrderManagement()");
		ordermanagementDAO.updateOrderManagement(ordermanagementDTO);
	}
	
	// 엑셀 수정
	public List<OrderManagementDTO> getOrderManagementList2() {
		return ordermanagementDAO.getOrderManagementList2();
	}

}