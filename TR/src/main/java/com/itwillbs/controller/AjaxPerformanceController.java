package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.service.PerformanceService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/perfajax")
public class AjaxPerformanceController {

	@Inject
	PerformanceService perfService;

	@PostMapping("/delete")
	public ResponseEntity<String> perfdelete (@RequestParam("perfCode") String perfCode) {

		log.debug("perfDelete 요청");

		// 삭제 로직 수행
	    boolean success = perfService.perfdelete(perfCode);
	    System.out.println(success);

	    if (success) {
	        return ResponseEntity.ok("삭제 성공");
	    } else {
	        return ResponseEntity.status(500).body("삭제 실패"); // 실패 응답, 500은 서버 오류 코드
	    }
	}
	
	/*
	 * @PostMapping("/ajaxinsert") public ResponseEntity<String> ajaxinsert (
	 * PerformanceDTO perfDTO ) { log.debug("perfInsert요청");
	 * 
	 * boolean success = perfService.perfinsert(perfDTO);
	 * System.out.println(success); if (success) { return
	 * ResponseEntity.ok("등록 성공");
	 * 
	 * } else {
	 * 
	 * return ResponseEntity.status(500).body("등록 실패"); // 실패 응답, 500은 서버 오류 코드 } }
	 */
	
	@PostMapping("/perfdonut")
	public ResponseEntity<List<PerformanceDTO>> getdonut(@RequestBody List<String> lineCode) {
		 System.out.println("Line Codes: " + lineCode);
	    List<PerformanceDTO> getdonutdata = perfService.getdonut(lineCode);
	    log.debug("가져오는값:"+ lineCode);
	    return ResponseEntity.ok(getdonutdata);
	    

	}
	
	@PostMapping("/updatePro")
	public String perfupdate(PerformanceDTO perfDTO) {
		System.out.println("실적 업데이트 데이터 "+perfDTO);
		System.out.println("실적 업데이트 데이터 "+perfDTO);
		System.out.println("실적 업데이트 데이터 "+perfDTO);
		System.out.println("실적 업데이트 데이터 "+perfDTO);
//		try {
//			
////			perfService.updateperf(perfDTO);
//			
//			return new ResponseEntity<>("true", HttpStatus.OK); // 성공 시 "true" 반환
//			
//		} catch (Exception e) {
//			 return new ResponseEntity<>("false: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//			
//		}
		return "true";
	}
}
	

	