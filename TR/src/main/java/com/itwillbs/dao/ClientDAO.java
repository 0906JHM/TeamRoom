package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ClientDAO {
		// 멤버변수 
	
		@Inject // root - context.xml에서 받아옴
		private SqlSession sqlsession;
		
		
		//MemberMapper 전체 이름 변수에 저장
		private static final String namespace="com.itwillbs.mappers.ClientMapper";

		public void insertClient(ClientDTO clientDTO) {
			
			sqlsession.insert(namespace+".insertClient", clientDTO);
			
			
			
		}

		public List<ClientDTO> getclientList() {
			
			return sqlsession.selectList(namespace+".getclientList");
			
		}

		public String getclientCode(String clientType) {
			        log.debug("ClientDAO getclientCode 요청");
			        
			        System.out.println(clientType);
			        String clientCode="";
			        if("수주처".equals(clientType)) {
			            clientCode = "CL000";
			        } else {
			            clientCode = "OR000";
			        }
			
			return sqlsession.selectOne(namespace+".getclientCode",clientType);
		}

}
