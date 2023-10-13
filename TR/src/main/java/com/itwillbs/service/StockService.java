package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.StockDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

@Service
public class StockService {
	
	// StockDAO 객체생성
	@Inject
	private StockDAO stockDAO;

	public void insertBoard(StockDTO stockDTO) {
		System.out.println("StockService insertBoard()");
		stockDAO.insertBoard(stockDTO);
	} // insertBoard()


    // List 페이징
	public List<StockDTO> getBoardList(PageDTO pageDTO) {
		System.out.println("StockService getBoardList()");
		// 시작하는 행번호
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		// 끝나느 행번호
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		// 디비작업 startRow -1
		pageDTO.setStartRow(startRow-1);
		pageDTO.setEndRow(endRow);
		
		return stockDAO.getBoardList(pageDTO);
	} // getBoardList
	
	public int getBoardCount(PageDTO pageDTO) {
		System.out.println("StockService getBoardCount");
		return stockDAO.getBoardCount();
	} // getBoardCount



	public StockDTO getBoard(int stockNum) {
		System.out.println("StockService getBoard");
		return stockDAO.getBoard(stockNum);
	} // getBoard



	public void updateBoard(StockDTO stockDTO) {
		System.out.println("StockService updateBoard()");
		stockDAO.updateBoard(stockDTO);
	} // updateboard

} // StockService
