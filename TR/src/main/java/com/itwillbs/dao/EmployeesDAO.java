package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.PageDTO;
@Repository
public class EmployeesDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.itwillbs.Mappers.EmployeesMapper";
	

	public void insertEmployees(EmployeesDTO employeesDTO) {
		sqlSession.insert(namespace+".insertEmployees", employeesDTO);
		
	}


	public List<EmployeesDTO> getEmployeesList(PageDTO pageDTO) {
		return sqlSession.selectList(namespace+".getEmployeesList", pageDTO);
	}
	
	// 삭제 하기
    public void delete(String empId){
       sqlSession.delete(namespace + ".delete", empId); 
       }


	public EmployeesDTO getMember(String empId) {
		return sqlSession.selectOne(namespace+".getMember", empId);
	}


	public void updateEmployees(EmployeesDTO employeesDTO) {
		sqlSession.update(namespace+".updateEmployees", employeesDTO);
	}


	public int getEmployeesCount(PageDTO pageDTO) {
		return sqlSession.selectOne(namespace+".getEmployeesCount",pageDTO);
	}


	public List<EmployeesDTO> getEmployeesSearchList(EmployeesDTO employeesDTO) {
		return sqlSession.selectList(namespace+".getEmployeesSearchList", employeesDTO);
	}

}
