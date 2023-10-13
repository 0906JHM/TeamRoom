package com.itwillbs.service;

import java.nio.file.spi.FileSystemProvider;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InMaterialDAO;
import com.itwillbs.domain.InMaterialDTO;
import com.itwillbs.domain.OrderManagementDTO;

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

	public void insertList(OrderManagementDTO ordermanagementDTO) {
//		ordermanagementDTO 여기에서 필요한 데이터 inMaterialDTO 에 넣기 
		InMaterialDTO inMaterialDTO = new InMaterialDTO();
		String code = "IN";
		Integer inNum = inMaterialDAO.getMaxNum(code);
		if(inNum == null) {
			inNum = 0;
		}
		String changeCode = this.codeChange(code, inNum);
		
		inMaterialDTO.setInNum(changeCode);
		inMaterialDTO.setInCount(ordermanagementDTO.getBuyCount());
		inMaterialDTO.setRawPrice(ordermanagementDTO.getRawPrice());
		int price = Integer.parseInt(ordermanagementDTO.getRawPrice()) * ordermanagementDTO.getBuyCount();
		inMaterialDTO.setInPrice(price);
		
		inMaterialDTO.setRawCode(ordermanagementDTO.getRawCode());
		inMaterialDTO.setClientCode(ordermanagementDTO.getClientCode());
		inMaterialDTO.setInState("미입고");

		
		System.out.println("OrderManagementService insertOrderManagement()");
		
		// buyNum 자동생성
		// = rawCode + buyDate
		// = 원자재코드 + 년 + 월 + 일
		// = PER1 + 2023 + 10 + 11
		// = PER120231011
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    String buyDateStr = sdf.format(ordermanagementDTO.getBuyDate());
	    String buyNum = ordermanagementDTO.getRawCode() + buyDateStr;
		inMaterialDTO.setBuyNum(buyNum);

		
		
		
		inMaterialDAO.insertList(inMaterialDTO);
	}
	
	public String codeChange(String code_id, int num){
		return String.format("%s%04d", code_id, ++num);
	}

	public InMaterialDTO inMaterialContent(String inNum) {
		return inMaterialDAO.inMaterialContent(inNum);
	}

	public void updateWhseCount(InMaterialDTO inMaterialDTO) {
		inMaterialDAO.updateWhseCount(inMaterialDTO);
		
	}


	public void updateInState(InMaterialDTO inMaterialDTO) {
		inMaterialDAO.updateInState(inMaterialDTO);
		
	}
}
