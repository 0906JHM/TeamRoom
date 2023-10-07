package com.itwillbs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.service.ProdServiceImpl;

@Controller
@RequestMapping("/product/*")
public class ProdController2 {
	@Inject // 프로덕트 서비스 의존성 주입
	private ProdServiceImpl prodService;

	@PostMapping("/delete")
	public String productDelete(@RequestParam("selectedProId") String[] selectedProId) {
		
		System.out.println("삭제 컨트롤러ㅜㅜ");
		// 다중 삭제를 위한 리스트 형식의 맵 타입 배열 변수선언
		List<Map<String, String>> codeAndTypeList = new ArrayList<>();
		
		// DB에서 원자재와 완제품을 구분하기위해 맵형태 배열에 키값을 추가하고 조건문에 들어갈 품목번호를 입력한다
		for (String a : selectedProId) {
			
			// 맵 타입 배열 객체생성
		    Map<String, String> codeAndType = new HashMap<>();
		    
		    // 품목번호를 삽입한다
		    codeAndType.put("code", a);
		    // 원자재와 완제품을 구분하기위한 코드를 삽입한다 = R0001 = R(원자재)
		    codeAndType.put("type", a.substring(0,1));
		    // 리스트 배열에 맵 배열을 삽입한다
		    codeAndTypeList.add(codeAndType);
		}
		
		return Boolean.toString(prodService.productDelete(codeAndTypeList));
	}
}
