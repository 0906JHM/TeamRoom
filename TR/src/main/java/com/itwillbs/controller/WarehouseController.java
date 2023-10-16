package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.service.WarehouseService;

@Controller
@RequestMapping("/Warehouse/")
public class WarehouseController {
	
	// WarehouseService 객체생성
	@Inject
	private WarehouseService warehouseService;
	
	@GetMapping("/list")
	public String list(HttpServletRequest request , Model model) {
		
		// 페이징
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
		
		List<WarehouseDTO> warehouseList = warehouseService.getWarehouseList(pageDTO);
		
		int count = warehouseService.getWarehouseCount(pageDTO);
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
		
		model.addAttribute("warehouseList",warehouseList);
		model.addAttribute("pageDTO", pageDTO);
		
		return "warehouse/list";
	} // list
	
	@GetMapping("/write")
	public String write() {
		return "warehouse/write";
	} // write
	
	@PostMapping("/writePro")
	public String writePro(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseController writePro()");
		// 글쓰기
		warehouseService.insertWarehouse(warehouseDTO);
		// 주소 변경 후 이동
		return "redirect:/warehouse/list";
	} // writePro
	
	@GetMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("WarehouseController update()");
		
		String whseCode = request.getParameter("whseCode");
		
		WarehouseDTO warehouseDTO = warehouseService.getWarehouse(whseCode);
		model.addAttribute("warehouseDTO", warehouseDTO);
		
		return "warehouse/update";
	} // update
	
	@PostMapping("/updatePro")
	public String updatePro(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseController updatePro()");
		System.out.println(warehouseDTO);
		//  게시판 글 수정
		warehouseService.updateWarehouse(warehouseDTO);
		return "redirect:/warehouse/list";
	} // updatePro
	
	// 체크박스로 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	warehouseService.delete(ajaxMsg[i]);
        }
        return "redirect:/Warehouse/list";
    }

}
