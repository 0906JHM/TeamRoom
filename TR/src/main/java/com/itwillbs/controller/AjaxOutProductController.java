package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.service.OutProductService;

@RestController
@RequestMapping("/outProduct/*")
public class AjaxOutProductController {
	
	@Inject
	private OutProductService outProductService;
	
	@RequestMapping(value = "/listSearch", method = RequestMethod.POST)
	public ResponseEntity<List<OutProductDTO>> SalesList(OutProductDTO outProductDTO) {
		System.out.println(outProductDTO);
		List<OutProductDTO> outProductList = outProductService.getOutProductList(outProductDTO);

		ResponseEntity<List<OutProductDTO>> entity = new ResponseEntity<>(outProductList, HttpStatus.OK);
	    return entity;
	}
}
