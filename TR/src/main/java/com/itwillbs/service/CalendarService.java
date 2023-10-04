package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.CalendarDAO;
import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.ChartDTO;

@Service
public class CalendarService {
	
	@Inject
	private CalendarDAO calendarDAO;

	public List<CalendarDTO> getCalendarList() {
		return calendarDAO.getCalendarList();
	}

	public List<ChartDTO> getSalesList() {
		return calendarDAO.getSalesList();
	}

	public List<ChartDTO> getStockList() {
		return calendarDAO.getStockList();
	}

	public List<ChartDTO> getPerfList() {
		return calendarDAO.getPerfList();
	}
	
	
}
