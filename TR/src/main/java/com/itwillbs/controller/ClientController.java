package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.ClientService;

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
	
	@GetMapping("/clientinsert")
	public String client() {
		
		log.debug("거래처추가 새창 ");
		
		return "client/clientinsert";
		
	}
	

	
	@PostMapping("/insertPro")
	public String insert(ClientDTO clientDTO) {
		
		System.out.println("ClientController insertPro요청");
		log.debug("거래처추가로직");
		System.out.println(clientDTO);
		clientService.insertClient(clientDTO);
		
		return "redirect:/client/client";
	}
	
	
	

}
