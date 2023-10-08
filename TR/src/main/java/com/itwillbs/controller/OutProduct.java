package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/outProduct/*")
public class OutProduct {

	@GetMapping("/list")
	public String outProductList() {
		
		return "outProduct/outProduct";
	}
}
