package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.EmployeesService;
import com.itwillbs.service.PerformanceService;
import com.itwillbs.service.ProdService;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/perf/*")
public class PerformanceController {
	
	@Inject
	private PerformanceService perfService;
	
	@Inject
	private ProdService prodService;
	
	@Inject
	private EmployeesService empService;
	
	private String cont="PerformanceController";
	
	
	@GetMapping("/perf")
	public String perf(Model model) {
		
		System.out.println("PerformanceController perf메인페이지요청");
		log.debug(cont+"메인페이지요청");
		
		/*
		 * List<ClientDTO> clientList = clientService.getclientList();
		 * 
		 * 
		 * model.addAttribute("clientList",clientList);
		 */
		
		return "perf/perf";
		
	}
	
	@GetMapping("/perfinsert")
	public String perfInsert(Model model) {
		
		System.out.println("PerformanceController perf추가페이지요청");
		log.debug("PerformanceController perf추가페이지요청 ");
		
		/*
		 * List<ClientDTO> clientList = clientService.getclientList();
		 * 
		 * 
		 * model.addAttribute("clientList",clientList);
		 * 
		 */
		
		return "perf/perfinsert";
		
		
	}
	
	
	
	
	

}
