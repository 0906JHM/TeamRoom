package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.CalendarDAO;
import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.SellDTO;

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

	public void insertSellCalendar(SellDTO sellDTO) {
		
		CalendarDTO calendarDTO = new CalendarDTO();
		
		calendarDTO.setCode(sellDTO.getSellCode());
		calendarDTO.setCalendar_title("수주");
		calendarDTO.setStartDate(sellDTO.getSellDate());
		calendarDTO.setEndDate(sellDTO.getSellDuedate());
		
		String memo = sellDTO.getClientCompany() + " " + sellDTO.getProdName() +"("+ sellDTO.getProdCode() + ") " + sellDTO.getSellCount();
		calendarDTO.setCalendar_memo(memo);
		
		calendarDAO.insertSellCalendar(calendarDTO);
	}
	
	
}
