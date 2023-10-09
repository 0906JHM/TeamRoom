package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.LoginDTO;
import com.itwillbs.service.LoginService;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Inject
	private LoginService loginService;
	
//------------------------------------------------------- login ----------------------------------------------------
	@GetMapping("/login")
	public String login() {
		
		return "login/login";
	}//login

	@PostMapping("/loginPro")
	public String loginPro(LoginDTO loginDTO, HttpSession session) {
		System.out.println("LoginController loginPro()");
		
		System.out.println(loginDTO);
		
		loginDTO = loginService.userCheck(loginDTO);
		
		if(loginDTO != null) {
			session.setAttribute("EmpId", loginDTO.getEmpId());
			return "redirect:/sell/sellMain";
		}else {
			return "redirect:/main/calendar";
		}
	}//loginPro

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();

		return "redirect:/login/login";
	}//
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
