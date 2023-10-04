package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.ClientService;

@Controller
@RequestMapping("/client/*")
public class ClientController {
	
	@Inject
	private ClientService clientService;
	
	@GetMapping("/client")
	public String client() {
		
		return "client/client";
		
	}
	
	@PostMapping("/insertPro")
	public String insert(ClientDTO clientDTO) {
		
		System.out.println("ClientController insertPro요청");
		System.out.println(clientDTO);
		clientService.insertClient(clientDTO);
		
		return "redirect:/client/client";
	}
	
	
	

}
