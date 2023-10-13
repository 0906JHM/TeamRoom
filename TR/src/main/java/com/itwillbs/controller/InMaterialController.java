package com.itwillbs.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

	// 입고처리 버튼 => 입고상태, 담당자, 날짜 업데이트해야함
	@PostMapping("/inMaterialUpdate")
	@ResponseBody
	public void inMaterialUpdate(@RequestBody InMaterialDTO inMaterialDTO, HttpServletRequest response) {
		System.out.println("inMaterialController inMaterialUpdate");
		
		inMaterialService.inMaterialContent(inMaterialDTO.getInNum());

		//미입고 => 입고완료
		inMaterialService.updateInState(inMaterialDTO);
		
		// 현재 시간을 Timestamp로 가져오기
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		// Timestamp를 Date로 변환
					Date currentDate = new Date(currentTime.getTime());
		// Date를 원하는 형식의 문자열로 변환
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String current = dateFormat.format(currentDate);
		//입고일 세팅
		inMaterialDTO.setInDate(current);
		//입고일 업데이트
		inMaterialService.updateInDate(inMaterialDTO);
		
		//재고 테이블에서 원자재코드로 입고한만큼 개수 증가
		inMaterialService.updateWhseCount(inMaterialDTO);

//		response.setContentType("text/html;charset=UTF-8");
//		PrintWriter out;
		
		
	}




}
