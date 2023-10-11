package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InMaterialDAO;
import com.itwillbs.domain.InMaterialDTO;

@Service
public class InMaterialService {
	@Inject
	private InMaterialDAO inMaterialDAO;

	public List<InMaterialDTO> getInMaterialList() {
		return inMaterialDAO.getInMaterialList();
	}
}
