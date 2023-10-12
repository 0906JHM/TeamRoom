package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.PerformanceDAO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PerformanceService {
	
	@Inject
	private PerformanceDAO perfDAO;
	
	public List<PerformanceDTO> perflist() {
		
		return perfDAO.getperflist();
	}

	public List<LineDTO> getlinelist() {
		
		return perfDAO.getlinelist();
	}

	public List<ProdDTO> getprodList() {
		
		return perfDAO.getprodlist();
	}

	public List<WorkOrderDTO> getworkList() {
	
		return perfDAO.getworklist();
	}

	public void perfinsert(PerformanceDTO perfDTO) {
		
		perfDAO.perfinsert(perfDTO);
		
	}

	public PerformanceDTO getdetail(String perfCode) {
		
		return perfDAO.getdetail(perfCode);
	}

	



}
