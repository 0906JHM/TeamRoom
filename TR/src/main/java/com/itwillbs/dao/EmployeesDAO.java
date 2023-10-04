package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmployeesDTO;
@Repository
public class EmployeesDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.itwillbs.Mappers.EmployeesMapper";
	

	public void insertEmployees(EmployeesDTO employeesDTO) {
		sqlSession.insert(namespace+".insertEmployees", employeesDTO);
		
	}


	public List<EmployeesDTO> getEmployeesList() {
		return sqlSession.selectList(namespace+".getEmployeesList");
	}
	
	// 삭제 하기
    public void delete(String empId){
       sqlSession.delete(namespace + ".delete", empId); 
       }

}
