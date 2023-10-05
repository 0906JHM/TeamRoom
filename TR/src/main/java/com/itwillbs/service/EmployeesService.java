package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.EmployeesDAO;
import com.itwillbs.domain.EmployeesDTO;
@Service
public class EmployeesService {
	
	@Inject
	private EmployeesDAO employeesDAO;

	public void insertEmployees(EmployeesDTO employeesDTO) {
		employeesDAO.insertEmployees(employeesDTO);
		
	}

	public List<EmployeesDTO> getEmployeesList() {
		return employeesDAO.getEmployeesList();
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

}
