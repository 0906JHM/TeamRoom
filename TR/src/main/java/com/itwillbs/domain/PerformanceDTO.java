package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PerformanceDTO {
	
	private String perfCode;
	
	  public String getPerfCode() {
	        return perfCode;
	    }

	    public void setPerfCode(String perfCode) {
	        this.perfCode = perfCode;
	    }

	private String workCode;
	private String prodCode;
	private String lineCode;
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
	
	//도넛차트 변수 추가 
	private int totalAmount;
	private int totalFair;
	private int totalDefect;
	
}
