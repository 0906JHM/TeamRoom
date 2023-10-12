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
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.service.RawmaterialsService;

@Controller   
@RequestMapping("/Rawmaterials/*")
public class RawmaterialsController {
	
	// RawmaterialsService 객체생성
	@Inject
	private RawmaterialsService rawmaterialsService;

	// 가상주소 http://localhost:8080/leeweb/Rawmaterials/home
	@GetMapping("/main")
	public String main() {
		return "Rawmaterials/main";
	}
	
	// 가상주소 http://localhost:8080/leeweb/Rawmaterials/home
	// @GetMapping("/home")
	// public String home(Model model) {
					
		// 품목추가한 내용 뿌려주기
		// List<RawmaterialsDTO> rawmaterialsList= rawmaterialsService.getRawmaterialsList();
		// model.addAttribute("rawmaterialsList", rawmaterialsList);
				
		// return "Rawmaterials/home";
	// }
	
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
	        
	    // 품목추가한 내용 뿌려주기
	    model.addAttribute("rawmaterialsList", rawmaterialsList);
		model.addAttribute("pageDTO", pageDTO);
	    
	    return "Rawmaterials/home";
	}
	
	// 가상주소 http://localhost:8080/leeweb/Rawmaterials/insert
	@GetMapping("/insert")
	public String insert() {
		return "Rawmaterials/insert";
	}
	
	// 가상주소 http://localhost:8080/leeweb/Rawmaterials/insertPro
	@PostMapping("/insertPro")
	public String insertPro(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsController insertPro()");
		System.out.println(rawmaterialsDTO);
		rawmaterialsService.insertRawmaterials(rawmaterialsDTO);
		return "redirect:/Rawmaterials/home";
	}

	// 체크박스로 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	rawmaterialsService.delete(ajaxMsg[i]);
        }
        return "redirect:/Rawmaterials/home";
    }
    
    // home에서 원자재코드 클릭시 detail페이지로 이동
    @GetMapping("/detail")
 	public String detail(RawmaterialsDTO rawmaterialsDTO, Model model) {
    	System.out.println("RawmaterialsController detail()");
 		
 		// 원자재코드 잘 들고왔는지 확인
 		System.out.println(rawmaterialsDTO.getRawCode());
 		
 		// 1) rawmaterialsService, rawmaterialsDAO에 getDetail 메서드를 만들어, 들고온 a1에 해당하는 다른 내용 a2, a3 등을 가져오게 하고 => rawmaterialsDTO 변수에 담기
 		rawmaterialsDTO = rawmaterialsService.getDetail(rawmaterialsDTO.getRawCode());
 		// 2) Model을 사용해서 rawmaterialsDTO에 넣은 모든 내용을 보여주기
 		model.addAttribute("rawmaterialsDTO", rawmaterialsDTO);
 		
 		return "Rawmaterials/detail";
 	}
    
 	@GetMapping("/update")
 	public String update(RawmaterialsDTO rawmaterialsDTO, Model model) {
 		System.out.println("RawmaterialsController update()");
 		
 		// 원자재코드 잘 들고왔는지 확인
 	 	System.out.println(rawmaterialsDTO.getRawCode());
 	 	
 	 	// detail 코드내용 재활용
 		rawmaterialsDTO = rawmaterialsService.getDetail(rawmaterialsDTO.getRawCode());
 		model.addAttribute("rawmaterialsDTO", rawmaterialsDTO);
 		
 		return "Rawmaterials/update";
 	}
    
    @PostMapping("/updatePro")
	public String updatePro(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsController updatePro()");
		
		// 수정한내용 잘 들고왔는지 확인
		System.out.println(rawmaterialsDTO);
		
		// insert, update 등은 DB에서 작업하고 끝낼거라 리턴할필요 없음 
		// 따라서 boardDTO = boardService.updateBoard(boardDTO);처럼 boardDTO에 받아올 필요없고, Service랑 DAO에서 void 쓰고 return 안함
		rawmaterialsService.updateRawmaterials(rawmaterialsDTO);
		return "redirect:/Rawmaterials/home";
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
        
        return "Rawmaterials/selectclient";
    }
 	
 	// selectwarehouse 페이징처리, 검색기능
  	@GetMapping("/selectwarehouse")
     public String selectwarehouse(HttpServletRequest request,Model model) {
         
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
         
        // 창고 내용 뿌려주기
        List<WarehouseDTO> warehouseList= rawmaterialsService.getWarehouseList(pageDTO);
         
        int count = rawmaterialsService.getWarehouseCount(pageDTO);
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
         
        // 창고 내용 뿌려주기
        model.addAttribute("warehouseList", warehouseList);
        model.addAttribute("pageDTO", pageDTO);
         
        return "Rawmaterials/selectwarehouse";
    }
 	
}