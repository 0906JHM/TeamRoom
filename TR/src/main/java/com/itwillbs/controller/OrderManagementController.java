package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.service.InMaterialService;
import com.itwillbs.service.OrderManagementService;
import com.itwillbs.service.RawmaterialsService;

@Controller  
@RequestMapping("/OrderManagement/*")
public class OrderManagementController {
	
	// OrderManagementService 객체생성
	@Inject
	private OrderManagementService ordermanagementService;
	@Inject
	private RawmaterialsService rawmaterialsService;
	@Inject
	private InMaterialService inMaterialService;
	
	// 가상주소 http://localhost:8080/leeweb/OrderManagement/home
	// home 페이징처리, 검색기능
	@GetMapping("/home")
	public String home(HttpServletRequest request,Model model) {
			
		String search1 = request.getParameter("search1");
		System.out.println("search1 : " + search1);
		String search2 = request.getParameter("search2");
		System.out.println("search2 : " + search2);
		String search3 = request.getParameter("search3");
		System.out.println("search3 : " + search3);
		String search4 = request.getParameter("search4");
		System.out.println("search4 : " + search4);
			
		int pageSize = 10;
		String pageNum=request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		    
		int currentPage = Integer.parseInt(pageNum);
		PageDTO pageDTO =new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch1(search1); // 검색어저장
		pageDTO.setSearch2(search2);
		pageDTO.setSearch3(search3);
		pageDTO.setSearch4(search4);
		        
		// 품목추가한 내용 뿌려주기
		List<OrderManagementDTO> ordermanagementList= ordermanagementService.getOrderManagementList(pageDTO);
		        
		int count = ordermanagementService.getOrderManagementCount(pageDTO);
		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		    
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		model.addAttribute("pageDTO", pageDTO);
		        
		// 품목추가한 내용 뿌려주기
		model.addAttribute("ordermanagementList", ordermanagementList);
		model.addAttribute("pageDTO", pageDTO);
		    
		return "OrderManagement/home";
	}
	
	// 가상주소 http://localhost:8080/leeweb/OrderManagement/insert
	@GetMapping("/insert")
	public String insert() {
		return "OrderManagement/insert";
	}
	
	// 가상주소 http://localhost:8080/leeweb/OrderManagement/insertPro
		@PostMapping("/insertPro")
		public String insertPro(OrderManagementDTO ordermanagementDTO) {
			System.out.println("OrderManagementController insertPro()");
			System.out.println(ordermanagementDTO);
			
			inMaterialService.insertList(ordermanagementDTO);
			ordermanagementService.insertOrderManagement(ordermanagementDTO);
			return "redirect:/OrderManagement/home";
		}
	
