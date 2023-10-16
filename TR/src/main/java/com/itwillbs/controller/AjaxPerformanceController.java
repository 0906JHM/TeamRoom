package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
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
	
	@RequestMapping(value = "/perf/pielist", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> pielist(@RequestParam("lineCode") String lineCode) {
		List<ChartDTO> pielist = perfService.getpileList(lineCode);
		
		ResponseEntity<List<ChartDTO>> entity = new ResponseEntity<>(pielist, HttpStatus.OK);
		
		return entity;
		
	}
}
		
