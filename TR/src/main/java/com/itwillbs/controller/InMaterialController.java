package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.service.InMaterialService;

@Controller
@RequestMapping("/inMaterial/*")
public class InMaterialController {

	@Inject
	private InMaterialService inMaterialService;
	
	@GetMapping("/list")
	public String list(Model model, HttpServletRequest request) {
		return "inMaterial/list";
	}
}
