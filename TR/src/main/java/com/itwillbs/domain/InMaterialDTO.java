package com.itwillbs.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InMaterialDTO {
	private String inNum;
	private Date inDate;
	private int inCount;
	private String rawCode;
	private String buyNum;
	private String inEmpId;
	private String clientCode;
//	비고 필요없나
	private String inMemo;
	
}
