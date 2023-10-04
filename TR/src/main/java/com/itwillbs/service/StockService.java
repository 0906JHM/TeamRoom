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
//		if(stockDAO.getMaxNum() == null) {
//			// 글 없는 경우
//			stockDTO.setNum(1);
//		} else {
//			// 글 있는 경우 // max(num) +1
//			stockDTO.setNum(stockDAO.getMaxNum()+1);
//		}
		stockDAO.insertBoard(stockDTO);
	} // insertBoard()



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
	
	public int getBoardCount() {
		System.out.println("StockService getBoardCount");
		return stockDAO.getBoardCount();
	} // getBoardCount



	public StockDTO getBoard(String prodCode) {
		System.out.println("StockService getBoard");
		return stockDAO.getBoard(prodCode);
	} // getBoard



	public void updateBoard(StockDTO stockDTO) {
		System.out.println("StockService updateBoard()");
		stockDAO.updateBoard(stockDTO);
	} // updateboard



	public void deleteBoard(String prodCode) {
		System.out.println("StockService deleteBoard()");
		stockDAO.deleteBoard(prodCode);
	} // deleteBoard




} // StockService
