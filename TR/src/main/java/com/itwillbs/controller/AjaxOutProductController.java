package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.service.OutProductService;

@RestController
@RequestMapping("/outProduct/*")
public class AjaxOutProductController {
	
	@Inject
	private OutProductService outProductService;
	
//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public ResponseEntity<List<OutProductDTO>> SalesList(OutProductDTO outProductDTO, HttpServletRequest request) {
		System.out.println("출고코드"+outProductDTO.getOutCode());
		System.out.println("제품이름"+outProductDTO.getProdName());
		System.out.println("거래처이름"+outProductDTO.getClientCompany());
		System.out.println("거래 상태 "+outProductDTO.getSellState());
		
		if("".equals(outProductDTO.getOutCode()) || "null".equals(outProductDTO.getOutCode()) || outProductDTO.getOutCode() == null) {
			System.out.println("출고 코드 변경");
			outProductDTO.setOutCode("");
		}
		if("".equals(outProductDTO.getProdName()) || "null".equals(outProductDTO.getProdName()) || outProductDTO.getProdName() == null) {
			System.out.println("제품 이름 변경");
			outProductDTO.setProdName("");
		}
		if("".equals(outProductDTO.getClientCompany()) || "null".equals(outProductDTO.getClientCompany()) || outProductDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			outProductDTO.setClientCompany("");
		}
		if("".equals(outProductDTO.getSellState()) || "null".equals(outProductDTO.getSellState()) || outProductDTO.getSellState() == null) {
			System.out.println("거래처 이름 변경");
			outProductDTO.setSellState("");
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
		outProductDTO.setCurrentPage(currentPage);
		outProductDTO.setPageNum(pageNum);
		outProductDTO.setPageSize(pageSize);
		
//		검색어는 이미 outProductDTO에 담겨져있다
		
//		게시판 전체 글 개수 구하기

		List<OutProductDTO> outProductList = outProductService.getOutProductList(outProductDTO);

		int count = outProductService.getOutProductListCount(outProductDTO);
		
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
		
		outProductDTO.setCount(count);
		outProductDTO.setPageBlock(pageBlock);	
		outProductDTO.setStartPage(startPage);
		outProductDTO.setEndPage(endPage);
		outProductDTO.setPageCount(pageCount);
		
//		페이징을 저장 후 마지막 outProductList의 마지막에 삽입 
		outProductList.add(outProductDTO);

		ResponseEntity<List<OutProductDTO>> entity = new ResponseEntity<>(outProductList, HttpStatus.OK);
	    return entity;
	}
	
	
}
