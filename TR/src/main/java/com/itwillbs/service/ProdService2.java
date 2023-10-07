package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

	
	
@Service
public interface ProdService2 {
	// 품목 삭제
		public boolean productDelete(List<Map<String, String>> codeAndTypeList);

}
