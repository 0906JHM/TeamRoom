package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.PerformanceDAO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.ProdDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PerformanceService {
	
	@Inject
	private PerformanceDAO perfDAO;

	public List<LineDTO> getlinelist() {
		
		return perfDAO.getlinelist();
	}

	public List<ProdDTO> getprodList() {
		
		return perfDAO.getprodlist();
	}



}
