package com.itwillbs.domain;

public class CalendarEventDTO {
	private int id;
    private String title;
    private String start;
    private String end;
    private String description;
    private String otherDate;
    private String color;
    
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getOtherDate() {
		return otherDate;
	}
	public void setOtherDate(String otherDate) {
		this.otherDate = otherDate;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}

}
