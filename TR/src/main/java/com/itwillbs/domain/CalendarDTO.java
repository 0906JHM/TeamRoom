package com.itwillbs.domain;

public class CalendarDTO {
	private int calendar_num;
	private String calendar_title;
	private String calendar_memo;
	private String startDate;
	private String endDate;

	public int getCalendar_num() {
		return calendar_num;
	}

	public void setCalendar_num(int calendar_num) {
		this.calendar_num = calendar_num;
	}

	public String getCalendar_title() {
		return calendar_title;
	}

	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}

	public String getCalendar_memo() {
		return calendar_memo;
	}

	public void setCalendar_memo(String calendar_memo) {
		this.calendar_memo = calendar_memo;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
