package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.service.ProdService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product/*")
public class ProdController {

	@Inject
	private ProdService prodService;

	// 소요량관리 정보 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String productDelete(@RequestParam(value = "checked[]") List<String> checked) throws Exception {

		// 서비스 - 소요량관리 삭제
		prodService.productDelete(checked);

		return "redirect:/product/list";
	}

	@GetMapping("/list")
	public String list(ProdDTO prodDTO, Model model, HttpServletRequest request) {
		System.out.println("1");

		//검색어 가져오기
		// 페이징-------------------------------------------
		// 한 화면에 보여줄 글개수 설정
		int pageSize = 10;
		// 현 페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		// 페이지 번호가 없을 경우 => "1"로 설정
		if (pageNum == null) {
			pageNum = "1";
		}

		// 페이지 번호 => 정수형 변경
		int currentPage = Integer.parseInt(pageNum);

		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		
		List<ProdDTO> prodList;
		int count;
		if (prodDTO.getProdCode() != null || prodDTO.getProdName() != null || prodDTO.getClientCompany() != null) {
		prodList = prodService.getSearch(prodDTO, pageDTO);
		count = prodService.getSearchcount(prodDTO);
	
		}
		else {
			prodList = prodService.getProdList(pageDTO);
			count = prodService.getProdCount(pageDTO);
		}

		// 전체 글개수 가져오기
		
		
		
		
		
		// 한화면에 보여줄 페이지 개수 설정
		int pageBlock = 10;
		// 시작하는 페이지 번호
		int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
		// 끝나는 페이지 번호
		int endPage = startPage + pageBlock - 1;
		// 전체페이지 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 끝나는 페이지 번호 전체페이지 개수 비교
		// => 끝나는 페이지 번호가 크면 전체페이지 개수로 변경
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);

		model.addAttribute("prodList", prodList);
		model.addAttribute("pageDTO", pageDTO);
		
		// member/list.jsp
		// WEB-INF/views/member/list.jsp
		return "product/list";
	}//

	@GetMapping("/write")
	public String write(Model model) {
		String code = prodService.makeCode();
		ProdDTO prodDTO = new ProdDTO();
		prodDTO.setProdCode(code);
		model.addAttribute("prodDTO",prodDTO);
		return "product/write";
	}//

	@PostMapping("/writePro")
	public String writePro(ProdDTO prodDTO) {

		System.out.println("ProdController writePro()");
		System.out.println(prodDTO);
		// 디비에 글쓰기
		prodService.insert(prodDTO);

		// 글목록 주소변경하면서 이동 /board/list
		return "redirect:/product/list";
	}//

	/*
	 * @GetMapping("/search") public String search(ProdDTO prodDTO, Model
	 * model,HttpServletRequest request) {
	 * 
	 * 
	 * 
	 * int pageSize = 1; // 현 페이지 번호 가져오기 String pageNum =
	 * request.getParameter("pageNum"); // 페이지 번호가 없을 경우 => "1"로 설정 if (pageNum ==
	 * null) { pageNum = "1"; }
	 * 
	 * // 페이지 번호 => 정수형 변경 int currentPage = Integer.parseInt(pageNum);
	 * 
	 * PageDTO pageDTO = new PageDTO(); pageDTO.setPageSize(pageSize);
	 * pageDTO.setPageNum(pageNum); pageDTO.setCurrentPage(currentPage); // 전체 글개수
	 * 가져오기
	 * 
	 * int count = prodService.getSearchcount(prodDTO); List<ProdDTO> prodList =
	 * prodService.getSearch(prodDTO, pageDTO); model.addAttribute("prodList",
	 * prodList);
	 * 
	 * 
	 * // 한화면에 보여줄 페이지 개수 설정 int pageBlock = 10; // 시작하는 페이지 번호 int startPage =
	 * (currentPage - 1) / pageBlock * pageBlock + 1; // 끝나는 페이지 번호 int endPage =
	 * startPage + pageBlock - 1; // 전체페이지 개수 int pageCount = count / pageSize +
	 * (count % pageSize == 0 ? 0 : 1); // 끝나는 페이지 번호 전체페이지 개수 비교 // => 끝나는 페이지 번호가
	 * 크면 전체페이지 개수로 변경 if (endPage > pageCount) { endPage = pageCount; }
	 * 
	 * pageDTO.setCount(count); pageDTO.setPageBlock(pageBlock);
	 * pageDTO.setStartPage(startPage); pageDTO.setEndPage(endPage);
	 * pageDTO.setPageCount(pageCount);
	 * 
	 * model.addAttribute("prodList", prodList); model.addAttribute("pageDTO",
	 * pageDTO); return "product/list"; }
	 */

	@GetMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("prodController update()");
		String prodCode = request.getParameter("prodCode");

		// 내용가져오기
		ProdDTO prodDTO = prodService.getProd(prodCode);

		model.addAttribute("prodDTO", prodDTO);

		return "product/update";
	}

	@PostMapping("/updatePro")
	public String updatePro(ProdDTO prodDTO) {
		System.out.println("ProdController updatePro()");
		// 수정
		prodService.updateProd(prodDTO);

		return "redirect:/product/list";
	}//

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
