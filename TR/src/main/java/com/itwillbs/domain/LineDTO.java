package com.itwillbs.domain;

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
	private String lineInsertDate;
	private String lineProcess;
	
	

}
