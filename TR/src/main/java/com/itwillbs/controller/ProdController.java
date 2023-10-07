package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ProdDTO;
import com.itwillbs.service.ProdService;
import com.itwillbs.service.ProdServiceImpl;

@Controller
@RequestMapping("/product/*")
public class ProdController {

	@Inject
	private ProdService prodService;
	

	
	@GetMapping("/list")
	public String list(Model model) {
		System.out.println("1");
		List<ProdDTO> prodList= prodService.getProdList();
				
		model.addAttribute("prodList", prodList);

		// member/list.jsp
		// WEB-INF/views/member/list.jsp
		return "product/list";
	}//
	
	
	@GetMapping("/write")
	public String write() {
		return "product/write";
	}//
	
	@PostMapping("/writePro")
	public String writePro(ProdDTO prodDTO) {
		
		System.out.println("ProdController writePro()");
		System.out.println(prodDTO);
		//디비에 글쓰기
		prodService.insert(prodDTO);
		
		// 글목록 주소변경하면서 이동 /board/list
		return "redirect:/product/list";
	}//
	
	@GetMapping("/search")
	public String search(ProdDTO prodDTO, Model model) {
		System.out.println(prodDTO);
	    List<ProdDTO> prodList = prodService.getSearch(prodDTO);
	    System.out.println("controller search");
	    model.addAttribute("prodList", prodList);
		return "product/list";
	}
	

	
//	@GetMapping("/list")
//	public String roomair(ProdDTO prodDTO, Model model) {
//	    List<ProdDTO> prodList = prodService.getProdSearch(prodDTO);
//	    System.out.println("controller");
//	    model.addAttribute("prodList", prodList);
//	    return "product/list";
//	}
	
//	@GetMapping("/list")
//	public void getProdList(Model model, ProdDTO prodDTO) {
//		System.out.println("ProdController getProdList");
//		List<ProdDTO> prodList = new ArrayList<ProdDTO>();
//		model.addAttribute("prodList", prodList);
//		
//		if (prodDTO.getProdCode() != null || prodDTO.getProdName() != null || prodDTO.getClientCode() != null ) {
////			int total = prodService.countProd(prodDTO);
////			pvo = new PagingVO(total, pvo.getNowPage(), pvo.getCntPerPage());
////			List<ProdDTO> pordList = prodService.getProdList(prodDTO);//(prodDTO, pvo)페이지 디티오
//			model.addAttribute("prodList", prodList);
////			model.addAttribute("paging", pvo);
//			model.addAttribute("prodDTO", prodDTO);
//
//
////			if (input != null && !input.equals("")) {
////				model.addAttribute("input", input);
////				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
////			}
//		} else {
////			int total = prodService.countProd();
////			pvo = new PagingVO(total);
////			logger.debug("pvo : " + pvo);
////			List<ProductVO> list = service.getProdList(pvo);
////			model.addAttribute("prodList", list);
////			model.addAttribute("paging", pvo);
////			logger.debug(" 모든 리스트 가져감");
//		}
//		
//	}
	
}
