package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OutProductDAO;
import com.itwillbs.domain.OutProductDTO;

@Service
public class OutProductService {

	@Inject
	private OutProductDAO outProductDAO;
	
	public List<OutProductDTO> getOutProductList(OutProductDTO outProductDTO) {
		return outProductDAO.getOutProductList(outProductDTO);
	}

	public OutProductDTO outProductContent(String outCode) {
		return outProductDAO.outProductContent(outCode);
	}

}
