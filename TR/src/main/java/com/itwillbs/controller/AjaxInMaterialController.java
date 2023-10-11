package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.InMaterialDTO;
import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.service.InMaterialService;

@RestController
@RequestMapping("/inMaterial/*")
public class AjaxInMaterialController {

	@Inject
	private InMaterialService inMaterialService;
//--------------------------------------------------------------
	
//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public ResponseEntity<List<InMaterialDTO>> BuyList(InMaterialDTO inMaterialDTO, HttpServletRequest request) {
		System.out.println("입고번호"+inMaterialDTO.getInNum());
		System.out.println("원자재 품명"+inMaterialDTO.getRawName());
		System.out.println("거래처명"+inMaterialDTO.getClientCompany());
		System.out.println("입고 상태 "+inMaterialDTO.getInState());
		
		if("".equals(inMaterialDTO.getInNum()) || "null".equals(inMaterialDTO.getInNum()) || inMaterialDTO.getInNum() == null) {
			System.out.println("입고 번호 변경");
			inMaterialDTO.setInNum("");
		}
		if("".equals(inMaterialDTO.getRawName()) || "null".equals(inMaterialDTO.getRawName()) || inMaterialDTO.getRawName() == null) {
			System.out.println("원자재 이름(품명) 변경");
			inMaterialDTO.setRawName("");
		}
		if("".equals(inMaterialDTO.getClientCompany()) || "null".equals(inMaterialDTO.getClientCompany()) || inMaterialDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			inMaterialDTO.setClientCompany("");
		}
		if("".equals(inMaterialDTO.getInState()) || "null".equals(inMaterialDTO.getInState()) || inMaterialDTO.getInState() == null) {
			System.out.println("입고 상태 변경");
			inMaterialDTO.setInState("");
		}
		
//		한페이지에서 보여지는 글개수 설정
		int pageSize =10;
		
//		페이지 번호
		String pageNum=request.getParameter("pageNum");
//		패이지 번호가 없으면 1페이지 설정
		if(pageNum == null) {
			pageNum = "1";
		}
//		페이지 번호를 정수형 변경 
		int currentPage = Integer.parseInt(pageNum);
//		페이지 번호를 저장
		inMaterialDTO.setCurrentPage(currentPage);
		inMaterialDTO.setPageNum(pageNum);
		inMaterialDTO.setPageSize(pageSize);
		
//		검색어는 이미 outProductDTO에 담겨져있다
		
//		게시판 전체 글 개수 구하기

		List<InMaterialDTO> inMaterialList = inMaterialService.getInMaterialList(inMaterialDTO);

		int count = inMaterialService.getInMaterialListCount(inMaterialDTO);
		
//		한화면에 보여줄 페이지 개수 설정
		int pageBlock =10;
//		시작하는 페이지 번호
//		currentPage 			pageBlock => startPage
//		1~10(0~9)/10 = 0		    10    => 0*10+1  => 1
//		11~20(10~19)/10 = 1			10    => 1*10+1  => 11
//		21~30(20~29)/10 = 2			10    => 2*10+1  => 21
		int startPage = (currentPage-1)/pageBlock*pageBlock+1;
//		끝나는 페이지 번호
//		startPage  pageBlock => endPage
//		1			10		 =>  10
//		2			10		 =>  20
//		3			10		 =>  30
//		계산한값 endPage 10 => 실제 페이지는 2 
		int endPage = startPage + pageBlock -1;
			
//		전체페이지 구하기 
//		글개수 50 한화면에 보여줄 글 개수 10 => 페이지수 5
//		count%pageBlock == 0 ? count/pageBlock : count/pageBlock+1;
		int pageCount = count%pageBlock == 0 ? count/pageBlock : count/pageBlock+1 ;
		if(endPage > pageCount ) {
				endPage = pageCount;
		}
		
		inMaterialDTO.setCount(count);
		inMaterialDTO.setPageBlock(pageBlock);	
		inMaterialDTO.setStartPage(startPage);
		inMaterialDTO.setEndPage(endPage);
		inMaterialDTO.setPageCount(pageCount);
		
//		페이징을 저장 후 마지막 outProductList의 마지막에 삽입 
		inMaterialList.add(inMaterialDTO);

		ResponseEntity<List<InMaterialDTO>> entity = new ResponseEntity<>(inMaterialList, HttpStatus.OK);
	    return entity;
	}
	
}
