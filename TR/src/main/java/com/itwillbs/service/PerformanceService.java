package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.PerformanceDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PerformanceService {
	
	@Inject
	private PerformanceDAO perfDAO;

}
