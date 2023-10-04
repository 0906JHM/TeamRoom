package com.itwillbs.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientDTO;

@Repository
public class ClientDAO {
		// 멤버변수 
	
		@Inject // root - context.xml에서 받아옴
		private SqlSession sqlsession;
		
		
		//MemberMapper 전체 이름 변수에 저장
		private static final String namespace="com.itwillbs.mappers.ClientMapper";

		public void insertClient(ClientDTO clientDTO) {
			
			sqlsession.insert(namespace+".insertClient");
			
			
			
		}

}
