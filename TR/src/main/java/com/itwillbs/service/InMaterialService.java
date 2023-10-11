package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InMaterialDAO;

@Service
public class InMaterialService {
	@Inject
	private InMaterialDAO inMaterialDAO;
}
