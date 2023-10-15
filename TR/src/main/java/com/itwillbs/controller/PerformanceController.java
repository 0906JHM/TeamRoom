package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;
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
		  log.debug("메인페이지  실적코드 요청"); 
		  List<PerformanceDTO> perflist =perfService.perflist();
		  
		  
		  log.debug("반환값"+perflist);
		  model.addAttribute("perflist",perflist); 

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
	
	@GetMapping("/linelist")
	public String linelist(Model model) {
		
		
		log.debug("팝업창 linelist 요청 ");
        List<LineDTO> linelist = perfService.getlinelist();
		
        model.addAttribute("linelist",linelist);
        System.out.println(linelist);
		
		return "perf/linelist";
		
		
	}
	
	@GetMapping("/prodlist")
	public String prodlist(Model model) {
		

		log.debug("팝업창 prodlist 요청 ");
		
        List<ProdDTO> prodlist = perfService.getprodList();
		model.addAttribute("prodlist",prodlist);
		System.out.println(prodlist);
		
		return "perf/prodlist";
		
		
	}
	
	@GetMapping("/worklist")
	public String worklist(Model model) {
		

		log.debug("팝업창 prodlist 요청 ");
		
        List<WorkOrderDTO> worklist = perfService.getworkList();
		model.addAttribute("worklist",worklist);
		System.out.println(worklist);
		
		return "perf/worklist";
		
		
	}
	
@PostMapping("/perfinsertPro")
public String perfinsert(PerformanceDTO perfDTO, HttpServletRequest req) {
	
	log.debug("insertPro요청");
	log.debug("받은 값:"+perfDTO);

	String perfDefect = req.getParameter("perfDefect");
	System.out.println("+++++++++++++++++++++++:"+perfDefect);
	perfService.perfinsert(perfDTO);
	
	return "redirect:/perf/perfinsert";
	
	
}

@GetMapping("/detail")
public String perfdetail ( HttpServletRequest req , Model model ) {
	        
	String perfCode=req.getParameter("perfCode");
	log.debug(perfCode);
	System.out.println("@@@@@@@@@@@@@@:"+perfCode);
	PerformanceDTO perfDTO = perfService.getdetail(perfCode);
	model.addAttribute("perfDTO",perfDTO);

	return "perf/perfdetail";
}

@GetMapping("/perfupdate")
public String perfupdate(HttpServletRequest req ,Model model) {
	
	String perfCode=req.getParameter("perfCode");
	PerformanceDTO perfDTO = perfService.getdetail(perfCode);
	model.addAttribute("perfDTO",perfDTO);
	
	return "perf/perfupdate";
	
	
}

@PostMapping("/updatePro")
public String perfupdatePro(PerformanceDTO perfDTO) {
	
	System.out.println("받아오는값++++++++++++++"+perfDTO);
	perfService.perfupdate(perfDTO);
	
	return "redirect:/perf/perf";
	
}

	

	
	

	
	
	
	
	

}
