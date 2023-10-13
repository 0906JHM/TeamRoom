package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.SellDAO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;


@Service
public class SellService {
	
	@Inject
	private SellDAO sellDAO;

//----------------------------------------------------- getSellList --------------------------------------------------------	
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
	
//----------------------------------------------------- getSellCount --------------------------------------------------------
	public int getSellCount() {
		System.out.println("SellService getSellCount()");
		
		return sellDAO.getSellCount();
	}//getSellCount
	
//----------------------------------------------------- insertSell --------------------------------------------------------
	public void insertSell(SellDTO sellDTO) {
		System.out.println("SellService insertSell()");
		
		/* sellDTO.setSellDuedate(null); */
		
		sellDAO.insertSell(sellDTO);	
	}//insertSell
	
	//----------------------------------------------------- getSellMemo --------------------------------------------------------
		public SellDTO getSellMemo(String sellCode) {
		System.out.println("SellService getSellMemo()");
			
			return sellDAO.getSellMemo(sellCode);
		}//getSellMemo

	//----------------------------------------------------- updateSellMemo ---------------------------------------
		public void updateSellMemo(SellDTO sellDTO) {
			System.out.println("SellService updateSellMemo");

			sellDAO.updateSellMemo(sellDTO);
		}//updateSellMemo

		
		//----------------------------------------------------- insertSellMemo --------------------------------------------------------
		public void insertSellMemo(SellDTO sellDTO) {
			System.out.println("SellService insertSellMemo()");

			sellDAO.insertSellMemo(sellDTO);	
		}//insertSellMemo

		//----------------------------------------------------- sellDelete --------------------------------------------------------
		/*
		 * // 체크박스로 선택삭제
		 * 
		 * @Override public void sellDelete(String sellCode){
		 * sellDAO.sellDelete(sellCode); }//sellDelete
		 * 
		 * 
		 * 
		 */

	

}//class


