package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InMaterialDAO;
import com.itwillbs.domain.InMaterialDTO;

@Service
public class InMaterialService {
	
	@Inject
	private InMaterialDAO inMaterialDAO;


	public List<InMaterialDTO> getInMaterialList(InMaterialDTO inMaterialDTO) {
//		시박하는 행부터 10개 뽑아오기
//		페이지 번호 	한화면에 보여줄 글개수 => 			시작하는 행번호
//		currentPage		pageSize	=>		 	startRow
//		1				10			=> 0*10 +1	 1 ~ 10
//		2				10			=> 1*10 +1 	11 ~ 20
//		3				10			=> 2*10 +1 	21 ~ 30
//		((currentPage-1)*10)+1
		int startRow = (inMaterialDTO.getCurrentPage()-1)*inMaterialDTO.getPageSize()+1;
		int endRow = startRow + inMaterialDTO.getPageSize() -1;
		System.out.println("start Row : " + startRow);
		System.out.println("end Row : " + endRow);
//		디비에 표현하기 위해서
		inMaterialDTO.setStartRow(startRow-1);
		inMaterialDTO.setEndRow(endRow);
		
		return inMaterialDAO.getInMaterialList(inMaterialDTO);
	}

	public int getInMaterialListCount(InMaterialDTO inMaterialDTO) {
		return inMaterialDAO.getInMaterialListCount(inMaterialDTO);
	}
}
