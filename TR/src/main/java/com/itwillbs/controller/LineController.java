package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.service.LineService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/line/*")
public class LineController {
	
	@Inject
	private LineService lineService;
	
	@GetMapping("/line")
	public String line(Model model) {
		
		System.out.println("LineController line 메인페이지 요청");
		log.debug("LineController line 메인페이지 요청");
		
		
		return "line/line";
		
	}
	

}
