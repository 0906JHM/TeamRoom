package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

public interface ProdDAO2 {
	// 품목 삭제
		public boolean productDelete(List<Map<String, String>> codeAndTypeList);
}
