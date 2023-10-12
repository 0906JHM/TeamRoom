package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;
import com.itwillbs.service.SellService;



@Controller
@RequestMapping("/sell/*")
public class SellController {
	
	@Inject
	private SellService sellService;
	


//----------------------------------------------------- sellMain---------------------------------------
@GetMapping("/sellMain")
public String sellList(HttpServletRequest request,Model model) {
	System.out.println("SellController sellMain()");
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
	
	SellPageDTO sellPageDTO = new SellPageDTO();
	sellPageDTO.setPageSize(pageSize);
	sellPageDTO.setPageNum(pageNum);
	sellPageDTO.setCurrentPage(currentPage);
	
List<SellDTO>sellList= sellService.getSellList(sellPageDTO);
System.out.println(sellList);
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
	

//----------------------------------------------------- sellAdd ---------------------------------------
@GetMapping("/sellAdd")
public String sellAdd() {
	System.out.println("SellController sellAdd()");
	
	return "sell/sellAdd";
}//sellAdd

@PostMapping("/sellAddPro")
public ResponseEntity<String> sellAddPro(SellDTO sellDTO) {
	System.out.println("SellController ()");
	sellService.insertSell(sellDTO);	
	return ResponseEntity.ok("<script>window.close();</script>");
	/*
	 sellCode 수주코드, 
	 sellDate 수주일자, 
	 sellDuedate납기일자, 
	 sellEmpId 수주담당직원, 
	 sellCount 수주수량, 
	 prodCode 제품코드, 
	 prodName 제품명,
	 sellFile 수주파일, 
	 sellMemo 수주비고, 
	 sellState 수주상태(현황), 
	 clientCode 거래처코드, 
	 sellPrice 수주단가
	 */

	 
}//sellAddPro


//----------------------------------------------------- sellMemo ---------------------------------------
@GetMapping("/sellMemo")
public String sellMemo(HttpServletRequest request, Model model) {
	System.out.println("SellController sellMemo()");
	
	String sellCode = request.getParameter("sellCode");
	
	// sellMemo 가져오기
	SellDTO sellDTO = sellService.getSellMemo(sellCode);
	System.out.println("sellDTO" + sellDTO);
	model.addAttribute("sellDTO",sellDTO);
	
	return "sell/sellMemo";
	
}//sellMemo

//----------------------------------------------------- updateSellMemo ---------------------------------------
//	가상주소 http://localhost:8080/Test/sell/sellMemoUpdate?num=
//@RequestMapping(value = "/sellMemoUpdate", method = RequestMethod.GET)
@GetMapping("/sellMemoUpdate")
public String updateSellMemo(HttpServletRequest request,Model model) {
	System.out.println("SellController sellMemoUpdate()");
	
	String sellCode = request.getParameter("sellCode");
	
	//글가져오기
	SellDTO sellDTO = sellService.getSellMemo(sellCode);

	model.addAttribute("sellDTO", sellDTO);

	// center/update.jsp
	// WEB-INF/views/center/update.jsp
	return "sell/updateSellMemo";
}//sellMemoUpdate
	
//@PostMapping("/sellMemoUpdatePro")
//public void sellMemoUpdatePro(SellDTO sellDTO) {
//	System.out.println("SellController sellMemoUpdatePro()");
//	
//	// sellMemo 수정
//	sellService.updateSellMemo(sellDTO);
//
//}//sellMemoUpdatePro
@PostMapping("/sellMemoUpdatePro")
public ResponseEntity<String> sellMemoUpdatePro(SellDTO sellDTO) {
	System.out.println("SellController sellMemoUpdatePro()");
	System.out.println(sellDTO);
	sellService.updateSellMemo(sellDTO);
	
	// 창을 닫기 위한 스크립트를 반환합니다.
	return ResponseEntity.ok("<script>window.close();</script>");
}

//----------------------------------------------------- sellMemotype ---------------------------------------
@GetMapping("/sellMemotype")
public String sellMemoAdd(HttpServletRequest request, Model model) {
	System.out.println("SellController sellMemotype()");
	String sellCode = request.getParameter("sellCode");
	System.out.println(sellCode);
	SellDTO sellDTO = sellService.getSellMemo(sellCode);
	String memotype = request.getParameter("memotype");
	System.out.println(sellDTO);
	
	model.addAttribute("sellDTO", sellDTO);
	model.addAttribute("memotype", memotype);

	return "sell/sellMemotype";
}//sellMemotype

@PostMapping("/sellMemotypePro")
public ResponseEntity<String> sellMemoAddPro(SellDTO sellDTO) {
	System.out.println("SellController sellMemotypePro()");
	System.out.println(sellDTO);
	sellService.insertSellMemo(sellDTO);	
	return ResponseEntity.ok("<script>window.close();</script>");
	
}//sellMemotypePro	
	
//-------------------------------------------------- sellDelete ---------------------------------------------
@GetMapping("/sellDelete")
public void sellDeletePro(SellDTO sellDTO) {
	System.out.println("SellController sellDelete()");
	System.out.println(sellDTO);
	
	sellService.sellDelete(sellDTO);
}// sellDelete
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
