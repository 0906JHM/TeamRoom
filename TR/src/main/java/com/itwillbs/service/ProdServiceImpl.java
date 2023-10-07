package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ProdDAOImpl;

@Service
public class ProdServiceImpl implements ProdService2 {
	@Inject //DAO 의존성 주입
	private ProdDAOImpl prodDAO;
	
	@Override
	public boolean productDelete(List<Map<String, String>> codeAndTypeList) {
		
		
		return prodDAO.productDelete(codeAndTypeList);
	}
}