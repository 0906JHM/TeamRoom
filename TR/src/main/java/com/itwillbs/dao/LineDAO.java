package com.itwillbs.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class LineDAO {
	@Inject
	private SqlSession sqlsession;
	
	
	//LineMapper 전체 이름 변수에 저장
	private static final String namespace="com.itwillbs.mappers.LineMapper";
	
	

}
