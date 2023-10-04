package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;
import com.itwillbs.service.SellService;



@Controller
@RequestMapping("/sell/*")
public class SellController {
	
	@Inject
	private SellService sellService;

	//	가상주소 http://localhost:8080/FunWeb/board/write
//	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	@GetMapping("/sellMain")
	public String sellMain() {
		
		// main/main.jsp
		// WEB-INF/views/main/main.jsp
		return "sell/sellMain";
	}//
	
//----------------------------------------------------- sellList ---------------------------------------
@GetMapping("/sellList")
public String sellList(HttpServletRequest request,Model model) {
	System.out.println("SellController sellList()");
	//한 화면에 보여줄 글개수 설정
	int pageSize = 10;
	// 현 페이지 번호 가져오기
	String pageNum=request.getParameter("pageNum");
	// 페이지 번호가 없을 경우 => "1"로 설정
	if(pageNum == null) {
		pageNum = "1";
	}
	
	// 페이지 번호 => 정수형 변경
	int currentPage = Integer.parseInt(pageNum);
	
	SellPageDTO sellPageDTO =new SellPageDTO();
	sellPageDTO.setPageSize(pageSize);
	sellPageDTO.setPageNum(pageNum);
	sellPageDTO.setCurrentPage(currentPage);
	
List<SellDTO>sellList= sellService.getSellList(sellPageDTO);

	// 전체 글개수 가져오기
	int count = sellService.getSellCount();
	// 한화면에 보여줄 페이지 개수 설정
	int pageBlock = 10;
	// 시작하는 페이지 번호
	int startPage=(currentPage-1)/pageBlock*pageBlock+1;
	// 끝나는 페이지 번호
	int endPage = startPage + pageBlock -1;
	// 전체페이지 개수
	int pageCount = count/pageSize+(count%pageSize==0?0:1);
	// 끝나는 페이지 번호  전체페이지 개수 비교 
	//=> 끝나는 페이지 번호가 크면 전체페이지 개수로 변경
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	
	sellPageDTO.setCount(count);
	sellPageDTO.setPageBlock(pageBlock);
	sellPageDTO.setStartPage(startPage);
	sellPageDTO.setEndPage(endPage);
	sellPageDTO.setPageCount(pageCount);

	
	model.addAttribute("sellList", sellList);
	model.addAttribute("SellpageDTO", sellPageDTO);
	
	// center/notice.jsp
	// WEB-INF/views/center/notice.jsp
	return "sell/sellMain";
}//
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