	// 체크박스로 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	ordermanagementService.delete(ajaxMsg[i]);
        }
        return "redirect:/OrderManagement/home";
    }
    
    @GetMapping("/detail")
 	public String detail(HttpServletRequest request, Model model) {
    	System.out.println("OrderManagementController detail()");
 		
 		// 발주번호 잘 들고왔는지 확인
    	String buyNum = request.getParameter("buyNum");
 		
 		// 1) ordermanagementService, ordermanagementDAO에 getDetail 메서드를 만들어, 들고온 buyNum에 해당하는 다른 내용을 가져오게 하고 => ordermanagementDTO 변수에 담기
    	OrderManagementDTO ordermanagementDTO = ordermanagementService.getDetail(buyNum);
 		// 2) Model을 사용해서 ordermanagementDTO에 넣은 모든 내용을 보여주기
 		model.addAttribute("ordermanagementDTO", ordermanagementDTO);
 		
 		return "OrderManagement/detail";
 	}
    
    @GetMapping("/update")
 	public String update(HttpServletRequest request, Model model) {
    	System.out.println("OrderManagementController update()");
 		
    	// 발주번호 잘 들고왔는지 확인
    	String buyNum = request.getParameter("buyNum");
 	 	
 	 	// detail 코드내용 재활용
    	OrderManagementDTO ordermanagementDTO = ordermanagementService.getDetail(buyNum);
 		model.addAttribute("ordermanagementDTO", ordermanagementDTO);
 		
 		return "OrderManagement/update";
 	}
    
    @PostMapping("/updatePro")
	public String updatePro(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementController updatePro()");
		
		// 수정한내용 잘 들고왔는지 확인
		System.out.println(ordermanagementDTO);
		
		// insert, update 등은 DB에서 작업하고 끝낼거라 리턴할필요 없음 
		// 따라서 boardDTO = boardService.updateBoard(boardDTO);처럼 boardDTO에 받아올 필요없고, Service랑 DAO에서 void 쓰고 return 안함
		ordermanagementService.updateOrderManagement(ordermanagementDTO);
		return "redirect:/OrderManagement/home";
	}
    
    // selectrawmaterials 페이징처리, 검색기능
 	@GetMapping("/selectrawmaterials")
 	public String selectrawmaterials(HttpServletRequest request,Model model) {
 		
 		String search1 = request.getParameter("search1");
 		System.out.println("search1 : " + search1);
 		String search2 = request.getParameter("search2");
 		System.out.println("search2 : " + search2);
 		String search3 = request.getParameter("search3");
 		System.out.println("search3 : " + search3);
 		String search4 = request.getParameter("search4");
 		System.out.println("search4 : " + search4);
 		
 	    int pageSize = 10;
 	    String pageNum=request.getParameter("pageNum");
 	    if(pageNum == null) {
 	    	pageNum = "1";
 	    }
 	    
 	    int currentPage = Integer.parseInt(pageNum);
 	    PageDTO pageDTO =new PageDTO();
 	    pageDTO.setPageSize(pageSize);
 	    pageDTO.setPageNum(pageNum);
 	    pageDTO.setCurrentPage(currentPage);
 	    pageDTO.setSearch1(search1); // 검색어저장
 	    pageDTO.setSearch2(search2);
 	    pageDTO.setSearch3(search3);
 	    pageDTO.setSearch4(search4);
 	        
 	    // 품목 추가한 내용 뿌려주기
 	    List<RawmaterialsDTO> rawmaterialsList= rawmaterialsService.getRawmaterialsList(pageDTO);
 	        
 	    int count = rawmaterialsService.getRawmaterialsCount(pageDTO);
 	    int pageBlock = 10;
 	    int startPage=(currentPage-1)/pageBlock*pageBlock+1;
 	    int endPage = startPage + pageBlock -1;
 	    int pageCount = count/pageSize+(count%pageSize==0?0:1);
 	    if(endPage > pageCount) {
 	    	endPage = pageCount;
 	    }
 	    
 	    pageDTO.setCount(count);
 	    pageDTO.setPageBlock(pageBlock);
 	    pageDTO.setStartPage(startPage);
 	    pageDTO.setEndPage(endPage);
 	    pageDTO.setPageCount(pageCount);
 	    model.addAttribute("pageDTO", pageDTO);
 	        
 	    // 품목 추가한 내용 뿌려주기
 	    model.addAttribute("rawmaterialsList", rawmaterialsList);
 		model.addAttribute("pageDTO", pageDTO);
 	    
 	    return "OrderManagement/selectrawmaterials";
 	}
 	
 	// selectclient 페이징처리, 검색기능
  	@GetMapping("/selectclient")
    public String selectclient(HttpServletRequest request,Model model) {
         
  		String search1 = request.getParameter("search1");
 		System.out.println("search1 : " + search1);
 		String search2 = request.getParameter("search2");
 		System.out.println("search2 : " + search2);
 		String search3 = request.getParameter("search3");
 		System.out.println("search3 : " + search3);
 		String search4 = request.getParameter("search4");
 		System.out.println("search4 : " + search4);
  		
        int pageSize = 10;
        String pageNum=request.getParameter("pageNum");
        if(pageNum == null) {
        	pageNum = "1";
        }
         
        int currentPage = Integer.parseInt(pageNum);
        PageDTO pageDTO =new PageDTO();
        pageDTO.setPageSize(pageSize);
        pageDTO.setPageNum(pageNum);
        pageDTO.setCurrentPage(currentPage);
        pageDTO.setSearch1(search1); // 검색어저장
 	    pageDTO.setSearch2(search2);
 	    pageDTO.setSearch3(search3);
 	    pageDTO.setSearch4(search4);
         
        // 거래처 내용 뿌려주기
        List<ClientDTO> clientList= rawmaterialsService.getClientList(pageDTO);
         
        int count = rawmaterialsService.getClientCount(pageDTO);
        int pageBlock = 10;
        int startPage=(currentPage-1)/pageBlock*pageBlock+1;
        int endPage = startPage + pageBlock -1;
        int pageCount = count/pageSize+(count%pageSize==0?0:1);
        if(endPage > pageCount) {
        	endPage = pageCount;
        }
        pageDTO.setCount(count);
        pageDTO.setPageBlock(pageBlock);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setPageCount(pageCount);
        model.addAttribute("pageDTO", pageDTO);
         
        // 거래처 내용 뿌려주기
        model.addAttribute("clientList", clientList);
        model.addAttribute("pageDTO", pageDTO);
         
        return "OrderManagement/selectclient";
     }
	
}