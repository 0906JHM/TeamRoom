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

	public void updateSellState(OutProductDTO outProductDTO) {
		outProductDAO.updateSellState(outProductDTO);
	}

	public void updateOutDate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutDate(outProductDTO);
	}

	public void updateOutRedate(OutProductDTO outProductDTO) {
		outProductDAO.updateOutRedate(outProductDTO);
	}

	public void updateWhseCount(OutProductDTO outProductDTO) {
		outProductDAO.updateWhseCount(outProductDTO);
	}

	public void updateOutProductContent(OutProductDTO outProductDTO) {
		outProductDAO.updateOutProductContent(outProductDTO);
	}

}
