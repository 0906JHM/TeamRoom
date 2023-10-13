package com.itwillbs.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ExcepctionController {
	
	@ExceptionHandler(Exception.class)
	public void exceptionHandler(Exception e) {
		log.error("예외 발생!!" + e );
		e.printStackTrace();
	}

}

