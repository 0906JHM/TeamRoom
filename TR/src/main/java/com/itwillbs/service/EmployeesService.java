package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.EmployeesDAO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.PageDTO;
@Service
public class EmployeesService {
	
	@Inject
	private EmployeesDAO employeesDAO;

	public void insertEmployees(EmployeesDTO employeesDTO) {
		employeesDAO.insertEmployees(employeesDTO);
		
	}

	public List<EmployeesDTO> getEmployeesList(PageDTO pageDTO) {
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return employeesDAO.getEmployeesList(pageDTO);
	}
	
	//게시물 삭제
    public void delete(String empId){
    	employeesDAO.delete(empId);
    }

	public EmployeesDTO getMember(String empId) {
		return employeesDAO.getMember(empId);
	}

	public void updateEmployees(EmployeesDTO employeesDTO) {
		employeesDAO.updateEmployees(employeesDTO);	
	}

	public int getEmployeesCount(PageDTO pageDTO) {
		return employeesDAO.getEmployeesCount(pageDTO);
	}

	public List<EmployeesDTO> getEmployeesSearchList(EmployeesDTO employeesDTO) {
		return employeesDAO.getEmployeesSearchList(employeesDTO);
	}

}
