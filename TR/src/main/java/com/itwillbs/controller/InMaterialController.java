package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.InMaterialDTO;
import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.service.InMaterialService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/inMaterial/*")
@Slf4j
public class InMaterialController {

	@Inject
	private InMaterialService inMaterialService;
//--------------------------------------------------------------
	
//	출고 페이지 이동 -> ajaxOutProductController에서 ajax로 리스트 불러오게 할려고 
	@GetMapping("/list")
	public String getInMaterialList(Model model) {
		
		  log.debug("호출한 곳");
//			List<OutProductDTO> outProductList = outProductService.getOutProductList();
//			
//			model.addAttribute("outProductList", outProductList);
		 
		return "inMaterial/inMaterial";
	}
	
}
