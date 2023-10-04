package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.service.EmployeesService;

@Controller
@RequestMapping("/employees/*")
public class EmployeesController {
	
	@Inject
	private EmployeesService employeesService;

	@GetMapping("/employees")
	public String employees(Model model) {	
		List<EmployeesDTO> employeesList= employeesService.getEmployeesList();
		model.addAttribute("employeesList", employeesList);
		return "employees/employees";	
	}
	
	@GetMapping("/employees2")
	public String employees2() {	
		return "employees/employees2";	
	}
	
	@PostMapping("/insertPro")
	public String insertPro(EmployeesDTO employeesDTO) {
		employeesService.insertEmployees(employeesDTO);
		return "redirect:/employees/employees";
	}
	
	// 게시물 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {

        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	employeesService.delete(ajaxMsg[i]);
        }
        return "redirect:/employees/employees";
    }
	
	
	
	
	
	
	
}
