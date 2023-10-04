package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmployeesDTO;
@Repository
public interface EmployeesDAO2 {
	public void delete(String empId);//삭제
	

}
