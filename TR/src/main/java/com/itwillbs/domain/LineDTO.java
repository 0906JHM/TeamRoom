package com.itwillbs.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class LineDTO {
	
	private String lineCode;
	private String lineName;
	private int lineUse;
	private String lineEmpId;
	private Date lineInsertDate;
	private String lineProcess;
	
	

}
