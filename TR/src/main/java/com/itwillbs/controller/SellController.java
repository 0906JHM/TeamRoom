package com.itwillbs.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.SellPageDTO;
import com.itwillbs.service.CalendarService;
import com.itwillbs.service.OutProductService;
import com.itwillbs.service.SellService;

import lombok.extern.slf4j.Slf4j;
 


@Controller
@Slf4j
@RequestMapping("/sell/*")
public class SellController {
	
	@Inject
	private SellService sellService;
	@Inject 
	private OutProductService outProductService;
	@Inject
	private CalendarService calendarService;
	
	private static final Logger logger = LoggerFactory.getLogger(SellController.class);

//----------------------------------------------------- 수주 목록 ---------------------------------------
@GetMapping("/sellMain")
public String sellList(HttpServletRequest request,Model model) {
	System.out.println("SellController sellMain()");
	//한 화면에 보여줄 글개수 설정
	int pageSize = 8;
	// 현 페이지 번호 가져오기
	String pageNum=request.getParameter("pageNum");
	// 페이지 번호가 없을 경우 => "1"로 설정
	if(pageNum == null) {
		pageNum = "1";
	}
	
	// 페이지 번호 => 정수형 변경
	int currentPage = Integer.parseInt(pageNum);
	
	//DTO에 담을 정보
	SellPageDTO sellPageDTO = new SellPageDTO();
	sellPageDTO.setPageSize(pageSize);
	sellPageDTO.setPageNum(pageNum);
	sellPageDTO.setCurrentPage(currentPage);
	
	List<SellDTO>sellList= sellService.getSellList(sellPageDTO);
	System.out.println(sellList);
	// 전체 글개수 가져오기
	int count = sellService.getSellCount();
	// 한화면에 보여줄 페이지 개수 설정
	int pageBlock = 8;
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

	// 글 목록
	model.addAttribute("sellList", sellList);// ("이름", 값)
	// 페이지
	model.addAttribute("sellPageDTO", sellPageDTO);
	
	log.debug("페이지번호"+pageNum);
	// center/notice.jsp
	// WEB-INF/views/center/notice.jsp
	return "sell/sellMain";
}//
	

//----------------------------------------------------- 수주 추가 ---------------------------------------
@GetMapping("/sellAdd")
public String sellAdd() {
	System.out.println("SellController sellAdd()");
	
	return "sell/sellAdd";
}//sellAdd

@PostMapping("/sellAddPro")
public ResponseEntity<String> sellAddPro(SellDTO sellDTO) {
	System.out.println("SellController sellAddPro()");
	System.out.println(sellDTO);
	
//	수주 코드 생성 
	Date now = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
    String formattedDate = dateFormat.format(now);
    String sellCode = "CL" + formattedDate;
    System.out.println("수주 코드 만드는거 : " + sellCode);
    sellDTO.setSellCode(sellCode);
	
//  sellState 수정 처음엔 무조건 미출고 
    sellDTO.setSellState("미출고");
    
	outProductService.insertList(sellDTO);		
	sellService.insertSell(sellDTO);			
	calendarService.insertSellCalendar(sellDTO);
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
	 prodPrice 제품단가 1ea
	 */

	return ResponseEntity.ok("<script>window.close();</script>");
}//sellAddPro

//-------------------------------------------------- 수주 상세정보 ------------------------------------------
@GetMapping("/sellDetail")
public String sellDetail(HttpServletRequest request, Model model) {
	System.out.println("SellController sellDetail()");
	
	String sellCode = request.getParameter("sellCode");
	
	// sellDetail 가져오기
	SellDTO sellDTO = sellService.getSell(sellCode);
	System.out.println("sellDTO" + sellDTO);
	model.addAttribute("sellDTO",sellDTO);
	
	return "sell/sellDetail";
	
}//sellDetail
//-------------------------------------------------- 수주 수정 ---------------------------------------------
	@GetMapping("/sellUpdate")
	public String sellUpdate(HttpServletRequest request, Model model) {
		System.out.println("sellController sellUpdate()");
		String sellCode = request.getParameter("sellCode");

		// 내용가져오기
		SellDTO sellDTO = sellService.getSell(sellCode);
		System.out.println(sellCode);
		model.addAttribute("sellDTO", sellDTO);

		return "sell/sellUpdate";
	}//sellUpdate

