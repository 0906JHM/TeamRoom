package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class PerformanceDAO {
	
	@Inject // root - context.xml에서 받아옴
	private SqlSession sqlsession;
	
	
	//MemberMapper 전체 이름 변수에 저장
	private static final String namespace="com.itwillbs.mappers.PerformanceMapper";




	public List<LineDTO> getlinelist() {

		return sqlsession.selectList(namespace+".getlinelist");
	}




	public List<ProdDTO> getprodlist() {
	
		return sqlsession.selectList(namespace+".getprodlist");
	}




	public List<PerformanceDTO> getperflist() {
		
		return  sqlsession.selectList(namespace+".getperflist");
		
	}




	public List<WorkOrderDTO> getworklist() {
		
		return sqlsession.selectList(namespace+".getworklist");
	}




	public void perfinsert(PerformanceDTO perfDTO) {
		
		sqlsession.insert(namespace+".perfinsert",perfDTO);
		
		
	}
	
	
	
	

}
