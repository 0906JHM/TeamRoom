package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PerformanceDTO {
	
	private String perfCode;
	private String workCode;
	private String prodCode;
	private String perfDate;
	private int perfAmount;
	private String perfEmpId;
	private String perfDateadd;
	private int perfFair;
	private int perfDefect;
	private String perfDefectreason;
	private String perfDefectmemo;
	private String perfMemo;
	private String perfStatus;
}
