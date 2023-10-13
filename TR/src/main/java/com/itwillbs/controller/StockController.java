package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.service.StockService;

@Controller
public class StockController {
	
	// StockService 객체생성
	@Inject
	private StockService stockService;
	
	// 주소 
	@RequestMapping(value = "/stock/write", method = RequestMethod.GET)
	public String write() {
	// stock/write.jsp
	// WEB-INF / views / stock / write.jsp
	return "stock/write";
	
	} // write
	
	@RequestMapping(value = "/stock/writePro", method = RequestMethod.POST)
	public String writePro(StockDTO stockDTO) {
    System.out.println("StockController writePro()");
    System.out.println(stockDTO);
	//디비에 글쓰기
	stockService.insertBoard(stockDTO);
	// 글목록 주소변경하면서 이동 /board/list
	return "redirect:/stock/list";
	
	}// writePro
	
	@RequestMapping(value="/stock/list", method=RequestMethod.GET)
	public String list(HttpServletRequest request,Model model) {
		
		String search1 = request.getParameter("search1");
		System.out.println("search1 : " + search1);
		String search2 = request.getParameter("search2");
		System.out.println("search2 : " + search2);
		String search3 = request.getParameter("search3");
		System.out.println("search3 : " + search3);
		
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum="1";
		}
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch1(search1); // 검색어저장
		pageDTO.setSearch2(search2);
		pageDTO.setSearch3(search3);
		
		List<StockDTO> boardList=stockService.getBoardList(pageDTO);
		
		int count = stockService.getBoardCount(pageDTO);
		int pageBlock = 10;
		int startPage = (currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		if(endPage>pageCount) {
			endPage = pageCount;
		}
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageDTO", pageDTO);
        
		// stock/list.jsp
		// WEB-INF/views/stock/list.jsp
		return "stock/list";
	} // list
	
	@RequestMapping(value = "/stock/update", method = RequestMethod.GET)
	public String update(HttpServletRequest request, Model model) {
		int stockNum = Integer.parseInt(request.getParameter("stockNum"));
		// num에 대한 게시판 글 가져오기
        StockDTO stockDTO = stockService.getBoard(stockNum);		
		model.addAttribute("stockDTO", stockDTO);
		// stock/update.jsp
		// WEB-INF/views/stock/update.jsp
		return "stock/update";
	}// update
	
	@RequestMapping(value="/stock/updatePro", method = RequestMethod.POST)
	public String updatePro(StockDTO stockDTO) {
		System.out.println(stockDTO);
		// prodCode에 대한 게시판 글 수정
		stockService.updateBoard(stockDTO);
		
		return "redirect:/stock/list";
	} // updatePro
	

}
