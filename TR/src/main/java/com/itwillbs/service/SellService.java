package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.dao.SellDAO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class SellService {

	@Inject
	private SellDAO sellDAO;

	//----------------------------------------------------- 수주 목록 --------------------------------------------------------	
	public List<SellDTO> getSellList(SellPageDTO sellPageDTO) {
		System.out.println("SellService getSellList()");
		// 10개씩 가져올때 현페이지에 대한 시작하는 행번호 구하기
		int startRow = (sellPageDTO.getCurrentPage()-1)*sellPageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + sellPageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		sellPageDTO.setStartRow(startRow - 1);
		sellPageDTO.setEndRow(endRow);

		return sellDAO.getSellList(sellPageDTO);
	}//getSellList

	//----------------------------------------------------- 수주 개수 --------------------------------------------------------
	public int getSellCount() {
		System.out.println("SellService getSellCount()");

		return sellDAO.getSellCount();
	}//getSellCount

	//----------------------------------------------------- 수주 추가 --------------------------------------------------------
	public void insertSell(SellDTO sellDTO) {
		System.out.println("SellService insertSell()");

		sellDAO.insertSell(sellDTO);	
	}//insertSell

	//----------------------------------------------------- 수주 상세정보 --------------------------------------------------------
	public SellDTO getSell(String sellCode) {
		System.out.println("SellService getSell()");
		
		SellDTO sellDTO = sellDAO.getSell(sellCode);
		
	    return sellDTO;

//		return sellDAO.getSell(sellCode);
		
	}//getSell

	//----------------------------------------------------- 수주 수정 --------------------------------------------------------
	public void sellUpdate(SellDTO sellDTO) {
		sellDAO.sellUpdate(sellDTO);
		
	}//sellUpdate

	//----------------------------------------------------- 수주 삭제 --------------------------------------------------------
	public int sellDelete(List<String> checked) throws Exception {
		System.out.println("SellService sellDelete()");
		
		return sellDAO.sellDelete(checked);
	}//sellDelete

	//----------------------------------------------------- 비고 보기 --------------------------------------------------------
	public SellDTO getSellMemo(String sellCode) {
		System.out.println("SellService getSellMemo()");

		return sellDAO.getSellMemo(sellCode);
	}//getSellMemo

	//----------------------------------------------------- 비고 추가 --------------------------------------------------------
	public void insertSellMemo(SellDTO sellDTO) {
		System.out.println("SellService insertSellMemo()");

		sellDAO.insertSellMemo(sellDTO);	
	}//insertSellMemo
	
	//----------------------------------------------------- 비고 수정 ---------------------------------------
	public void updateSellMemo(SellDTO sellDTO) {
		System.out.println("SellService updateSellMemo");

		sellDAO.updateSellMemo(sellDTO);
	}//updateSellMemo

	





}//class


