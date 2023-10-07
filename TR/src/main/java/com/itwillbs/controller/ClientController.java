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
	public String client(Model model) {
		
		System.out.println("ClientController client");
		log.debug("거래처리스트출력");
		
	    List<ClientDTO> clientList = clientService.getclientList();
		
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