	@PostMapping("/sellUpdatePro")
	public ResponseEntity<String> sellUpdatePro(SellDTO sellDTO) {
		System.out.println("SellController sellUpdatePro()");
		// 수정
		sellService.sellUpdate(sellDTO);

		//return "redirect:/sell/sellMain";
		
		return ResponseEntity.ok("<script>window.close();</script>");
	}//sellUpdatePro
	
//-------------------------------------------------- 수주 삭제 ---------------------------------------------
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> sellDelete(@RequestBody List<String> checked) throws Exception {
		
		System.out.println("넘어온 데이터 "+checked);
		
		int result = sellService.sellDelete(checked);
		calendarService.deleteSellCalendar(checked);
		outProductService.deleteSell(checked);
		if (result > 0) {
	        return new ResponseEntity<String>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
	    }
		
	}//sellDelete
		
		
//----------------------------------------------------- 비고 보기 ---------------------------------------
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

//----------------------------------------------------- 비고 추가 ---------------------------------------
@GetMapping("/sellMemotype")
public String sellMemoAdd(HttpServletRequest request, Model model) {
	System.out.println("SellController sellMemotype()");
	String sellCode = request.getParameter("sellCode");
	System.out.println(sellCode);
	
	SellDTO sellDTO = sellService.getSellMemo(sellCode);
	String memotype = request.getParameter("memotype");
	System.out.println(memotype);
	
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

//----------------------------------------------------- 비고 수정 ---------------------------------------
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
	
@PostMapping("/sellMemoUpdatePro")
public ResponseEntity<String> sellMemoUpdatePro(SellDTO sellDTO) {
	System.out.println("SellController sellMemoUpdatePro()");
	System.out.println(sellDTO);
	sellService.updateSellMemo(sellDTO);
	// 창을 닫기 위한 스크립트를 반환합니다.
	return ResponseEntity.ok("<script>window.close();</script>");
}//sellMemoUpdatePro

@PostMapping("/sellMainSearch")
public String sellMainSearch(Model model,HttpServletRequest request, SellDTO sellDTO) {
	
	String daterange1 = request.getParameter("daterange1");
	String daterange2 = request.getParameter("daterange2");
	
	if(!("".equals(daterange1) || "null".equals(daterange1) || daterange1 == null)) {
		String sellDate =  daterange1.split(" - ")[0].replaceAll("/", "-");
		String sellEndDate = daterange1.split(" - ")[1].replaceAll("/", "-");
		sellDTO.setSellDate(sellDate);
		sellDTO.setSellEndDate(sellEndDate);
	}
	if(!("".equals(daterange2) || "null".equals(daterange2) || daterange2 == null)) {
		String sellDuedate =  daterange2.split(" - ")[0].replaceAll("/", "-");
		String sellEndDuedate = daterange2.split(" - ")[1].replaceAll("/", "-");
		sellDTO.setSellDuedate(sellDuedate);
		sellDTO.setSellEndDuedate(sellEndDuedate);
	}
	if("".equals(daterange1) || "null".equals(daterange1) || daterange1 == null) {
		sellDTO.setSellDate("");
		sellDTO.setSellEndDate("");
	}
	if("".equals(daterange2) || "null".equals(daterange2) || daterange2 == null) {
		sellDTO.setSellDuedate("");
		sellDTO.setSellEndDuedate("");
	}
	if("".equals(sellDTO.getProdCode()) || "null".equals(sellDTO.getProdCode()) || sellDTO.getProdCode() == null) {
		System.out.println("제품 변경");
		sellDTO.setProdCode("");
	}
	if("".equals(sellDTO.getClientCode()) || "null".equals(sellDTO.getClientCode()) || sellDTO.getClientCode() == null) {
		System.out.println("거래처 변경");
		sellDTO.setClientCode("");
	}
	if("".equals(sellDTO.getSellCode()) || "null".equals(sellDTO.getSellCode()) || sellDTO.getSellCode() == null) {
		System.out.println("수주코드 변경");
		sellDTO.setSellCode("");
	}
	
	
	System.out.println(sellDTO);

	List<SellDTO>sellList= sellService.getSellListSearch(sellDTO);
	

	// 글 목록
	model.addAttribute("sellList", sellList);// ("이름", 값)
	// 페이지
	
	// center/notice.jsp
	// WEB-INF/views/center/notice.jsp
	return "sell/sellMain";
	
}
	
	
	
	
	
	
	
	
	
	
	
	
}//class
