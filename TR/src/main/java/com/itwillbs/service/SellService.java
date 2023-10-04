package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.SellDAO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;


@Service
public class SellService {
	
	@Inject
	private SellDAO sellDAO;

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
	}

	public int getSellCount() {
		System.out.println("SellService getSellCount()");
		
		return sellDAO.getSellCount();
	}
	
	

}//class


