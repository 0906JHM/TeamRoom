package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.service.OutProductService;

@Controller
@RequestMapping("/outProduct/*")
public class OutProductController {

	@Inject
	private OutProductService outProductService;
	
	@GetMapping("/list")
	public String outProductList(Model model) {
//		List<OutProductDTO> outProductList = outProductService.getOutProductList();
//		
//		model.addAttribute("outProductList", outProductList);
		
		return "outProduct/outProduct";
	}
	
	@GetMapping("/outProductContent")
	public String outProductContent(HttpServletRequest request, Model model) {
		
		String outCode = request.getParameter("outCode");
		
		OutProductDTO outProductDTO = outProductService.outProductContent(outCode);
		
		model.addAttribute("outProductDTO",outProductDTO);
		
		return "outProduct/outProductContent";
	}
}
