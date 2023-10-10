package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.LineDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LineService {
	
	@Inject
	private LineDAO lineDAO;
	

}
