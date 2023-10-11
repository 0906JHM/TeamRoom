package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OutProductDAO;
import com.itwillbs.domain.OutProductDTO;

@Service
public class OutProductService {

	@Inject
	private OutProductDAO outProductDAO;
	
	public List<OutProductDTO> getOutProductList(OutProductDTO outProductDTO) {
//		시박하는 행부터 10개 뽑아오기
//		페이지 번호 	한화면에 보여줄 글개수 => 			시작하는 행번호
//		currentPage		pageSize	=>		 	startRow
//		1				10			=> 0*10 +1	 1 ~ 10
//		2				10			=> 1*10 +1 	11 ~ 20
//		3				10			=> 2*10 +1 	21 ~ 30
//		((currentPage-1)*10)+1
		int startRow = (outProductDTO.getCurrentPage()-1)*outProductDTO.getPageSize()+1;
		int endRow = startRow + outProductDTO.getPageSize() -1;
		System.out.println("start Row : " + startRow);
		System.out.println("end Row : " + endRow);
//		디비에 표현하기 위해서
		outProductDTO.setStartRow(startRow-1);
		outProductDTO.setEndRow(endRow);
		
		return outProductDAO.getOutProductList(outProductDTO);
	}
	
	public int getOutProductListCount(OutProductDTO outProductDTO) {
		return outProductDAO.getOutProductListCount(outProductDTO);
	}

	public OutProductDTO outProductContent(String outCode) {
		return outProductDAO.outProductContent(outCode);
	}

	public void updateSellState(OutProductDTO outProductDTO) {
		outProductDAO.updateSellState(outProductDTO);
	}

	public void updateOutDate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutDate(outProductDTO);
	}

	public void updateOutRedate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutRedate(outProductDTO);
	}

	public void updateWhseCount(OutProductDTO outProductDTO) {
		outProductDAO.updateWhseCount(outProductDTO);
	}

	public void updateOutProductContent(OutProductDTO outProductDTO) {
		outProductDAO.updateOutProductContent(outProductDTO);
	}

	

}
