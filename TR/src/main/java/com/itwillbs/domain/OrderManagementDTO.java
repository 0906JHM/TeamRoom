package com.itwillbs.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderManagementDTO {
 
	private String buyNum; 
	private String rawCode;
	private String rawName;
	private String rawType;
	private String clientCode;
	private int whseCount;
	private int buyCount;
	private int rawPrice;
	// 단가총계 생략됨
	private Date buyDate;
	private String buyEmpId;
	private String buyInstate;
	
}