package com.itwillbs.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@PostMapping("/outProductUpdate")
	public void outProductUpdate(OutProductDTO outProductDTO, HttpServletResponse response){
//		디비에 저장된 outProductDTO2 		업데이트된 내용이 들어있는 outProductDTO
		OutProductDTO outProductDTO2 = outProductService.outProductContent(outProductDTO.getOutCode());

//		sellState 변경
		if(outProductDTO.getOutCount() < outProductDTO.getWhseCount()) {
			if(outProductDTO.getOutCount() == 0) {
				outProductDTO.setSellState("미출고");
			}else {
				outProductDTO.setSellState("중간납품");
			}
		}else if(outProductDTO.getOutCount() == outProductDTO.getWhseCount()) {
			outProductDTO.setSellState("출고완료");
		}

		outProductService.updateSellState(outProductDTO);

//		현재 시간을 Timestamp로 가져오기
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		
//		Timestamp를 Date로 변환
        Date currentDate = new Date(currentTime.getTime());
        
//      Date를 원하는 형식의 문자열로 변환
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String current = dateFormat.format(currentDate);

//      중간납품이 아니면 출고일세팅
        if(outProductDTO.getOutDate() == null || "".equals(outProductDTO.getOutDate())) {
			outProductDTO.setOutDate(current);
			outProductService.updateOutDate(outProductDTO);
		}else {
			outProductDTO.setOutRedate(current);
			outProductService.updateOutRedate(outProductDTO);
		}
//      3차 출고 테이블 출고개수 출고비고 업데이트  / 나중에 담당자도 업뎃 
        outProductService.updateOutProductContent(outProductDTO);
        
//      4차
//      재고 테이블에서 제품코드로 출고한만큼 개수 감소
        if(outProductDTO2.getOutCount() < outProductDTO.getOutCount()) {
        	outProductDTO.setOutCount(outProductDTO.getOutCount() - outProductDTO2.getOutCount() );
        	outProductService.updateWhseCount(outProductDTO);
        }
        
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("window.opener.location.reload();");
			out.println("window.close();");
			out.println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		System.out.println("아아아아");
	}
}
