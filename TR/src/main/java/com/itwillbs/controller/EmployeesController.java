package com.itwillbs.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.EmployeesService;

@Controller
@RequestMapping("/employees/*")
public class EmployeesController {
	
	@Inject
	private EmployeesService employeesService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/employees")
	public String employees(HttpServletRequest request,Model model) {
		String search = request.getParameter("search");
		int pageSize = 10;
		String pageNum=request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		PageDTO pageDTO =new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch(search);
		List<EmployeesDTO> employeesList= employeesService.getEmployeesList(pageDTO);
		int count = employeesService.getEmployeesCount(pageDTO);
		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("employeesList", employeesList);
		return "employees/employees";	
	}
	
	@GetMapping("/employees2")
	public String employees2() {	
		return "employees/employees2";	
	}
	
	@PostMapping("/insertPro")
	public String insertPro(EmployeesDTO employeesDTO,HttpServletRequest request, MultipartFile file) throws Exception{
		UUID uuid = UUID.randomUUID();
		String filename=uuid.toString()+"_"+file.getOriginalFilename();
		FileCopyUtils.copy(file.getBytes(), new File(uploadPath,filename) );
		employeesDTO.setEmpFile(filename);
		
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
    }//delete
    
    // 인사수정
	@GetMapping("/update")
	public String update(HttpServletRequest request,Model model) {
		String empId = request.getParameter("empId");
		EmployeesDTO employeesDTO = employeesService.getMember(empId);
		model.addAttribute("employeesDTO", employeesDTO);
		return "employees/employees3";
	}//update
	
	@PostMapping("/updatePro")
	public String updatePro(EmployeesDTO employeesDTO, RedirectAttributes rttr) {
	    employeesService.updateEmployees(employeesDTO);
	    rttr.addFlashAttribute("refreshAndClose", true);
	    return "redirect:/employees/employees";
	}
	
	@GetMapping("/empIdCheck")
	public ResponseEntity<Boolean> checkEmpId(@RequestParam String empId) {
	    boolean exists = employeesService.existsById(empId);
	    return new ResponseEntity<>(exists, HttpStatus.OK);
	}
	
	@GetMapping("/empdropdown")
    public ResponseEntity<List<EmployeesDTO>> empdropdown() {
		List<EmployeesDTO> employeesList = employeesService.getEmployeesList2();
		ResponseEntity<List<EmployeesDTO>> entity = new 
		ResponseEntity<List<EmployeesDTO>>(employeesList, HttpStatus.OK);
        return entity;
	}
	
}
