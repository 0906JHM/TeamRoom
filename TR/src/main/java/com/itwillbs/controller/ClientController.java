package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.service.ClientService;
import com.itwillbs.service.RawmaterialsService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/client/*")
public class ClientController {	 
	
	@Inject
	private ClientService clientService;
	
	
	
	
	@GetMapping("/client")
	public String client(Model model,HttpServletRequest request,ClientDTO clientDTO) {
		
System.out.println("BoardController list()");
		
		//검색어 가져오기
		String search = request.getParameter("search");
		
		// <----------------------------------->
		// 한 화면에 보여줄 글 개수 
		int pageSize = 10;
		
		// 현 페이지 번호 가져오기
		String pageNum=request.getParameter("pageNum");
		//페이지 번호가 없을 경우에는 1로 설정
		if (pageNum == null ) {
			pageNum = "1";
		}
		
		// 페이지 번호 => 정수형 변경
		int currentPage = Integer.parseInt(pageNum);
		
		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		
		
		pageDTO.setSearch(search);
		
		List<ClientDTO> clientList;
		int count;
		if (clientDTO.getClientCode() != null || clientDTO.getClientName() != null || clientDTO.getClientCompany() != null) {
		clientList = clientService.getSearch(clientDTO, pageDTO);
		count = clientService.getSearchcount(clientDTO);
	
		}
		else {
			clientList = clientService.getclientList(pageDTO);
			count = clientService.getclientCount(pageDTO);
		}

		
		int pageBlock = 10;
		// 시작하는 페이지 번호
		int startPage = (pageDTO.getCurrentPage()-1)/pageBlock*pageBlock+1;
		// 끝나는 페이지 번호
		int endPage = startPage + pageBlock -1;
		
		//전체페이지 개수 
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		// 끝나는 페이지 번호 전체 페이지 개수 비교 
		
		if(endPage > pageCount ) {
			
			endPage= pageCount;
			
		}
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		
		
		System.out.println("ClientController client");
		log.debug("거래처리스트출력");
		
	    
		
		model.addAttribute("clientList",clientList);
		
		return "client/client";
		
		
		
	}
	
	
	@GetMapping("/clientinsert") // 거래처 추가 페이지
	public String client() {
		
		log.debug("거래처추가 새창 ");
		
		return "client/clientinsert";
		
	}
	

	
	@PostMapping("/insertPro") // 거래처추가 로직
	public void insert(ClientDTO clientDTO) {
		
		System.out.println("ClientController insertPro요청");
		log.debug("거래처추가로직");
		System.out.println(clientDTO);
		clientService.insertClient(clientDTO);
		
	}
	
	@ResponseBody
	@GetMapping("/getclientCode") // 수주처 발주처 코드 받아오기
	public String getclientCode(String clientType) {
		

		 log.debug(clientType);
		 System.out.println("clientController getclientCode++++++++++++++++++" + clientType);
		 
		 clientService.getclientCode(clientType);
		 String clientCode = clientService.getclientCode(clientType);
		 
		 System.out.println("clientController getClientCode 반환값 : ++++++++" + clientCode);
		 
		return clientCode;
	}
	
	@GetMapping("/clientdetail") // 해당 거래처 내용 출력
	public String clientdetail(HttpServletRequest req , Model model) {
		
		String clientCompany = req.getParameter("clientCompany");
		ClientDTO clientDTO = clientService.clientdetail(clientCompany);
		model.addAttribute("clientDTO",clientDTO);
		
		String clientCode = req.getParameter("clientCode");		
		// clientCode에 따라 분기 처리
		 if (clientCode != null && clientCode.startsWith("CL")) {
		        // CL로 시작하는 경우 sell 테이블 데이터 가져오기
		        ProdDTO prodDTO = clientService.selldetail(clientCode);
		        model.addAttribute("prodDTO", prodDTO);
		    } else if (clientCode != null && clientCode.startsWith("OR")) {
		        // OR로 시작하는 경우 rawMaterial 테이블 데이터 가져오기
		        RawmaterialsDTO rawmaterialsDTO = clientService.rawmaterialsdetail(clientCode);
		        model.addAttribute("rawmaterialsDTO", rawmaterialsDTO);
		    }
		 
		return "client/clientdetail";
	}
	
	@GetMapping("/clientupdate")
	public String clientupdate(HttpServletRequest req , Model model) {
		
		String clientCompany = req.getParameter("clientCompany");
		
		ClientDTO clientDTO = clientService.clientdetail(clientCompany);
		
		model.addAttribute("clientDTO",clientDTO);
		
		return "client/clientupdate";
		
	}
	
	@PostMapping("/clientupdatePro")
	public void clinetupdatePro(ClientDTO clientDTO) {
		
		System.out.println("ClientController updatePro요청");
		log.debug("거래처추가로직");
		System.out.println(clientDTO);
		clientService.clientupdate(clientDTO);
		
	}
	
	@GetMapping("/delete")
	public String clientdelete(String clientCompany) {
		System.out.println("ClientController delete요청");
		clientService.clientdelete(clientCompany);
		
		return "redirect:/client/client";
	}
	
	

}
