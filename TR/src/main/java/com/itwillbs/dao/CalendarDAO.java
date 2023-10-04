package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.ChartDTO;

@Repository
public class CalendarDAO {

	
	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.calendarMapper.";
	
	public List<CalendarDTO> getCalendarList() {
		return sqlSession.selectList(namespace+"getCalendarList");
	}

	public List<ChartDTO> getSalesList() {
		return sqlSession.selectList(namespace+"getSalesList");
	}

	public List<ChartDTO> getStockList() {
		return sqlSession.selectList(namespace+"getStockList");
	}

	public List<ChartDTO> getPerfList() {
		return sqlSession.selectList(namespace+"getPerfList");
	}
}
