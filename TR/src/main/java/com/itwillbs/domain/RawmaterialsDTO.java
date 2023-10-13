package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RawmaterialsDTO {
 
	private String rawCode; 
	private String rawName;
	private String rawType;
	private String rawUnit;
	private String rawPrice;
	private String clientCode;
	private String whseCode;
	private String rawMemo;
	
	// 내가 추가한 변수
	private int rawNum;
	private Timestamp date;
	private int whseCount;
	
}